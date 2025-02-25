//
//  HeroDetailVC.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import Foundation
import UIKit

class HeroDetailVC : UIViewController {
    
    @IBOutlet weak var heroImage: MyImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    @IBAction func ComicsBtn(_ sender: UIButton) {
        pager?.ShowComics()
    }
    @IBAction func SeriesBtn(_ sender: UIButton) {
        pager?.ShowSeries()
    }
    @IBAction func StoriesBtn(_ sender: UIButton) {
        pager?.ShowStories()
    }
    
    public var CurrentHero: Hero?
    
    var items: [Item] = []
    
    var GetItemsInProgress: Bool = false
    
    var pager: PagerContainerVC?
    var heroesList: HeroesListVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let CurrentHero = CurrentHero{
            debugPrint(CurrentHero.id)
            
            if let urlImg = CurrentHero.thumbnail?.Url {
                heroImage.SetImageAsync(url: urlImg)
            }
            
            heroDescription.text = CurrentHero.description
            heroName.text = CurrentHero.name
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pager = segue.destination as? PagerContainerVC {
            self.pager = pager
            pager.hero = CurrentHero
        }
    }
    
    @IBAction func Swiper(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}
