//
//  ViewController.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class TaskListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        setupTopBar()

        collectionView?.backgroundColor = UIColor.white
        setupMenuBar()
        
        
        // Registers custom classes for the headers and cells of the task list
        collectionView?.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    // Button which segues to home screen when clicked
    let overviewButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.yellow
        button.setImage(UIImage(named: "upwards-2sided"), for: .normal)
        return button
    }()
    
    
    // Sets up the top section of the navigation bar
    private func setupTopBar(){
        navigationController?.navigationBar.addSubview(overviewButton)
        navigationController?.navigationBar.addConstraintsWithFormat(format: "H:|-182-[v0(50)]", views: overviewButton)
        navigationController?.navigationBar.addConstraintsWithFormat(format: "V:|-8-[v0(50)]", views: overviewButton)
        overviewButton.addTarget(self, action: #selector(segueToHomeScreen(_:)), for: .touchUpInside)
    }
    
    @objc func segueToHomeScreen(_ sender: UIButton){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        present(controller!, animated: true, completion: nil)
    }
    
    // Instance of the custom menu bar
    var menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    // View behind the navigation bar that makes animation transition smooth and no white shows up in the background
    var redView : UIView = {
        let redView = UIView()
        //redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        //redView.backgroundColor = UIColor.blue
        redView.backgroundColor = UIColor(red: 91/255, green: 185/255, blue: 235/255, alpha: 1)
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
        
        menuBar.editButton.addTarget(self, action: #selector(clickedEditButton(_:)), for: .touchUpInside)
    }
    
    @objc func clickedEditButton(_ sender: UIButton){
        print("Switching mode \n")
        if menuBar.editButton.titleLabel?.text == "Edit"{
            menuBar.editButton.setTitle("Done", for: .normal)
            collectionView?.reloadData()
            
        } else {
            menuBar.editButton.setTitle("Edit", for: .normal)
            collectionView?.reloadData()
        }
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
        //let headerAmountOfTasks = indexPath.section == 0 ? tempTasklist.incompleteTasks.count : tempTasklist.currentTasks.count
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
        cell.setTaskName(taskName: taskName)
        //cell.taskInfoName.text = String(indexPath.row + 1) + ". " + taskName
        //print(taskName + ":" + "(\(indexPath.section), \(indexPath.row)) + contains add task: \(cell.subviews.contains(cell.addToCurrentDayButton))")

        // Sets information for task time
        let taskTime = indexPath.section == 0 ? tempTasklist.incompleteTasks[indexPath.row].time : tempTasklist.currentTasks[indexPath.row].time
        cell.setTaskTime(taskTime: taskTime)
        //cell.taskInfoTime.text = taskTime
        
        // Sets information for the task category
        let taskCat = indexPath.section == 0 ? tempTasklist.incompleteTasks[indexPath.row].category : tempTasklist.currentTasks[indexPath.row].category
        if taskCat == .academic{
            //cell.emojiImageView.image = UIImage(named: "textbook")
            //cell.taskInfoView.backgroundColor = UIColor(named: "academicColor")!.withAlphaComponent(0.6)
            cell.setEmojiImage(imageName: "textbook")
            cell.setTaskInfoBackground(categoryColor: "academicColor")
            cell.backgroundColor = UIColor(named: "academicColor")?.withAlphaComponent(0.6)
        } else if taskCat == .social{
            //cell.emojiImageView.image = UIImage(named: "hands")
            //cell.taskInfoView.backgroundColor = UIColor(named: "socialColor")!.withAlphaComponent(0.6)
            cell.setEmojiImage(imageName: "hands")
            cell.setTaskInfoBackground(categoryColor: "socialColor")
            cell.backgroundColor = UIColor(named: "socialColor")?.withAlphaComponent(0.6)
        } else if taskCat == .health{
            //cell.emojiImageView.image = UIImage(named: "heart")
            //cell.taskInfoView.backgroundColor = UIColor(named: "healthColor")!.withAlphaComponent(0.6)
            cell.setEmojiImage(imageName: "heart")
            cell.setTaskInfoBackground(categoryColor: "healthColor")
            cell.backgroundColor = UIColor(named: "healthColor")?.withAlphaComponent(0.6)
        } else if taskCat == .events{
            //cell.emojiImageView.image = UIImage(named: "calander")
            //cell.taskInfoView.backgroundColor = UIColor(named: "eventsColor")!.withAlphaComponent(0.6)
            cell.setEmojiImage(imageName: "calander")
            cell.setTaskInfoBackground(categoryColor: "eventsColor")
            cell.backgroundColor = UIColor(named: "eventsColor")?.withAlphaComponent(0.6)
        } else {
           // cell.emojiImageView.image = UIImage(named: "question")
            //cell.taskInfoView.backgroundColor = UIColor(named: "otherColor")!.withAlphaComponent(0.6)
            cell.setEmojiImage(imageName: "question")
            cell.setTaskInfoBackground(categoryColor: "otherColor")
            cell.backgroundColor = UIColor(named: "otherColor")?.withAlphaComponent(0.6)
        }
        
        if menuBar.editButton.titleLabel?.text == "Edit" {
            if indexPath.section == 0 {
                cell.hideFinish()
                cell.hideRemove()
                cell.showAdd()
                cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
            } else {
                cell.hideAdd()
                cell.hideRemove()
                cell.showFinish()
                cell.finishFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
            }
        } else {
            if indexPath.section == 0{
                cell.hideAdd()
                cell.hideFinish()
                cell.showRemove()
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(removeTaskFromIncomplete(_:)), for: .touchUpInside)
            } else {
                cell.hideAdd()
                cell.hideFinish()
                cell.showRemove()
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(removeTaskFromCurrent(_:)), for: .touchUpInside)
            }
        }
        
        /*if ((cell.subviews.contains(cell.addToCurrentDayButton) == false && indexPath.section == 0) || (cell.subviews.contains(cell.finishFromCurrentDayButton) == false && indexPath.section == 1)) {
            if indexPath.section == 0{
                cell.addSubview(cell.addToCurrentDayButton)
                //cell.removeFromCurrentDayButton.isHidden = true
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.addToCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.addToCurrentDayButton)
                
                cell.addSubview(cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.removeFromCurrentDayButton)
                
                cell.removeFromCurrentDayButton.isHidden = true
                print("Created add task button and remove from current day button")
                print("\(cell.subviews.contains(cell.addToCurrentDayButton)), \(cell.subviews.contains(cell.removeFromCurrentDayButton))")
                cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
            } else {
                cell.addSubview(cell.finishFromCurrentDayButton)
                //cell.addToCurrentDayButton.isHidden = true
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.finishFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.finishFromCurrentDayButton)
                
                cell.addSubview(cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.removeFromCurrentDayButton.isHidden = true
                print("Created finish task button and remove from current day button")
                cell.finishFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
            }
        } else {
            if menuBar.editButton.titleLabel?.text == "Edit" {
                // Based on the section, there is a different action button. For the incomplete section, the button allows the user to move the task to the task list. For the current section, the button allows the user to remove the task from the task list and it compares the category and sends it to the social timeline
                if indexPath.section == 0{
                    //cell.addSubview(cell.addToCurrentDayButton)
                    print("Showing add button and hiding finish and remove")
                    cell.addToCurrentDayButton.isHidden = false
                    cell.finishFromCurrentDayButton.isHidden = true
                    cell.removeFromCurrentDayButton.isHidden = true
                    cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
                    
                } else {
                    //cell.addSubview(cell.finishFromCurrentDayButton)
                    print("Showing finish button and hiding add and remove")
                    cell.addToCurrentDayButton.isHidden = true
                    cell.finishFromCurrentDayButton.isHidden = false
                    cell.removeFromCurrentDayButton.isHidden = true
                    cell.finishFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
                }
                //print(cell.subviews.contains(cell.addToCurrentDayButton))
            } else {
                if indexPath.section == 0{
                    //cell.addToCurrentDayButton.removeFromSuperview()
                    //cell.willRemoveSubview(cell.addToCurrentDayButton)
                    print("Showing X for incomplete section")
                    cell.addToCurrentDayButton.isHidden = true
                    cell.finishFromCurrentDayButton.isHidden = true
                    cell.removeFromCurrentDayButton.isHidden = false
                    cell.removeFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
                }else{
                    print("Showing X for current sectiion")
                    cell.addToCurrentDayButton.isHidden = true
                    //cell.finishFromCurrentDayButton.removeFromSuperview()
                    cell.finishFromCurrentDayButton.isHidden = true
                    cell.removeFromCurrentDayButton.isHidden = false
                    cell.removeFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
                }
            }
        }*/
        
        /*if menuBar.editButton.titleLabel?.text == "Edit" {
            // Based on the section, there is a different action button. For the incomplete section, the button allows the user to move the task to the task list. For the current section, the button allows the user to remove the task from the task list and it compares the category and sends it to the social timeline
            if indexPath.section == 0{
                cell.addSubview(cell.addToCurrentDayButton)
                cell.removeFromCurrentDayButton.isHidden = true
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.addToCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.addToCurrentDayButton)
                
                cell.addSubview(cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.removeFromCurrentDayButton.isHidden = true
                cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
                
            } else {
                cell.addSubview(cell.finishFromCurrentDayButton)
                cell.addToCurrentDayButton.isHidden = true
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.finishFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.finishFromCurrentDayButton)
                
                cell.addSubview(cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.addConstraintsWithFormat(format: "H:|-362-[v0(30)]", views: cell.removeFromCurrentDayButton)
                cell.removeFromCurrentDayButton.isHidden = true
                
                cell.finishFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
            }
            print(cell.subviews.contains(cell.addToCurrentDayButton))
        } else {

            if indexPath.section == 0{
                //cell.addToCurrentDayButton.removeFromSuperview()
                //cell.willRemoveSubview(cell.addToCurrentDayButton)
                cell.addToCurrentDayButton.isHidden = true
                cell.finishFromCurrentDayButton.isHidden = true
                cell.removeFromCurrentDayButton.isHidden = false
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
            }else{
                cell.addToCurrentDayButton.isHidden = true
                //cell.finishFromCurrentDayButton.removeFromSuperview()
                cell.finishFromCurrentDayButton.isHidden = true
                cell.removeFromCurrentDayButton.isHidden = false
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
                }
        }*/
        
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
        let tempTask = Task(name: task.name, time: task.time, category: task.category, pinned: false)
        tempTasklist.removeTask(task: task)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        
        tempTasklist.addTask(task: tempTask)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView?.reloadData()

    }
    
    @objc func removeTaskFromIncomplete(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = tempTasklist.incompleteTasks[indexPath.row]
        tempTasklist.removeTask(task: task)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])


        
    }
    
    @objc func removeTaskFromCurrent(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = tempTasklist.currentTasks[indexPath.row]
        tempTasklist.removeTask(task: task)
        tempTasklist.calculateCurrentTasks()
        tempTasklist.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        
        
        
    }
    
}



