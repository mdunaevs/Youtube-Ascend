//
//  HomeControllerUsingTableView.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/27/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class HomeControllerUsingTableView: UITableViewController {
    
    let cellId = "cellId"
    var tempTasklist: TaskList = TaskList(listOfTasks: [
        Task(name: "physics hw", time: "9am", category: .academic),
        Task(name: "doctors", time: "11am", category: .health),
        Task(name: "Robotics meeting", time: "1pm", category: .social),
        Task(name: "Laundry", time: "3pm", category: .other),
        Task(name: "Job fair", time: "3pm", category: .events),
        Task(name: "Calculus test", time: "3pm", category: .academic, pinned: true)
        ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Task"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
       
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "header"
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let incompleteTasks = tempTasklist.calculateIncompleteTasks()
        let dailyTasks = tempTasklist.calculateCurrentTasks()

        //if section == 0 {
        //    return incompleteTasks.count
       // }
       // return dailyTasks.count
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        
        let incompleteTasks = tempTasklist.calculateIncompleteTasks()
        let dailyTasks = tempTasklist.calculateCurrentTasks()

        
        //let name = indexPath.section == 0 ? incompleteTasks[indexPath.row].name :
           // dailyTasks[indexPath.row].name
        
        //let time = indexPath.section == 0 ? incompleteTasks[indexPath.row].time :
            //dailyTasks[indexPath.row].time
        
        
        //cell.taskInfoName.text = String(indexPath.row + 1) + ". " + tempTasklist.listOfTasks[indexPath.row].name
        //cell.taskInfoTime.text = tempTasklist.listOfTasks[indexPath.row].time
        
        //cell.taskInfoName.text = String(indexPath.row + 1) + ". " + name
        //cell.taskInfoTime.text = time
        
        
        if tempTasklist.listOfTasks[indexPath.row].category == .academic{
            cell.emojiImageView.image = UIImage(named: "textbook")
            cell.taskInfoView.backgroundColor = UIColor(named: "academicColor")!.withAlphaComponent(0.6)
        } else if tempTasklist.listOfTasks[indexPath.row].category == .social{
            cell.emojiImageView.image = UIImage(named: "hands")
            cell.taskInfoView.backgroundColor = UIColor(named: "socialColor")!.withAlphaComponent(0.6)
        } else if tempTasklist.listOfTasks[indexPath.row].category == .health{
            cell.emojiImageView.image = UIImage(named: "heart")
            cell.taskInfoView.backgroundColor = UIColor(named: "healthColor")!.withAlphaComponent(0.6)
        } else if tempTasklist.listOfTasks[indexPath.row].category == .events{
            cell.emojiImageView.image = UIImage(named: "calander")
            cell.taskInfoView.backgroundColor = UIColor(named: "eventsColor")!.withAlphaComponent(0.6)
        } else {
            cell.emojiImageView.image = UIImage(named: "question")
            cell.taskInfoView.backgroundColor = UIColor(named: "otherColor")!.withAlphaComponent(0.6)
        }
        
        return cell
    }
    
}

class CustomCell: UITableViewCell{
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
    
    func setupViews() {
        
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
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

