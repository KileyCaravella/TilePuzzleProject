//
//  MainViewController.swift
//  TilePuzzleProject
//
//  Created by Kiley  Caravella on 6/13/16.
//  Copyright © 2016 Kiley Caravella. All rights reserved.
//

import UIKit

public var clearBtn = UIButton()
public var distanceBetweenBtns = 0.0
public var level = 1
public var baseImg = UIImage(named: "image3.jpg")


class MainViewController: UIViewController, communicationControllerMenu {
    
    @IBOutlet weak var movesLbl: UILabel!
    @IBOutlet weak var tileView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    var tileArray: [Tile] = []
    var numMoves = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tileView.layer.borderWidth = 2
        menuBtn.addTarget(self, action: #selector(callMenuModal), forControlEvents: .TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    func callMenuModal() {
        let menuVC = MenuViewController()
        menuVC.delegate = self
        menuVC.modalPresentationStyle = .OverCurrentContext
        presentViewController(menuVC, animated: false, completion: nil)
    }
    
    func createTiles(level: Int) {
        for  i in 0  ..< (level*level) {
            distanceBetweenBtns = Double(tileView.frame.size.width)/Double(level)
            let btn = Tile()
            btn.setupBtn(distanceBetweenBtns, level: level, iValue: i)
            btn.addTarget(self, action: #selector(btnWasPressed), forControlEvents: .TouchUpInside)
            
            if(i == (level*level)-1) {
                btn.imgOrBlackBtn(false)
                clearBtn = btn
            } else {
                btn.imgOrBlackBtn(true)
                btn.insertImg(baseImg!, view: tileView)
            }
            
            tileView.addSubview(btn)
            tileArray.append(btn)
            print(tileArray.count)
        }
        randomizeBtnLocation()
    }
    
    func btnWasPressed(sender: Tile) {
        numMoves += 1
        movesLbl.text = "Moves: " + String(numMoves)
        sender.btnWasPressed()
        checkSolution()
    }
    
    func randomizeBtnLocation() {
        let randomNumOfShuffles = Int(arc4random_uniform(1000))
        var lastRoundBtn = tileArray[0]
        for _ in 0...randomNumOfShuffles {
            let btn = tileArray[Int(arc4random_uniform(UInt32(tileArray.count - 1)))]
            
            //Shuffles with a different btn each time
            if (btn == lastRoundBtn) {}
            else if (btn.compareBtns(clearBtn.frame.origin.x, clearX: btn.frame.origin.x,
                senderY: clearBtn.frame.origin.y, clearY: btn.frame.origin.y)) {
                
                btn.moveBtn()
                
                //Switch array values
                let arrayValueBtn = getArrayValue(btn)
                let arrayValueFirstBtn = getArrayValue(clearBtn)
                
                swap(&tileArray[arrayValueBtn], &tileArray[arrayValueFirstBtn])
                lastRoundBtn = clearBtn as! Tile
            }
        }
    }
    
    func checkSolution() {
        for i in 0...tileArray.count-3 {
            if(tileArray[i] == clearBtn || tileArray[i+1] == clearBtn) {
                return
            } else if(Int(tileArray[i].titleLabel!.text!)! != Int(tileArray[i+1].titleLabel!.text!)! - 1) {
                return
            }
        }
        
        print("winner!")
    }
    
    func getArrayValue(item: UIButton) -> Int{
        for btn in 0..<tileArray.count {
            if item == tileArray[btn] {
                return btn
            }
        }
        return 0
    }
    
    func backFromMenu() {
        self.dismissViewControllerAnimated(true, completion: nil)
        tileView.layer.borderColor = UIColor.blackColor().CGColor
        for btn in tileArray {
            btn.removeFromSuperview()
        }
        tileArray.removeAll()
        createTiles(level)
    }
    
}






























