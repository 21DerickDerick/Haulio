//
//  User.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import Foundation

class Driver {
    
    // TODO: getter methods n make private
    var givenName: String?
    var profilePhotoUrl: URL?
    
    init(givenName: String?, profilePhotoUrl: URL? = nil) {
        self.givenName = givenName
        self.profilePhotoUrl = profilePhotoUrl
    }
}
