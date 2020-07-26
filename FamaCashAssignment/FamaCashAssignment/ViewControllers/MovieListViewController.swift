//
//  MovieListViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tblMovieList: UITableView!
    
    var movieList: MovieListModel? = nil
    var movieResultsModel = [MovieModel]()
    var selectedGenre: GenreModel? = nil
    var pageNumber = 1
    var selectedApiCallingStatus = apiCallingStatus.completedRunning
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    // MARK: - Custom Method
    private func initialSetup() {
        tblMovieList.tableFooterView = UIView()
        navigationItem.title = selectedGenre?.name ?? kMovies
        getMovieListAPI()
    }
    
    // MARK: - API Call
    private func loadMoreMovieList() {
        switch selectedApiCallingStatus {
        case .isRunning:
            print("API running")
            return
        case .completedRunning:
            print("API running completed")
        }
        
        if pageNumber >= movieList?.total_pages ?? 0 { return }
        pageNumber = pageNumber + 1
        getMovieListAPI()
    }
    
    private func getMovieListAPI() {
        guard let safeSelectedGenre = selectedGenre else { return }
        self.startLoading()
        weak var weakSelf = self
        selectedApiCallingStatus = .isRunning
        ApiManager.sharedInstance.getMovieList(movieId: safeSelectedGenre.id ?? 1, parameters: [kLanguage: kEnglishLanguage, kPage: pageNumber]) { (success, response) in
            if let movieLst = response as? MovieListModel {
                self.movieList = movieLst
                if let safeMovieResults = self.movieList?.results {
                    self.movieResultsModel = self.movieResultsModel + safeMovieResults
                }
            } else if let errorMdl = response as? ErrorModel {
                weakSelf?.showAlert(title: kError, message: errorMdl.status_message ?? "")
            } else {
                weakSelf?.showAlert(title: kError, message: "")
            }
            self.tblMovieList.reloadDataOnMainThread()
            self.stopLoading()
            self.selectedApiCallingStatus = .completedRunning
            if (self.movieResultsModel.count == 0) {
                weakSelf?.showAlert(title: kNoDataFound, message: "")
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == kSegue_MovieListToMovieDetail {
            let destinationVC = segue.destination as? MovieDetailViewController
            destinationVC?.selectedMovieResultsModel = movieResultsModel[tblMovieList.indexPathForSelectedRow?.row ?? 0]
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieResultsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieTableViewCell, for: indexPath) as? MovieTableViewCell
        cell?.initWithMovieCellData(movieMdl: movieResultsModel[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movieResultsModel.count - 1 {
            loadMoreMovieList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kSegue_MovieListToMovieDetail, sender: nil)
    }
}
