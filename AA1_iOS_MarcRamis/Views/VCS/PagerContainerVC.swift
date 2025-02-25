//
//  PageContainerTest.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 5/5/23.
//

import Foundation
import UIKit

class PagerContainerVC : UIPageViewController {
    
    var hero: Hero?
    var vcs : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let ComicsVC = storyBoard.instantiateViewController(withIdentifier: "Comics") as? HeroesComicsVC {
            ComicsVC.CurrentHero = hero
            vcs.append(ComicsVC)
        }
        
        if let SeriesVC = storyBoard.instantiateViewController(withIdentifier: "Series") as? HeroesSeriesVC {
            SeriesVC.CurrentHero = hero
            vcs.append(SeriesVC)
        }
        
        if let StoriesVC = storyBoard.instantiateViewController(withIdentifier: "Stories") as? HeroesStoriesVC {
            StoriesVC.CurrentHero = hero
            vcs.append(StoriesVC)
        }
        
        self.delegate = self
        self.dataSource = self
        
        self.setViewControllers([vcs[0]], direction: .forward, animated: true)
    }
}

extension PagerContainerVC : UIPageViewControllerDelegate, UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcs.firstIndex(of: viewController) else{
            return nil
        }
        
        if (index == 0){
            return nil
        }
        
        var prev = (index - 1) % vcs.count
        if prev < 0 {
            prev = vcs.count - 1
        }
        return vcs[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcs.firstIndex(of: viewController) else {
            return nil
        }
        if (index == (vcs.count - 1)){
            return nil
        }
        
        let nxt = abs((index + 1) % vcs.count)
        return vcs[nxt]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return vcs.count
    }
    
}

extension PagerContainerVC {
    
    func ShowComics()
    {
        self.setViewControllers([vcs[0]], direction: .forward, animated: true)
    }
    
    func ShowSeries()
    {
        self.setViewControllers([vcs[1]], direction: .forward, animated: true)
    }
    
    func ShowStories()
    {
        self.setViewControllers([vcs[2]], direction: .forward, animated: true)
    }
}
