//
//  GuideListVC.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import UIKit
import os

class GuideListVC: UIViewController {
    // TODO: Move this somewhere central for reuse
    let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyy"
        return dateFormatter
    }()
    
    var guideService : GuideListDataService
    var guideList : GuideList?
    var tableView : UITableView = UITableView()
    
    convenience init() {
        self.init(guideService: GuideListDataService())
    }
    
    init(guideService: GuideListDataService) {
        self.guideService = guideService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        fetchGuideList()
        // TODO: Show loading icon
        // TODO: Show error from response
    }
    
    @MainActor
    func setupNavigationBar() {
        self.navigationItem.title = "Upcoming Guides"
    }
    
    @MainActor
    func setupTableView() {
        tableView.register(GuideTableViewCell.self, forCellReuseIdentifier: GuideTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 60.0;
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @MainActor
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func fetchGuideList() {
        Task {
            guideList = await guideService.getUpcomingGuides()
            reloadTableView()
        }
    }
}

extension GuideListVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return guideList?.startDates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let date = guideList?.startDates[section] else {
            Logger.logger.error("miscalculated number of sections")
            return 0
        }
        
        return guideList?.upcomingGuides[date]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = guideList?.startDates[section] else {
            Logger.logger.error("date for section \(section) does not exist")
            return nil
        }
        
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GuideTableViewCell.identifier, for: indexPath) as? GuideTableViewCell ?? GuideTableViewCell()
        
        guard let date = guideList?.startDates[indexPath.section] else {
            Logger.logger.error("date for index path \(indexPath) does not exist")
            return cell
        }
        
        guard let guide = guideList?.upcomingGuides[date] else {
            Logger.logger.error("guides for index path \(indexPath) does not exist")
            return cell
        }
        
        cell.configureWith(guide: guide[indexPath.row])
        
        return cell
    }
}

