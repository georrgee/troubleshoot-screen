//  TroubleShootController.swift
//  App: CopiaInternApp
//  Created by George Garcia on 8/30/18.
//  Copyright © 2018 GeeTeam. All rights reserved.

//  Description: TroubleShootViewController.swift represents a single view page of the FAQ section for Copia™
//  Instead of using a storyboard, UITableView, Cells, Search Bar, and a Navigation Bar are created programmatically

import UIKit
import Alamofire
import SwiftyJSON

class TroubleShootController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = [CellContent]()
    let cellId = "cellId"
    var currentSelection: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = []
        getCopiaData()
        setupNavBar()
        setupTableView()
    }
    
    // function that retrieves data from Copia's database. Used JSON Parsing Library(SwiftyJSON) & Network Library(Alamofire)
    func getCopiaData() {
        //let username = "1234"
        //let password = "eyJhbGciOiJIUzI1NiJ9.eyJVU0lEIjoiNmVjZTZiZWUwYTRlMTlmMGE4MjdiNTM5MmI2NTRhNGM1MWYwMDNjOSIsInRzIjoxNTMzMzM5ODc0fQ.bT-2QxLiQfyqp3Ubwi_A3er77tX5feR9g1Ahx2iYjFw"
        let url = "https://prep2.gw.gocopia.com/prep/faq"
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        // function that sends a request to the database. This has its username and password so that way it is authorized
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            if response.result.isSuccess {
                let faqJSON: JSON = JSON(response.result.value!)
                // print (faqJSON) display data on console
                if let list = faqJSON.object as? [[String: Any]] {
                    self.dataSource = list.map { CellContent(json: $0) }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Failed to get data...")
                }
            }
        }
    }
    
    // Function that sets up the Navigation Bar
    func setupNavBar(){
        navigationItem.title = "Troubleshoot"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22, weight: .thin)]
    }
    
    // Creating a UITableView
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none   // original separators between each cell. Use
        tv.allowsSelection = true
        tv.backgroundColor = UIColor(displayP3Red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        return tv
    }()
    
    // Function that will create the Table View
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension // Automatically expand depending on the dimension of the content
        
        tableView.register(FAQCell.self, forCellReuseIdentifier: cellId) // Apply the FAQCell attributes to cell
        view.addSubview(tableView)
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        // creating a search bar
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        
    }
    
    // number of sections for the table view which in this case its only 1 section.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows function.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns amount of rows depending on the amount of data (hence the questions with their answers)
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FAQCell
        cell.contentItem = dataSource[indexPath.row]
        return cell
    }
    
    //Function where the user taps the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates() // .beginUpdates and .endUpdates applies the animation
        if let selected = self.currentSelection { // if the cell is not selected, the row is not expanded
            dataSource[selected.row].expanded = false
            tableView.reloadRows(at: [selected], with: UITableViewRowAnimation.automatic)
            if selected == indexPath {          //tapped on the currently expanded row
                tableView.endUpdates()
                self.currentSelection = nil
                return
            }
        }
        self.currentSelection = indexPath
        let content = dataSource[indexPath.row]
        content.expanded = !content.expanded
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        if currentSelection != nil {
            print("Scroll to Row here")
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
        tableView.endUpdates()
    }
}
