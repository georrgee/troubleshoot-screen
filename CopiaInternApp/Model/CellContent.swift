//
//  CellContent.swift
//  CopiaInternApp
//  Created by George Garcia on 9/4/18.
//  Copyright © 2018 GeeTeam. All rights reserved.
//
//  Description: The CellContent class represents the cell's attributes for the UITableView

import UIKit

class CellContent {
    var question: String?
    var answer: String?
    var expanded: Bool
    
    // takes a json value to grab the data and apply it to the class's attributes (question & answer)
    init(json: [String: Any]) {
        self.question = json.keys.first ?? ""
        self.answer = json.values.first as? String ?? ""
        self.expanded = false
    }
}
