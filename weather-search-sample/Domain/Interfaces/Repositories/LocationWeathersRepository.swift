//
//  LocationWeathersRepository.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation
import RxSwift

protocol LocationRepository {
    func getLocations(query: String) -> Observable<[Location]>
    func getLocation(id: Int) -> Observable<Location?>
    
}
