//
//  HeroesComicsVC.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 11/5/23.
//

import Foundation
import UIKit

class HeroesStoriesVC : UICollectionViewController {
    
    public var CurrentHero: Hero?
    
    var items: [Item] = []
    
    var GetComicsInProgress: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let CurrentHero = CurrentHero{
            GetMoreStories(hero: CurrentHero)
        }
    }
}

extension HeroesStoriesVC
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = self.items[indexPath.row]
        
        if let imgUrl = item.thumbnail?.Url {
            itemCell.itemImage.SetImageAsync(url: imgUrl)
        }
        itemCell.itemName.text = item.title
        
        return itemCell
    }
}

extension HeroesStoriesVC
{
    func GetMoreStories(hero : Hero) {
        
        if (!GetComicsInProgress)
        {
            GetComicsInProgress = true
            
            Api.Marvel.GetContent(page: .Stories, characterId: hero.id, offset: items.count, limit: 30) {
                responseItems in
                
                self.GetComicsInProgress = false;
                
                self.items.insert(contentsOf: responseItems, at: self.items.count)
                debugPrint(self.items.count)
                self.collectionView.reloadData()
            } onError: { error in
                self.GetComicsInProgress = false
            }
            }
        }
}
