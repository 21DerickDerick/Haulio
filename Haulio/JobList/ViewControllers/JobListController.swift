//
//  JobListController.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit
import GoogleSignIn

class JobListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
}
