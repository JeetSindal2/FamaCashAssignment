//
//  MovieDetailViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imgVwMoviePhoto: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblMovieStatus: UILabel!
    @IBOutlet weak var btnSeeVideo: UIButton!
    
    var selectedMovieResultsModel: MovieModel? = nil
    var movieDetailModel: MovieDetailModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    // MARK: - Custom Methods
    private func initialSetup() {
        getMovieDetailAPI()
    }
    
    private func setupData() {
        DispatchQueue.main.async {
            self.lblBudget.text = String(self.movieDetailModel?.budget ?? 0)
            self.lblTitle.text = self.movieDetailModel?.title
            self.lblOverview.text = self.movieDetailModel?.overview
            self.lblMovieStatus.text = self.movieDetailModel?.status
            self.lblReleaseDate.text = self.movieDetailModel?.release_date
            
            if let img = self.movieDetailModel?.backdrop_path {
                self.imgVwMoviePhoto.sd_setImage(with: URL(string: kImageBaseUrl + img), placeholderImage: #imageLiteral(resourceName: "app-splash-screen"))
            } else {
                self.imgVwMoviePhoto.image = #imageLiteral(resourceName: "app-splash-screen")
            }
        }
    }
    
    // MARK: IBAction Methods
    @IBAction func actionBtnSeeVideo(_ sender: Any) {
        performSegue(withIdentifier: kSegue_MovieDetailToMovieVideoList, sender: nil)
    }
    
    @IBAction func actionBtnSeeReviews(_ sender: Any) {
        performSegue(withIdentifier: kSegue_MovieDetailToMovieReview, sender: nil)
    }
    
    // MARK: API Call
    private func getMovieDetailAPI() {
        guard let safeMovieResultModel = selectedMovieResultsModel else { return }
        weak var weakSelf = self
        self.startLoading()
        ApiManager.sharedInstance.getMovieDetail(movieId: safeMovieResultModel.id ?? 0, parameters: [kLanguage: kEnglishLanguage]) { (success, response) in
            if success, let movieDetailMdl = response as? MovieDetailModel {
                self.movieDetailModel = movieDetailMdl
                weakSelf?.setupData()
            } else if let errorMdl = response as? ErrorModel {
                weakSelf?.showAlert(title: kError, message: errorMdl.status_message ?? "")
            } else {
                weakSelf?.showAlert(title: kError, message: "")
            }
            self.stopLoading()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == kSegue_MovieDetailToMovieVideoList {
            let destinationVC = segue.destination as? MovieVideoListViewController
            destinationVC?.selectedMovieResultsModel = selectedMovieResultsModel
        } else if segue.identifier == kSegue_MovieDetailToMovieReview {
            let destinationVC = segue.destination as? MovieReviewListViewController
            destinationVC?.selectedMovieResultsModel = selectedMovieResultsModel
        }
    }
}
