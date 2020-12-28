//
//  DIContainer.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import Foundation

final class AppDIContainer {
    
    func makeLocationSceneDIContainer() -> LocationSceneDIContainer {
        return LocationSceneDIContainer()
    }
}
