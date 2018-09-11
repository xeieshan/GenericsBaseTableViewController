//
//  BaseTableViewController.swift
//  BaseTableViewController
//
//  Created by Zeeshan Haider on 16/08/2018.
//  Copyright © 2018 Company Name. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

fileprivate extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return nil }
}

extension UITableView {
    fileprivate func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)

        //        If we want to use non nib cells
        //        if nib != nil {
        //        }
        //        else {
        //            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        //        }
        //    }
    }
    fileprivate func dequeueReusableCell<T: UITableViewCell>(indexPath: NSIndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
    
    fileprivate func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    fileprivate func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}

class BaseTableViewController<T: BaseTableViewCell<U>, U>: UITableViewController {
    
    var items = [[U]]()
    
    fileprivate func setupView() {
        tableView.registerReusableCell(T.self)
        
        tableView.tableFooterView = UIView()
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = rc
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath as NSIndexPath) as T
        cell.item = items[indexPath.section][indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: -  Refresh Control  -
    @objc func handleRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: -  Private  -
    func loadingCell() -> UITableViewCell? {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = cell.center
        cell.addSubview(activityIndicator)
        cell.tag = 98989
        activityIndicator.startAnimating()
        return cell
    }
}

class BaseTableViewCell<U>: UITableViewCell, Reusable {
    var item: U!
}

