//
//  Player.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

struct Player: Codable {
    let name: String
    let firstName: String
    let lastName: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "image_url"
        case name
    }
}

