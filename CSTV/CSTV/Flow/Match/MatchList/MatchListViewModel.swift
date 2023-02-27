//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class MatchListViewModel {
    
    var matches = BehaviorRelay<[Match]>(value: [])

    let service: MatchService
    let bag = DisposeBag()
    
    init(service: MatchService = MatchService()) {
        self.service = service
        
        reload()
    }
    
    func reload() {
        Observable.zip(service.loadRunningMatches().catchAndReturn([]), service.loadUpcomingMatches().catchAndReturn([]))
            .map { $0.0 + $0.1 }
            .bind(to: matches)
            .disposed(by: bag)
    }
}
