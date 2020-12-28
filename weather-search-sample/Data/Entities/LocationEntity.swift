//
//  LocationEntity.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation

// 지역별 날씨 정보
struct LocationEntity: Codable {
    let title: String
    let woeid: Int
    var dailyWeathers: [WeatherEntity]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case woeid
        case dailyWeathers = "consolidated_weather"
    }
}

extension LocationEntity {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        woeid = try values.decode(Int.self, forKey: .woeid)
        title = try values.decode(String.self, forKey: .title)
        dailyWeathers = try? values.decode([WeatherEntity].self, forKey: .dailyWeathers)
    }
}

struct WeatherEntity: Codable {
    let name: String           // 날씨 요약
    let iconState: String      // 아이콘 이미지 정보
    let temp: Double              // 온도
    let humidity:Int        // 습도
    
    private enum CodingKeys: String, CodingKey {
        case name = "weather_state_name"
        case iconState = "weather_state_abbr"
        case temp = "the_temp"
        case humidity
    }
}
