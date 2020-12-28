//
//  AppDelegate.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/21.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let navigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(window: window!,
                                        appDIContainer: appDIContainer,
                                        navigationController: navigationController)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        return true
    }

}

