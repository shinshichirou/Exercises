//
//  MainViewModel.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

class MainViewModel {
    
    var inserRowCallback: ((IndexPath) -> Void)?
    var insertSectionCallback: Callback?
    
    func numberOfSections() -> Int {
        return Storage.exercises().count
    }
    
    func exerciseFor(_ section: Int) -> Exercise {
        return Storage.exercises()[section]
    }
    
    func numberOfCellsIn(_ section: Int) -> Int {
        return Storage.exercises()[section].sets.count
    }
    
    func header(_ tableView: UITableView, section: Int) -> ExerciseHeaderView {
        let header = tableView.headerWithType(ExerciseHeaderView.self)
        header.section = section
        header.nameLabel.text = "Exercise #\(section + 1)"
        header.delegate = self
        return header
    }
    
    func cellFor(_ tableView: UITableView, indexPath: IndexPath) -> SetTableViewCell {
        let cell = tableView.cellWithType(SetTableViewCell.self, indexPath: indexPath)
        
        let exercise = exerciseFor(indexPath.section)
        let set = exercise.sets[indexPath.row]
        
        cell.nameLabel.text = "Set #\(indexPath.row + 1)"
        cell.bulletView.backgroundColor = set.type == SetType.regular.rawValue ? UIColor.bulletBlue : UIColor.bulletOrange
        return cell
    }
    
    // adding new exercise
    
    func addNewExercise() {
        Storage.addNewExercise { (error) in
            if let err = error {
                print(err)
            }
            self.insertSectionCallback?()
        }
    }
    
}

extension MainViewModel: ExerciseHeaderViewDelegate {
    
    internal func addSetFor(_ section: Int) {
        let exercise = Storage.exercises()[section]
        Storage.addNewSetTo(exercise) { (error) in
            if let err = error {
                print(err)
            }
            self.inserRowCallback?(IndexPath(row: exercise.sets.count-1,
                                             section: section))
        }
    }
}
