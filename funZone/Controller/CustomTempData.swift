//
//  CustomTempData.swift
//  funZone
//
//  Created by admin on 1/9/25.
//

import Foundation

class TempNote {
    var name: String
    var content: String
    var index: Int
    
    var isEmpty: Bool {
        if self.name.isEmpty && self.content.isEmpty {
            return true
        }
        else {
            return false
        }
    }
    
    init() {
        self.name = ""
        self.content = ""
        self.index = -1
    }
    
    init(name: String, content: String, index: Int) {
        self.name = name
        self.content = content
        self.index = index
    }
}
