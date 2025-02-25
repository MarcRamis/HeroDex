//
//  ViewController.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import UIKit

class HeroesListVC: UIViewController {
    
    @IBOutlet weak var heroesTable: UITableView!
    
    @IBOutlet weak var SearchText: UITextField!
    
    @IBAction func SearchBtn(_ sender: UIButton) {
    }
    
    var heroes: [Hero] = []

    var GetHeroesInProgress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heroesTable.delegate = self
        heroesTable.dataSource = self
    
        GetMoreHeroes()
    }
}

extension HeroesListVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let heroCell = tableView.dequeueReusableCell(withIdentifier: "HeroCell") as? HeroTableViewCell else {
            return UITableViewCell()
        }
        
        let hero = self.heroes[indexPath.row]
        
        if let imgUrl = hero.thumbnail?.Url {
            heroCell.heroImage.SetImageAsync(url: imgUrl)
        }
        
        heroCell.nameLabel.text = hero.name
        heroCell.descriptionTB.text = hero.description
        
        if (indexPath.row + 5 >= heroes.count && !GetHeroesInProgress)
        {
            GetMoreHeroes()
        }
        
        return heroCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        if let heroDetailVC = storyboard.instantiateViewController(withIdentifier: "HeroDetail")
            as? HeroDetailVC {
            
            heroDetailVC.heroesList = self
            heroDetailVC.CurrentHero = heroes[indexPath.row]
            heroDetailVC.modalPresentationStyle = .fullScreen
            self.present(heroDetailVC, animated: true)
        }
    }
}

extension HeroesListVC{
    
    func GetMoreHeroes() {
        
        if (!GetHeroesInProgress)
        {
            GetHeroesInProgress = true
            
            Api.Marvel.GetHeroes(offset: heroes.count, limit: 30) { 
                heroes in self.GetHeroesInProgress = false;
                
                self.heroes.insert(contentsOf: heroes, at: self.heroes.count)
                self.heroesTable.reloadData()
            } onError: { error in
                self.GetHeroesInProgress = false
            }
        }
    }
}
