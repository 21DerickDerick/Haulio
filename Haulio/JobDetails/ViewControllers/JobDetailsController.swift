//
//  JobDetailsController.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import CoreLocation

enum AnnotationType: String {
    case CurrentLocation
    case JobLocation
}

class JobDetailsController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobNumberLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var driver: Driver?
    var jobNumber: String?
    var jobGeolocation: Geolocation?
    var lat: Double?
    var lng: Double?
    
    let locationManager = CLLocationManager()
    var searchedItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension JobDetailsController {
    private func setup() {
        setupUI()
        
        mapView.delegate = self
        searchCompleter.delegate = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchBar.delegate = self
        
        if let driver = driver {
            nameLabel.text = driver.givenName
            profileImageView.kf.setImage(with: driver.profilePhotoUrl)
        }
        
        jobNumberLabel.text = jobNumber ?? "-"
        
        lat = locationManager.location?.coordinate.latitude
        lng = locationManager.location?.coordinate.longitude
        
        setupMap()
        
        if let jobGeolocation = jobGeolocation {
            guard let lat = jobGeolocation.latitude, let lng = jobGeolocation.longitude else { return }
            let location = CLLocation(latitude: lat, longitude: lng)
            
            addJobAnnotation(location: location)
        }
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func setupMap() {
        guard let lat = lat, let lng = lng else { return }
        let location = CLLocation(latitude: lat, longitude: lng)
        let regionRadius: CLLocationDistance = 1000
        centerMapOnLocation(location: location, regionRadius: regionRadius)
    }
    
    private func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        annotation.title = AnnotationType.CurrentLocation.rawValue
        
        mapView.addAnnotation(annotation)
    }
    
    func addJobAnnotation(location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation.title = AnnotationType.JobLocation.rawValue
        mapView.addAnnotation(annotation)
    }
    
    func performSearch(searchString: String)
    {
        let searchReq = MKLocalSearchRequest()
        searchReq.naturalLanguageQuery = searchString
        searchReq.region = mapView.region
        
        let localSearch = MKLocalSearch(request: searchReq)
        
        localSearch.start { (response, error) in
            
            if error != nil
            {
                Alert.showBasicAlert(on: self, withTitle: "Haulio", message: "Search failed. Please try again later.")
            }
            else if response?.mapItems.count == 0
            {
                //Alert.showBasicAlert(on: self, withTitle: "Haulio", message: "No Result Found")
            }
            else
            {
                for item in (response?.mapItems)!
                {
                    self.searchedItems.append(item as MKMapItem)
                    
                    print("Matching items = \(self.searchedItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
}















