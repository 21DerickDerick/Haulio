//
//  LoginController.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension LoginController {
    private func setup() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
}

extension LoginController: GIDSignInUIDelegate {
    
}

extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // Todo: Show Alert
            print("\(error.localizedDescription)")
        } else {
            var driver: Driver?
            guard let givenName = user.profile.givenName else { return }
            
            if user.profile.hasImage, let profilePhoto = user.profile.imageURL(withDimension: 80) {
                driver = Driver(givenName: givenName, profilePhotoUrl: profilePhoto)
            } else {
                driver = Driver(givenName: givenName)
            }
        
            let sb = UIStoryboard(name: "JobList", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "JobListController") as? JobListController else {return}
            vc.driver = driver
            present(vc, animated: true, completion: nil)
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
}
