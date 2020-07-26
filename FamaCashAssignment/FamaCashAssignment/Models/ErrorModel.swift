//
//  ErrorModel.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation
import UIKit

struct ErrorModel {
    var status_message: String?
    var success: Bool?
    var status_code: Int?
        
    init(status_message: String?, success: Bool?, status_code: Int?) {
        self.status_message = status_message
        self.success = success
        self.status_code = status_code
    }
}
