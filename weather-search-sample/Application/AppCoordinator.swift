//
//  AppCoordinator.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void>{
    var window: UIWindow
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(window: UIWindow,
         appDIContainer: AppDIContainer,
         navigationController: UINavigationController) {
        self.window = window
        self.appDIContainer = appDIContainer
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let locationSceneDIContainer = appDIContainer.makeLocationSceneDIContainer()
        
        let startCoordinator = locationSceneDIContainer.makeLocationListCoordinator(navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: startCoordinator)
    }
}
