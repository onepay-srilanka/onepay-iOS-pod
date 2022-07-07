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
        let initData = IPGInit(token: "3d0cd6ed02ce5e4277e42a6c4c7ff968d2075ed3b3f23a907f31ecbae72e6df9ea23039c0a4da077.B4AA1189E174E887371D7", firstName: "Chamath", lastName: "Rathnayake", phone: "+94778869070", reference: "0000000000050", appID: "KO651189E174E88737186", email: "chamathrathnayake95@gmail.com", hashKey: "XGFM1189E174E887371B3", amount: 100.05 , currency: CurrencyTypes.LKR)
        mainVC.setInitData(ipgInitData: initData)
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

