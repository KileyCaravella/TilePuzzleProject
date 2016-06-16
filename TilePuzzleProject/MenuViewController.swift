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
    @IBOutlet weak var innerViewColorLbl: UILabel!
    @IBOutlet weak var background: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lvlDifficultySegCntrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(goBackToMainVC), forControlEvents: .TouchUpInside)
        setupInnerView()
        view.sendSubviewToBack(background)
        view.alpha = 0
        lvlDifficultySegCntrl.isEnabledForSegmentAtIndex(0)
        background.alpha = 0.7
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {
            self.view.alpha = 1
            self.innerView.alpha = 1
        })
    }
    
    func setupInnerView() {
        innerView.clipsToBounds = true
        innerViewColorLbl.layer.cornerRadius = 4
        innerViewColorLbl.layer.borderColor = UIColor.blackColor().CGColor
        innerViewColorLbl.layer.borderWidth = 7
        
        innerView.layer.cornerRadius = 4
        innerView.layer.borderColor = UIColor.orangeColor().CGColor
        innerView.layer.borderWidth = 6
    }
    
    func goBackToMainVC() {
       
        //Case to figure out level
        switch self.lvlDifficultySegCntrl.selectedSegmentIndex {
        case 0:
            level = 3
        case 1:
            level = 4
        case 2:
            level = 5
        default:
            print("failed at clicking button")
        }
                
        UIView.animateWithDuration(1, animations: {
            self.view.alpha = 0
            }, completion: { finished in
                self.delegate?.backFromMenu()
        })
    }

}
