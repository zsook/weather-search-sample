//
//  LocationListViewModel.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import Foundation
import RxSwift
import RxCocoa

final class LocationListViewModel: ViewModelType {
    struct Input {
        let query: Observable<String>
        let isHiddenLoading = BehaviorRelay<Bool>(value: false)
    }
    
    struct Output {
        let locations: Driver<[LocationListItemViewModel]>
        let hideLoading: Observable<Bool>
    }
    
    private let searchUseCase: SearchLocationsUseCase
    private let fetchUseCase: FetchLocationDetailUseCase
    
    var disposeBag = DisposeBag()
    
    init(searchUseCase: SearchLocationsUseCase,
         fetchUseCase: FetchLocationDetailUseCase) {
        self.searchUseCase = searchUseCase
        self.fetchUseCase = fetchUseCase
        
    }
    
    func transform(input: Input) -> Output {

        let isHiddenLoading = input.isHiddenLoading

        let locations = input.query
            .flatMapLatest { [self] (query) -> Observable<[Location]> in
                self.searchUseCase.excute(query: query)
            }
            .flatMapLatest { [self] (locations) -> Observable<[LocationListItemViewModel]> in
                let observerbles = locations.compactMap { (location) -> Observable<Location?>  in
                    return self.fetchUseCase.excute(id: location.woeid)
                }

                return Observable.zip(observerbles)
                    .map { location -> [LocationListItemViewModel] in
                        location.compactMap {
                            if let location = $0 {
                                return LocationListItemViewModel(location: location)
                            }
                            return nil
                        }
                    }

            }
            .do(onNext: { locations in
                isHiddenLoading.accept(true)
            })
            .asDriver(onErrorJustReturn: [])

        
        return Output(locations: locations,
                      hideLoading: isHiddenLoading.asObservable())
    }
}
