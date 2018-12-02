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
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email

            
            let sb = UIStoryboard(name: "JobList", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "JobListController") as? JobListController else {return}
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
