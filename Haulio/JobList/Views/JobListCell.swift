//
//  JobListCell.swift
//  Haulio
//
//  Created by Derick on 02/12/2018.
//  Copyright © 2018 DerickProductions. All rights reserved.
//

import UIKit

protocol JobListCellDelegate {
    func didTapAcceptButton(jobNumber: String, geoLocation: Geolocation?)
}

class JobListCell: UITableViewCell {

    @IBOutlet weak var jobNumberLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    var geolocation: Geolocation?
    var delegate: JobListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        delegate?.didTapAcceptButton(jobNumber: jobNumberLabel.text ?? "-", geoLocation: geolocation)
    }
    
}

extension JobListCell {
    private func setupUI() {
        acceptButton.layer.cornerRadius = 5
    }
}
