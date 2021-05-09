//
//  RazorPayDisplay.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/8/21.
//

import SwiftUI
import Razorpay

struct RazorPayDisplay : UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    var customerNumber:String
    var paymentAmount:String
    var serviceProviderId:String
    var appointmentId:String

    func makeUIViewController(context: Context) -> RazorPayViewController {
        return RazorPayViewController()
    }
    
    func updateUIViewController(_ uiViewController: RazorPayViewController, context: Context) {
    }
}

class RazorPayViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    
    typealias Razorpay = RazorpayCheckout
    var razorpay: RazorpayCheckout!
    
//    var customerNumber:String
//    var paymentAmount:String
//    var serviceProviderId:String
//    var appointmentId:String
//
//    init(customerNumber:String, paymentAmount:String, serviceProviderId:String, appointmentId:String) {
//        self.customerNumber = customerNumber
//        self.paymentAmount = paymentAmount
//        self.serviceProviderId = serviceProviderId
//        self.appointmentId = appointmentId
//        super.init(nibName: nil, bundle: nil)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_live_QUyrXjNsqaBZFq", andDelegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPaymentForm()
    }
    
    internal func showPaymentForm(){
        let options: [String:Any] = [
            "amount": String(Int("0")! * 100), //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "NambaDoctor",
            "image": "https://avatars.githubusercontent.com/u/71248382?s=200&v=4",
            "name": "NambaDoctor",
            "prefill": [
                "contact": "customerNumber",
            ],
            "theme": [
                "color": "#0061FF"
            ]
        ]
        razorpay.open(options)
    }
    
    public func onPaymentError(_ code: Int32, description str: String){
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    public func onPaymentSuccess(_ payment_id: String){
        print(payment_id)
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
