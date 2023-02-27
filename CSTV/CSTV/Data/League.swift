//
//  League.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

struct League: Codable {
    let name: String
    let id: Int
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        
        case name, id
    }
}
