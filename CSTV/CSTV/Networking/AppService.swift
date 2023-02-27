//
//  AppService.swift
//  CSTV
//
//  Created by Lucas Farah on 26/02/23.
//

import Foundation
import Alamofire
import RxSwift

class AppService {
    
    func request<T: Codable>(route: String, responseType: T.Type) -> Observable<T> {
        guard let url = URL(string: Keys.baseURL + route) else {
            return Observable.error(NetworkError.badURL)
        }
        
        return Observable.create { emitter in
            // I know there are better ways to handle authorization by using interceptors.
            let headers = HTTPHeaders(["Authorization": Keys.authorization])
            AF.request(url, headers: headers).responseDecodable(of: responseType) { result in
                switch result.result {
                case .success(let object):
                    emitter.onNext(object)
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
