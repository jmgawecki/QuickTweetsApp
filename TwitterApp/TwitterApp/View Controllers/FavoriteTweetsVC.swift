//
//  FavoriteTwitsVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

class FavoriteTweetsVC: UIViewController {
    
    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Tweet>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Tweet>!
    
    var tweets: [Tweet] = []
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        configureVC()
        configureCollectionView()
        configureDataSource()
        updateData()
        
    }


    //MARK: - Network Calls

    private func getFavorites() {
        PersistenceManager.retrieveFavoritesTweets { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let tweets):
                self.tweets = tweets
                if self.tweets.isEmpty {
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
    
    
    private func deleteFavorite(tweet: Tweet) {
        PersistenceManager.updateWithTweets(newFavoriteTweet: tweet, persistenceAction: .remove) { (error) in
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
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweets) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteTweetsCell.reuseId, for: indexPath) as! FavoriteTweetsCell
            cell.set(with: tweets)
            cell.delegate       = self
            cell.delegateSafari = self
            return cell
        })
    }
    
    
    private func updateData() {
        snapshot = NSDiffableDataSourceSnapshot<Section, Tweet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tweets)
        DispatchQueue.main.async { self.dataSource.apply(self.snapshot, animatingDifferences: true) }
    }


    //MARK: - Layout configuration

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionLayouts.favoriteTwitsCollectionLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FavoriteTweetsCell.self, forCellWithReuseIdentifier: FavoriteTweetsCell.reuseId)
    }
}

extension FavoriteTweetsVC: FavoriteTweetsCellDelegate {
    func didRemoveTweetFromFavorites(tweet: Tweet) {
        #warning("creae a conditional here in case deleteFavorite from UserDefaults did not succeed. Or is it actuall already made?")
        deleteFavorite(tweet: tweet)
        
        tweets.removeAll(where: { $0.twitsId == tweet.twitsId })
        snapshot.deleteItems([tweet])
        DispatchQueue.main.async { self.dataSource.apply(self.snapshot, animatingDifferences: true) }
        if tweets.isEmpty {
            DispatchQueue.main.async {
                #warning("add animation here so its gonna appears in one second, not instantly")
                self.presentEmptyStateView(with: "Looks like... \nYou have no favorite Tweets 🧐 \n\nTime to change that!", in: self.view)
            }
        }
    }
}

extension FavoriteTweetsVC: FavoriteTweetsCellDelegateSafari {
    func didRequestSafari(with urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { print("tralalala"); return }
        presentSafariVC(with: url)
    }
}
