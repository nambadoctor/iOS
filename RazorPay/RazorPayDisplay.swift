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
    
    var customerAppointment:CustomerAppointment
    var delegate:RazorPayDelegate
    
    func makeUIViewController(context: Context) -> RazorPayViewController {
        return RazorPayViewController(customerAppointment: self.customerAppointment,
                                      delegate: self.delegate)
    }
    
    func updateUIViewController(_ uiViewController: RazorPayViewController, context: Context) {
    }
}

class RazorPayViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    
    // typealias Razorpay = RazorpayCheckout
    
    var razorpay: RazorpayCheckout!
    
    var customerAppointment:CustomerAppointment
    var delegate:RazorPayDelegate
    
    init(customerAppointment:CustomerAppointment, delegate:RazorPayDelegate) {
        self.customerAppointment = customerAppointment
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
            "amount": String((customerAppointment.serviceFee * 100).clean), //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "purchase description",
            "image": "https://url-to-image.png",
            "name": "NambaDoctor",
            "prefill": [
                "contact": "\(LocalStorageHelper().getPhoneNumber().countryCode)\(LocalStorageHelper().getPhoneNumber().number)",
                "email":"nambadoctor@gmail.com"
            ],
            "theme": [
                "color": "#0061FF"
            ],
            "notes": [
                "serviceProviderId":self.customerAppointment.serviceProviderID,
                "customerId":self.customerAppointment.customerID,
                "appointmentId":self.customerAppointment.appointmentID,
                "serviceProviderName":self.customerAppointment.serviceProviderName,
                "customerName":self.customerAppointment.customerName,
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
