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
    
    var fadeView: UIView?
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.mainViewController = self
        registerHeader()
    
        viewModel.inserRowCallback = { [weak self] (indexPath) in
            main {
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                self?.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            }
        }
        
        viewModel.insertSectionCallback = { [weak self] in
            guard let sectionsCount = self?.viewModel.numberOfSections() else {
                return
            }
            let lastSection = sectionsCount - 1
            let indexSet = IndexSet(integer: lastSection)
            let sectionIndexPath = IndexPath(row: NSNotFound, section: lastSection)
            main {
                self?.tableView.insertSections(indexSet, with: .automatic)
                self?.tableView.scrollToRow(at: sectionIndexPath, at: .bottom, animated: true)
            }
        }
        
        viewModel.deleteRowCallback = { [weak self] (indexPath) in
            main {
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
        }
        
        viewModel.editRowCallback = { [weak self] in
            self?.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteSet(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navView = navigationController?.view
        
        fadeView = UIView(frame: view.bounds)
        fadeView?.backgroundColor = UIColor.fadeGray
        navView?.addSubview(fadeView!)
        
        let addView: AddSetView = AddSetView.initFromNib()
        addView.isEditing = true
        addView.titleLabel.text = "Set #\(indexPath.row+1)"
        addView.section = indexPath.section
        addView.row = indexPath.row
        addView.typeControl.selectedSegmentIndex = viewModel.setFor(indexPath).type
        addView.delegate = self
        addView.showOn(navView!)
    }
}

extension MainViewController: ExerciseHeaderViewDelegate {
    
    internal func addSetFor(_ section: Int) {
        let navView = navigationController?.view
        
        fadeView = UIView(frame: view.bounds)
        fadeView?.backgroundColor = UIColor.fadeGray
        navView?.addSubview(fadeView!)
        
        let addView: AddSetView = AddSetView.initFromNib()
        addView.titleLabel.text = "Set #\(viewModel.exerciseFor(section).sets.count+1)"
        addView.section = section
        addView.delegate = self
        addView.showOn(navView!)
    }
}

extension MainViewController: AddSetViewDelegate {
    
    func cancel() {
        fadeView?.close()
    }
    
    func added(_ section: Int, type: Int) {
        fadeView?.close()
        viewModel.addNewSet(section, type: type)
    }
    
    func edited(_ indexPath: IndexPath, type: Int) {
        fadeView?.close()
        viewModel.editSet(indexPath, type: type)
    }
    
}

