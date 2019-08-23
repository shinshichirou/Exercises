//
//  Constants.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

let kDefaultTableHeaderHeight = CGFloat(64.0)
let kDefaultTableCellHeight = CGFloat(44.0)
let kDefaultAnimationDuration = 0.3

// MARAK: - Enums

enum SetType {
    static let regular = 0
    static let warmup = 1
}

enum Storyboards {
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
}

// MARK: - Typealiases

typealias Callback = () -> ()
typealias Completion = (Error?) -> ()

// MARK: - Functions

func background(work: @escaping () -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

func main(work: @escaping () -> ()) {
    DispatchQueue.main.async {
        work()
    }
}

func performAfter(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}
