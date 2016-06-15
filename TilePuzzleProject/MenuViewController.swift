//
//  MenuViewController.swift
//  TilePuzzleProject
//
//  Created by Kiley  Caravella on 6/15/16.
//  Copyright © 2016 Kiley Caravella. All rights reserved.
//

import UIKit

protocol communicationControllerMenu {
    func backFromMenu()
}


class MenuViewController: UIViewController {
    var delegate: communicationControllerMenu? = nil
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var background: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(goBackToMainVC), forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
        view.alpha = 0
        background.alpha = 0.8
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {
            self.view.alpha = 1
            self.innerView.alpha = 1
        })
    }
    
    func goBackToMainVC() {
       
        UIView.animateWithDuration(1, animations: {
            self.view.alpha = 0
            }, completion: { finished in
                self.delegate?.backFromMenu()
        })
    }

}
