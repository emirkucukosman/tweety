//
//  TweetCell.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var authorLabel: UILabel!
    var bodyLabel: UILabel!
    var dateLabel: UILabel!
    var authorImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textColor = .label
        
        bodyLabel = UILabel()
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.textColor = .label
        bodyLabel.numberOfLines = 0
        bodyLabel.lineBreakMode = .byWordWrapping
        
        authorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.contentMode = .scaleAspectFit
        authorImageView.makeRounded()
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(authorImageView)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
            authorLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bodyLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 30),
            bodyLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -20),
                        
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
