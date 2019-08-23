//
//  AddSetView.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

protocol AddSetViewDelegate: class {
    func cancel()
    func added(_ section: Int, type: Int)
    func edited(_ indexPath: IndexPath, type: Int)
}

class AddSetView: UIView {

    var section = 0
    var row = 0
    
    var isEditing = false
    
    weak var delegate: AddSetViewDelegate?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeControl: UISegmentedControl!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isEditing {
            addButton.setTitle("Save", for: .normal)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        delegate?.cancel()
        close()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let type = typeControl.selectedSegmentIndex
        if isEditing {
            delegate?.edited(IndexPath(row: row, section: section),
                             type: type)
        } else {
            delegate?.added(section,  type: type)
        }
        close()
    }
}
