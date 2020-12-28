//
//  LocationListItemViewModel.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import Foundation

struct LocationListItemViewModel {
    
    let locationTitle: String
    let locationID: Int
    
    // today
    var todayWeatherIconURLPath = ""
    var todayWeatherState = ""
    var todayWeatherTemp = 0
    var todayWeatherHumidity = 0
    
    // tomorrow
    var tomorrowWeatherIconURLPath  = ""
    var tomorrowWeatherState  = ""
    var tomorrowWeatherTemp = 0
    var tomorrowWeatherHumidity = 0
}

extension LocationListItemViewModel {
    init(location: Location) {
        self.locationTitle = location.title
        self.locationID = location.woeid
        
        
        guard let weathers = location.dailyWeathers else {
            return
        }
        
        for (index, weather) in weathers.enumerated() {
            if index == 0 {
                self.todayWeatherState = weather.name
                self.todayWeatherTemp = Int(weather.temp)
                self.todayWeatherHumidity = weather.humidity
                self.todayWeatherIconURLPath = self.iconURLPath(by: weather.iconState)
            
            }else if index == 1 {
                self.tomorrowWeatherState = weather.name
                self.tomorrowWeatherTemp = Int(weather.temp)
                self.tomorrowWeatherHumidity = weather.humidity
                self.tomorrowWeatherIconURLPath = self.iconURLPath(by: weather.iconState)
            }
        }
    }
    
    private func iconURLPath(by state: String) -> String {
        "https://www.metaweather.com/static/img/weather/png/64/\(state).png"
    }
    
}
