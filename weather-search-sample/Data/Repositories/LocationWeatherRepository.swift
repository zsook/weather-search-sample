//
//  LocationWeatherRepository.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import RxSwift

final class DefaultLocationRepository: LocationRepository {
    
    private let locationDataStore: LocationDataStore
    
    init(locationDataStore: LocationDataStore) {
        self.locationDataStore = locationDataStore
    }
    
    func getLocations(query: String) -> Observable<[Location]> {
        let remoteRequest = self.locationDataStore.getLocations(query: query)
        let observable = remoteRequest.map { (entities) -> [Location] in
            return entities.compactMap { LocationTranslator.translate($0) }
        }
        return observable
    }
    
    func getLocation(id: Int) -> Observable<Location?> {
        let remoteRequest = self.locationDataStore.getLocation(id: id)
        let observable = remoteRequest.map { (entity) -> Location? in
            if let entity = entity {
                return LocationTranslator.translate(entity)
            }
            return nil
        }
        return observable
    }
    
    
    
}
