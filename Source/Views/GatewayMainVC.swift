//
//  GatewayMainVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-01.
//

import UIKit

protocol KeyboardManagementDelegate: Any{
    
    func onKeyboardWillHide()
    func onKeyboardWillShow()
}

public class GatewayMainVC: UIViewController, KeyboardManagementDelegate {

    
    @IBOutlet weak var viewVisaMaster: UIView!
    
    public static let CONTAINS_STORYBOARD = Constant.MainStoryboard
    public static let MAINGATEWAY         = Constant.MainGatewayVC
     
    private var onepayIPGDelegate: OnepayIPGDelegate? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewVisaMaster.layer.cornerRadius = 8
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func setIPGDelegate(onepayIPGDelegate: OnepayIPGDelegate){
        
        self.onepayIPGDelegate = onepayIPGDelegate
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MainPVC{
            
            destination.onepayIPGDelegate = onepayIPGDelegate
            destination.keyboardNotificationDelegate = self
        }
    }
    
    func onKeyboardWillHide() {
        
        self.view.frame.origin.y = 0
    }
    
    func onKeyboardWillShow() {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.frame.origin.y = -60
            self.view.layoutIfNeeded()
        })
    }
}
