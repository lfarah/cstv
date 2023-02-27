//
//  MatchOpponentDetail.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

struct MatchOpponentDetailResult: Codable {
    let opponents: [MatchOpponentDetail]
}

struct MatchOpponentDetail: Codable {
    let players: [Player]
}
