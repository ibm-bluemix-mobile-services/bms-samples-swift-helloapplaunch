//
//  ViewController.swift
//  Engage-Pizza
//
//  Created by Chethan Kumar on 3/16/17.
//  Copyright © 2017 Chethan Kumar. All rights reserved.
//

import UIKit
import Engage
import LocalAuthentication


class ViewController: UIViewController {

    @IBOutlet weak var touchIdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Engage.sharedInstance.initializeWithAppGUID(applicationId: "e63d4d97-5ce6-459e-b0fc-f5fa032e07e6", clientSecret: "4a17f904-8e87-4d92-b7a0-342974955710")
        
        Engage.sharedInstance.registerWith(userId: "chethan") { (response, status, error) in
            if(status == 201){
                //get features
                print("User is registered")
                
                Engage.sharedInstance.getFeatures { (response, status, error) in
                    if(response != nil){
                        var features:EngageFeatures = EngageFeatures(featureSet: response!)
                        if(features.hasFeatureWith(code: "_fagwqc8so")){
                            
                            DispatchQueue.main.async() {
                                self.touchIdButton.isHidden = false
                            }
                            
                            let value1:String = features.getValueFor(featureWithCode: "_fagwqc8so", variableWithCode: "_x7t4re1pq")
                            
                            DispatchQueue.main.async() {
                                self.touchIdButton.setTitle(value1, for: UIControlState.normal)
                            }
                            
                            
                            //Actual feature implementation
                            var error:NSError?
                            let authenticationContext = LAContext()
                            guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                                self.showAlertViewIfNoBiometricSensorHasBeenDetected()
                                return
                            }
                            
                            // 3. Check the fingerprint
                            authenticationContext.evaluatePolicy(
                                .deviceOwnerAuthenticationWithBiometrics,
                                localizedReason: "Only awesome people are allowed",
                                reply: { [unowned self] (success, error) -> Void in
                                    if( success ) {
                                        // Fingerprint recognized
                                        // Go to view controller
                                        //                                    self.navigateToAuthenticatedViewController()
                                    }else {
                                        // Check if there is an error
                                        if let error = error {
                                            
                                        }
                                    }
                            })
                            
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    @IBAction func touchid(_ sender: Any) {
        Engage.sharedInstance.sendMetricsWith(code: "_w7xos3fqh")
        var error:NSError?
        
        let authenticationContext = LAContext()
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            self.showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Easy Touch Id Checkout",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    
                   self.showAlertWithTitle(title: "Chekout Success", message: "Your pizza will arrive in less than 30 mins")
                    
                }else {
                    
                    // Check if there is an error
                    if let error = error {
                        
                        
                        
                    }
                    
                }
                
        })
    }
    
    func showAlertWithTitle( title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
    }
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    @IBAction func checkout(_ sender: Any) {
        showAlertWithTitle(title: "Chekout Success", message: "Your pizza will arrive in less than 30 mins")
    }

    @IBAction func regularCheckout(_ sender: Any) {
        showAlertWithTitle(title: "Regular checkout", message: "Your boring regular checkout")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

