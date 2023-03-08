//
//  ViewController.swift
//  ProgrammaticSearchController
//
//  Created by Logan Melton on 3/7/23.
//

import UIKit

class ViewController: UIViewController {

  var musicians = SampleData.data
  var filtered = [String]()
  
  let searchController = UISearchController(searchResultsController: nil)
  var sampleTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Programmatic"
    view.backgroundColor = .systemBackground
    navigationItem.searchController = searchController
    navigationItem.preferredSearchBarPlacement = .automatic
    navigationItem.largeTitleDisplayMode = .always
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Yer Face"
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
    definesPresentationContext = true

    searchController.searchBar.delegate = self
    style()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let indexPath = sampleTable.indexPathForSelectedRow {
      sampleTable.deselectRow(at: indexPath, animated: true)
    }
  }
  
  var isSearchBarEmpty: Bool {
    guard let barStatus = searchController.searchBar.text?.isEmpty else { return true }
    return barStatus
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  func filterContentForSearchText(_ searchText: String) {
    filtered = musicians.filter { (string: String) -> Bool in
      let name = string
      return name.lowercased().contains(searchText.lowercased())
    }
    sampleTable.reloadData()
  }
}

extension ViewController {
  private func style() {
    sampleTable = UITableView()
    sampleTable.translatesAutoresizingMaskIntoConstraints = false
    sampleTable.register(UITableViewCell.self,
                         forCellReuseIdentifier: "cell")
    sampleTable.dataSource = self
    view.addSubview(sampleTable)
    NSLayoutConstraint.activate([
      sampleTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      sampleTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      sampleTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      sampleTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch isFiltering {
      case true:
        if filtered.isEmpty {
          return 1
        } else {
          return filtered.count
        }
      case false:
        return musicians.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = sampleTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var config = cell.defaultContentConfiguration()
    
    var cellName = String()
    switch isFiltering {
      case true:
        if filtered.isEmpty {
          cellName = "No Results"
        } else {
          cellName = filtered[indexPath.item]
        }
      case false:
        cellName = musicians[indexPath.item]
    }
    
    config.text = cellName
    cell.contentConfiguration = config
    return cell
  }
}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //    print(searchText)
  }
}

