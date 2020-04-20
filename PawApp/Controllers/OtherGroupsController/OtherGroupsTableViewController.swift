//
//  OtherGroupsTableViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 01.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class OtherGroupsTableViewController: UITableViewController {
    var groups = [Group]()
    var filteredGroups = [Group]() {
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
        let group7 = Group(name: "The Simpsons in movie",
                           avatarImageName: "TheSimpsonsInMovie")
        let group8 = Group(name: "Springfield School",
                           avatarImageName: "SpringfieldSchool")
        let group9 = Group(name: "Springfield moms",
                           avatarImageName: "SpringfieldMoms")
        let group10 = Group(name: "Springfield prison news",
                            avatarImageName: "SpringfieldPrisonNews")
        
        groups = [group1, group2, group3, group4, group5, group6, group7, group8, group9, group10]
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.isEmpty ? groups.count : filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherGroupsTableViewCell", for: indexPath) as! OtherGroupsTableViewCell
        let group = filteredGroups.isEmpty ? groups[indexPath.row] : filteredGroups[indexPath.row]
        cell.otherGroupNameLabel.text = group.name
        cell.otherGroupsPhotoImageView.image = UIImage(named: group.avatarImageName)
        return cell
    }
}

extension OtherGroupsTableViewController: UISearchBarDelegate {
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
