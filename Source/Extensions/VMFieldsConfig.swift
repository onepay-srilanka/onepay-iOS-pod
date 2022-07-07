//
//  VisaMasterConfig.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-06.
//

import Foundation
import UIKit

extension VisaMasterVC: UITextFieldDelegate{

    
    @objc func validateExpireDate(textField:UITextField){
        
        if let text = textField.text {
    
            if text.count == 0 {
                
                txtFieldDate.resignFirstResponder()
                txtFieldCVV.becomeFirstResponder()
            } else if text.count == 5 {
                
                txtFieldDate.resignFirstResponder()
            }
        }
    }
    
    @objc func validateCVC(textField:UITextField){
        
        
        if let text = textField.text {
            
            if text.count == 0 {
                
                txtFieldCVV.resignFirstResponder()
                txtFieldCardNumber.becomeFirstResponder()
                
            } else if text.count == 3 {
                
                txtFieldCVV.resignFirstResponder()
                txtFieldDate.becomeFirstResponder()
            }
            
        }
        
    }
    
    @objc func reformatAsCardNumber(textField:UITextField){
        
        let formatter = CreditCardFormatter.sharedInstance
        var isAmex = false
        
        if selectedCardType == "AMEX" {
            isAmex = true
        }
        
        formatter.formatToCreditCardNumber(isAmex: isAmex, textField: textField, withPreviousTextContent: textField.text, andPreviousCursorPosition: textField.selectedTextRange)
        
        let input = self.txtFieldCardNumber.text!
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        switch formatter.cardType(number: numberOnly) {
        
        case .Visa:
            
            cardType = .Visa
            let bundle = Bundle(for: VisaMasterVC.self)
            self.imgCardType.image = UIImage(named: "visa.png", in: bundle, compatibleWith: nil)
            
        case .MasterCard:
            
            cardType = .MasterCard
            let bundle = Bundle(for: VisaMasterVC.self)
            self.imgCardType.image = UIImage(named: "mastercard.png", in: bundle, compatibleWith: nil)

        default:
            
            cardType = .Unknown
            self.imgCardType.image = nil
           
        }
        
        if numberOnly.count == 16 {
            
            txtFieldCardNumber.resignFirstResponder()
            txtFieldCVV.becomeFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 0 || textField.tag == -1{
            return true
        }
        
        if textField.tag == 1 {
            
            return range.location < 3
            
        } else {
            
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            let updatedText = oldText.replacingCharacters(in: r, with: string)
        
            
            if string == "" {
                if updatedText.count == 2 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
            } else if updatedText.count == 1 {
                if updatedText > "1" {
                    return false
                }
            } else if updatedText.count == 2 {
                if updatedText <= "12" { //Prevent user to not enter month more than 12
                    textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
                }
                return false
            } else if updatedText.count == 5 {
                
                self.expDateValidation(dateStr: updatedText)
               
                
            } else if updatedText.count > 5 {

                return false
            }
            
            return true
            
        }
        
        
    }
    
    
    private func expDateValidation(dateStr:String) {
        
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
        
        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        
        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                
                isValidExpireDate = true
            } else {
               
                isValidExpireDate = false
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   
                    isValidExpireDate = true
                } else {
                    
                    isValidExpireDate = false
                }
            } else {
               
                isValidExpireDate = false
            }
        } else {
            
            isValidExpireDate = false
        }
    }
}
