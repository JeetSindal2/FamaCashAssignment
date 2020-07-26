//
//  Constants.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation

// MARK: - Enum

enum apiCallingStatus {
    case isRunning
    case completedRunning
}

// MARK: - General
let kEnglishLanguage = "en-US"
let kGenreTitle = "GENRE"
let kAppSettings = "AppSettings"
let ApiKey = "aa9e7757d50b1c7554e95ff0488fca17"
let kMovies = "Movies"
let kReviews = "Reviews"
let kImageBaseUrl = "https://image.tmdb.org/t/p/w500"
let kOk = "Ok"
let kError = "Error"
let kNoDataFound = "No data found"

// MARK: - Parameter Keys
let kApiKey = "api_key"
let kLanguage = "language"
let kPage = "page"

// MARK: - Response Keys
let kId = "id"
let kName = "name"
let kGenres = "genres"
let kDescription = "description"
let kFavorite_count = "favorite_count"
let kiso_639_1 = "iso_639_1"
let kitem_count = "item_count"
let klist_type = "list_type"
let kposter_path = "poster_path"
let ktotal_pages = "total_pages"
let ktotal_results = "total_results"
let kresults = "results"

let kbackdrop_path = "backdrop_path"
let kbudget = "budget"
let koverview = "overview"
let krelease_date = "release_date"
let kstatus = "status"
let ktitle = "title"
let kvideo = "video"

let kKey = "key"
let kSite = "site"
let kType = "type"

let kstatus_message = "status_message"
let ksuccess = "success"
let kstatus_code = "status_code"

let kauthor = "author"
let kcontent = "content"
let kurl = "url"

// MARK: - API Endpoints
let genreListApiEndpoint = "genre/movie/list"
let movieListApiEndPoint = "movie/%@/lists"
let movieDetailApiEndPoint = "movie/%@"
let movieVideoListAPIEndPoint = "movie/%@/videos"
let movieReviewListAPIEndPoint = "movie/%@/reviews"

// MARK: - Cell Identifiers
let kGenreTableViewCell = "GenreTableViewCell"
let kMovieTableViewCell = "MovieTableViewCell"

// MARK: - Segue Identifiers
let kSegue_GenreToMovieList = "segue_GenreToMovieList"
let kSegue_MovieListToMovieDetail = "segue_MovieListToMovieDetail"
let kSegue_MovieDetailToMovieVideoList = "segue_MovieDetailToMovieVideoList"
let kSegue_MovieVideoListToVideoPlay = "segue_MovieVideoListToVideoPlay"
let kSegue_MovieDetailToMovieReview = "segue_MovieDetailToMovieReview"
