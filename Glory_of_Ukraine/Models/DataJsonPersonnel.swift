//
//  DataJsonPersonnel.swift
//  Glory_of_Ukraine
//
//  Created by Serhii Palamarchuk on 20.07.2022.
//

import Foundation

struct DataJsonPersonnel: Codable {
    let date: String
    let day, personnel: Int
    let welcomePersonnel: Personnel
    let pow: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case welcomePersonnel = "personnel*"
        case pow = "POW"
    }
}

enum Personnel: String, Codable {
    case about = "about"
    case more = "more"
}

typealias ArrayPersonnel = [DataJsonPersonnel]
