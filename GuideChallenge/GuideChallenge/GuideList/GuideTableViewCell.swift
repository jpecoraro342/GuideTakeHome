//
//  GuideTableViewCell.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/31/23.
//

import UIKit
import os

class GuideTableViewCell: UITableViewCell {
    private let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyy"
        return dateFormatter
    }()
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let subtitleLabel : UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    private let endDateLabel : UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        endDateLabel.textColor = .secondaryLabel
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return endDateLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init() {
        self.init(style: .default, reuseIdentifier: Self.identifier)
    }
    
    func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(endDateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: endDateLabel.leadingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            endDateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            endDateLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            endDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        endDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        endDateLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    @MainActor
    func configureWith(guide: Guide) {
        titleLabel.text = guide.name
        endDateLabel.text = dateFormatter.string(from: guide.endDate)
        
        if let city = guide.venue?.city, let state = guide.venue?.state {
            subtitleLabel.text = "\(city), \(state)"
        } else {
            // It seems like the city/state isn't being provided from the api right now (response is "venue": {})
            // So just doing this as a visual placeholder
            subtitleLabel.text = "City, State Not Provided"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
