//
//  AllFriendsController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 31.03.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    private var filteredUsers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var userGroups = [String: [User]]() {
        didSet {
            users = userGroups.flatMap { $0.value }.sorted { $0.name < $1.name }
            tableView.reloadData()
        }
    }
    private var users = [User]()
    private var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homer = User(name: "Homer Simpson",
                         age: 39,
                         numberOfFollowers: 4,
                         maritalStatus: .married,
                         lifeStatus: .working,
                         avatarImageName: "homer_simpson_avatar",
                         photosImageName: ["homer_simpson_avatar", "HomerSimpson1", "HomerSimpson2"])
        
        let marge = User(name: "Marge Simpson",
                         age: 37,
                         numberOfFollowers: 4,
                         maritalStatus: .married,
                         lifeStatus: .housewife,
                         avatarImageName: "marge_simpson_avatar",
                         photosImageName: ["marge_simpson_avatar", "MargeSimpson1", "MargeSimpson2"])
        
        let bart = User(name: "Bart Simpson",
                        age: 10,
                        numberOfFollowers: 4,
                        maritalStatus: .single,
                        lifeStatus: .schoolboy,
                        avatarImageName: "bart_simpson_avatar",
                        photosImageName: ["bart_simpson_avatar", "BartSimpson1", "BartSimpson2", "BartSimpson3", "BartSimpson4", "BartSimpson5"])
        
        let lisa = User(name: "Lisa Simpson",
                        age: 8,
                        numberOfFollowers: 4,
                        maritalStatus: .single,
                        lifeStatus: .schoolgirl,
                        avatarImageName: "lisa_simpson_avatar",
                        photosImageName: ["lisa_simpson_avatar", "LisaSimpson1", "LisaSimpson2", "LisaSimpson3", "LisaSimpson4", "LisaSimpson5"])
        
        let maggie = User(name: "Maggie Simpson",
                          age: 1,
                          numberOfFollowers: 4,
                          maritalStatus: .single,
                          lifeStatus: .baby,
                          avatarImageName: "maggie_simpson_avatar",
                          photosImageName: ["maggie_simpson_avatar", "MaggieSimpson1", "MaggieSimpson2", "MaggieSimpson3", "MaggieSimpson4", "MaggieSimpson5"])
        
        let grandpa = User(name: "Abraham Simpson",
                           age: 83,
                           numberOfFollowers: 1,
                           maritalStatus: .divorced,
                           lifeStatus: .pensioner,
                           avatarImageName: "abraham_simpson_avatar",
                           photosImageName: ["abraham_simpson_avatar", "AbrahamSimpson1", "AbrahamSimpson2"])
        
        let gerald = User(name: "Baby Gerald",
                          age: 1,
                          numberOfFollowers: 0,
                          maritalStatus: .single,
                          lifeStatus: .baby,
                          avatarImageName: "baby_gerald_avatar",
                          photosImageName: ["baby_gerald_avatar", "BabyGerald1", "BabyGerald2"])
        
        let clancyWiggum = User(name: "Clancy Wiggum",
                                age: 43,
                                numberOfFollowers: 2,
                                maritalStatus: .married,
                                lifeStatus: .working,
                                avatarImageName: "clancy_wiggum_avatar",
                                photosImageName: ["clancy_wiggum_avatar", "ClancyWiggum3", "ClancyWiggum5", "ClancyWiggum1", "ClancyWiggum4", "ClancyWiggum2" ])
        
        let nedFlanders = User(name: "Ned Flanders",
                       age: 60,
                       numberOfFollowers: 100,
                       maritalStatus: .married,
                       lifeStatus: .working,
                       avatarImageName: "ned_flanders_avatar",
                       photosImageName: ["ned_flanders_avatar", "NedFlanders1", "NedFlanders2", "NedFlanders3", "NedFlanders4", "NedFlanders5"])
        
        let drHibbert = User(name: "Julius Hibbert",
                             age: 40,
                             numberOfFollowers: 10,
                             maritalStatus: .married,
                             lifeStatus: .working,
                             avatarImageName: "julius_hibbert_avatar",
                             photosImageName: ["julius_hibbert_avatar", "JuliusHibbert1", "JuliusHibbert2"])

        let users = [homer, marge, bart, lisa, maggie, grandpa, gerald, clancyWiggum, nedFlanders, drHibbert]
        configureUserGroups(with: users)
        
        tableView.tableFooterView = UIView()
    }
    
    private func configureUserGroups(with users: [User]) {
        for user in users {
            let userKey = String(user.name.prefix(1))
            if var userGroup = userGroups[userKey] {
                userGroup.append(user)
                userGroups[userKey] = userGroup
            } else {
                userGroups[userKey] = [user]
            }
        }
        sectionTitles = [String](userGroups.keys)
        sectionTitles = sectionTitles.sorted { $0 < $1 }
    }

    // MARK: - UITableViewDataSource
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredUsers.isEmpty ? sectionTitles : nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredUsers.isEmpty ? sectionTitles[section] : nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if filteredUsers.isEmpty {
            let sectionTitle = sectionTitles[section]
            return SectionHeaderView(sectionTitle: sectionTitle)
        } else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredUsers.isEmpty ? sectionTitles.count : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.isEmpty {
            let sectionTitle = sectionTitles[section]
            return userGroups[sectionTitle]?.count ?? 0
        } else {
            return filteredUsers.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsTableViewCell",
                                                 for: indexPath) as! AllFriendsTableViewCell
        var user: User? = nil
        if filteredUsers.isEmpty {
            let sectionTitle = sectionTitles[indexPath.section]
            user = userGroups[sectionTitle]?[indexPath.row]
        } else {
            user = filteredUsers[indexPath.row]
        }
        cell.friendNameLabel.text = user!.name
        cell.friendProfilePhotoImageView.image = UIImage(named: user!.avatarImageName)
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowPhotos" {
            guard let viewController = segue.destination as? FriendPhotosCollectionViewController,
                let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            var user: User? = nil
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[selectedIndexPath.section]
                user = userGroups[sectionTitle]?[selectedIndexPath.row]
            } else {
                user = filteredUsers[selectedIndexPath.row]
            }
            viewController.user = user!
        }
    }
}

extension AllFriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            clearSearch(searchBar)
            return
        }
        filteredUsers = users.filter { $0.name.contains(searchText) }
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
        filteredUsers = [User]()
    }
}
