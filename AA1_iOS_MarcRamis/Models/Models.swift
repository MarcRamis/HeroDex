//
//  Models.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import Foundation

struct HeroesResponse : Codable {
    let code: Int
    let status: String
    let data: HeroesData
}

struct HeroesData: Codable{
    let results: [Hero]
}

struct Hero: Codable{
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
}

struct Thumbnail : Codable
{
    let path: String
    let `extension`: String
    
    var ImageUrl: String { get { return "\(path).\(`extension`)" } }
    var Url: URL? { get { URL(string: ImageUrl) } }
}

struct ItemsResponse : Codable {
    let code: Int
    let status: String
    let data: ItemsData
}

struct ItemsData: Codable{
    let results: [Item]
}

struct Item : Codable{
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
}
