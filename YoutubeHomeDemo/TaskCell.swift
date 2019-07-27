//
//  TaskCell.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TaskCell: BaseCell {
    
    let taskInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple.withAlphaComponent(0.3)
        view.layer.borderWidth = 1
        return view
    }()
    
    let taskInfoName: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskInfoTime: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let finishTaskButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        return button
    }()
    
    let addTaskButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        return button
    }()
    
    let emojiImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    
    
    /*let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        //imageView.image = UIImage(named: "taylor_swift_blank_space")
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.red
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()*/
    
    override func setupViews() {
        
//        H: (Horizontal) //horizontal direction
//        V: (Vertical) //vertical direction
//        | (pipe) //superview
//        - (dash) //standard spacing (generally 8 points)
//        [] (brackets) //name of the object (uilabel, unbutton, uiview, etc.)
//        () (parentheses) //size of the object
//        == equal widths //can be omitted
//        -16- non standard spacing (16 points)
//        <= less than or equal to
//        >= greater than or equal to
//        @250 priority of the constraint //can have any value between 0 and 1000
        
        
        addSubview(taskInfoView)
        taskInfoView.addSubview(taskInfoName)
        taskInfoView.addSubview(taskInfoTime)
        addSubview(finishTaskButton)
        addSubview(addTaskButton)
        addSubview(emojiImageView)
        addSubview(separatorView)
        
        addConstraintsWithFormat(format: "H:|-22-[v0(30)]-10-[v1(250)]-50-[v2(30)]", views: emojiImageView, taskInfoView, finishTaskButton)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: emojiImageView)
        //addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: taskInfoView)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: finishTaskButton)
        addConstraintsWithFormat(format: "H:|-10-[v0(190)]-20-[v1(20)]", views: taskInfoName, taskInfoTime)
        addConstraintsWithFormat(format: "V:|-5-[v0(20)]", views: taskInfoName)
        addConstraintsWithFormat(format: "V:|-5-[v0(20)]", views: taskInfoTime)
        
        
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]-24-[v1(1)]", views: taskInfoView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        
        
        /*addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))*/
        
    }
    
    
    

}


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
