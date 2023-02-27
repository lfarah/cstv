//
//  UICollectionView+Extensions.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(type: T.Type) {
        self.register(type, forCellWithReuseIdentifier: NSStringFromClass(type))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(type), for: indexPath) as? T else {
            preconditionFailure("Cell not registered")
        }
        return cell
    }
    
    func register<T: UICollectionReusableView>(type: T.Type, kind: String) {
        self.register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: NSStringFromClass(type))
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(type: T.Type, kind: String, indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(type), for: indexPath) as? T else {
            preconditionFailure("\(kind) not registered")
        }
        
        return view
    }
}
