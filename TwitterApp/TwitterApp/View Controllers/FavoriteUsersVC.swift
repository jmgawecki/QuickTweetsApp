//
//  FavoriteUsersVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoriteUsersVC: UIViewController {
    
    enum Section {
        case user1
        case user2
        case user3
    }
    
    var tweetsUser1: [String] = [TweetsDebugs.tweet1, TweetsDebugs.tweet2, TweetsDebugs.tweet3, TweetsDebugs.tweet4, TweetsDebugs.tweet5]
    var array2 =    ["twit21", "twit22", "twit23", "twit24", "twit25", "twit26", "twit27", "twit28", "twit29", "twit210", "twit211"]
    var array3 =    ["twit31", "twit32", "twit33", "twit34", "twit35", "twit36", "twit37", "twit38", "twit39", "twit310", "twit311"]
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<Section, String>!
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureDataSource()
        updateData()
    }
    
    
    //MARK: - @Objective functions
    
    
    
    //MARK: - Private Functions
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = ""
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([Section.user1, Section.user2, Section.user3])
        
        snapshot.appendItems(tweetsUser1,  toSection: Section.user1)
        snapshot.appendItems(array2, toSection: Section.user2)
        snapshot.appendItems(array3, toSection: Section.user3)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func configureDataSource() {
        dataSource      = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView,
                                                                              cellProvider: { (collectionView, indexPath, array) -> UICollectionViewCell? in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteUsersCell.reuseId, for: indexPath) as! FavoriteUsersCell
            cell.set(with: array)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath ) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: FavoritesCollectionHeader.reuseId,
                                                                         for: indexPath) as! FavoritesCollectionHeader
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