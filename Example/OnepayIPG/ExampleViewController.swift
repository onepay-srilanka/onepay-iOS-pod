//
//  ViewController.swift
//  OnepayIPG
//
//  Created by Udaya on 06/01/2022.
//  Copyright (c) 2022 Udaya. All rights reserved.
//

import UIKit
import OnepayIPG

class ExampleViewController: UIViewController, OnepayIPGDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startOnepayIPG(_ sender: Any) {
        
        let frameworkBundle = Bundle(for: GatewayMainVC.self)
        let storyBoard = UIStoryboard(name: GatewayMainVC.CONTAINS_STORYBOARD, bundle: frameworkBundle)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: GatewayMainVC.MAIN_GATEWAY) as! GatewayMainVC
        
        mainVC.setInitData(ipgInitData:
                            createIPGInit(builder: IPGInitBuilder()
                                         ))
        mainVC.setIPGDelegate(onepayIPGDelegate: self)
        
        self.present(mainVC, animated: true)
        
    }
    
    private func createIPGInit(builder: IPGInitBuilder) -> OnepayIPGInit{
        
        builder.setUser(Customer(
            firstName: "Chamath",
            lastName: "Rathnayake",
            phone: "+94778869070",
            email: "chamathrathnayake95@gmail.com"))
        
        builder.setConfigurations(Configurations(
            token: "3d0cd6ed02ce5e4277e42a6c4c7ff968d2075ed3b3f23a907f31ecbae72e6df9ea23039c0a4da077.B4AA1189E174E887371D7",
            appID: "KO651189E174E88737186",
            hashKey: "XGFM1189E174E887371B3"))
        
        builder.setProduct(Product(
            amount: 1000.58,
            currency: .LKR,
            reference: "0000000000060"))
        
        return builder.build()
    }
    
    
    func onPaymentSuccess(response: OnepayIPGSuccess) {
        
        print(response)
    }
    
    func onPaymentFailed(error: OnepayIPGError) {
        
        print(error)
    }
}

