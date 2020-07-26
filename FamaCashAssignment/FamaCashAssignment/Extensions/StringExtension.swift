//
//  StringExtension.swift
//  FamaCashAssignment
//
//  Created by Mac on 25/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import Foundation

extension String {
    func getUrlWithParam(parameters: [String: Any]) -> String {
        var newPath = self
        if parameters.count > 0 {
            for (key, value) in parameters {
                let appendWith = newPath.contains("?") ? "&" : "?"
                newPath.append("\(appendWith)\(key)=\(value)")
            }
        }
        return newPath
    }
}
