//
//  MatchService.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation
import Alamofire
import RxSwift

class MatchService: AppService {
    func loadRunningMatches() -> Observable<[Match]> {
        request(route: "running", responseType: [Match].self)
    }
    
    func loadUpcomingMatches() -> Observable<[Match]> {
        request(route: "upcoming", responseType: [Match].self)
    }
    
    func loadMatchOpponents(for match: Match) -> Observable<MatchOpponentDetailResult> {
        request(route: "\(match.id)/opponents", responseType: MatchOpponentDetailResult.self)
    }
}
