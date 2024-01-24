//
//  APOD.swift
//  AstronomyPictures
//
//  Created by myung hoon on 22/01/2024.
//

import Foundation

struct APOD: Decodable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let title: String
    let url: String
}
