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
    
    // For the snake case, I could've used a custom decoder, but I thought this would be simpler since I slightly changed other variables
    enum CodingKeys: String, CodingKey {
        case scheduledAt = "scheduled_at"
        case isDraw = "draw"
        
        case name, id, slug
    }

}

struct MatchService {
    func loadMatches() -> Observable<[Match]> {
        // TODO: Move this to better place
        guard let url = URL(string: "https://api.pandascore.co/csgo/matches") else {
            return Observable.just([])
        }
        
        return Observable.create { emitter in
            // I know there are better ways to handle authorization by using interceptors.
            // TODO: move bearer to another place
            let headers = HTTPHeaders(["Authorization": "Bearer DDhsvrsvHJTqxbYFszVLixAMekdLlY_hJ6DEqtk_-3SM_xOCHVE"])
            AF.request(url, headers: headers).responseDecodable(of: [Match].self) { result in
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
