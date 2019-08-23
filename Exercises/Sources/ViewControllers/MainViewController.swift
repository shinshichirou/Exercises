//
//  MainViewController.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 44.0
        }
    }
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerHeader()
        
        viewModel.updateCompletion = { [weak self] in
            main {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    private func registerHeader() {
        let identifier = ExerciseHeaderView.className
        let headerNib = UINib.init(nibName: identifier, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        viewModel.addNewExercise()
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellsIn(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.header(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellFor(tableView, indexPath: indexPath)
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kDefaultTableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kDefaultTableCellHeight
    }
    
}
