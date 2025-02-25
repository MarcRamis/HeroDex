//
//  ApiRepo+Content.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 4/5/23.
//

import Foundation

extension MarvelRepository{

    func GetContent(page: MarvelURLComponents.SubPath, characterId: Int, offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Item]) -> (), onError: @escaping (HeroError)->() = {_ in })
    {
        let marvelComp = MarvelURLComponents()
       
        marvelComp
            .AddToPath(.Characters).GetInsideId(characterId).AddToPath(page)
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
                
                guard let itemsResponse = try? JSONDecoder().decode(ItemsResponse.self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    onSuccess(itemsResponse.data.results)
                }
                
            }
        }
        
        task.resume()
    }
    
}
