//
//  MovieVideoModel.swift
//  FamaCashAssignment
//
//  Created by Mac on 26/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

struct MovieVideoModel {
    var id: Int?
    var results: [MovieVideoResultModel]?
    
    init(id: Int?, results: [MovieVideoResultModel]?) {
        self.id = id
        self.results = results
    }
}

struct MovieVideoResultModel {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var type: String?
    
    init(id: String?, key: String?, name: String?, site: String?, type: String?) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.type = type
    }
}
