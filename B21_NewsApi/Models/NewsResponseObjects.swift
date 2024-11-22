//
//  NewsResponseObjects.swift
//  B21_NewsApi
//
//  Created by Till Hemmerich on 22.11.24.
//

import Foundation

enum HTTPError : Error{
    case invalidURL, fetchFailed
    
    var message: String{
        switch self {
        case .invalidURL:
            "Die URL ist ungültig"
        case .fetchFailed:
            "Das Laden der Daten ist fehlgeschlagen"
        }
    }
}

struct News : Codable{
    var status : String
    var totalResults: Int
    let articles: [Article]
}
struct Article : Codable, Hashable{
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}
struct Source : Codable, Hashable{
    var name: String
}

/**
 ```
 {
 "status": "ok",
 "totalResults": 2083,
 -"articles": [
 -{
 -"source": {
 "id": null,
 "name": "Yahoo Entertainment"
 },
 "author": "Amy Skorheim",
 "title": "Black Friday Apple deals 2024: The best Apple sales on iPads, AirPods, Apple Watches, MacBooks and AirTags",
 "description": "Between the ”Let Loose” iPad event\r\n in May, the iPhone 16 “It’s Glowtime” event\r\n in September and the Mac Week non-event\r\n in October, Apple has been busy releasing a slew of new iPads, Macs, Apple Watches, MacBooks and more for 2024. If you’ve been waiting…",
 "url": "https://consent.yahoo.com/v2/collectConsent?sessionId=1_cc-session_eaa3e088-3fab-41b9-a1e1-0b8620ef792b",
 "urlToImage": null,
 "publishedAt": "2024-11-21T15:48:13Z",
 "content": "If you click 'Accept all', we and our partners, including 237 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+678 chars]"
 },
 ]
 }
 ```
 **/
