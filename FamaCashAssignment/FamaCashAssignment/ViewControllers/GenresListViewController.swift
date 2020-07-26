//
//  GenresListViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit

class GenresListViewController: UIViewController {

    // Outlets
    @IBOutlet weak var tblGenre: UITableView!
    
    // Properties
    var genreLists = [GenreModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    // MARK: - Custom Methods
    func initialSetup() {
        tblGenre.tableFooterView = UIView()
        navigationItem.title = kGenreTitle
        getGenreListAPI()
    }

    // MARK: - API Call
    func getGenreListAPI() {
        self.startLoading()
        weak var weakSelf = self
        ApiManager.sharedInstance.getGenreList(parameters: [kLanguage: kEnglishLanguage]) { (success, response) in
            if let genreList = response as? [GenreModel] {
                self.genreLists = genreList
            } else if let errorMdl = response as? ErrorModel {
                weakSelf?.showAlert(title: kError, message: errorMdl.status_message ?? "")
            } else {
                weakSelf?.showAlert(title: kError, message: "")
            }
            self.tblGenre.reloadDataOnMainThread()
            self.stopLoading()
            if (self.genreLists.count == 0) {
                weakSelf?.showAlert(title: kNoDataFound, message: "")
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == kSegue_GenreToMovieList {
            let destination = segue.destination as? MovieListViewController
            destination?.selectedGenre = genreLists[tblGenre.indexPathForSelectedRow?.row ?? 0]
        }
    }
}

extension GenresListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGenreTableViewCell, for: indexPath) as? GenreTableViewCell
        cell?.initWithGenreCellData(genreMdl: genreLists[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension GenresListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kSegue_GenreToMovieList, sender: nil)
    }
}
