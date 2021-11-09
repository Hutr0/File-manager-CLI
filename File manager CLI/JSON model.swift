//
//  JSON model.swift
//  fileManager
//
//  Created by Леонид Лукашевич on 13.09.2021.
//

import Foundation

struct jsonFile: Codable {
    
    let name: String
    let surname: String
    let number: String
    let meals: [Meal]
}

enum Meal: String, Codable {
    case breakfast, lunch, dinner
}
