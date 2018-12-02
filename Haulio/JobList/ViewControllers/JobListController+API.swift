//
//  JobListController+API.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import Foundation

// TODO: Create networking layer for reusability

extension JobListController {
    func callJobListAPI() {
        
        let urlString = JOB_LIST_URL
        if let url = URL(string: urlString) {
            CircularSpinner.show()
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                CircularSpinner.hide()
                
                do {
                    guard let data = data else {
                        return
                    }
                    
                    let getResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("\(getResponse)")
                    
                    if let modelArray = getResponse as? [[String: Any]] {
                        modelArray.forEach({ (dict) in
                            
                            let id = dict["id"] as? Int
                            let jobId = dict["job-id"] as? Int
                            let priority = dict["priority"] as? Int
                            let company = dict["company"] as? String
                            let address = dict["address"] as? String
                            let geoLocation = dict["geolocation"] as? [String: Double]
                            
                            guard let geolocation = geoLocation else { return }
                            
                            let latitude = geolocation["latitude"]
                            let longitude = geolocation["longitude"]
                            let geo = Geolocation(latitude: latitude, longitude: longitude)
                            
                            let job = Job(id: id, jobId: jobId, priority: priority, company: company, address: address, geolocation: geo)
                            self.jobList.append(job)
                        })
                        DispatchQueue.main.async {
                            self.jobsTableView.reloadData()
                        }
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                }.resume()
        }
        
    }
}
