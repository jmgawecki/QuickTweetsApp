//
//  UserTwitsVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class UserTwitsVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<Section, String>!
    
    var username:       String!
    var user:           User!
    
    var array = ["twit1", "twit2", "twit3", "twit4", "twit5", "twit6", "twit7", "twit8", "twit9", "twit10", "twit11"]
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureDataSource()
        updateData()
    }
    
    //MARK: - Private Functions

    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    //MARK: - Layout configuration
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(array)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, array) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TwitTwitsCell.reuseId, for: indexPath) as! TwitTwitsCell
            cell.set(with: array)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserTwitsHeaderView.reuseId, for: indexPath) as! UserTwitsHeaderView
            return header
        }
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionLayouts.userTwitsCollectionLayout())
        view.addSubview(collectionView)

        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(TwitTwitsCell.self, forCellWithReuseIdentifier: TwitTwitsCell.reuseId)
        
        collectionView.register(UserTwitsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserTwitsHeaderView.reuseId)
        
    }
}
