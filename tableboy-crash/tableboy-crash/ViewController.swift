//
//  ViewController.swift
//  tableboy-crash
//
//  Created by mac_25648_newMini on 2020/11/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    @IBAction func onClick(_ sender: Any) {
        
        self.tableview.performBatchUpdates {
            self.tableview.reloadData()
        } completion: { (res) in
            print("completion")
        }
    }
    
}


extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt:\(indexPath.row)")
        Thread.sleep(forTimeInterval: 0.1)
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay:\(indexPath.row)")
    }
}

