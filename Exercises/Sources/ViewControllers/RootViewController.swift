//
//  RootViewController.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController!
    
    init() {
        let main = Storyboards.main.viewController(MainViewController.self)
        current = UINavigationController(rootViewController: main)
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)

    }
    
    // MARK: - Switch Root
    
    public func switchToMain() {
        let main = Storyboards.main.viewController(MainViewController.self)
        animateFadeTransition(to: UINavigationController(rootViewController: main)) {
            print("MainViewController was open")
        }
    }
    
    // MARK: - Switch Animations
    
    private func animateFadeTransition(to new: UIViewController,
                                       completion: @escaping (() -> Void)) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current,
                   to: new,
                   duration: 0.3,
                   options: [.transitionCrossDissolve, .curveEaseOut],
                   animations: {
                    
        }, completion: { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion()
        })
    }
    
    private func animateDismissTransition(to new: UIViewController,
                                          completion: @escaping (() -> Void)) {
        let initialFrame = CGRect(x: -view.bounds.width,
                                  y: 0,
                                  width: view.bounds.width,
                                  height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        transition(from: current,
                   to: new,
                   duration: 0.3,
                   options: [],
                   animations: {
                    new.view.frame = self.view.bounds
        }, completion: { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion()
        })
    }
    
}

