//
//  FetchLocationDetailUseCase.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import RxSwift

protocol FetchLocationDetailUseCase {
    func excute(id: Int) -> Observable<Location?>
}

final class DefaultFetchLocationDetailUseCase: FetchLocationDetailUseCase {
    
    private let locationRepository: LocationRepository
    
    init (locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    func excute(id: Int) -> Observable<Location?> {
        locationRepository.getLocation(id: id)
    }
}
