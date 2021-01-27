//
//  NewUserViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var generateWalletButton: UIView!
    @IBOutlet weak var importWalletButton: UIView!
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        generateWalletButton.layer.shadowColor = UIColor.black.cgColor
        generateWalletButton.layer.shadowOpacity = 0.07
        generateWalletButton.layer.shadowOffset = .zero
        generateWalletButton.layer.shadowRadius = 7
        generateWalletButton.layer.cornerRadius = 7
        
        importWalletButton.layer.shadowColor = UIColor.black.cgColor
        importWalletButton.layer.shadowOpacity = 0.07
        importWalletButton.layer.shadowOffset = .zero
        importWalletButton.layer.shadowRadius = 7
        importWalletButton.layer.cornerRadius = 7
        
        self.generateWalletButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.generateWalletButtonTapped)))
        self.importWalletButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.importWalletButtonTapped)))

        // Do any additional setup after loading the view.
    }
    
    @objc func generateWalletButtonTapped(sender : UITapGestureRecognizer) {

        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.generateWalletButton)
        
        performSegue(withIdentifier: "goToGenerateWalletVC", sender: nil)
    }
    
    @objc func importWalletButtonTapped(sender : UITapGestureRecognizer) {

        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        animateButton(sender: self.importWalletButton)
        
        performSegue(withIdentifier: "goToImportWalletVC", sender: nil)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
