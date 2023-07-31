//
//  Extension String.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import Foundation

extension String? {
    func isHttpAdress() -> Bool {
        guard let potentialAddress = self else {
            return false
        }
        if potentialAddress.starts(with: "https") {
            return true
        }
        return false
    }
}
