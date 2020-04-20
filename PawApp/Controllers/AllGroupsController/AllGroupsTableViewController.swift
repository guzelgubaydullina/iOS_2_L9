//
//  AllGroupsTableViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 01.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    private var groups = [Group]()
    private var filteredGroups = [Group]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group1 = Group(name: "Springfield Life",
                           avatarImageName: "SpringfieldLife")
        let group2 = Group(name: "The Itchy & Scratchy Show",
                           avatarImageName: "TheItchy&Scratchy")
        let group3 = Group(name: "The Srpingfield Times",
                           avatarImageName: "TheSpringfieldTimes")
        let group4 = Group(name: "Simpsons Fan",
                           avatarImageName: "SimpsonsFan")
        let group5 = Group(name: "Krusty the Clown show",
                           avatarImageName: "KrustyTheClownShow")
        let group6 = Group(name: "Bart's friends",
                           avatarImageName: "BartsFriends")
        
        groups = [group1, group2, group3, group4, group5, group6]
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.isEmpty ? groups.count : filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsTableViewCell", for: indexPath) as! AllGroupsTableViewCell
        let group = filteredGroups.isEmpty ? groups[indexPath.row] : filteredGroups[indexPath.row]
        cell.allGroupsNameLabel.text = group.name
        cell.allGroupsPhotoImageView.image = UIImage(named: group.avatarImageName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addGroups(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroups" {
            let otherGroupsTableViewController = segue.source as! OtherGroupsTableViewController

            if let indexPath = otherGroupsTableViewController.tableView.indexPathForSelectedRow {
                let otherGroups = otherGroupsTableViewController.filteredGroups.isEmpty ? otherGroupsTableViewController.groups : otherGroupsTableViewController.filteredGroups
                let group = otherGroups[indexPath.row]
                if !groups.contains(group) {
                    groups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return filteredGroups.isEmpty ? true : false
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            clearSearch(searchBar)
            return
        }
        filteredGroups = groups.filter { $0.name.contains(searchText) }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch(searchBar)
    }
    
    private func clearSearch(_ searchBar: UISearchBar) {
        searchBar.text = nil
        view.endEditing(true)
        filteredGroups = [Group]()
    }
}
