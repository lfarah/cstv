//
//  MatchOpponent.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

struct MatchOpponentResult: Codable {
    let opponent: MatchOpponent
}

struct MatchOpponent: Codable {
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
    }
}
