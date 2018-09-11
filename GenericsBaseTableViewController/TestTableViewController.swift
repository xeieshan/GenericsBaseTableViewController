//
//  TestTableViewController.swift
//  GenericsBaseTableViewController
//
//  Created by Zeeshan Haider on 11/09/2018.
//  Copyright © 2018 Company name All rights reserved.
//

import Foundation
import UIKit

class TestTableViewController: BaseTableViewController<NibTableViewCell, MOPerson> {
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            [MOPerson(name : "Howard Robertson", genderAge : "Male, 34Y"),
             MOPerson(name : "Addison Mitchell", genderAge : "Female, 31Y"),
             MOPerson(name : "Fred Jacobs", genderAge : "Male, 18Y"),
             MOPerson(name : "Danielle Price", genderAge : "Female, 22Y"),
             MOPerson(name : "Clinton Schmidt", genderAge : "Male, 30Y")]
        ]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        print(items[indexPath.section][indexPath.row].name)
    }
}
