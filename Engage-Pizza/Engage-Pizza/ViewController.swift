//
//  ViewController.swift
//  Engage-Pizza
//
//  Created by Chethan Kumar on 3/16/17.
//  Copyright © 2017 Chethan Kumar. All rights reserved.
//

import UIKit
import LocalAuthentication
import IBMAppLaunch


class ViewController: UIViewController {

    @IBOutlet weak var touchIdButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
        
        if(AppLaunch.sharedInstance.hasFeatureWith(code: "_1o2xw6uds")){

            let label:String = AppLaunch.sharedInstance.getValueFor(featureWithCode: "_1o2xw6uds", propertyWithCode: "_2zyawutfc")

            DispatchQueue.main.async() {
                self.touchIdButton.isHidden = false
                self.touchIdButton.setTitle(label, for: UIControlState.normal)
            }
        }
    }
    
    @IBAction func touchid(_ sender: Any) {
        var metriccodes = [String]()
        metriccodes.append("_w6ll8y166")
        AppLaunch.sharedInstance.sendMetricsWith(codes: metriccodes)
        
    }
    
    
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
        
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

