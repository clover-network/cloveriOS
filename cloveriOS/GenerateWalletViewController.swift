//
//  GenerateWalletViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import web3swift

class GenerateWalletViewController: UIViewController {
    
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
    
    var mnemonicsStr:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Generate Wallet"
        
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOpacity = 0.07
        doneButton.layer.shadowOffset = .zero
        doneButton.layer.shadowRadius = 7
        doneButton.layer.cornerRadius = 7
        doneButton.alpha = 1
        
        self.doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.doneViewTapped)))
        
        mnemonicsStr = try! BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english)!
        
        phrase1TextField.text = "1. \(mnemonicsStr.components(separatedBy: " ")[0])"
        phrase2TextField.text = "2. \(mnemonicsStr.components(separatedBy: " ")[1])"
        phrase3TextField.text = "3. \(mnemonicsStr.components(separatedBy: " ")[2])"
        phrase4TextField.text = "4. \(mnemonicsStr.components(separatedBy: " ")[3])"
        phrase5TextField.text = "5. \(mnemonicsStr.components(separatedBy: " ")[4])"
        phrase6TextField.text = "6. \(mnemonicsStr.components(separatedBy: " ")[5])"
        phrase7TextField.text = "7. \(mnemonicsStr.components(separatedBy: " ")[6])"
        phrase8TextField.text = "8. \(mnemonicsStr.components(separatedBy: " ")[7])"
        phrase9TextField.text = "9. \(mnemonicsStr.components(separatedBy: " ")[8])"
        phrase10TextField.text = "10. \(mnemonicsStr.components(separatedBy: " ")[9])"
        phrase11TextField.text = "11. \(mnemonicsStr.components(separatedBy: " ")[10])"
        phrase12TextField.text = "12. \(mnemonicsStr.components(separatedBy: " ")[11])"
        
        phrase1TextField.isUserInteractionEnabled = false
        phrase2TextField.isUserInteractionEnabled = false
        phrase3TextField.isUserInteractionEnabled = false
        phrase4TextField.isUserInteractionEnabled = false
        phrase5TextField.isUserInteractionEnabled = false
        phrase6TextField.isUserInteractionEnabled = false
        phrase7TextField.isUserInteractionEnabled = false
        phrase8TextField.isUserInteractionEnabled = false
        phrase9TextField.isUserInteractionEnabled = false
        phrase10TextField.isUserInteractionEnabled = false
        phrase11TextField.isUserInteractionEnabled = false
        phrase12TextField.isUserInteractionEnabled = false
        

        // Do any additional setup after loading the view.
    }
    
      @objc func doneViewTapped(sender : UITapGestureRecognizer) {
    
          let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
          impactFeedbackgenerator.prepare()
          impactFeedbackgenerator.impactOccurred()
          
          animateButton(sender: self.doneButton)
          
          let keystore = try! BIP32Keystore(
                 mnemonics: mnemonicsStr,
             password: "",
             mnemonicsPassword: "",
                 language: .english)!
             
             let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
             
             UserDefaults.standard.set(keyData, forKey: "keyData")
             
             
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let newViewController = storyBoard.instantiateViewController(withIdentifier: "InitViewController") as! InitViewController
             self.navigationController?.pushViewController(newViewController, animated: true)
          
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

}
