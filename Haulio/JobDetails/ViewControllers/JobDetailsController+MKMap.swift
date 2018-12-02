//
//  JobDetailsController+MKMap.swift
//  Haulio
//
//  Created by Derick on 03/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import MapKit

extension JobDetailsController: MKMapViewDelegate {
    
    func mapView(_ map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationViewReuseIdentifier = "annotationViewReuseIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewReuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationViewReuseIdentifier)
        }
        
        if annotation.title == AnnotationType.CurrentLocation.rawValue {
            annotationView?.image = UIImage(named: "currentLocation")
        } else if annotation.title == AnnotationType.JobLocation.rawValue {
            annotationView?.image = UIImage(named: "target")
        } else {
            annotationView?.image = UIImage(named: "searchLocation")
        }
        
        
        annotationView?.annotation = annotation
        
        // add below line of code to enable selection on annotation view
        annotationView?.canShowCallout = true
        
        return annotationView
    }
}

extension JobDetailsController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}
