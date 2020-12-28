//
//  Translator.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/22.
//

import Foundation

protocol Translator: class {
    associatedtype Input
    associatedtype Output

    static func translate(_ entity: Input) -> Output
}
