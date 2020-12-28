//
//  UITableViewCell+.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
