//
//  LocationListCoordinator.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit
import RxSwift

class LocationListCoordinator: BaseCoordinator<Void> {
    private weak var navigationController: UINavigationController?
    private let dependencies: LocationCoordinatorDependencies
    
    private weak var locationListViewController: LocationListViewController?
    
    init(navigationController: UINavigationController,
         dependencies: LocationCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<Void> {
        
        let vc = dependencies.makeLocationListViewController()
        navigationController?.pushViewController(vc, animated: false)
        locationListViewController = vc
        
        return Observable.never()
    }
    
    
}
