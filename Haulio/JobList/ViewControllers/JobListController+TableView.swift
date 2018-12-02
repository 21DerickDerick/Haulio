//
//  JobListController+TableView.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit

extension JobListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JobListCell
        cell.delegate = self
        
        if let jobId = jobList[indexPath.row].jobId {
            cell.jobNumberLabel.text = "Job Number: \(jobId)"
        } else {
            cell.jobNumberLabel.text = "-"
        }
        
        cell.companyNameLabel.text = "Company: \(jobList[indexPath.row].company ?? "-")"
        cell.companyAddressLabel.text = "Address: \(jobList[indexPath.row].address ?? "-")"
        cell.geolocation = jobList[indexPath.row].geolocation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

