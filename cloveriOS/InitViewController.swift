//
//  InitViewController.swift
//  stkriOS
//
//  Created by Burak Keceli on 26.10.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
               if UserDefaults.standard.object(forKey: "keyData") != nil{
             
                print("Existing User")
                performSegue(withIdentifier: "goToHomeVC", sender: nil)
                
                   
               }
               else {

                print("New User")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewUserViewController") as! NewUserViewController
                self.navigationController?.pushViewController(newViewController, animated: false)

               }

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
