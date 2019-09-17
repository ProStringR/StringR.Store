//
//  LayoutController.swift
//  StringR.Store
//
//  Created by Jaafar on 16/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class LayoutController {
    static func generateCardCellCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }
}
