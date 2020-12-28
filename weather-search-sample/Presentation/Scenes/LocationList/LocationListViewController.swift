//
//  LocationListViewController.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Alamofire

final class LocationListViewController: UIViewController {
   
    fileprivate lazy var locationTableView: UITableView = self.createLocationTableView()
    fileprivate lazy var loadingView: UIActivityIndicatorView = self.createLoadingView()
    
    private var viewModel: LocationListViewModel!
    
    var disposeBag = DisposeBag()
    
    static func create(with viewModel: LocationListViewModel) -> LocationListViewController {
        let view = LocationListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: LocationListViewModel) {
        locationTableView
          .rx.setDelegate(self)
          .disposed(by: disposeBag)
        
        let observableQuery = Observable.just("se")
        
        let input = LocationListViewModel.Input(query: observableQuery)
        
        let output = viewModel.transform(input: input)
        
        // bind to UITableView
        output.locations.drive(locationTableView.rx.items(cellIdentifier: LocationListItemCell.cellIdentifier,
                                                          cellType: LocationListItemCell.self)) { _, viewModel, cell in
            cell.bind(with: viewModel)
        }.disposed(by: disposeBag)
        
        output.hideLoading
            .bind(onNext: { (isHidding) in
                if !isHidding {
                    self.loadingView.startAnimating()
                    self.loadingView.isHidden = false
                    self.locationTableView.isHidden = true
                }else {
                    self.loadingView.stopAnimating()
                    self.loadingView.isHidden = true
                    self.locationTableView.isHidden = false
                }
                
            })
            .disposed(by: disposeBag)
    }
}

// MARK:- UITableViewDelegate

extension LocationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LocationListItemHeaderCell()
        view.backgroundColor = UIColor(hexString: "f9f9f9")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK:- UI

extension LocationListViewController {
    
    private func setupViews() {
        setNavigation()
        
        view.backgroundColor = .white
        
        let titleView = createTitleView(with: "Local Weather")
        let topPaddingView = UIView()
        topPaddingView.backgroundColor = .systemRed
        
        view.addSubview(topPaddingView)
        view.addSubview(titleView)
        view.addSubview(locationTableView)
        view.addSubview(loadingView)
        
        topPaddingView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(topPaddingView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func createTitleView(with text: String) -> UIView {
        let view = UIView()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return label
        }()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        return view
    }
    
    private func createLocationTableView() -> UITableView {
        let tableView = UITableView()
        tableView.refreshControl = UIRefreshControl()
        tableView.register(LocationListItemHeaderCell.self, forCellReuseIdentifier: LocationListItemHeaderCell.cellIdentifier)
        tableView.register(LocationListItemCell.self, forCellReuseIdentifier: LocationListItemCell.cellIdentifier)

        return tableView
    }
    
    private func createLoadingView() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)
        activityIndicatorView.style = .gray
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.isHidden = true

        return activityIndicatorView
    }
}


