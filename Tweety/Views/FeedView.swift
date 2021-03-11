//
//  FeedView.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class FeedView: UIView {
    
    var shouldUpdateConstraints = true
    
    var tableView: UITableView!
    
    let tableViewRefresher = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView()
        tableView.refreshControl = tableViewRefresher
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
        tableView.register(TweetCell.self, forCellReuseIdentifier: "tweetCell")
        
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if shouldUpdateConstraints {
            
            NSLayoutConstraint.activate([
                tableView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
                tableView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
                tableView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                tableView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            ])
            
            shouldUpdateConstraints = false
        }
    }
}
