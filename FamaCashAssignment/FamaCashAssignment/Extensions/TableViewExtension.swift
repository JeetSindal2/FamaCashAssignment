//
//  TableViewExtension.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
