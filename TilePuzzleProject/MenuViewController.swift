//
//  MenuViewController.swift
//  TilePuzzleProject
//
//  Created by Kiley  Caravella on 6/15/16.
//  Copyright © 2016 Kiley Caravella. All rights reserved.
//

import UIKit

protocol communicationControllerMenu {
    func backFromMenu(level: Int, img: UIImage)
}


class MenuViewController: UIViewController {
    var delegate: communicationControllerMenu? = nil
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var innerViewColorLbl: UILabel!
    @IBOutlet weak var background: UILabel!
    @IBOutlet weak var img1Btn: UIButton!
    @IBOutlet weak var img2Btn: UIButton!
    @IBOutlet weak var img3Btn: UIButton!
    @IBOutlet weak var lvlDifficultySegCntrl: UISegmentedControl!
    @IBOutlet weak var playBtn: UIButton!
    
    var img = UIImage(named: "image1.jpg")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBtn.addTarget(self, action: #selector(goBackToMainVC), forControlEvents: .TouchUpInside)
        img1Btn.addTarget(self, action: #selector(choosePicforTiles), forControlEvents: .TouchUpInside)
        img2Btn.addTarget(self, action: #selector(choosePicforTiles), forControlEvents: .TouchUpInside)
        img3Btn.addTarget(self, action: #selector(choosePicforTiles), forControlEvents: .TouchUpInside)


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
    
    func choosePicforTiles(sender: UIButton) {
        img1Btn.highlighted = false
        img2Btn.highlighted = false
        img3Btn.highlighted = false
        
        dispatch_async(dispatch_get_main_queue(), {
            sender.highlighted = true
        })
        
        
        img = sender.currentBackgroundImage
    }
    
    func goBackToMainVC() {
       
        //Case to figure out level
        var level = 0

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
                self.delegate?.backFromMenu(level, img: self.img!)
        })
    }

}
