//
//  MarvelRepository.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 5/5/23.
//

import Foundation

class MarvelRepository
{
    public class MarvelURLComponents {

        // my keys
        //private static let publicKey = "a459b0bcbefd4d62f91099d119be2a0c"
        //private static let privateKey = "51d25e264b19fc596d211bece62792ffb68f4157"
        
        // class keys
        private static let publicKey = "a1f82c3af384b645dd6b334274ad24ef"
        private static let privateKey = "43a1c9b7210deb64d09ee19ad9ce370f94e9461c"
        
        private static let mainUrl = "https://gateway.marvel.com:443/v1/public/"
        
        private var components: URLComponents?
        public var Components: URLComponents { get{ return components! }}
        
        enum SubPath: String{
            
            case Characters = "characters"
            case Comics = "comics"
            case Series = "series"
            case Stories = "stories"
        }
        
        init()
        {
            self.components = URLComponents(string: MarvelURLComponents.mainUrl)
            
            let ts = String(Date().timeIntervalSince1970)
            let hash = Api.MD5(string:"\(ts)\(MarvelURLComponents.privateKey)\(MarvelURLComponents.publicKey)")
            
            self.components?.queryItems = [
                URLQueryItem(name: "apikey", value: MarvelURLComponents.publicKey),
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "hash", value: hash),
            ]
        }
        
        @discardableResult func AddToPath(_ subPath: SubPath) -> MarvelURLComponents
        {
            self.components?.path += subPath.rawValue
            return self
        }
        
        static func +=(comp: MarvelURLComponents, subPath: SubPath)
        {
            comp.AddToPath(subPath)
        }
        
        @discardableResult static func +(comp: MarvelURLComponents, subPath: SubPath) -> MarvelURLComponents
        {
            comp.AddToPath(subPath)
        }
        
        @discardableResult func AddLimit(_ limit: Int) -> MarvelURLComponents
        {
            self.components?.queryItems?.append(URLQueryItem(name:"limit", value: String(limit)))
            return self
        }
        
        @discardableResult func AddOffset(_ offset: Int) -> MarvelURLComponents
        {
            self.components?.queryItems?.append(URLQueryItem(name:"offset", value: String(offset)))
            return self
        }
        @discardableResult func GetInsideId(_ id: Int) -> MarvelURLComponents
        {
            self.components?.path += "/" + String(id) + "/"
            return self
        }
    }

}
