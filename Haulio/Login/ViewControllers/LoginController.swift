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
    }
}

extension LoginController: GIDSignInUIDelegate {
    
}
