//
//  FavoriteUsersVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoriteUsersVC: UIViewController {
    
    enum SectionsUsers: Hashable {
        case favoriteUser(User)
        case favoriteUsers([User])
    }
    
    var users: [User]   = []
    var tweets: [Tweet] = []
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<SectionsUsers, Tweet>!
    var snapshot:       NSDiffableDataSourceSnapshot<SectionsUsers, Tweet>!
    
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
        snapshot = NSDiffableDataSourceSnapshot<SectionsUsers, Tweet>()
        var index = 0
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue")
        let dispatchSema  = DispatchSemaphore(value: 0)
        dispatchQueue.async {
            for user in users {
                dispatchGroup.enter()
                NetworkManager.shared.getSingleUsersTweets(userId: user.idStr) { (tweetsArray) in
                    let tweets: [Tweet] = tweetsArray
                    self.snapshot.appendSections([.favoriteUser(users[index])])
                    self.snapshot.appendItems(tweets, toSection: .favoriteUser(users[index]))
                    index += 1
                    dispatchSema.signal()
                    dispatchGroup.leave()
                }
                dispatchSema.wait()
            }
            
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            DispatchQueue.main.async {
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func configureDataSource() {
        dataSource      = UICollectionViewDiffableDataSource<SectionsUsers, Tweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweets) -> UICollectionViewCell? in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteUsersCell.reuseId, for: indexPath) as! FavoriteUsersCell
            cell.set(with: tweets)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath ) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: FavoritesCollectionHeader.reuseId,
                                                                         for: indexPath) as! FavoritesCollectionHeader
            #warning("it probably did not work cause the index has changed")
            header.set(with: self.users[indexPath.section], index: indexPath)
            header.delegate = self
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

extension FavoriteUsersVC: FavoritesCollectionHeaderDelegates {
    
    func didRemoveUserFromFavorites(index: IndexPath, user: User) {
        #warning("refactor protocol - delete indexPath passed")
        users.removeAll {$0.idStr == user.idStr}
        snapshot.deleteSections([.favoriteUser(user)])
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    
}
