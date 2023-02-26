//
//  ViewConfigurable.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

protocol ViewConfigurable {
    associatedtype Content: Codable
    func configure(with content: Content)
}
