//
//  RazorPayDisplay.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/8/21.
//

import SwiftUI
import Razorpay

protocol RazorPayDelegate {
    func paymentSucceeded(paymentId:String)
    func paymentFailed()
}

struct RazorPayDisplay : UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    var customerNumber:String
    var paymentAmount:String
    var serviceProviderId:String
    var appointmentId:String
    var delegate:RazorPayDelegate
    
    func makeUIViewController(context: Context) -> RazorPayViewController {
        return RazorPayViewController(customerNumber: self.customerNumber,
                                      paymentAmount: self.paymentAmount,
                                      serviceProviderId: self.serviceProviderId,
                                      appointmentId: self.appointmentId,
                                      delegate: self.delegate)
    }
    
    func updateUIViewController(_ uiViewController: RazorPayViewController, context: Context) {
    }
}

class RazorPayViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    
    // typealias Razorpay = RazorpayCheckout
    
    var razorpay: RazorpayCheckout!
    
    var customerNumber:String
    var paymentAmount:String
    var serviceProviderId:String
    var appointmentId:String
    var delegate:RazorPayDelegate
    
    init(customerNumber:String, paymentAmount:String, serviceProviderId:String, appointmentId:String, delegate:RazorPayDelegate) {
        print("HITTING THIS INIT")
        print(paymentAmount)
        self.customerNumber = customerNumber
        self.paymentAmount = paymentAmount
        self.serviceProviderId = serviceProviderId
        self.appointmentId = appointmentId
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_live_QUyrXjNsqaBZFq", andDelegate: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showPaymentForm()
    }
    
    internal func showPaymentForm(){
        let options: [String:Any] = [
                    "amount": String(Int(paymentAmount)! * 100), //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": "purchase description",
                    "image": "https://url-to-image.png",
                    "name": "NambaDoctor",
                    "prefill": [
                        "contact": "+91\(self.customerNumber)",
                        "email":"nambadoctor@gmail.com"
                    ],
                    "theme": [
                        "color": "#0061FF"
                      ]
                ]
        razorpay.open(options)
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        delegate.paymentFailed()
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        delegate.paymentSucceeded(paymentId: payment_id)
    }
}
