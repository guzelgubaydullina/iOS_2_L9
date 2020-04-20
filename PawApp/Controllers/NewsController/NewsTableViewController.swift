//
//  NewsTableViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 12.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    private var news = [News]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        generateNews()
    }
    
    private func generateNews() {
        let news1 = News(avatarImageName: "abraham_simpson_avatar",
                         authorName: "Abraham Simpson",
                         newsText: "Sint id elit amet quis adipisicing eiusmod dolore elit. Aliquip id anim ullamco amet in cupidatat ullamco ea minim consequat aute amet officia. Ex culpa consectetur cupidatat ad minim adipisicing enim occaecat aliqua amet officia. Lorem pariatur tempor ut voluptate enim culpa commodo magna dolor elit veniam.",
                         newsImageName: "AbrahamSimpson2")
        
        let news2 = News(avatarImageName: "bart_simpson_avatar",
                         authorName: "Bart Simpson",
                         newsText: "Sint id elit amet quis adipisicing eiusmod dolore elit. Aliquip id anim ullamco amet in cupidatat ullamco ea minim consequat aute amet officia. Ex culpa consectetur cupidatat ad minim adipisicing enim occaecat aliqua amet officia. Lorem pariatur tempor ut voluptate enim culpa commodo magna dolor elit veniam.",
                         newsImageName: "BartSimpson2")
        
        let news3 = News(avatarImageName: "homer_simpson_avatar",
                         authorName: "Homer Simpson",
                         newsText: "Occaecat adipisicing aliquip nulla magna qui dolor. Velit magna pariatur sit Lorem. Fugiat amet elit nulla ipsum eu est anim adipisicing ea ea reprehenderit proident. Tempor esse deserunt veniam laborum dolore aute labore excepteur elit aliqua officia.",
                         newsImageName: "HomerSimpson2")
        
        let news4 = News(avatarImageName: "clancy_wiggum_avatar",
                         authorName: "Clancy Wiggum",
                         newsText: "Consequat mollit ipsum aliqua magna aute. Dolore labore aliquip enim quis. Dolor eiusmod consectetur in ad consectetur enim tempor anim ad eiusmod aliquip ad pariatur pariatur. Deserunt labore consequat consequat nisi velit exercitation Lorem.",
                         newsImageName: "ClancyWiggum1")
        
        let news5 = News(avatarImageName: "lisa_simpson_avatar",
                         authorName: "Lisa Simpson",
                         newsText: "Sint ipsum dolor ipsum ipsum aliquip cupidatat et non ut anim occaecat ipsum. Consequat amet ad pariatur pariatur esse exercitation eu exercitation pariatur duis non et mollit. Eiusmod officia nisi fugiat labore incididunt. Cupidatat officia nisi officia culpa enim non.",
                         newsImageName: "LisaSimpson5")
        
        news = [news1, news2, news3, news4, news5]
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsModel = news[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configure(with: newsModel)
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
