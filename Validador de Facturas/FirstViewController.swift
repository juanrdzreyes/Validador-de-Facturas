//
//  FirstViewController.swift
//  Validador de Facturas
//
//  Created by Juan Rodriguez Reyes on 22/01/20.
//  Copyright © 2020 Juan Rodriguez Reyes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var scannerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func onClickScannerButton(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scannerVC") as UIViewController
        self.present(viewController, animated: true, completion: {
            print("On close scanner")
        })
    }
    
}

