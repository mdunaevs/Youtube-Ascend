//
//  VideoCell.swift
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TaskCell: BaseCell {
    
    // Elements for the cell view
    
    // Subview which contains information regarding name and time of a task
    let taskInfoView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.purple.withAlphaComponent(0.3)
        //view.layer.borderWidth = 1
        return view
    }()
    
    // Subview of taskInfoView which will display the task name
    let taskInfoName: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Subview of taskInfoView which will display the task time
    let taskInfoTime: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // Button for cells in the current section
    let finishFromCurrentDayButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.red
        button.setImage(UIImage(named: "square"), for: .normal)
        return button
    }()
    
    // Button for cells in the incomplete section
    let addToCurrentDayButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.orange
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    let removeFromCurrentDayButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.orange
        button.setImage(UIImage(named: "remove"), for: .normal)
        return button
    }()
    
    // Displays emoji based on category type
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
        addSubview(taskInfoTime)
        addSubview(emojiImageView)
        addSubview(separatorView)
        addSubview(addToCurrentDayButton)
        addSubview(finishFromCurrentDayButton)
        addSubview(removeFromCurrentDayButton)
        
        addConstraintsWithFormat(format: "H:|-22-[v0(30)]-10-[v1(230)]-10-[v2(40)]", views: emojiImageView, taskInfoView, taskInfoTime)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: emojiImageView)
        //addConstraintsWithFormat(format: "H:|-10-[v0(180)]-20-[v1(40)]", views: taskInfoName, taskInfoTime)
        addConstraintsWithFormat(format: "H:|-10-[v0(180)]", views: taskInfoName)
        addConstraintsWithFormat(format: "V:|-5-[v0(20)]", views: taskInfoName)
        //addConstraintsWithFormat(format: "V:|-5-[v0(20)]", views: taskInfoTime)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: taskInfoTime)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]-24-[v1(1)]", views: taskInfoView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: addToCurrentDayButton)
        addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: addToCurrentDayButton)
        
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: finishFromCurrentDayButton)
        addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: finishFromCurrentDayButton)
        
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: removeFromCurrentDayButton)
        addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: removeFromCurrentDayButton)
        
        hideRemove()
    }
    
    func setTaskName(taskName: String){
        taskInfoName.text = taskName
    }
    
    func setTaskTime(taskTime: String){
        taskInfoTime.text = taskTime
    }
    
    func setEmojiImage(imageName: String){
        emojiImageView.image = UIImage(named: imageName)
    }
    
    func setTaskInfoBackground(categoryColor: String){
        taskInfoView.backgroundColor = UIColor(named: categoryColor)!.withAlphaComponent(0.6)
    }
    
    func hideAdd(){
        addToCurrentDayButton.isHidden = true
    }
    
    func showAdd(){
        addToCurrentDayButton.isHidden = false
    }
    
    func hideFinish(){
        finishFromCurrentDayButton.isHidden = true
    }
    
    func showFinish(){
        finishFromCurrentDayButton.isHidden = false
    }
    
    func hideRemove(){
        removeFromCurrentDayButton.isHidden = true
    }
    
    func showRemove(){
        removeFromCurrentDayButton.isHidden = false
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
