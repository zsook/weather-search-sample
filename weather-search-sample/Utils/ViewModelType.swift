//
//  ViewModelType.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
