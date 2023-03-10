//
//  Match.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation

struct Match: Codable {
    let scheduledAt: String
    let isDraw: Bool
    let name: String
    let id: Int
    let slug: String
    let status: String
    let opponents: [MatchOpponentResult]
    let league: League
    let serie: Serie
    
    var team1: MatchOpponent? {
        return opponents.first?.opponent
    }
    
    var team2: MatchOpponent? {
        return opponents.last?.opponent
    }
    
    var scheduledDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: scheduledAt)
    }
    
    var parsedDate: String? {
        guard let date = scheduledDate else {
            return nil
        }
        
        let formatter = DateFormatter()
        
        // Types:
        // AGORA
        // Hoje, 21:00
        // Ter, 22:00
        // 22.04 15:00
        
        // I tried using RelativeDateFormatter, but didn't have success finding the correct types to all design cases listed above
        if Calendar.current.isDateInToday(date) {
            if Date() > date {
                return "AGORA"
            } else {
                formatter.dateFormat = "HH:mm"
                let formattedHour = formatter.string(from: date)
                return "Hoje, \(formattedHour)"
            }
        } else if Calendar.current.isDate(Date(), equalTo: date, toGranularity: .weekOfYear) {
            formatter.dateFormat = "E, HH:mm"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "DD.MM HH:mm"
            return formatter.string(from: date)
        }
    }
    
    var parsedStatus: MatchStatus {
        MatchStatus(rawValue: status) ?? .notStarted
    }

    // For the snake case, I could've used a custom decoder, but I thought this would be simpler since I slightly changed other variables
    enum CodingKeys: String, CodingKey {
        case scheduledAt = "scheduled_at"
        case isDraw = "draw"
        
        case name, id, slug, opponents, status, league, serie
    }
}
