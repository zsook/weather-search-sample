//
//  LocationWeatherTranslator.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation

final class LocationTranslator: Translator {
    typealias Input = LocationEntity
    typealias Output = Location
    
    static func translate(_ entity: Input) -> Output {
        let weathers = entity.dailyWeathers?.map {
            WeatherTranslator.translate($0)
        }
        return Location(title: entity.title,
                               woeid: entity.woeid,
                               dailyWeathers: weathers)
    }
}

final class WeatherTranslator: Translator {
    typealias Input = WeatherEntity
    typealias Output = Weather
    
    static func translate(_ entity: Input) -> Output {
        return Weather(name: entity.name,
                       iconState: entity.iconState,
                       temp: entity.temp,
                       humidity: entity.humidity)
    }
}
