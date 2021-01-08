//
//  FavoritesUsersVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoritesUsersVC: UIViewController {
    
    enum Section {
        case user1
        case user2
        case user3
    }
    var array = ["twit1", "twit2", "twit3", "twit4", "twit5", "twit6", "twit7", "twit8", "twit9", "twit10", "twit11"]

    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
    
    
    //MARK: - @Objective functions
    
    
    
    //MARK: - Private Functions
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favorite Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        
        collectionView.register(TwitUserFavoritesCell.self, forCellWithReuseIdentifier: TwitUserFavoritesCell.reuseId)
        
        collectionView.register(UserInfoCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoCollectionHeaderView.reuseId)
    }
    
    
    //MARK: - Layout configuration

    
    
}
