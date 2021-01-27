//
//  HomeViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import CryptoKit
import web3swift
import Network
import UInt256
import BigInt

struct Wallet {
    let address: String
    let data: Data
    let name: String
    let isHD: Bool
    var ethBalance: BigUInt
}

class HomeViewController: UIViewController {
    

    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var ethTab: UIView!
    @IBOutlet weak var ankrTab: UIView!
    @IBOutlet weak var goethTab: UIView!
    @IBOutlet weak var aethtab: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    var userWallet = Wallet(address: "", data: Data(), name: "", isHD: false, ethBalance: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Wallet"
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "My Wallet"
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ethTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionEthTab)))
        ankrTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionAnkrTab)))
        goethTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionGoethTab)))
        aethtab.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.checkActionAethtab)))
        
        bckView.layer.shadowColor = UIColor.black.cgColor
        bckView.layer.shadowOpacity = 0.07
        bckView.layer.shadowOffset = .zero
        bckView.layer.shadowRadius = 9
        bckView.layer.cornerRadius = 9
        
        ethTab.layer.shadowColor = UIColor.black.cgColor
        ethTab.layer.shadowOpacity = 0.07
        ethTab.layer.shadowOffset = .zero
        ethTab.layer.shadowRadius = 9
        ethTab.layer.cornerRadius = 9
        
        ankrTab.layer.shadowColor = UIColor.black.cgColor
        ankrTab.layer.shadowOpacity = 0.07
        ankrTab.layer.shadowOffset = .zero
        ankrTab.layer.shadowRadius = 9
        ankrTab.layer.cornerRadius = 9
        
        goethTab.layer.shadowColor = UIColor.black.cgColor
        goethTab.layer.shadowOpacity = 0.07
        goethTab.layer.shadowOffset = .zero
        goethTab.layer.shadowRadius = 9
        goethTab.layer.cornerRadius = 9
        
        aethtab.layer.shadowColor = UIColor.black.cgColor
        aethtab.layer.shadowOpacity = 0.07
        aethtab.layer.shadowOffset = .zero
        aethtab.layer.shadowRadius = 9
        aethtab.layer.cornerRadius = 9

        
        var web3Infura = Web3.InfuraMainnetWeb3()
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                web3Infura = web3(provider: Web3HttpProvider(URL(string: "https://mainnet.infura.io/v3/444215a4372f452da1f9248cb4633305")!)!)
            }
        }
        
        let keyData = UserDefaults.standard.object(forKey: "keyData") as! Data
        let keystore = BIP32Keystore(keyData)!
        let keystoreManager = KeystoreManager([keystore])
        
        
        
        
        
        userWallet = Wallet(address: keystore.addresses!.first!.address, data: keyData, name: "userWallet", isHD: true, ethBalance: 0)
        web3Infura.addKeystoreManager(keystoreManager)
        
        label.text = "❏ \(userWallet.address)"
        
        //label.text = "My ETH address is: \(keystore.addresses!.first!.address)"

        UserDefaults.standard.set(userWallet.address, forKey: "userWalletAddress")
        UserDefaults.standard.set(try! keystore.UNSAFE_getPrivateKeyData(password: "", account: EthereumAddress(userWallet.address)!).hexEncodedString(), forKey: "userWalletHexPrivateKey")
        

        // Do any additional setup after loading the view.
    }
    
    func copyaddress(asset:String){
        let alertController = UIAlertController(title: "My \(asset) Address", message:userWallet.address, preferredStyle: .actionSheet)
         
         let action1 = UIAlertAction(title: "Copy Address", style: .default) { (action) in

             let pasteboard = UIPasteboard.general
            pasteboard.string = self.userWallet.address
             
         }
         
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alertController.addAction(action1)
         alertController.addAction(cancelAction)
         present(alertController, animated: true, completion: nil)
    }
    

        @objc func checkActionEthTab(sender : UITapGestureRecognizer) {

        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.ethTab)
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Deposit CLV", style: .default) { (action) in

                self.copyaddress(asset: "CLV")
                
            }
            
            let action2 = UIAlertAction(title: "Withdraw CLV", style: .default) { (action) in

                //
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
    }
    
        @objc func checkActionAnkrTab(sender : UITapGestureRecognizer) {

        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.ankrTab)
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Deposit DOT", style: .default) { (action) in

                self.copyaddress(asset: "DOT")
            }
            
            let action2 = UIAlertAction(title: "Withdraw DOT", style: .default) { (action) in

                //
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func checkActionGoethTab(sender : UITapGestureRecognizer) {

        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.goethTab)
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            let action1 = UIAlertAction(title: "Deposit cETH", style: .default) { (action) in

                self.copyaddress(asset: "cETH")
                
            }
            
            let action2 = UIAlertAction(title: "Withdraw cETH", style: .default) { (action) in

                //
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var ee: UILabel!
    @IBOutlet weak var ee2: UILabel!
    
    @objc func checkActionAethtab(sender : UITapGestureRecognizer) {

        ee.text = "9.99 CLV"
        ee2.text = "0.00 USD"
        
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


extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
