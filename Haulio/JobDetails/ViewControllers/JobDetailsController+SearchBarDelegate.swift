//
//  JobDetailsController+SearchBarDelegate.swift
//  Haulio
//
//  Created by Derick on 03/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import Foundation
import UIKit

extension JobDetailsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            searchResultTableView.isHidden = false
            searchCompleter.queryFragment = searchText
        } else {
            searchResultTableView.isHidden = true
            view.endEditing(true)
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchResultTableView.isHidden = true
    }
    
}
