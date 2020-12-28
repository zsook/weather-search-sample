//
//  SceneDIContainer.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit

protocol LocationCoordinatorDependencies  {
    func makeLocationListViewController() -> LocationListViewController
}

final class LocationSceneDIContainer: LocationCoordinatorDependencies{
    init() { }
    
    func makeLocationListViewModel() -> LocationListViewModel {
        return LocationListViewModel(searchUseCase: makeSearchLocationsUseCase(),
                                     fetchUseCase: makeFetchLocationUseCase())
    }
    
    func makeSearchLocationsUseCase() -> SearchLocationsUseCase {
        return DefaultSearchLocationsUseCase(locationRepository: makeLocationRepository())
    }
    
    func makeFetchLocationUseCase() -> FetchLocationDetailUseCase {
        return DefaultFetchLocationDetailUseCase(locationRepository: makeLocationRepository())
    }
    
    func makeLocationRepository() -> LocationRepository {
        return DefaultLocationRepository(locationDataStore: LocationRemoteDataStore())
    }
    
    func makeLocationListViewController() -> LocationListViewController {
        return LocationListViewController.create(with: makeLocationListViewModel())
    }
    
    func makeLocationListCoordinator(navigationController: UINavigationController) -> LocationListCoordinator {
        return LocationListCoordinator(navigationController: navigationController,
                                       dependencies: self)
    }
}
