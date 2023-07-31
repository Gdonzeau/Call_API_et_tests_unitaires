//
//  NewsGot.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import Foundation

struct NewsGot: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let author: String?
    let title: String?
    let url: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source?
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
