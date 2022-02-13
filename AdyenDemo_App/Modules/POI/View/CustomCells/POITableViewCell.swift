//
//  POITableViewCell.swift
//  AdyenDemo_App
//
//  Created by Ali on 12/02/22.
//

import UIKit

class POITableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var distanceLbl : UILabel!
    
    // MARK: - Lifecycle/State functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Data function
    
    func populateData(_ model : MapAnnotationView) {
        self.titleLbl.text = model.title
        self.descriptionLbl.text = model.subtitle
        self.distanceLbl.text = model.distance != 0 ? String(format: "%.01f", model.distance) + " m" : "-"
    }

}
