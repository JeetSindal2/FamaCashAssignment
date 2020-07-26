//
//  MovieDetailModel.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailModel {
    var backdrop_path: String?
    var budget: Int?
    var overview: String?
    var release_date: String?
    var status: String?
    var title: String?
    var video: Bool?
    
    init(backdrop_path: String?, budget: Int?, overview: String?, release_date: String?, status: String?, title: String?, video: Bool?) {
        self.backdrop_path = backdrop_path
        self.budget = budget
        self.overview = overview
        self.release_date = release_date
        self.status = status
        self.title = title
        self.video = video
    }
}
