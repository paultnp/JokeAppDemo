//
//  JokeTableViewCell.swift
//  JokeAppDemo
//
//  Created by Teenanath on 29/08/23.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    let lableJoke = UILabel()
    let lableDate = UILabel()
    let containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        // Customize cell layout
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        containerView.backgroundColor = UIColor(red: 190.0/255.0, green: 250.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 5
        contentView.addSubview(containerView)

        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true

        
        lableJoke.translatesAutoresizingMaskIntoConstraints = false
        lableJoke.numberOfLines = 0
        containerView.addSubview(lableJoke)
        
        lableDate.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lableDate)
        
        lableJoke.textColor = .black
        lableJoke.font = UIFont.init(name: "Arial", size: 14)
        lableJoke.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        lableJoke.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        lableJoke.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8).isActive = true
        lableJoke.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        
        lableDate.textColor = .gray
        lableDate.font = UIFont.init(name: "Arial", size: 12)
        lableDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        lableDate.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    func animateView() {
        self.containerView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

        UIView.animate(withDuration: 1, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.containerView.transform = .identity
            }
        }
    }
    
}
