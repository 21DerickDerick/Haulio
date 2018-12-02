//
//  JobDetailsController+TableView.swift
//  Haulio
//
//  Created by Derick on 03/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit
import CoreLocation

extension JobDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true)
        mapView.removeAnnotations(mapView.annotations)
        
        setupMap()
        
        if let jobGeolocation = jobGeolocation {
            guard let lat = jobGeolocation.latitude, let lng = jobGeolocation.longitude else { return }
            let location = CLLocation(latitude: lat, longitude: lng)
            
            addJobAnnotation(location: location)
        }
        
        self.performSearch(searchString: searchResults[indexPath.row].title)
    }
    
}
