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
}

class AddSetView: UIView {

    var section = 0
    weak var delegate: AddSetViewDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeControl: UISegmentedControl!
    
    @IBAction func cancelPressed(_ sender: Any) {
        delegate?.cancel()
        close()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let type = typeControl.selectedSegmentIndex
        delegate?.added(section,  type: type)
        close()
    }
}
