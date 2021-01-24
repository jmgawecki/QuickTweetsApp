//
//  TwitsVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class SearchTweetsVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<Section, Tweet>!
    
    var username:       String!
    var user:           User!
    var tweets:         [Tweet] = []
    
    var array: [String] = [TweetsDebugs.tweet1, TweetsDebugs.tweet2, TweetsDebugs.tweet3, TweetsDebugs.tweet4, TweetsDebugs.tweet5]
    
    
    //MARK: - Initialiser
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersTweets()
        configureVC()
        configureCollectionView()
    }
    
    //MARK: - Objectives
    
    @objc private func addUserToFavorites() {
        addUserToFavorite(user: user)
    }
    
    //MARK: - Private Functions
    
    private func getUsersTweets() {
        NetworkManager.shared.getSingleUsersTweets(userId: user.idStr) { [weak self] (result) in
            guard let self = self else { return }
            self.tweets.append(contentsOf: result)
            DispatchQueue.main.async {
                self.configureDataSource()
                self.updateData()
            }
        }
    }

    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to favorites", style: .plain, target: self, action: #selector(addUserToFavorites))
    }
    
    private func addUserToFavorite(user: User) {
        let favorite = User(idStr:                  user.idStr,
                            name:                   user.name,
                            screenName:             user.screenName,
                            profileImageUrl:        user.profileImageUrl,
                            profileBackgroundUrl:   user.profileBackgroundUrl,
                            friendsCount:           user.friendsCount,
                            followersCount:         user.followersCount,
                            followingCount:         user.followingCount,
                            statusesCount:          user.statusesCount,
                            location:               user.location,
                            createdAt:              user.createdAt)
        PersistenceManager.updateWithUsers(newFavoriteUser: favorite, persistenceAction: .add) { [weak self] (error) in
            guard self != nil else { return }
            guard let error = error else {
                print("success")
                return
            }
            
            print(error.rawValue)
        }
    }
    
    //MARK: - Layout configuration
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tweet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tweets)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tweet>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tweet) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTweetsCell.reuseId, for: indexPath) as! SearchTweetsCell
            let buttonTitle = (tweet.urlToExpandWithSafari != nil) ? "See Full" : nil
            let isEnabled   = (buttonTitle != nil) ? true : false
            cell.set(with: tweet, user: self.user, buttonTitle: buttonTitle, isEnabled: isEnabled)
            cell.delegateSafari = self
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchTweetsVCCollectionHeader.reuseId, for: indexPath) as! SearchTweetsVCCollectionHeader
            header.set(with: self.user)
            return header
        }
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionLayouts.userTweetsCollectionLayout())
        view.addSubview(collectionView)

        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(SearchTweetsCell.self, forCellWithReuseIdentifier: SearchTweetsCell.reuseId)
        
        collectionView.register(SearchTweetsVCCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchTweetsVCCollectionHeader.reuseId)
        
    }
}

extension SearchTweetsVC: SearchTweetsCellDelegates {
    func didRequestSafari(with urlString: String?) {
        let url = URL(string: urlString!)!
        presentSafariVC(with: url)
    }
    
    
}
