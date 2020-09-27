//
//  DetailTableViewController.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 26.09.2020.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var track: Track?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! DetailTableViewCell
            if let track = track {
                cell.configureCell(withData: track)
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
            cell.textLabel?.text = track?.track
            return cell
        }
    }
}
