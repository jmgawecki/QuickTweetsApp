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


    //MARK: - @Objective functions



    //MARK: - Private Functions
    
    private func getFavorites() {
        PersistenceManager.retrieveFavoritesTweets { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let tweets):
                self.tweets = tweets
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title                   = "Favorite Tweets"
        view.backgroundColor    = .systemBackground
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweets) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteTweetsCell.reuseId, for: indexPath) as! FavoriteTweetsCell
            cell.set(with: tweets)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tweet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tweets)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }


    //MARK: - Layout configuration

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionLayouts.favoriteTwitsCollectionLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FavoriteTweetsCell.self, forCellWithReuseIdentifier: FavoriteTweetsCell.reuseId)
        
    }
    
   
}
