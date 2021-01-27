//
//  ImportWalletViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import web3swift

class ImportWalletViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phrase1TextField: UITextField!
    @IBOutlet weak var phrase2TextField: UITextField!
    @IBOutlet weak var phrase3TextField: UITextField!
    @IBOutlet weak var phrase4TextField: UITextField!
    @IBOutlet weak var phrase5TextField: UITextField!
    @IBOutlet weak var phrase6TextField: UITextField!
    @IBOutlet weak var phrase7TextField: UITextField!
    @IBOutlet weak var phrase8TextField: UITextField!
    @IBOutlet weak var phrase9TextField: UITextField!
    @IBOutlet weak var phrase10TextField: UITextField!
    @IBOutlet weak var phrase11TextField: UITextField!
    @IBOutlet weak var phrase12TextField: UITextField!
    
    @IBOutlet weak var doneButton: UIView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Import Wallet"
        
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOpacity = 0.07
        doneButton.layer.shadowOffset = .zero
        doneButton.layer.shadowRadius = 7
        doneButton.layer.cornerRadius = 7
        doneButton.alpha = 0.5
             
        phrase1TextField.returnKeyType = UIReturnKeyType.done
        phrase2TextField.returnKeyType = UIReturnKeyType.done
        phrase3TextField.returnKeyType = UIReturnKeyType.done
        phrase4TextField.returnKeyType = UIReturnKeyType.done
        phrase5TextField.returnKeyType = UIReturnKeyType.done
        phrase6TextField.returnKeyType = UIReturnKeyType.done
        phrase7TextField.returnKeyType = UIReturnKeyType.done
        phrase8TextField.returnKeyType = UIReturnKeyType.done
        phrase9TextField.returnKeyType = UIReturnKeyType.done
        phrase10TextField.returnKeyType = UIReturnKeyType.done
        phrase11TextField.returnKeyType = UIReturnKeyType.done
        phrase12TextField.returnKeyType = UIReturnKeyType.done
             
        phrase1TextField.delegate = self
        phrase2TextField.delegate = self
        phrase3TextField.delegate = self
        phrase4TextField.delegate = self
        phrase5TextField.delegate = self
        phrase6TextField.delegate = self
        phrase7TextField.delegate = self
        phrase8TextField.delegate = self
        phrase9TextField.delegate = self
        phrase10TextField.delegate = self
        phrase11TextField.delegate = self
        phrase12TextField.delegate = self
           
        phrase1TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase2TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase3TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase4TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase5TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase6TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase7TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase8TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase9TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase10TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase11TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        phrase12TextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.doneViewTapped)))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
    phrase1TextField.resignFirstResponder()
        }
    
    func animateButton(sender: UIView) {
        
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
    }
    
    
    
    @objc func doneViewTapped(sender : UITapGestureRecognizer) {
    
        if(doneButton.alpha >= 1) {
        // Do what you want
        print("checkAction")
            
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
            
            animateButton(sender: self.doneButton)
            
            do {
                 let keystore = try BIP32Keystore(
                     mnemonics: "\(phrase1TextField.text!) \(phrase2TextField.text!) \(phrase3TextField.text!) \(phrase4TextField.text!) \(phrase5TextField.text!) \(phrase6TextField.text!) \(phrase7TextField.text!) \(phrase8TextField.text!) \(phrase9TextField.text!) \(phrase10TextField.text!) \(phrase11TextField.text!) \(phrase12TextField.text!)",
                 password: "",
                 mnemonicsPassword: "",
                     language: .english)!
                 
                 let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
                 
                 UserDefaults.standard.set(keyData, forKey: "keyData")
                 
                 
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let newViewController = storyBoard.instantiateViewController(withIdentifier: "InitViewController") as! InitViewController
                 self.navigationController?.pushViewController(newViewController, animated: true)
                 
                 
                 //performSegue(withIdentifier: "aftermnomonicSegue", sender: nil)
             }
             catch {
                 let dialogMessage = UIAlertController(title: "Error", message: "One or more passphrase not valid.", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)
                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
             }
            
            
        }

    }
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
    
    if (phrase1TextField.text!.count >= 3 && phrase2TextField.text!.count >= 3 && phrase3TextField.text!.count >= 3 && phrase4TextField.text!.count >= 3 && phrase5TextField.text!.count >= 3 && phrase6TextField.text!.count >= 3 && phrase7TextField.text!.count >= 3  && phrase8TextField.text!.count >= 3 && phrase9TextField.text!.count >= 3 && phrase10TextField.text!.count >= 3 && phrase11TextField.text!.count >= 3 && phrase12TextField.text!.count >= 3){
        doneButton.alpha = 1
    }
    else {
        doneButton.alpha = 0.5
    }
    }

}


