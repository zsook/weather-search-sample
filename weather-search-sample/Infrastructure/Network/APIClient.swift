//
//  APIClient.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum NetworkResult<T: Codable> {
    case success(T)
    case error(NetworkError)
}

enum NetworkError: Int, Error {
  case badRequest = 400
  case authenticationFailed = 401
  case notFoundException = 404
  case contentLengthError = 413
  case quotaExceeded = 429
  case systemError = 500
  case endpointError = 503
  case timeout = 504
}

open class APIClient {
    
    private static let successRange = 200..<300
    
    class func getItem<T: Codable>(_ urlString: String,
                                   parameters: Parameters? = nil,
                                   headers: HTTPHeaders? = nil) -> Single<NetworkResult<T>> {
        return Single.create { single in
              let request = AF.request(
                urlString,
                method: .get,
                parameters: parameters,
                headers: headers
                )
                .responseData { response in
                  switch response.result {
                  case .success(let data):
                    do {
                        let returnObject = try JSONDecoder().decode(T.self, from: data)
                        single(.success(.success(returnObject)))
                    }catch let error {
                        single(.error(error))
                    }
                    
                  case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if let networkError = NetworkError(rawValue: statusCode){
                            single(.success(.error(networkError)))
                        }else {
                            single(.error(error))
                        }
                    }else {
                        single(.error(error))
                    }
                  }
              }
              return Disposables.create {
                request.cancel()
              }
            }
    }
}


