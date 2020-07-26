//
//  MovieReviewListViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 26/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class MovieReviewListViewController: UIViewController {
    @IBOutlet weak var tblMovieReview: UITableView!
    
    var selectedMovieResultsModel: MovieModel? = nil
    var movieReviewList: MovieReviewListModel? = nil
    var movieReviewResultsModel = [MovieReviewModel]()
    var selectedApiCallingStatus = apiCallingStatus.completedRunning
    var pageNumber = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    // MARK: - Custom Method
    private func initialSetup() {
        tblMovieReview.tableFooterView = UIView()
        navigationItem.title = kReviews
        getMovieReviewListAPI()
    }

    // MARK: - API Call
    
    private func loadMoreMovieReviewList() {
        switch selectedApiCallingStatus {
        case .isRunning:
            print("API running")
            return
        case .completedRunning:
            print("API running completed")
        }
        
        if pageNumber >= movieReviewList?.total_pages ?? 0 { return }
        pageNumber = pageNumber + 1
        getMovieReviewListAPI()
    }
    
    private func getMovieReviewListAPI() {
        guard let safeSelectedMovieResultsModel = selectedMovieResultsModel else { return }
        self.startLoading()
        weak var weakSelf = self
        selectedApiCallingStatus = .isRunning
        ApiManager.sharedInstance.getMovieReviewList(movieId: safeSelectedMovieResultsModel.id ?? 1, parameters: [kLanguage: kEnglishLanguage, kPage: pageNumber]) { (success, response) in
            if let movieLst = response as? MovieReviewListModel {
                self.movieReviewList = movieLst
                if let safeMovieResults = self.movieReviewList?.results {
                    self.movieReviewResultsModel = self.movieReviewResultsModel + safeMovieResults
                }
            } else if let errorMdl = response as? ErrorModel {
                weakSelf?.showAlert(title: kError, message: errorMdl.status_message ?? "")
            } else {
                weakSelf?.showAlert(title: kError, message: "")
            }
            self.tblMovieReview.reloadDataOnMainThread()
            self.stopLoading()
            self.selectedApiCallingStatus = .completedRunning
            if (self.movieReviewResultsModel.count == 0) {
                weakSelf?.showAlert(title: kNoDataFound, message: "")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieReviewListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieReviewResultsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieTableViewCell, for: indexPath) as? MovieTableViewCell
        cell?.initWithMoviewReviewCellData(movieReviewMdl: movieReviewResultsModel[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension MovieReviewListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movieReviewResultsModel.count - 1 {
            loadMoreMovieReviewList()
        }
    }
}
