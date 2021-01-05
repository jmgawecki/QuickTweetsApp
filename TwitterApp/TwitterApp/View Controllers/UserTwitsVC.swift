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
        getUserInfo()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(TwitTwitsCell.self, forCellWithReuseIdentifier: TwitTwitsCell.reuseId)
        
        collectionView.register(UserInfoCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserInfoCollectionHeaderView.reuseId)
        
    }
    
//    private func layoutUI() {
//        view.addSubview(headerView)
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.layer.borderWidth = 2
//
//
//        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            headerView.heightAnchor.constraint(equalToConstant: 200),
//        ])
//        add(childVC: TwitUserInfoHeaderVC(), to: headerView)
//    }


    
//    private func add(childVC: UIViewController, to containerView: UIView) {
//        addChild(childVC)
//        containerView.addSubview(childVC.view)
//        childVC.view.frame = containerView.bounds
//        childVC.didMove(toParent: self)
//    }
//
}
