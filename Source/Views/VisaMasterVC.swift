//
//  VisaMasterVC.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-03.
//

import UIKit
import MGPSDK

class VisaMasterVC: UIViewController {
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldCardNumber: UITextField!
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var txtFieldCVV: UITextField!
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var btPay: UIButton!
    
    private let viewModel = VisaMasterViewModel()
    private var htmlView: String? = nil
    var isValidExpireDate = false
    var cardType = CardType.Unknown
    var delegate: OnepayIPGDelegate? = nil
    var initData: OnepayIPGInit!
    var mainVCManagemnetDelegate: MainManagementDelegate? = nil
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
        
        if let htmlContent = self.htmlView{
            
            card3dsEnrolment(htmlPage: htmlContent)
        }else{
            
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
    }
    
    private func get3DS(data: _3DSRequestData){
        
        GatewayMainVC.progress.show()
        viewModel.validateAndGet3DS(reqData: data){ [weak self] result in
            
            guard let _ = self else{ return }
            
            GatewayMainVC.progress.hide()
            
            switch result{
                
            case .success(let response):
                
                if response.status == 1024{
                    
                    self!.htmlView = response.data!.tdsAuthenticationRedirect
                    self!.card3dsEnrolment(htmlPage: response.data!.tdsAuthenticationRedirect)
                }else{
                    
                    Alert.showError(msg: response.message, on: self!)
                }
                
            case .failure(let error):
                
                Alert.showError(msg: error.rawValue, on: self!)
            }
        }
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        
        mainVCManagemnetDelegate?.onKeyboardWillShow()
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        
        mainVCManagemnetDelegate?.onKeyboardWillHide()
    }
    
    private func keyboardNotification () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    func card3dsEnrolment(htmlPage: String)  {
        
        // create the Gateway3DSecureViewController
        let threeDSecureView = Gateway3DSecureViewController(nibName: nil, bundle: nil)
        
        // Optionally, customize the presentation
        threeDSecureView.title = "3-D Secure Auth onepay"
        threeDSecureView.navBar.tintColor = UIColor(red: 1, green: 0.357, blue: 0.365, alpha: 1)
        
        // present the 3DSecureViewController
        present(threeDSecureView, animated: true)
        
        GatewayMainVC.progress.show()
        // provide the html content and a handler
        threeDSecureView.authenticatePayer(htmlBodyContent: htmlPage) {[weak self] (threeDSView, result) in
            
            guard let _ = self else{ return }
            GatewayMainVC.progress.hide()
            // dismiss the 3-D Secure view controller
            threeDSView.dismiss(animated: true)
            
            // handle the result case
            switch result {
                
            case .completed(let gatewayResult):
                
                let transDetails = self!.initData!
                let success = OnepayIPGSuccess(status: gatewayResult.status,
                                               description: gatewayResult.description,
                                               firstName: transDetails.userDetails.firstName,
                                               lastName: transDetails.userDetails.lastName,
                                               phone: transDetails.userDetails.phone,
                                               reference: transDetails.proDetails.reference,
                                               email: transDetails.userDetails.email,
                                               amount: transDetails.proDetails.amount,
                                               currency: transDetails.proDetails.currency.rawValue)
        
                self!.delegate?.onPaymentSuccess(response: success)
                self!.mainVCManagemnetDelegate?.close()
            case .error(let error):
                
                if let afError =  error.asAFError{
                    
                    self!.delegate?.onPaymentFailed(error: OnepayIPGError(responseCode: afError.responseCode, description: afError.errorDescription))
                    self!.mainVCManagemnetDelegate?.close()
                }
            case .cancelled:
                print("")
            }
            
        }
    }
}
