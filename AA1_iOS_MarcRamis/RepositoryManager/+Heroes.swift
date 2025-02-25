//
//  ApiRepository.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import Foundation
import CryptoKit

extension MarvelRepository{
    
    public struct HeroError: Error {
            
            public enum HeroErrors: String {
                case CantCreateUrlWithString = "Can't create url with string"
                case CantCreateUrl = "Can't create url"
                case Unown = "Unowned error"
            }
            
            let error: HeroErrors
        }
    
    
    func GetHeroes(offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Hero]) -> (), onError: @escaping (HeroError)->() = {_ in })
    {
        let marvelComp = MarvelURLComponents()
       
        marvelComp
            .AddToPath(.Characters)
            .AddOffset(offset)
            .AddLimit(limit)
        
        guard let url = marvelComp.Components.url else {
            onError(HeroError(error: .CantCreateUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    onError(HeroError(error: .Unown))
                    return
                }
                return
            }
            
            if let data = data {
               
                //var jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
                guard let heroesResponse = try? JSONDecoder().decode(HeroesResponse.self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    onSuccess(heroesResponse.data.results)
                }
                
            }
        }
        
        task.resume()
    }
    
}
