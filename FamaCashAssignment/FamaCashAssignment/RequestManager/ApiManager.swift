//
//  ApiManager.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

typealias ApiCompletionHandler = (Bool, Any?) -> Void

class ApiManager: NSObject {

    static let sharedInstance = ApiManager()
    
    let baseUrl = "https://api.themoviedb.org/3/"
    
    func getGenreList(parameters: [String: Any], completion: @escaping ApiCompletionHandler) {
        let fullPath = baseUrl + genreListApiEndpoint
        
        makeHttpGetApiCall(path: fullPath, parameters: parameters) { (success, response) in
            if success {
                let genreList = ResponseManager.parseGenreResponse(response: response)
                completion(success, genreList)
            } else {
                completion(success, response)
            }
        }
    }
    
    func getMovieList(movieId: Int, parameters: [String: Any], completion: @escaping ApiCompletionHandler) {
        let fullPath = baseUrl + String(format: movieListApiEndPoint, String(movieId))
        
        makeHttpGetApiCall(path: fullPath, parameters: parameters) { (success, response) in
            if success {
                let genreList = ResponseManager.parseMovieListResponse(response: response)
                completion(success, genreList)
            } else {
                completion(success, response)
            }
        }
    }
    
    func getMovieDetail(movieId: Int, parameters: [String: Any], completion: @escaping ApiCompletionHandler) {
        let fullPath = baseUrl + String(format: movieDetailApiEndPoint, String(movieId))
        makeHttpGetApiCall(path: fullPath, parameters: parameters) { (success, response) in
            if success {
                let genreList = ResponseManager.parseMovieDetail(response: response)
                completion(success, genreList)
            } else {
                completion(success, response)
            }
        }
    }
    
    func getMovieVideoList(movieId: Int, parameters: [String: Any], completion: @escaping ApiCompletionHandler) {
        let fullPath = baseUrl + String(format: movieVideoListAPIEndPoint, String(movieId))
        makeHttpGetApiCall(path: fullPath, parameters: parameters) { (success, response) in
            if success {
                let genreList = ResponseManager.parseMovieVideoList(response: response)
                completion(success, genreList)
            } else {
                completion(success, response)
            }
        }
    }
    
    func getMovieReviewList(movieId: Int, parameters: [String: Any], completion: @escaping ApiCompletionHandler) {
        let fullPath = baseUrl + String(format: movieReviewListAPIEndPoint, String(movieId))
        
        makeHttpGetApiCall(path: fullPath, parameters: parameters) { (success, response) in
            if success {
                let genreList = ResponseManager.parseMovieReviewListResponse(response: response)
                completion(success, genreList)
            } else {
                completion(success, response)
            }
        }
    }
    
    private func makeHttpGetApiCall(path: String, parameters: [String: Any], completionHandler: @escaping ApiCompletionHandler) {
        var paramWithKey = parameters
        paramWithKey[kApiKey] = ApiKey
        let pathWithParam = path.getUrlWithParam(parameters: paramWithKey)
        guard let url = URL(string: pathWithParam) else { return }
        let request = URLRequest(url: url)
    
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let jsonData = data {
                    let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                    print("Url: \(pathWithParam) response: \(anyObject ?? "")")
                    
                    if let httpRespnse = response as? HTTPURLResponse {
                        if httpRespnse.statusCode == 401 || httpRespnse.statusCode == 404 {
                            let errorMdl = ResponseManager.parseErrorResponse(response: anyObject)
                            completionHandler(false, errorMdl)
                        } else if httpRespnse.statusCode == 200 {
                            completionHandler(true, anyObject)
                        } else {
                            completionHandler(false, anyObject)
                        }
                    }
                } else {
                    completionHandler(false, nil)
                }
            } else {
                completionHandler(false, nil)
            }
        }
        dataTask.resume()
    }
}
