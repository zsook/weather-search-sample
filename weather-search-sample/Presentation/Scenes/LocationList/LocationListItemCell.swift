//
//  LocationListItemCell.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit
import Kingfisher

class LocationListItemCell: UITableViewCell {
    
    fileprivate lazy var locationTitleLable: UILabel = self.createLocationTitleLabel()
    
    // today
    fileprivate lazy var todayWeatherIconImageView: UIImageView = self.createWeatherIconImageView()
    fileprivate lazy var todayWeatherStateLabel: UILabel = self.createWeatherStateLabel()
    fileprivate lazy var todayWeatherTempLabel: UILabel = self.createWeatherTempLabel()
    fileprivate lazy var todayWeatherHumidityLabel: UILabel = self.createWeatherHumidityLabel()
    
    // tomorrow
    fileprivate lazy var tomorrowWeatherIconImageView: UIImageView = self.createWeatherIconImageView()
    fileprivate lazy var tomorrowWeatherStateLabel: UILabel = self.createWeatherStateLabel()
    fileprivate lazy var tomorrowWeatherTempLabel: UILabel = self.createWeatherTempLabel()
    fileprivate lazy var tomorrowWeatherHumidityLabel: UILabel = self.createWeatherHumidityLabel()
    
    private var viewModel: LocationListItemViewModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func commonInit() {
        setupViews()
    }
    
    func bind(with viewModel: LocationListItemViewModel) {
        locationTitleLable.text = viewModel.locationTitle
        
        todayWeatherTempLabel.text = "\(viewModel.todayWeatherTemp)℃"
        todayWeatherStateLabel.text = viewModel.todayWeatherState
        todayWeatherHumidityLabel.text = "\(viewModel.todayWeatherHumidity)%"
        todayWeatherIconImageView.kf.setImage(with: URL(string: viewModel.todayWeatherIconURLPath))
        
        tomorrowWeatherTempLabel.text = "\(viewModel.tomorrowWeatherTemp)℃"
        tomorrowWeatherStateLabel.text = viewModel.tomorrowWeatherState
        tomorrowWeatherHumidityLabel.text = "\(viewModel.tomorrowWeatherHumidity)%"
        tomorrowWeatherIconImageView.kf.setImage(with: URL(string: viewModel.tomorrowWeatherIconURLPath))
        
    }
}

extension LocationListItemCell {
    private func setupViews() {
        
        let todayWeatherInfoView = createWeatherInfoView(iconImageView: todayWeatherIconImageView,
                                                         stateLabel: todayWeatherStateLabel,
                                                         tempLabel: todayWeatherTempLabel,
                                                         humidityLabel: todayWeatherHumidityLabel)
        
        let tomorrowWeatherInfoView = createWeatherInfoView(iconImageView: tomorrowWeatherIconImageView,
                                                            stateLabel: tomorrowWeatherStateLabel,
                                                            tempLabel: tomorrowWeatherTempLabel,
                                                            humidityLabel: tomorrowWeatherHumidityLabel)
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [locationTitleLable, todayWeatherInfoView, tomorrowWeatherInfoView])
            view.axis = .horizontal
            return view
        }()
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationTitleLable.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
        
        todayWeatherInfoView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
        tomorrowWeatherInfoView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
    }
    
    private func createWeatherInfoView(iconImageView: UIImageView,
                                       stateLabel: UILabel,
                                       tempLabel: UILabel,
                                       humidityLabel: UILabel) -> UIView {
        
        let view = UIView()
        
        let tempAndHumidityStackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [tempLabel, humidityLabel])
            view.axis = .horizontal
            view.distribution = .fill
            view.spacing = 5
            return view
        }()
        
        let labelsStackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stateLabel, tempAndHumidityStackView])
            view.axis = .vertical
            view.distribution = .fill
            view.spacing = 10
            return view
        }()
        
        view.addSubview(labelsStackView)
        view.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.leading.centerY.equalToSuperview()
        }
        
        labelsStackView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(iconImageView)
        }
        
        return view
    }
    
    private func createLocationTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }
    
    private func createWeatherIconImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    private func createWeatherStateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }
    
    private func createWeatherTempLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }
    
    private func createWeatherHumidityLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }
}
