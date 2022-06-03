//
//  VisaMasterVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-03.
//

import UIKit

class VisaMasterVC: UIViewController {

    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldCardNumber: UITextField!
    @IBOutlet weak var txtFieldCVV: UITextField!
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var btPay: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    private func setUpView(){
        
        
        btPay.layer.cornerRadius = 8
        
        txtFieldName.layer.borderWidth = 1
        txtFieldName.layer.borderColor = UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1).cgColor
        txtFieldName.attributedPlaceholder = getAttributedPlaceholder(placeholder: "Name on your Card")
        txtFieldName.layer.cornerRadius = 6
        
        txtFieldCardNumber.layer.borderWidth = 1
        txtFieldCardNumber.layer.borderColor = UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1).cgColor
        txtFieldCardNumber.attributedPlaceholder = getAttributedPlaceholder(placeholder: "Card Number")
        txtFieldCardNumber.layer.cornerRadius = 6
        
        txtFieldCVV.layer.borderWidth = 1
        txtFieldCVV.layer.borderColor = UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1).cgColor
        txtFieldCVV.attributedPlaceholder =  getAttributedPlaceholder(placeholder: "CVV")
        txtFieldCVV.layer.cornerRadius = 6

        txtFieldDate.layer.borderWidth = 1
        txtFieldDate.layer.borderColor = UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1).cgColor
        txtFieldDate.attributedPlaceholder = getAttributedPlaceholder(placeholder: "DD/MM")
        txtFieldDate.layer.cornerRadius = 6
    }
    
    private func getAttributedPlaceholder(placeholder: String) -> NSAttributedString {
        
       return NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1)] )
    }
}
