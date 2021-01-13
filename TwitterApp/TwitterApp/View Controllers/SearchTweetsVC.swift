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
    var dataSource:     UICollectionViewDiffableDataSource<Section, String>!
    
    var username:       String!
    var user: User!
    
    var array: [String] = [TweetsDebugs.tweet1, TweetsDebugs.tweet2, TweetsDebugs.tweet3, TweetsDebugs.tweet4, TweetsDebugs.tweet5]
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureDataSource()
        updateData()
        print(user!)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTweetsCell.reuseId, for: indexPath) as! SearchTweetsCell
            cell.set(with: array)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchTweetsVCCollectionHeader.reuseId, for: indexPath) as! SearchTweetsVCCollectionHeader
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
