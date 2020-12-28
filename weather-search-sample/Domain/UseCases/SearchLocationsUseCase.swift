//
//  SearchLocationsUseCase.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import RxSwift

protocol SearchLocationsUseCase {
    func excute(query: String) -> Observable<[Location]>
}

final class DefaultSearchLocationsUseCase: SearchLocationsUseCase {
    
    private let locationRepository: LocationRepository
    
    init (locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    func excute(query: String) -> Observable<[Location]> {
        return locationRepository.getLocations(query: query)
    }
}
