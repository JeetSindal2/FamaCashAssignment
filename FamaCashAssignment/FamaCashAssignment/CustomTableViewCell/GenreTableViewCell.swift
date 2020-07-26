//
//  GenreTableViewCell.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var vwShadow: UIView!
    @IBOutlet weak var lblGenreName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()
        vwShadow.layer.cornerRadius = 5.0
        vwShadow.backgroundColor = .white
        vwShadow.layer.applySketchShadow(color: .black, alpha: 0.12, x: 0, y: 12, blur: 12, spread: 0)
    }
    
    func initWithGenreCellData(genreMdl: GenreModel) {
        lblGenreName.text = genreMdl.name
    }
    
}
