//
//  SortMenuViewController.swift
//  SortMenuSelectionDemo
//
//  Created by Mac_Admin on 05/09/20.
//  Copyright © 2020 Mac_Admin. All rights reserved.
//

import UIKit

class SortMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var selectedSortOption: String? = nil
    var sortOptionSelected: ((String?) -> Void)? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    var sortOptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortcell", for: indexPath)
        cell.textLabel?.text = sortOptions[indexPath.row]
        cell.accessoryType = (selectedSortOption ?? "") == sortOptions[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if
            let selectedSortOption = selectedSortOption,
            let lastSelectedSortOptionIndex = sortOptions.firstIndex(of: selectedSortOption)
        {
            tableView.cellForRow(at: IndexPath(row: lastSelectedSortOptionIndex, section: 0))?.accessoryType = .none
        }
        selectedSortOption = sortOptions[indexPath.row]
        sortOptionSelected?(selectedSortOption)
    }
}
