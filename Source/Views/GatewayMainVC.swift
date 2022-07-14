//
//  GatewayMainVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-01.
//

import UIKit
import Alamofire

protocol MainManagementDelegate: Any{
    
    func onKeyboardWillHide()
    func onKeyboardWillShow()
    func close()
}

public class GatewayMainVC: UIViewController, MainManagementDelegate {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var ipgView: UIView!
    
    public static let CONTAINS_STORYBOARD = Constant.MainStoryboard
    public static let MAIN_GATEWAY         = Constant.MainGatewayVC
    static let progress = ProgressHUD(text: "processing")
     
    private var onepayIPGDelegate: OnepayIPGDelegate? = nil
    private var initData: OnepayIPGInit? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        ipgView.layer.cornerRadius = 8
        view.addSubview(GatewayMainVC.progress)
        GatewayMainVC.progress.hide()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func setInitData(ipgInitData: OnepayIPGInit){
        
        self.initData = ipgInitData
    }
    public func setIPGDelegate(onepayIPGDelegate: OnepayIPGDelegate){
        
        self.onepayIPGDelegate = onepayIPGDelegate
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
            if let destination = segue.destination as? MainPVC{
            
                if let initializeData = self.initData{
                    
                    lblAmount.text =  String(format: "%.2f LKR", initializeData.proDetails.amount)
                    destination.initData = initializeData
                    Constant.token = initializeData.secDetails.token
                    Constant.hashKey = initializeData.secDetails.hashKey
                }else{
                    
                    fatalError(IPGError.initError.rawValue)
                }
                destination.onepayIPGDelegate = onepayIPGDelegate
                destination.mainVCManagementDelegate = self
                
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
    
    func close() {
        
        self.dismiss(animated: true, completion: nil)
    }
}
