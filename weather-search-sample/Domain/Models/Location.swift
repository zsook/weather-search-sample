//
//  Location.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation

struct Location {
    let title: String
    let woeid: Int
    
    var dailyWeathers: [Weather]?
}

struct Weather {
    let name: String
    let iconState: String
    let temp: Double
    let humidity: Int
}
