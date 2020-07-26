//
//  ResponseManager.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class ResponseManager: NSObject {

    static func parseGenreResponse(response: Any?) -> [GenreModel]? {
        if let dict = response as? [String: Any] {
            guard let arr = dict[kGenres] as? [[String: Any]] else { return nil }
            var genreList = [GenreModel]()
            
            for dict in arr {
                let genreMdl = GenreModel(id: dict[kId] as? Int, name: dict[kName] as? String)
                genreList.append(genreMdl)
            }
            return genreList
        } else {
            return nil
        }
    }
    
    static func parseMovieListResponse(response: Any?) -> MovieListModel? {
        guard let dic = response as? [String: Any] else { return nil }
        guard let arrResults = dic[kresults] as? [[String: Any]] else { return nil }
        var results = [MovieModel]()
        
        for dicResults in arrResults {
            let movieMdl = MovieModel(description: dicResults[kDescription] as? String, favorite_count: dicResults[kFavorite_count] as? Int, id: dicResults[kId] as? Int, item_count: dicResults[kitem_count] as? Int, iso_639_1: dicResults[kiso_639_1] as? String, list_type: dicResults[klist_type] as? String, name: dicResults[kName] as? String, poster_path: dicResults[kposter_path] as? String)
            results.append(movieMdl)
        }
        
        let movieLstMdl = MovieListModel(id: dic[kId] as? Int, page: dic[kPage] as? Int, results: results, total_pages: dic[ktotal_pages] as? Int, total_results: dic[ktotal_results] as? Int)

        return movieLstMdl
    }
    
    static func parseMovieDetail(response: Any?) -> MovieDetailModel? {
        guard let dic = response as? [String: Any] else { return nil }
        let movieDetailMdl = MovieDetailModel(backdrop_path: dic[kbackdrop_path] as? String, budget: dic[kbudget] as? Int, overview: dic[koverview] as? String, release_date: dic[krelease_date] as? String, status: dic[kstatus] as? String, title: dic[ktitle] as? String, video: dic[kvideo] as? Bool)
        return movieDetailMdl
    }
    
    static func parseMovieVideoList(response: Any?) -> MovieVideoModel? {
        guard let dic = response as? [String: Any] else { return nil }
        guard let arrResults = dic[kresults] as? [[String: Any]] else { return nil }
        var results = [MovieVideoResultModel]()
        for dicResults in arrResults {
            let movieMdl = MovieVideoResultModel(id: dicResults[kId] as? String, key: dicResults[kKey] as? String, name: dicResults[kName] as? String, site: dicResults[kSite] as? String, type: dicResults[kType] as? String)
            results.append(movieMdl)
        }
        let movieVideoMdl = MovieVideoModel(id: dic[kId] as? Int, results: results)
        return movieVideoMdl
    }
    
    static func parseErrorResponse(response: Any?) -> ErrorModel? {
        guard let dic = response as? [String: Any] else { return nil }
        let errorMdl = ErrorModel(status_message: dic[kstatus_message] as? String, success: dic[ksuccess] as? Bool, status_code: dic[kstatus_code] as? Int)
        return errorMdl
    }
    
    static func parseMovieReviewListResponse(response: Any?) -> MovieReviewListModel? {
        guard let dic = response as? [String: Any] else { return nil }
        guard let arrResults = dic[kresults] as? [[String: Any]] else { return nil }
        var results = [MovieReviewModel]()
        
        for dicResults in arrResults {
            let movieReviewMdl = MovieReviewModel(author: dicResults[kauthor] as? String, content: dicResults[kcontent] as? String, id: dicResults[kId] as? String, url: dicResults[kurl] as? String)
            results.append(movieReviewMdl)
        }
        
        let movieReviewLstMdl = MovieReviewListModel(id: dic[kId] as? Int, page: dic[kPage] as? Int, results: results, total_pages: dic[ktotal_pages] as? Int, total_results: dic[ktotal_results] as? Int)

        return movieReviewLstMdl
    }
}
