//
//  ViewController.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tempTasklist: TaskList = TaskList(listOfTasks: [
        Task(name: "physics hw", time: "9am", category: .academic),
        Task(name: "dentist", time: "9am", category: .health),
        Task(name: "party", time: "9am", category: .social),
        Task(name: "doctors", time: "11am", category: .health, pinned: true),
        Task(name: "Robotics meeting", time: "1pm", category: .social, pinned: true),
        Task(name: "Laundry", time: "3pm", category: .other, pinned: true),
        Task(name: "Job fair", time: "3pm", category: .events, pinned: true),
        Task(name: "Calculus HW", time: "6pm", category: .academic, pinned: true)
        ])
    let cellId = "cellId"
    let headerId = "headerId"
    
    // Task list that will receive data from home screen
    var taskList = TaskList(listOfTasks: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Checks if the segue destination exists and textField has a value
            if let secondVC = segue.destination as? SecondViewController, let thisTaskList = taskList {
                secondVC.taskList = thisTaskList
            }
        }*/
        
        navigationController?.navigationBar.isTranslucent = false
        
        // Calculates the information for the which tasks belong in the sections of the task lists
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()

        // Setup for button to take user to homw screen
        let overviewButton = UIButton(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 50, height: 50))
        overviewButton.backgroundColor = UIColor.yellow


        collectionView?.backgroundColor = UIColor.white
        setupMenuBar()
        
        
        // Registers custom classes for the headers and cells of the task list
        collectionView?.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    // Instance of the custom menu bar
    var menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    // View behind the navigation bar that makes animation transition smooth and no white shows up in the background
    var redView : UIView = {
        let redView = UIView()
        redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        return redView
    }()
    
    // Sets up the menu bar with constraint positioning
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
    
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)

        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // No line spacing between the sections of the navigation bar
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Number of headers
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Establishes custom view for the header 
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        let headerTitle = indexPath.section == 0 ? "Incomplete" : "Current"
        let headerAmountOfTasks = indexPath.section == 0 ? tempTasklist.incompleteTasks.count : tempTasklist.currentTasks.count
        header.headerSectionLabel.text = headerTitle
        //header.amtTasksLeftLabel.text = String(headerAmountOfTasks) + " left"
        return header
    }
    
    // Sets the height of the header section to 80 pixels
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    // Determines how many cells per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //let incompleteTasks = tempTasklist.calculateIncompleteTasks()
        //let currentTasks = tempTasklist.calculateCurrentTasks()
        if (section == 0){
            return tempTasklist.incompleteTasks.count
        }
        return tempTasklist.currentTasks.count
        //return tempTasklist.listOfTasks.count
    }
    
    
    // Amount of section that will appear in the collection view
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Sets the height of the cell to 80 pixels
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    // Establishes custom view for the cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TaskCell
        
        // Sets information for task name
        let taskName = indexPath.section == 0 ? tempTasklist.incompleteTasks[indexPath.row].name : tempTasklist.currentTasks[indexPath.row].name
        cell.taskInfoName.text = String(indexPath.row + 1) + ". " + taskName

        // Sets information for task time
        let taskTime = indexPath.section == 0 ? tempTasklist.incompleteTasks[indexPath.row].time : tempTasklist.currentTasks[indexPath.row].time
        cell.taskInfoTime.text = taskTime
        
        // Sets information for the task category
        let taskCat = indexPath.section == 0 ? tempTasklist.incompleteTasks[indexPath.row].category : tempTasklist.currentTasks[indexPath.row].category
        if taskCat == .academic{
            cell.emojiImageView.image = UIImage(named: "textbook")
            cell.taskInfoView.backgroundColor = UIColor(named: "academicColor")!.withAlphaComponent(0.6)
        } else if taskCat == .social{
            cell.emojiImageView.image = UIImage(named: "hands")
            cell.taskInfoView.backgroundColor = UIColor(named: "socialColor")!.withAlphaComponent(0.6)
        } else if taskCat == .health{
            cell.emojiImageView.image = UIImage(named: "heart")
            cell.taskInfoView.backgroundColor = UIColor(named: "healthColor")!.withAlphaComponent(0.6)
        } else if taskCat == .events{
            cell.emojiImageView.image = UIImage(named: "calander")
            cell.taskInfoView.backgroundColor = UIColor(named: "eventsColor")!.withAlphaComponent(0.6)
        } else {
            cell.emojiImageView.image = UIImage(named: "question")
            cell.taskInfoView.backgroundColor = UIColor(named: "otherColor")!.withAlphaComponent(0.6)
        }
        
        // Based on the section, there is a different action button. For the incomplete section, the button allows the user to move the task to the task list. For the current section, the button allows the user to remove the task from the task list and it compares the category and sends it to the social timeline
        if indexPath.section == 0{
            cell.addSubview(cell.addToCurrentDayButton)
            cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.addToCurrentDayButton)
            cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.addToCurrentDayButton)
            cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
            
        } else {
            cell.addSubview(cell.removeFromCurrentDayButton)
            cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.removeFromCurrentDayButton)
            cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.removeFromCurrentDayButton)
            cell.removeFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    // Removes task from task list and sends it to the social timeline
    @objc func finishTask(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = tempTasklist.currentTasks[indexPath.row]
        tempTasklist.removeTask(task: task)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])

        
        // Sends the task information to the social timeline
        
    }
    
    // Moves task from incomplete to complete section
    @objc func moveTask(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = tempTasklist.incompleteTasks[indexPath.row]
        let tempTask = Task(name: task.name, time: task.time, category: task.category)
        tempTasklist.removeTask(task: task)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        
        tempTasklist.addTask(task: tempTask)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView?.reloadData()

    }
    
}



