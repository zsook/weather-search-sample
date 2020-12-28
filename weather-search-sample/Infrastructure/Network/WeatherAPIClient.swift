//
//  WeatherAPIClient.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class WeatherAPIClient: APIClient {
    
    enum Router {
        static let host = "https://www.metaweather.com/api"
        
        case searchLocations(name: String)
        case location(id: Int)
        
        var path: String {
            switch self {
            case .searchLocations:
                return Router.host + "/location/search"
            case .location(let id):
                return Router.host + "/location/\(id)"
            }
        }
        
        var parameters: Parameters {
            switch self {
            case .searchLocations(let name):
                return ["query": name]
            default:
                return [:]
            }
        }
    }
    
    class func searchLocations(query: String) -> Single<NetworkResult<[LocationEntity]>> {
        let router = WeatherAPIClient.Router.searchLocations(name: query)
        return WeatherAPIClient.getItem(router.path, parameters: router.parameters)
    }
    
    class func location(id: Int) -> Single<NetworkResult<LocationEntity>> {
        let router = WeatherAPIClient.Router.location(id: id)
        return WeatherAPIClient.getItem(router.path)
    }
}
