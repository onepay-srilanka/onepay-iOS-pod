//
//  ViewController.swift
//  OnepayIPG
//
//  Created by Udaya on 06/01/2022.
//  Copyright (c) 2022 Udaya. All rights reserved.
//

import UIKit
import OnepayIPG


class ViewController: UIViewController, OnepayIPGDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func startOnepayIPG(_ sender: Any) {
        
        let frameworkBundle = Bundle(for: GatewayMainVC.self)
        let storyBoard = UIStoryboard(name: GatewayMainVC.CONTAINS_STORYBOARD, bundle: frameworkBundle)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: GatewayMainVC.MAINGATEWAY) as! GatewayMainVC
        mainVC.setIPGDelegate(onepayIPGDelegate: self)
        self.present(mainVC, animated: true)
         
    }
    
    func onPaymentSuccess() {
        
        print("On payment success")
    }
    
    func onPaymentFailed() {
        
        print("On payment failed")
    }
}

