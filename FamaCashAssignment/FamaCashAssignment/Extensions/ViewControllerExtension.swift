//
//  ViewControllerExtension.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var activityIndicatorVw = UIActivityIndicatorView(style: .large)
    
    func startLoading() {
        DispatchQueue.main.async {
            let activity = UIViewController.activityIndicatorVw
            activity.tag = 7777
            activity.center = self.view.center
            activity.hidesWhenStopped = true
            activity.tintColor = .gray
            self.view.addSubview(activity)
            self.view.bringSubviewToFront(activity)
            activity.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            let activity = self.view.viewWithTag(7777) as? UIActivityIndicatorView //UIViewController.activityIndicatorVw
            activity?.stopAnimating()
            activity?.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: kOk, style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
