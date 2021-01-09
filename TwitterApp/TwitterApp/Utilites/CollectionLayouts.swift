//
//  CollectionLayouts.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

struct CollectionLayouts {
    static func userTwitsCollectionLayout() -> UICollectionViewLayout {
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(100))
        
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        
        let headerSize      = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(200))
        
        let headerElement   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                          elementKind: UserInfoCollectionHeaderView.reuseId,
                                                                          alignment: .top)
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    static func favoritesUsersCollectionLayout() -> UICollectionViewLayout {
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                     heightDimension: .estimated(300))
        
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        let headerSize      = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(200))
        
        let headerElement   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                          elementKind: UserInfoCollectionHeaderView.reuseId,
                                                                          alignment: .top)
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout          = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}




