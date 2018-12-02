//
//  Job.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

class Job {
    // Todo: Add getter function so no direct access
    private var id: Int?
    var company: String?
    var address: String?
    var jobId: Int?
    private var priority: Int?
    var geolocation: Geolocation?
    
    init(id: Int?, jobId: Int?, priority: Int?, company: String?, address: String?, geolocation: Geolocation) {
        self.id = id
        self.jobId = jobId
        self.priority = priority
        self.company = company
        self.address = address
        self.geolocation = geolocation
    }
}

class Geolocation {
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

