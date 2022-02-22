//
//  NewsFeed.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 26/01/2022.
//

import UIKit

struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]
}
