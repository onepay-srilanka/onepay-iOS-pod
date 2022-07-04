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
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var txtFieldCVV: UITextField!
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var btPay: UIButton!
    
    private let viewModel = VisaMasterViewModel()
    var isValidExpireDate = false
    var delegate: OnepayIPGDelegate? = nil
    var initData: IPGInit!
    var keyboardNotificationdelegate: KeyboardManagementDelegate? = nil
    internal var selectedCardType: String? {
        didSet{
            reformatAsCardNumber(textField: txtFieldCardNumber)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        keyboardNotification()
        setUpView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        txtFieldDate.addTarget(self, action: #selector(self.validateExpireDate(textField:)), for: .editingChanged)
        
        txtFieldCVV.addTarget(self, action: #selector(self.validateCVC(textField:)), for: .editingChanged)
        
        txtFieldCardNumber.addTarget(self, action: #selector(self.reformatAsCardNumber(textField:)), for: .editingChanged)
    }
    
    private func getAttributedPlaceholder(placeholder: String) -> NSAttributedString {
        
       return NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1)] )
    }
    
    @IBAction func tappedOnPay(_ sender: Any) {
        
        
    }

    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        keyboardNotificationdelegate?.onKeyboardWillShow()
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        
        keyboardNotificationdelegate?.onKeyboardWillHide()
    }
    
   private func keyboardNotification () {
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
}
