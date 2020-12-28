//
//  LocationDataStore.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import RxSwift

protocol LocationDataStore {
    func getLocations(query: String) -> Observable<[LocationEntity]>
    func getLocation(id: Int) -> Observable<LocationEntity?>
}

class LocationRemoteDataStore: LocationDataStore {
    func getLocations(query: String) -> Observable<[LocationEntity]> {
        return WeatherAPIClient.searchLocations(query: query)
            .asObservable()
            .flatMap { (networkResult) -> Observable<[LocationEntity]> in
                switch networkResult {
                case .success(let elements):
                    return Observable.from(optional: elements)
                case .error:
                    return Observable.just([])
                }
            }
    }
    
    func getLocation(id: Int) -> Observable<LocationEntity?> {
        let singleObservable = WeatherAPIClient.location(id: id)
        return singleObservable.asObservable().flatMap { (networkResult) -> Observable<LocationEntity?> in
            switch networkResult {
            case .success(let element):
                return Observable.from(optional: element)
            case .error:
                return Observable.just(nil)
            }
        }
    }
}
