//
//  MatchStatus.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

enum MatchStatus: String {
    case canceled
    case finished
    case notStarted = "not_started"
    case running
    case postponed
}
