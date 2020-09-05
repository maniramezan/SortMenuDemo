//
//  ViewController.swift
//  SortMenuSelectionDemo
//
//  Created by Mac_Admin on 05/09/20.
//  Copyright © 2020 Mac_Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var currentSortOption: String?
    var open = ["a","b","c"]
    var closed = ["d","e","f"]
    var dataSouce: [String] = []
    enum FilterType: String {
        case open = "Open"
        case closed = "Closed"
    }
    var filterTypes = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.removeAllSegments()
        filterTypes = ["open","closed"]
        filterTypes.enumerated()
            .forEach { index, segment in
                segmentControl?
                    .insertSegment(withTitle: segment, at: index, animated: false)
        }
        segmentControl?.selectedSegmentIndex = 0
        dataSouce = open
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "democell", for: indexPath)
        cell.textLabel?.text = dataSouce[indexPath.row]
        return cell
            
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dataSouce = open
        } else {
            dataSouce = closed
        }
        tableView.reloadData()
        currentSortOption = nil
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        guard let modalController = UIStoryboard(
        name: "Main",
        bundle: nil).instantiateViewController(
            withIdentifier: "SortMenuViewController")
        as? SortMenuViewController
            else {
                return
        }
        let popover = modalController
        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(
            width: 200.00,
            height: 200.00)
        if let presentation = popover.popoverPresentationController {
            presentation.barButtonItem = navigationItem.rightBarButtonItem
        }
       
        if segmentControl.selectedSegmentIndex == 0 {
            modalController.dataSource = ["Type", "Date"]
        } else {
            modalController.dataSource = ["CreatedDate", "Type", "ClosedDate"]
        }
        modalController.sortOptionSelected = { selectedSortOption in
            
            print(selectedSortOption)
            self.currentSortOption = selectedSortOption
            // will use the value to do some calculation and apply sorting to the existing tableView by using the switch
            switch selectedSortOption {
            case "Date":
                /// Sort list by date
                break;
            case "Type":
                /// Sort list alphabetically by feedbackType
                break;
            case "ClosedDate":
                /// Sort list status by isClosed
               break
            case "CreatedDate":
                break
            default:
                break
            }
            
        }
        if let previouslySelectedSort = currentSortOption {
            modalController.selectedSortOption = previouslySelectedSort
        }
        present(popover, animated: true, completion: nil)
        
    }
}

