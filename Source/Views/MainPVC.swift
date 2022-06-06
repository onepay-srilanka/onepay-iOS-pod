//
//  MainPVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-03.
//

import UIKit

class MainPVC: UIPageViewController, UIPageViewControllerDataSource{
    
    //MARK: - PageContollerVC Variables
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            newViewController(ipgOption: PaymentOptions.optionOne),
            newViewController(ipgOption: PaymentOptions.optionTwo)
        ]
    }()
    var onepayIPGDelegate: OnepayIPGDelegate? = nil
    var keyboardNotificationDelegate: KeyboardManagementDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
   
    private func newViewController(ipgOption: PaymentOptions) -> UIViewController {
        
        let bundle = Bundle(for: MainPVC.self)
        
        switch ipgOption {
        case .optionOne:
            
            let vc = UIStoryboard(name: Constant.MainStoryboard, bundle: bundle) .
            instantiateViewController(withIdentifier: ipgOption.rawValue) as! VisaMasterVC
            vc.keyboardNotificationdelegate = keyboardNotificationDelegate
            vc.delegate = self.onepayIPGDelegate
            return vc
        case .optionTwo:
            
            let vc = UIStoryboard(name: Constant.MainStoryboard, bundle: bundle) .
            instantiateViewController(withIdentifier: ipgOption.rawValue) as! FrimiVC
            vc.delegate = self.onepayIPGDelegate
            return vc
        }
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
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
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
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
