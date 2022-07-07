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
    private let progress  = ProgressHUD(text: "processing...")
    var isValidExpireDate = false
    var cardType = CardType.Unknown
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
        
//        view.addSubview(progress)
//        progress.hide()
        
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
        txtFieldDate.attributedPlaceholder = getAttributedPlaceholder(placeholder: "MM/YY")
        txtFieldDate.layer.cornerRadius = 6
        
        txtFieldDate.addTarget(self, action: #selector(self.validateExpireDate(textField:)), for: .editingChanged)
        
        txtFieldCVV.addTarget(self, action: #selector(self.validateCVC(textField:)), for: .editingChanged)
        
        txtFieldCardNumber.addTarget(self, action: #selector(self.reformatAsCardNumber(textField:)), for: .editingChanged)
    }
    
    private func getAttributedPlaceholder(placeholder: String) -> NSAttributedString {
        
       return NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 0.627, green: 0.682, blue: 0.753, alpha: 1)] )
    }
    
    @IBAction func tappedOnPay(_ sender: Any) {
        
        let nameONCard = txtFieldName.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let cardNumber = txtFieldCardNumber.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let expDate    = txtFieldDate.text ?? ""
        let cvv        = txtFieldCVV.text ?? ""
        
        
        viewModel.validateData(initData: self.initData, nameOnCard: nameONCard, cardNumber: cardNumber, cardType: self.cardType, isValidExpireDate: self.isValidExpireDate,expDate: expDate, cvv: cvv){ result in
            
            switch result{
                
            case .success(let requestData):
                
                get3DS(data: requestData)
                 break
                
            case .failure(let ipgError):
                
                Alert.showError(msg: ipgError.rawValue, on: self)
            }
        }
    }

    private func get3DS(data: _3DSRequestData){
        
        GatewayMainVC.progress.show()
        viewModel.validateAndGet3DS(reqData: data){ [weak self] result in
            
            guard let _ = self else{ return }
            
            GatewayMainVC.progress.hide()
            
            switch result{
                
            case .success(let response):
                
                if response.status == 1024{
                    
                    // do something when success
                }else{
                    
                    Alert.showError(msg: response.message, on: self!)
                }
                
            case .failure(let error):
                
                Alert.showError(msg: error.rawValue, on: self!)
            }
        }
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
