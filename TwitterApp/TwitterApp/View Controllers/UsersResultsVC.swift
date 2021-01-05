//
//  UsersResultsVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class UsersResultsVC: UIViewController {
    
    enum Section { case main }
    
    var array = ["user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8", "user9", "user10", "users11"]
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    



    //MARK: - @Objective functions

    
    
    
    //MARK: - functions
    
    func updateData(on array: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(array)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    
    
    
    //MARK: - Private Functions
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TwitUsersResultCell.self, forCellWithReuseIdentifier: TwitUsersResultCell.reuseId)
    }
    
            func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, array) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TwitUsersResultCell.reuseId, for: indexPath) as! TwitUsersResultCell
            cell.set(message: array) /// Is that correct?
            return cell
        })
    }
    
    

    //MARK: - Layout configuration
    
    
}
//MARK: - Extensions

extension UsersResultsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = UserTwitsVC()
        destVC.title = "User's twits"
        print("tralalal")
        navigationController?.pushViewController(destVC, animated: true)
    }
}
