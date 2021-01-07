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
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    var array = ["user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8", "user9", "user10", "users11"]
    var username: String!
    var headerView = UIView()
    var user: User!
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
//        layoutUI()
//        getUserInfo()
        configureCollectionView()
        configureDataSource()
        updateData()
        
    }
    
    //MARK: - @Objective functions
    
    
    
    //MARK: - Private Functions

    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUser(for: username) { (result) in
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                print(error)
            }
        }
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
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoCollectionHeaderView.reuseId, for: indexPath) as! UserInfoCollectionHeaderView
            return header
        }
    }
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false dont do it when you dont do constraints programatically!
        collectionView.backgroundColor = .systemBlue
        
        collectionView.register(TwitTwitsCell.self, forCellWithReuseIdentifier: TwitTwitsCell.reuseId)
        
        collectionView.register(UserInfoCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoCollectionHeaderView.reuseId)
        
    }
    
    private func createNSCollectionLayout() -> NSCollectionLayoutSection {
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(100))
        
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        
        addHeader(to: section)
        
        return section
    }

    private func addHeader(to section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UserInfoCollectionHeaderView.reuseId, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createNSCollectionLayout())
        return layout
    }
}
