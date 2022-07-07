//
//  Alert.swift
//  onepay_merchant
//
//  Created by Spemai-Macbook on 7/1/20.
//  Copyright © 2020 Spemai-Macbook. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc:UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    private static func showBasicAlertWithDismiss(on vc:UIViewController, with title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {( alert: UIAlertAction!) in
            vc.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    
    static func showError(msg: String,on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.USER_INPUTS_VALIDATION_ERROR_MESSAGE_HEADER, message: msg)
    }
    
    static func showSuccess(msg: String,on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.USER_INPUTS_VALIDATION_SUCCESS_MESSAGE_HEADER, message: msg)
    }
}

