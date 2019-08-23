//
//  ExerciseHeaderView.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

protocol ExerciseHeaderViewDelegate: class {
    func addSetFor(_ section: Int)
}

class ExerciseHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addSetButton: UIButton!
    
    var section = 0
    
    weak var delegate: ExerciseHeaderViewDelegate?
    
    @IBAction func addSetPressed(_ sender: Any) {
        delegate?.addSetFor(section)
    }
    
}
