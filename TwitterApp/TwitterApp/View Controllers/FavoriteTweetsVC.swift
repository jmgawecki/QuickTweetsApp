//
//  FavoriteTwitsVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

final class FavoriteTweetsVC: UIViewController {
    //MARK: - Declarations
    
    
    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, FavoriteTweet>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, FavoriteTweet>!
    
    var favoriteTweets: [FavoriteTweet] = []
    var tweets:         [Tweet] = []
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        configureVC()
        configureCollectionView()
        configureDataSource()
        updateData()
    }


    //MARK: - Persistence Manager functions
    

    private func getFavorites() {
        PersistenceManager.retrieveFavoritesTweets { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let favoriteTweets):
                self.favoriteTweets = favoriteTweets
                if self.favoriteTweets.isEmpty {
                    DispatchQueue.main.async {
                        self.presentEmptyStateView(with: "Looks like... \nYou have no favorite Tweets 🧐 \n\nTime to change that!", in: self.view)
                    }
                    return
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    private func deleteFavorite(tweet: FavoriteTweet) {
        PersistenceManager.updateWithTweets(favoriteTweet: tweet, persistenceAction: .remove) { (error) in
            guard let error = error else { print("success"); return }
            print(error.rawValue)
            return
        }
    }

    
    //MARK: - Private Functions
    
    
    private func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title                   = "Favorite Tweets"
        view.backgroundColor    = .systemBackground
    }
    
    //MARK:- CollectionView Configurations
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FavoriteTweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, favoriteTweet) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteTweetsCell.reuseId, for: indexPath) as! FavoriteTweetsCell
            let buttonTitle     = (favoriteTweet.urlToExpandWithSafari != nil) ? "See Full" : nil
            cell.set(with: favoriteTweet, buttonTitle: buttonTitle)
            cell.delegate       = self
            cell.delegateSafari = self
            return cell
        })
    }
    
    
    private func updateData() {
        snapshot = NSDiffableDataSourceSnapshot<Section, FavoriteTweet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(favoriteTweets)
        DispatchQueue.main.async { self.dataSource.apply(self.snapshot, animatingDifferences: true) }
    }


    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionLayouts.favoriteTweetsCollectionLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FavoriteTweetsCell.self, forCellWithReuseIdentifier: FavoriteTweetsCell.reuseId)
    }
}


//MARK:- Extensions


extension FavoriteTweetsVC: FavoriteTweetsCellDelegate {
    func didRemoveTweetFromFavorites(tweet: FavoriteTweet) {
        deleteFavorite(tweet: tweet)
        
        favoriteTweets.removeAll(where: { $0.twitsId == tweet.twitsId })
        snapshot.deleteItems([tweet])
        DispatchQueue.main.async { self.dataSource.apply(self.snapshot, animatingDifferences: true) }
        if favoriteTweets.isEmpty {
            self.presentEmptyStateView(with: TweetStrings.emptyStateMessage, in: self.view)
        }
    }
}


extension FavoriteTweetsVC: FavoriteTweetsCellSafariDelegates {
    func didRequestSafari(with urlString: String?) {
        let url = URL(string: urlString!)!
        presentSafariVC(with: url)
    }
}
