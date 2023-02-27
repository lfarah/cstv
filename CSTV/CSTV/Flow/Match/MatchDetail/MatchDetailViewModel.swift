//
//  MatchDetailViewModel.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class MatchDetailViewModel {
    
    var players = BehaviorRelay<[Player]>(value: [])
    let match: Match
    let service: MatchService
    let bag = DisposeBag()
    
    init(match: Match, service: MatchService = MatchService()) {
        self.match = match
        self.service = service
        reload()
    }
    
    func reload() {
        service.loadMatchOpponents(for: match)
            .map { $0.opponents }
            .map({ opponents in
                let team1Players = opponents.first?.players ?? []
                let team2Players = opponents.last?.players ?? []
                let arrays = [team1Players, team2Players]
                
                // merging players from both teams into one array. I've used UICollectionViewCompositionalLayout in the past, but time constraints made me take this route.
                guard let longest = arrays.max(by: { $0.count < $1.count })?.count else { return [] }
                var result: [Player] = []
                for index in 0..<longest {
                    for array in arrays {
                        guard index < array.count else { continue }
                        result.append(array[index])
                    }
                }
                return result
            })
            .bind(to: players)
            .disposed(by: bag)
    }
}
