//
//  SortMenuViewController.swift
//  SortMenuSelectionDemo
//
//  Created by Mac_Admin on 05/09/20.
//  Copyright © 2020 Mac_Admin. All rights reserved.
//

import UIKit

class SortMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var selectedSortOption: String?
    var sortOptionSelected: ((String) -> Void)?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    
    @IBOutlet weak var tableVie: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortcell", for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row]
        return cell
    }
    
    
    var dataSource:[String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVie.allowsSelection = true
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        sortOptionSelected?((dataSource?[indexPath.row])!)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if cell.textLabel?.text == selectedSortOption  {
            cell.setSelected(true, animated: false)
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)  // required, as noted below
        }
    }
}
