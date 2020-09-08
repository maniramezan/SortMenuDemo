//
//  ViewController.swift
//  SortMenuSelectionDemo
//
//  Created by Mac_Admin on 05/09/20.
//  Copyright © 2020 Mac_Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    struct ViewModel {
        var dataSource: [String]
        var sortOptions: [String]
        var selectedSortOption: String? = nil
    }
    
    enum FilterType: Int, CustomStringConvertible, CaseIterable {
        case open = 0
        case closed = 1
        
        var description: String {
            switch self {
            case .open:
                return "Open"
            case .closed:
                return "Closed"
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
//    var currentSortOption: String? = nil
    
    var viewModel = [
        FilterType.open: ViewModel(dataSource: ["a","b","c"], sortOptions: ["Type", "Date"]),
        FilterType.closed: ViewModel(dataSource: ["d","e","f"], sortOptions: ["CreatedDate", "Type", "ClosedDate"])
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.removeAllSegments()

        FilterType.allCases.forEach { filterType in
            segmentControl?.insertSegment(withTitle: filterType.description, at: filterType.rawValue, animated: false)
        }
        segmentControl.selectedSegmentIndex = FilterType.open.rawValue
    }
    
    private func selectedSegmentFilterType() -> FilterType {
        guard let filterType = FilterType(rawValue: segmentControl.selectedSegmentIndex) else {
            return .open
        }
        
        return filterType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel[selectedSegmentFilterType()]?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "democell", for: indexPath)
        cell.textLabel?.text = viewModel[selectedSegmentFilterType()]?.dataSource[indexPath.row]
        return cell
            
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        guard let modalController = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(
                    withIdentifier: "SortMenuViewController") as? SortMenuViewController
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
        
        modalController.sortOptions = viewModel[selectedSegmentFilterType()]?.sortOptions ?? []
        modalController.selectedSortOption = viewModel[selectedSegmentFilterType()]?.selectedSortOption

        modalController.sortOptionSelected = { [weak self] selectedSortOption in
            
            guard let self = self else { return }
            
            self.viewModel[self.selectedSegmentFilterType()]?.selectedSortOption = selectedSortOption
            print(selectedSortOption)
//            self.currentSortOption = selectedSortOption
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
        present(popover, animated: true, completion: nil)
        
    }
}

