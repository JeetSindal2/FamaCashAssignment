//
//  MovieListModel.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

struct MovieListModel {
    var id: Int?
    var page: Int?
    var results: [MovieModel]?
    var total_pages: Int?
    var total_results: Int?
    
    init(id: Int?, page: Int?, results: [MovieModel]?, total_pages: Int?, total_results: Int?) {
        self.id = id
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}

struct MovieModel {
    var description: String?
    var favorite_count: Int?
    var id: Int?
    var item_count: Int?
    var iso_639_1: String?
    var list_type: String?
    var name: String?
    var poster_path: String?
    
    init(description: String?, favorite_count: Int?, id: Int?, item_count: Int?, iso_639_1: String?, list_type: String?, name: String?, poster_path: String?) {
        self.description = description
        self.favorite_count = favorite_count
        self.id = id
        self.item_count = item_count
        self.iso_639_1 = iso_639_1
        self.list_type = list_type
        self.name = name
        self.poster_path = poster_path
    }
}
