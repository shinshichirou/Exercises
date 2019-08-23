//
//  RealmExtension.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    func write(_ writeClosure: WriteClosure, completion: Completion) {
        do {
            try self.write {
                writeClosure()
            }
            completion(nil)
        } catch {
            print("Realm could not write to database: ", error)
            completion(error)
        }
    }
    
}
