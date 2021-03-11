//
//  FeedViewController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    var feedView: FeedView!
    lazy var tweetViewModel: TweetViewModel = {
        print("tweet view model called")
        return TweetViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        feedView = FeedView()
        feedView.tableViewRefresher.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        view.addSubview(feedView)
        
        NSLayoutConstraint.activate([
            feedView.topAnchor.constraint(equalTo: view.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        setupDrivers()
        tweetViewModel.getTweets()
    }
    
    func setupDrivers() {
        
        tweetViewModel.tweets
            .drive(feedView.tableView.rx.items(cellIdentifier: "tweetCell")) { row, model, cell in
                if let cell = cell as? TweetCell {
                    cell.authorLabel.text = model.author
                    cell.bodyLabel.text = model.body
                    cell.dateLabel.text = model.createdAt
                    cell.authorImageView.image = UIImage(systemName: "person.fill", compatibleWith: .current)!
                    cell.authorImageView.downloadImage(from: model.authorPhotoURL)
                }
            }
            .disposed(by: tweetViewModel.disposeBag)
        
        tweetViewModel.error
            .drive { (error) in
                if let error = error {
                    let alert = self.getAlert(title: "Error", message: error)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            .disposed(by: tweetViewModel.disposeBag)

        tweetViewModel.tweetsLoading
            .drive(feedView.tableViewRefresher.rx.isRefreshing)
            .disposed(by: tweetViewModel.disposeBag)
    }
    
    @objc
    func refreshTableView() {
        tweetViewModel.getTweets()
    }
}
