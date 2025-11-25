//
//  SplashViewController.swift
//  WorldSide
//
//  Created by Banu Karakaya on 20.10.2025.
//

import UIKit


class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now()+6) { //2
            self.performSegue(withIdentifier: "toDetailView", sender: nil)
        }
    }
}
