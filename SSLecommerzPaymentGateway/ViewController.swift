//
//  ViewController.swift
//  SSLecommerzPaymentGateway
//
//  Created by Fahim Rahman on 28/8/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import SSLCommerzSDK

class ViewController: UIViewController, SSLCommerzDelegate {
    
    @IBOutlet weak var buttonAction: UIButton!
    
    var ssl: SSLCommerz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        // called payment method and passed parameters
        payment(storeID: "demolive", storePassword: "demoID123", ammount: 10.00)
    }
}



// payment gateway here
extension ViewController {
    
    //pass required and optional parameter here
    func payment(storeID: String, storePassword: String, ammount: Double) {
        
        // initialization sslCommerz
        
        ssl = SSLCommerz.init(integrationInformation: .init(storeID: storeID, storePassword: storePassword, totalAmount: ammount, currency: "BDT", transactionId: "IX233DFSA", productCategory: "demoProduct"), emiInformation: nil, customerInformation: .init(customerName: "demoCustomer", customerEmail: "demoEmail", customerAddressOne: "demoAddress", customerCity: "demoCity", customerPostCode: "1230", customerCountry: "BD", customerPhone: "01122334455"), shipmentInformation: nil, productInformation: nil, additionalInformation: nil)
        
        
        // Put delegate and start method here because we want to pass data and trigger our method when we want to pay.
        ssl?.delegate = self
        
        // If "shouldRunInTestMode" is true, then the SSLCOMMERZ framework is in Test Mode.
        // If "shouldRunInTestMode" is false, then the SSLCOMMERZ framework is in Live Mode.
        
        ssl?.start(in: self, shouldRunInTestMode: false)
    }
    
    
    
    // when a transaction is completed this method will fire and returns transaction details
    
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
        
        print("Tr data returned from the server",transactionData ?? "Trans Failed")
        
        print("Trans ID:", transactionData?.tran_id ?? "")
        print("Trans Amount:", transactionData?.amount ?? "")
    }
}
