//
//  LocationListItemHeaderCell.swift
//  weather-search-sample
//
//  Created by 김지수 on 2020/12/23.
//

import UIKit

class LocationListItemHeaderCell: UITableViewCell {
    
    fileprivate lazy var locationLabel: UILabel = self.createLabel(text: "Local")
    fileprivate lazy var todayLabel: UILabel = self.createLabel(text: "Today", weight: .bold)
    fileprivate lazy var tomorrowLabel: UILabel = self.createLabel(text: "Tomorrow", weight: .bold)
    
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
}

extension LocationListItemHeaderCell {
    private func setupViews() {
        
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [locationLabel, todayLabel, tomorrowLabel])
            view.axis = .horizontal
            view.distribution = .fillProportionally
            return view
        }()
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        locationLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
        
        todayLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
        tomorrowLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    private func createLabel(text: String, weight: UIFont.Weight = .regular) -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: weight)
        label.textAlignment = .center
        label.text = text
        
        return label
    }
}
