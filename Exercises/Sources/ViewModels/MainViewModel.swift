//
//  MainViewModel.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate {
    
}

class MainViewModel {
    
    var inserRowCallback: ((IndexPath) -> Void)?
    var insertSectionCallback: Callback?
    var deleteRowCallback: ((IndexPath) -> Void)?
    var editRowCallback: Callback?
    
    unowned var mainViewController: MainViewController!
    
    func numberOfSections() -> Int {
        return Storage.exercises().count
    }
    
    func exerciseFor(_ section: Int) -> Exercise {
        return Storage.exercises()[section]
    }
    
    func setFor(_ indexPath: IndexPath) -> ExerciseSet {
        let exercise = exerciseFor(indexPath.section)
        let sortedSets = exercise.sets.sorted(by: { $0.type > $1.type })
        return sortedSets[indexPath.row]
    }
    
    func numberOfCellsIn(_ section: Int) -> Int {
        return Storage.exercises()[section].sets.count
    }
    
    func header(_ tableView: UITableView, section: Int) -> ExerciseHeaderView {
        let header = tableView.headerWithType(ExerciseHeaderView.self)
        header.section = section
        header.nameLabel.text = "Exercise #\(section + 1)"
        header.delegate = mainViewController
        return header
    }
    
    func cellFor(_ tableView: UITableView, indexPath: IndexPath) -> SetTableViewCell {
        let cell = tableView.cellWithType(SetTableViewCell.self, indexPath: indexPath)
        let set = setFor(indexPath)
        
        cell.nameLabel.text = "Set #\(indexPath.row + 1)"
        cell.bulletView.backgroundColor = set.type == SetType.regular ? UIColor.bulletBlue : UIColor.bulletOrange
        return cell
    }
    
    // MARK: - adding objects
    
    func addNewExercise() {
        Storage.addNewExercise { (error) in
            if let err = error {
                print(err)
            }
            self.insertSectionCallback?()
        }
    }
    
    func addNewSet(_ section: Int, type: Int) {
        let exercise = Storage.exercises()[section]
        
        Storage.addNewSetTo(exercise, with: type) { (error) in
            if let err = error {
                print(err)
            }
            var row = exercise.sets.count-1
            if type == SetType.warmup {
                let regularSets = exercise.sets.filter("type == 0")
                row -= regularSets.count
            }
            self.inserRowCallback?(IndexPath(row: row,
                                             section: section))
        }
    }
    
    // MARK: - removing objects
    
    func deleteSet(indexPath: IndexPath) {
        let set = setFor(indexPath)
        
        Storage.delete(set) { (error) in
            if let err = error {
                print(err)
            }
            self.deleteRowCallback?(indexPath)
        }
    }
    
    // MARK: - editing objects
    
    func editSet(_ indexPath: IndexPath, type: Int) {
        let set = setFor(indexPath)
        store.write({
            set.type = type
        }) { (writeError) in
            if let error = writeError {
                print(error.localizedDescription)
            }
            self.editRowCallback?()
        }
        
    }
    
}

