//
//  FavoriteUsersVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoriteUsersVC: UIViewController {
    
    enum Section: CaseIterable {
        case user1
        case user2
        case user3
    }
    
    enum SectionsUsers: Hashable {
        case favoriteUser(User)
    }
    
    var tweetsUser1: [String] = [TweetsDebugs.tweet1, TweetsDebugs.tweet2, TweetsDebugs.tweet3, TweetsDebugs.tweet4, TweetsDebugs.tweet5]
    var array2 =    ["twit21", "twit22", "twit23", "twit24", "twit25", "twit26", "twit27", "twit28", "twit29", "twit210", "twit211"]
    var array3 =    ["twit31", "twit32", "twit33", "twit34", "twit35", "twit36", "twit37", "twit38", "twit39", "twit310", "twit311"]
    
    
    var users: [User] = []
    var tweets: [SearchUserTweet] = []

    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<SectionsUsers, SearchUserTweet>!
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        configureVC()
        configureCollectionView()
        configureDataSource()
    }
    
    
    //MARK: - @Objective functions
    
    
    
    //MARK: - Private Functions
    
    private func getFavorites() {
        PersistenceManager.retrieveFavoritesUsers { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                print(users)
                self.users = users
                DispatchQueue.main.async {
                    self.updateData(with: users)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = ""
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateData(with users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionsUsers, SearchUserTweet>()
        var index = 0
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue")
        let dispatchSema  = DispatchSemaphore(value: 0)
        dispatchQueue.async {
            for user in users {
                dispatchGroup.enter()
                NetworkManager.shared.getSingleUsersTweets(userId: user.idStr) { (tweetsArray) in
                    let tweets: [SearchUserTweet] = tweetsArray
                    snapshot.appendSections([.favoriteUser(users[index])])
                    snapshot.appendItems(tweets, toSection: .favoriteUser(users[index]))
                    index += 1
                    dispatchSema.signal()
                    dispatchGroup.leave()
                }
                dispatchSema.wait()
            }
            
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            DispatchQueue.main.async {
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func configureDataSource() {
        dataSource      = UICollectionViewDiffableDataSource<SectionsUsers, SearchUserTweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweets) -> UICollectionViewCell? in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteUsersCell.reuseId, for: indexPath) as! FavoriteUsersCell
            cell.set(with: tweets)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath ) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: FavoritesCollectionHeader.reuseId,
                                                                         for: indexPath) as! FavoritesCollectionHeader
            header.set(with: self.users[indexPath.section])
            return header
        }
    }
    
    
    private func configureCollectionView() {
        collectionView                  = UICollectionView(frame: view.bounds,
                                                           collectionViewLayout: CollectionLayouts.favoriteUsersCollectionLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor  = .systemBackground
        
        collectionView.register(FavoriteUsersCell.self,
                                forCellWithReuseIdentifier: FavoriteUsersCell.reuseId)
        
        collectionView.register(FavoritesCollectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: FavoritesCollectionHeader.reuseId)
    }
    //MARK: - Layout configuration

    
    
}
