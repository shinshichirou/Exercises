//
//  Exercise.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object {
    @objc dynamic var title = ""
    let sets = List<ExerciseSet>()
}


