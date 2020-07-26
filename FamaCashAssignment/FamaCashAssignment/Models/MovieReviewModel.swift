//
//  MovieReviewModel.swift
//  FamaCashAssignment
//
//  Created by Mac on 26/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

struct MovieReviewListModel {
    var id: Int?
    var page: Int?
    var results: [MovieReviewModel]?
    var total_pages: Int?
    var total_results: Int?
    
    init(id: Int?, page: Int?, results: [MovieReviewModel]?, total_pages: Int?, total_results: Int?) {
        self.id = id
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
}

struct MovieReviewModel {
    var author: String?
    var content: String?
    var id: String?
    var url: String?
    
    init(author: String?, content: String?, id: String?, url: String?) {
        self.id = id
        self.content = content
        self.url = url
        self.author = author
    }
}
