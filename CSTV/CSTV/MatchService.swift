//
//  MatchService.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation
import Alamofire
import RxSwift

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

enum MatchStatus: String {
    case canceled
    case finished
    case notStarted = "not_started"
    case running
    case postponed
}

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

struct League: Codable {
    let name: String
    let id: Int
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        
        case name, id
    }
}

struct Serie: Codable {
    let name: String?
}

// Detail screen
struct MatchOpponentDetailResult: Codable {
    let opponents: [MatchOpponentDetail]
}

struct MatchOpponentDetail: Codable {
    let players: [Player]
}

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

enum NetworkError: Error {
    case badURL
}

struct MatchService {
    func loadRunningMatches() -> Observable<[Match]> {
        // TODO: Move this to better place
        guard let url = URL(string: "https://api.pandascore.co/csgo/matches/running") else {
            return Observable.just([])
        }
        
        return Observable.create { emitter in
            // I know there are better ways to handle authorization by using interceptors.
            // TODO: move bearer to another place
            let headers = HTTPHeaders(["Authorization": "Bearer DDhsvrsvHJTqxbYFszVLixAMekdLlY_hJ6DEqtk_-3SM_xOCHVE"])
            AF.request(url, parameters: ["sort": "begin_at"], headers: headers).responseDecodable(of: [Match].self) { result in
                switch result.result {
                case .success(let object):
                    emitter.onNext(object)
                    print("results: \(object)")
                case .failure(let error):
                    print("error: \(error)")
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func loadUpcomingMatches() -> Observable<[Match]> {
        // TODO: Move this to better place
        guard let url = URL(string: "https://api.pandascore.co/csgo/matches/upcoming") else {
            return Observable.just([])
        }
        
        return Observable.create { emitter in
            // I know there are better ways to handle authorization by using interceptors.
            // TODO: move bearer to another place
            let headers = HTTPHeaders(["Authorization": "Bearer DDhsvrsvHJTqxbYFszVLixAMekdLlY_hJ6DEqtk_-3SM_xOCHVE"])
            AF.request(url, parameters: ["sort": "begin_at"], headers: headers).responseDecodable(of: [Match].self) { result in
                switch result.result {
                case .success(let object):
                    emitter.onNext(object)
                    print("results: \(object)")
                case .failure(let error):
                    print("error: \(error)")
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func loadMatchOpponents(for match: Match) -> Observable<MatchOpponentDetailResult> {
        // TODO: Move this to better place
        guard let url = URL(string: "https://api.pandascore.co/matches/\(match.id)/opponents") else {
            return Observable.error(NetworkError.badURL)
        }
        
        return Observable.create { emitter in
            // I know there are better ways to handle authorization by using interceptors.
            // TODO: move bearer to another place
            let headers = HTTPHeaders(["Authorization": "Bearer DDhsvrsvHJTqxbYFszVLixAMekdLlY_hJ6DEqtk_-3SM_xOCHVE"])
            AF.request(url, headers: headers).responseDecodable(of: MatchOpponentDetailResult.self) { result in
                switch result.result {
                case .success(let object):
                    emitter.onNext(object)
                    print("results: \(object)")
                case .failure(let error):
                    print("error: \(error)")
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
