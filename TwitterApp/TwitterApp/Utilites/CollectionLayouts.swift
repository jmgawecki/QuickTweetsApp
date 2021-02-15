//
//  CollectionLayouts.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

struct CollectionLayouts {
    static func userTweetsCollectionLayout() -> UICollectionViewLayout {
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(296))
        
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        
        let headerSize      = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(200))
        
        let headerElement   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                          elementKind: SearchTweetsVCCollectionHeader.reuseId,
                                                                          alignment: .top)
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    static func favoriteUsersCollectionLayout() -> UICollectionViewLayout {
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
        
        let groupHeight: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 270 : 250
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                     heightDimension: .estimated(groupHeight))
        
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let headerSize      = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(200))
        
        let headerElement   = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                          elementKind: SearchTweetsVCCollectionHeader.reuseId,
                                                                          alignment: .top)
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout          = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    static func favoriteTweetsCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(330))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
     
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}




