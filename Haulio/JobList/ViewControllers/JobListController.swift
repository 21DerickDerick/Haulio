//
//  JobListController.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit
import GoogleSignIn
import CoreLocation

class JobListController: UIViewController {

    @IBOutlet weak var jobsTableView: UITableView!
    var jobList: [Job] = []
    var driver: Driver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callJobListAPI()
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension JobListController {
    private func setup() {
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
    }
    
    private func checkLocationAccess() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return true
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
}

extension JobListController: JobListCellDelegate {
    func didTapAcceptButton(jobNumber: String, geoLocation: Geolocation?) {
        
        if checkLocationAccess() {
            let sb = UIStoryboard(name: "JobDetails", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "JobDetailsController") as? JobDetailsController else {return}
            vc.driver = driver
            vc.jobNumber = jobNumber
            vc.jobGeolocation = geoLocation
            present(vc, animated: true, completion: nil)
        } else {
            Alert.showNoLocationAccessAlert()
        }
        

    }
}
