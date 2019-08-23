//
//  Storage.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit
import RealmSwift

typealias WriteClosure = () -> ()

let store = try! Realm()

final class Storage {
    
    static let shared = Storage()
    
    private let schemaVersion: UInt64 = 1
    
    func setup() {
        Realm.Configuration.defaultConfiguration =
            Realm.Configuration(schemaVersion: schemaVersion,
                                migrationBlock: nil)
    }
    
    // MARK: - Models functions
    
    static func exercises() -> Results<Exercise> {
        return store.objects(Exercise.self)
    }
    
    static func addNewExercise(_ completion: Completion) {
        let newExercise = Exercise()
        store.write({
            store.add(newExercise)
        }) { (writeError) in
            if let error = writeError {
                print(error.localizedDescription)
            }
            completion(writeError)
        }
    }
    
    static func addNewSetTo(_ exercise: Exercise, completion: Completion) {
        let newSet = ExerciseSet()
        store.write({
            exercise.sets.append(newSet)
        }) { (writeError) in
            if let error = writeError {
                print(error.localizedDescription)
            }
            completion(writeError)
        }
    }
    
    static func delete(_ exercise: Exercise, completion: Completion) {
        store.write({
            store.delete(exercise)
        }) { (writeError) in
            if let error = writeError {
                print(error.localizedDescription)
            }
            completion(writeError)
        }
    }
    
    static func delete(_ set: ExerciseSet, completion: Completion) {
        store.write({
            store.delete(set)
        }) { (writeError) in
            if let error = writeError {
                print(error.localizedDescription)
            }
            completion(writeError)
        }
    }
    
}
