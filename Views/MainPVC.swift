//
//  MainPVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-03.
//

import UIKit

class MainPVC: UIPageViewController, UIPageViewControllerDataSource{
    
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            newViewController(name: "VM"),
            newViewController(name: "Frimi")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
   
    private func newViewController(name: String) -> UIViewController {
        
        let bundle = Bundle(for: MainPVC.self)
        return UIStoryboard(name: "Gateway", bundle: bundle) .
        instantiateViewController(withIdentifier: "\(name)ViewController")
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                   return nil
               }
               
               let previousIndex = viewControllerIndex - 1
               
               guard previousIndex >= 0 else {
                   return orderedViewControllers.last
               }
               
               guard orderedViewControllers.count > previousIndex else {
                   return nil
               }
               
               return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                    return nil
                }
                
                let nextIndex = viewControllerIndex + 1
                guard orderedViewControllers.count != nextIndex else {
                    return orderedViewControllers.first
                }
                
                guard orderedViewControllers.count > nextIndex else {
                    return nil
                }
                
                return orderedViewControllers[nextIndex]
    }
}
