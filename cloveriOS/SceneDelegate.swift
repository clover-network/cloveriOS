//
//  SceneDelegate.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit
import WalletConnect
import WalletCore
import web3swift
import BigInt


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var interactor: WCInteractor?
    let clientMeta = WCPeerMeta(name: "WalletConnect SDK", url: "https://github.com/TrustWallet/wallet-connect-swift")
    var defaultAddress: String = ""
    var defaultChainId: Int = 1
    var recoverSession: Bool = false
    var notificationGranted: Bool = false
    var privateKey = PrivateKey(data: Data(hexString: "ba005cd605d8a02e3d5dfd04234cef3a3ee4f76bfbad2722d1fb5af8e12e6764")!)!
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>){
        
        defaultAddress = UserDefaults.standard.object(forKey: "userWalletAddress") as! String
        privateKey = PrivateKey(data: Data(hexString: UserDefaults.standard.object(forKey: "userWalletHexPrivateKey") as! String)!)!
        
        
        
           var url: URL?
           for i in URLContexts{
            
            guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as? BrowseViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: rootVC)

            let alertController = UIAlertController(title: "example.walletconnect.org wants to access your public account address.", message: nil, preferredStyle: .actionSheet)

            
            
            if (String(i.url.absoluteString).prefix(13)=="stkrwallet://"){
                print("sdfd")
                print(String(i.url.absoluteString))
                
                var uriStr =  String(i.url.absoluteString).components(separatedBy: "stkrwallet://")[1]
                //.replacingOccurrences(of: "%3A", with: ":").replacingOccurrences(of: "%2F", with: "/")
                
                 print("uriStr:")
                print(uriStr)
                
                guard let session = WCSession.from(string: uriStr) else {
                    // invalid session
                    print("SESSION IS : \(uriStr)")
                    return
                }
                
                print("SESSION : \(session)")

                let interactor = WCInteractor(session: session, meta: clientMeta, uuid: UIDevice.current.identifierForVendor ?? UUID())
                
                /*
                let action = UIAlertAction(title: "Authorize", style: .default) { (action) in

                    interactor.onSessionRequest = { [weak self] (id, peerParam) in
                        print("ON SessionRequest id : \(id)")
                        print("ON SessionRequest peerParam : \(peerParam)")
                        let peer = peerParam.peerMeta
                        let message = [peerParam.peerMeta.description, peer.url].joined(separator: "\n")
                        
                        
                        print("APPROVE SESSSION accounts : \([self!.defaultAddress])")
                        
                        interactor.approveSession(accounts: [self!.defaultAddress], chainId: self!.defaultChainId).cauterize()
                    }
                    
                    interactor.connect().done { [weak self] connected in
                        self?.connectionStatusUpdated(connected)
                    }.catch { [weak self] error in
                        self?.present(error: error)
                    }
                    
                    self.interactor = interactor
                    
                }
    
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
                    self.interactor?.rejectSession().cauterize()
                }
                alertController.addAction(action)
                alertController.addAction(cancelAction)

                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                */
                
                interactor.onSessionRequest = { [weak self] (id, peerParam) in
                    print("ON SessionRequest id : \(id)")
                    print("ON SessionRequest peerParam : \(peerParam)")
                    let peer = peerParam.peerMeta
                    let message = [peerParam.peerMeta.description, peer.url].joined(separator: "\n")
                    
                    
                    print("APPROVE SESSSION accounts : \([self!.defaultAddress])")
                    
                    interactor.approveSession(accounts: [self!.defaultAddress], chainId: self!.defaultChainId).cauterize()
                }
                
                interactor.connect().done { [weak self] connected in
                    self?.connectionStatusUpdated(connected)
                }.catch { [weak self] error in
                    self?.present(error: error)
                }
                
                self.interactor = interactor
                
                
                
                interactor.eth.onTransaction = { [weak self] (id, event, transaction) in
                    print("tiss")
                    
                    let data = try! JSONEncoder().encode(transaction)
                    print(data.hexEncodedString())
                    let message = String(data: data, encoding: .utf8)
                    
                    let alert = UIAlertController(title: event.rawValue, message: message, preferredStyle: .alert)
                    
                    print("valueis 1")
                    print(transaction.gasPrice)
                    
                    
                    
                    
                    //print(strtoul(transaction.gasLimit, nil, 16))
                    
                    alert.addAction(UIAlertAction(title: "Sig", style: .default, handler: { _ in
                        var tx = EthereumTransaction.init(nonce: BigUInt(strtoul(transaction.nonce, nil, 16)), gasPrice: BigUInt(strtoul(transaction.gasPrice, nil, 16)), gasLimit: BigUInt(strtoul(transaction.gas, nil, 16)), to: EthereumAddress(transaction.to!)!, value: BigUInt(strtoul(transaction.value, nil, 16)), data: Data(hex: transaction.data))
                        
                        print("txis")
                        print(tx)
                        
                   
                        let txSig = SECP256K1.signForRecovery(hash: Hash.keccak256(data: tx.encode(forSignature: true,chainID: nil)!), privateKey: Data(hex: self!.privateKey.data.hexEncodedString())).serializedSignature?.hexEncodedString()
                        
                        
                        print("ris")
                        print(txSig!.substring(with: 0..<64))
                        print(BigUInt(strtoul(txSig!.substring(with: 0..<64), nil, 16)))
                        print("sis")
                        print(txSig!.substring(with: 64..<128))
                        print(BigUInt(strtoul(txSig!.substring(with: 64..<128), nil, 16)))
                        print("vis")
                        print(txSig!.substring(with: 128..<130))
                        print(BigUInt(strtoul(txSig!.substring(with: 128..<130), nil, 16)))
                        
                        
                        var signedTx = "\(tx.encode(forSignature: true,chainID: nil)!.hexEncodedString())\(txSig!.substring(with: 128..<130))a0\(txSig!.substring(with: 0..<64))a0\(txSig!.substring(with: 64..<128))"
                        
                        print("signedTxis")
                        print(signedTx)
                        
                        print("countis")
                        print(String(format:"%02X", (signedTx.count - 2) / 2))
                        
                        print("tx2is")
                        print(signedTx.substring(from: 2))
                        
                        var finalTx = "f8\(String(format:"%02X", (signedTx.count - 2) / 2))\(signedTx.substring(from: 2))"
                        
                        print("finalTxis")
                        print(finalTx)
                        
                        self!.interactor?.approveRequest(id: id, result: "0x" + finalTx).cauterize()
                        
                            
                             //+ txSig!.substring(with: 128..<130) + "a0" + txSig!.substring(with: 0..<64) + "a0" + txSig!.substring(with: 64..<128)
                        
                        
                        
                      
                    }))
                    
                    
                    alert.addAction(UIAlertAction(title: "Reject", style: .destructive, handler: { _ in
                        self?.interactor?.rejectRequest(id: id, message: "I don't have ethers").cauterize()
                    }))

                    self!.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                
                
                
                
                
                
                
                
                interactor.eth.onSign = { [weak self] (id, payload) in
                    
                    let alertController2 = UIAlertController(title: "Sign message", message: nil, preferredStyle: .actionSheet)
                    let action1_2 = UIAlertAction(title: "Sign", style: .default) { (action) in
                        self?.signEth(id: id, payload: payload)
                    }
                    let cancelAction2 = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
                        self?.interactor?.rejectRequest(id: id, message: "User canceled").cauterize()
                    }
                    
                    alertController2.addAction(action1_2)
                    alertController2.addAction(cancelAction2)
                    
                    self!.window?.rootViewController?.present(alertController2, animated: true, completion: nil)
                    
                }
                
            }
            
            
            
 
            
            
          
            
            
            
           }
       }
    
    func signEth(id: Int64, payload: WCEthereumSignPayload) {
        let data: Data = {
            switch payload {
            case .sign(let data, _):
                return data
            case .personalSign(let data, _):
                
                let prefix = "\u{19}Ethereum Signed Message:\n"
                let prefixData = (prefix + String(data.count)).data(using: .ascii)!
                print("ulanchexEncodedString")
                print((prefixData + data).hexEncodedString())
                return prefixData + data
                 
                //return data
            case .signTypeData(_, let data, _):
                // FIXME
                return data
            }
        }()

        print("before")
        print(privateKey.data.hexEncodedString())
        print("ddata")
        print(data.hexEncodedString())
        
        //var result = privateKey.sign(digest: Hash.keccak256(data: data), curve: .secp256k1)!
        
        /*
        var result = privateKey.sign(digest: Hash.keccak256(data: data), curve: .secp256k1)!
        result[64] += 27
        print("result")
        print(result.hexString)
        self.interactor?.approveRequest(id: id, result: "0x" + result.hexString).cauterize()
        */
        
        
        let sig = SECP256K1.signForRecovery(hash: Hash.keccak256(data: data), privateKey: Data(hex: privateKey.data.hexEncodedString()))
        self.interactor?.approveRequest(id: id, result: "0x" + (sig.serializedSignature?.hexEncodedString())!).cauterize()
        

        /*
        print("ssasa")
        let sig2 = SECP256K1.signForRecovery(hash: "646de6048fcecfe335572c6e932e31a9ea9b2856d09e6ec97165f6453e707950".hexaData, privateKey: Data("04AF566DC2E3FCFD8BBE42AC6961A7FBF481D94ECBCEED99BCA718E9AE635913".hexaData))
        
        print(sig2.serializedSignature?.hexEncodedString())
        */
        
        //b931be00da3c90f99faf8ca05229cac896e1810c834be74eefe7f06291e00c54
        //05c54c20c8041e105f3f38feb65c335a63cbc4be9bd285b729e3c286079e9463
        
        
    }
    
    func configure(interactor: WCInteractor) {

        interactor.onError = { [weak self] error in
            self?.present(error: error)
        }

        interactor.onSessionRequest = { [weak self] (id, peerParam) in
            let peer = peerParam.peerMeta
            let message = [peer.description, peer.url].joined(separator: "\n")
            interactor.approveSession(accounts: [self!.defaultAddress], chainId: self!.defaultChainId).cauterize()
        }

        interactor.onDisconnect = { [weak self] (error) in
            if let error = error {
                print(error)
            }
            self?.connectionStatusUpdated(false)
        }

        interactor.eth.onSign = { [weak self] (id, payload) in
            let alert = UIAlertController(title: payload.method, message: payload.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
                self?.interactor?.rejectRequest(id: id, message: "User canceled").cauterize()
            }))
            alert.addAction(UIAlertAction(title: "Sign", style: .default, handler: { _ in
                //self?.signEth(id: id, payload: payload)
            }))
            //self?.show(alert, sender: nil)
        }

        interactor.eth.onTransaction = { [weak self] (id, event, transaction) in
            let data = try! JSONEncoder().encode(transaction)
            let message = String(data: data, encoding: .utf8)
            let alert = UIAlertController(title: event.rawValue, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reject", style: .destructive, handler: { _ in
                self?.interactor?.rejectRequest(id: id, message: "I don't have ethers").cauterize()
            }))
            //self?.show(alert, sender: nil)
        }

        interactor.bnb.onSign = { [weak self] (id, order) in
            let message = order.encodedString
            let alert = UIAlertController(title: "bnb_sign", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak self] _ in
                self?.interactor?.rejectRequest(id: id, message: "User canceled").cauterize()
            }))
            alert.addAction(UIAlertAction(title: "Sign", style: .default, handler: { [weak self] _ in
                //self?.signBnbOrder(id: id, order: order)
            }))
            //self?.show(alert, sender: nil)
        }
    }
    
    func connectionStatusUpdated(_ connected: Bool) {
print("connectionStatusUpdated")
    }

    func present(error: Error) {
        print("presenter")
    }

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

