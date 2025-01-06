//
//  ViewControllerHelper.swift
//  funZone
//
//  Created by admin on 12/31/24.
//

import Foundation

// login prerequisites
struct LoginAttributes {
    var minLengthPassword : Int
    var minLengthUsername : Int
    var maxLengthPassword : Int
    var maxLengthUsername : Int
}

func checkUserDataExists(name: String, password: String) -> Bool {
    if (!name.isEmpty && !password.isEmpty) {
        return true
    }
    else {
        return false
    }
}
