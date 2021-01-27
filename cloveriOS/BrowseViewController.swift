//
//  ViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import WebKit
import WalletConnect
import WalletCore
import web3swift

class BrowseViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var interactor: WCInteractor?
    let clientMeta = WCPeerMeta(name: "WalletConnect SDK", url: "https://github.com/TrustWallet/wallet-connect-swift")
    var defaultAddress: String = "0xD432C5910f626dD21bE918D782facB38BDaE3296"
    var defaultChainId: Int = 1
    var recoverSession: Bool = false
    var notificationGranted: Bool = false
    let privateKey = PrivateKey(data: Data(hexString: "ba005cd605d8a02e3d5dfd04234cef3a3ee4f76bfbad2722d1fb5af8e12e6764")!)!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Browse"
        self.tabBarController?.navigationItem.title = "Browse"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print("ulan")
        print(Hash.keccak256(data: "e180850a02ffee0082520894daf21ca2bba638fa31d46d092ae0faf205cdfc8b8080".hexaData).hexEncodedString())
        
        
        
        
        
        
        
        let sig = SECP256K1.signForRecovery(hash: Hash.keccak256(data: "e180850a02ffee0082520894daf21ca2bba638fa31d46d092ae0faf205cdfc8b8080".hexaData), privateKey: Data(hex: privateKey.data.hexEncodedString()))
        
        
        print("ulansig")
        print(sig.serializedSignature?.hexEncodedString())
        
        
        var uriStr =  "wc:11ad47d2-0c12-43e0-add7-6f7542798a54@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=076e74b267c74bdd7eade8ad89b57458e8fc45aed5b166c3f2f7380e0a81f6de"
        //.replacingOccurrences(of: "%3A", with: ":").replacingOccurrences(of: "%2F", with: "/")
        
         print("uriStr:")
        print(uriStr)
        
        guard let session = WCSession.from(string: uriStr) else {
            // invalid session
            print("asd")
            return
        }
        
        let interactor = WCInteractor(session: session, meta: clientMeta, uuid: UIDevice.current.identifierForVendor ?? UUID())
        interactor.eth.onSign = { [weak self] (id, payload) in
            let alert = UIAlertController(title: payload.method, message: payload.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
                self?.interactor?.rejectRequest(id: id, message: "User canceled").cauterize()
            }))
            alert.addAction(UIAlertAction(title: "Sign", style: .default, handler: { _ in
                self?.signEth(id: id, payload: payload)
            }))
            self!.show(alert, sender: nil)
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(clipboardChanged),
        name: UIPasteboard.changedNotification, object: nil)
        
        
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        //https://stkr-dev.ankr.com/picker?account=0xC3cff98848ED07420D1910349AF3A1490129A0ce
        
        
        
        let url = URL(string: "https://example.walletconnect.org")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
    }
    
    func signEth(id: Int64, payload: WCEthereumSignPayload) {
        let data: Data = {
            switch payload {
            case .sign(let data, _):
                return data
            case .personalSign(let data, _):
                let prefix = "\u{19}Ethereum Signed Message:\n\(data)".data(using: .utf8)!
                return prefix + data
            case .signTypeData(_, let data, _):
                // FIXME
                return data
            }
        }()

        var result = privateKey.sign(digest: Hash.keccak256(data: data), curve: .secp256k1)!
        result[64] += 27
        self.interactor?.approveRequest(id: id, result: "0x" + result.hexString).cauterize()
    }
    
    @objc func fireTimer() {
        title = "sa"
    }
    
    @objc func clipboardChanged(){
        let pasteboardString: String? = UIPasteboard.general.string
        if let theString = pasteboardString {
 
            if let url = URL(string: "stkrwallet://\(theString)") {
                UIApplication.shared.open(url)
            }
            
            // Do cool things with the string
        }
    }
    
    func invokeURI(uri:URL){
        
        print("noa")
        print(uri)
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        
        /*
       
        
        if (1 == 1){
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let action = UIAlertAction(title: "Authorize", style: .default) { (action) in

                //
                
            }
            print("mkya")
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        */
        
        
    }


}

