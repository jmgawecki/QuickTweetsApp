//
//  FavoriteUsersVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

final class FavoriteUsersVC: TwetLoadingDataVC {
    
    enum SectionsUsers: Hashable {
        case favoriteUser(User)
        case favoriteUsers([User])
    }
    
    var users:  [User]  = []
    var tweets: [Tweet] = []
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<SectionsUsers, Tweet>!
    var snapshot:       NSDiffableDataSourceSnapshot<SectionsUsers, Tweet>!
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        configureVC()
        configureNC()
        configureCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    //MARK: - @Objective functions
    
    @objc private func refreshData() {
        updateData(with: users)
    }
    
    
    //MARK: - Persistence Manager/ Network Calls
    
    private func deleteFavorite(user: User) {
        PersistenceManager.updateWithUsers(favoriteUser: user, persistenceAction: .remove) { (error) in
            guard let _ = error else {
                return
            }
            self.presentAlertVCOnMainThread(title: "Oops!", message: TweetStrings.sthWentWrong, buttonTitle: "Ok")
        }
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavoritesUsers { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.users = users
                if self.users.isEmpty {
                    DispatchQueue.main.async {
                        self.presentEmptyStateView(with: TweetStrings.emptyStateMessage, in: self.view)
                        return
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateData(with: users)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    //MARK: - Private Functions
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = TweetStrings.emptyString
    }
    
    private func configureNC() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbolsAsImg.refresh, style: .plain, target: self, action: #selector(refreshData))
    }
    
    
    //MARK:- CollectionView Configurations
    
    private func updateData(with users: [User]) {
        snapshot = NSDiffableDataSourceSnapshot<SectionsUsers, Tweet>()
        var index = 0
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue")
        let dispatchSema  = DispatchSemaphore(value: 0)
        showLoadingView()
        dispatchQueue.async {
            for user in users {
                dispatchGroup.enter()
                NetworkManager.shared.getSingleUsersTweets(userId: user.idStr) { [weak self] (tweetsArray) in
                    guard let self = self else { return }
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
                self.dismissLoadingView()
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
            }
        }
    }
    
    
    private func configureDataSource() {
        dataSource          = UICollectionViewDiffableDataSource<SectionsUsers, Tweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweet) -> UICollectionViewCell? in
            let cell        = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteUsersCell.reuseId, for: indexPath) as! FavoriteUsersCell
            let buttonTitle = (tweet.urlToExpandWithSafari != nil) ? TweetStrings.seeFull : nil
            let isEnabled   = (buttonTitle != nil) ? true : false
            cell.delegateSafari = self
            cell.set(with: tweet, buttonTitle: buttonTitle, isEnabled: isEnabled)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath ) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: FavoritesCollectionHeader.reuseId,
                                                                         for: indexPath) as! FavoritesCollectionHeader
            header.set(with: self.users[indexPath.section])
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
}


    //MARK: - Extensions

extension FavoriteUsersVC: FavoritesCollectionHeaderDelegates {
    
    func didRemoveUserFromFavorites(user: User) {
        deleteFavorite(user: user)
        users.removeAll {$0.idStr == user.idStr}
        snapshot.deleteSections([.favoriteUser(user)])
        if users.isEmpty {
                self.presentEmptyStateView(with: "Looks like... \nYou have no favorite Users 🧐 \n\nTime to change that!", in: self.view)
        } else {
            DispatchQueue.main.async {
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
            }
        }
    }
}

extension FavoriteUsersVC: FavoriteUsersCellDelegates {
    func didRequestSafari(with urlString: String?) {
        let url = URL(string: urlString!)!
        presentSafariVC(with: url)
    }
    
    
}
