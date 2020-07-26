//
//  MovieTableViewCell.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var vwShadow: UIView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    
    
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

    func initWithMovieCellData(movieMdl: MovieModel?) {
        lblMovieTitle.text = movieMdl?.name
        lblMovieDescription.text = movieMdl?.description?.count ?? 0 > 0 ? movieMdl?.description : "NA"
    }
    
    func initWithMovieVideoCellData(movieVideoMdl: MovieVideoResultModel?) {
        lblMovieTitle.text = movieVideoMdl?.name
        lblMovieDescription.text = movieVideoMdl?.site
    }
    
    func initWithMoviewReviewCellData(movieReviewMdl: MovieReviewModel?) {
        lblMovieTitle.text = movieReviewMdl?.author
        lblMovieDescription.text = movieReviewMdl?.content
    }
}
