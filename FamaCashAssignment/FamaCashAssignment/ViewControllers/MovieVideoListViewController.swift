//
//  MovieVideoListViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 26/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class MovieVideoListViewController: UIViewController {
    
    @IBOutlet weak var tblMovieVideoList: UITableView!
    
    var selectedMovieResultsModel: MovieModel? = nil
    var movieVideoListModel: MovieVideoModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    // MARK: Custom Method
    private func initialSetup() {
        tblMovieVideoList.tableFooterView = UIView()
        getMovieVideoListAPI()
    }
    
    // MARK: - API Call
    func getMovieVideoListAPI() {
        guard let safeMovieResultModel = selectedMovieResultsModel else { return }
        weak var weakSelf = self
        self.startLoading()
        ApiManager.sharedInstance.getMovieVideoList(movieId: safeMovieResultModel.id ?? 0, parameters: [kLanguage: kEnglishLanguage]) { (success, response) in
            if success, let safeMovieVideoMdl = response as? MovieVideoModel {
                self.movieVideoListModel = safeMovieVideoMdl
            } else if let errorMdl = response as? ErrorModel {
                weakSelf?.showAlert(title: kError, message: errorMdl.status_message ?? "")
            } else {
                weakSelf?.showAlert(title: kError, message: "")
            }
            self.stopLoading()
            if (self.movieVideoListModel?.results?.count == 0) {
                weakSelf?.showAlert(title: kNoDataFound, message: "")
            }
            self.tblMovieVideoList.reloadDataOnMainThread()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == kSegue_MovieVideoListToVideoPlay {
            let destinationVC = segue.destination as? PlayVideoViewController
            destinationVC?.videoId = movieVideoListModel?.results?[tblMovieVideoList.indexPathForSelectedRow?.row ?? 0].key
        }
    }
}

extension MovieVideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieVideoListModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieTableViewCell, for: indexPath) as? MovieTableViewCell
        cell?.initWithMovieVideoCellData(movieVideoMdl: movieVideoListModel?.results?[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension MovieVideoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kSegue_MovieVideoListToVideoPlay, sender: nil)
    }
}
