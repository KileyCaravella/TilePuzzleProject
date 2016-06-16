//
//  MainViewController.swift
//  TilePuzzleProject
//
//  Created by Kiley  Caravella on 6/13/16.
//  Copyright © 2016 Kiley Caravella. All rights reserved.
//

import UIKit

public var clearBtn = UIButton()
public var baseImg = UIImage(named: "image3.jpg")

class MainViewController: UIViewController, communicationControllerMenu {
    
    @IBOutlet weak var movesLbl: UILabel!
    @IBOutlet weak var tileView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var previewBtn: UIButton!
    
    var tileArray: [Tile] = []
    var numMoves = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tileView.layer.borderWidth = 2
        menuBtn.addTarget(self, action: #selector(callMenuModal), forControlEvents: .TouchUpInside)
        previewBtn.addTarget(self, action: #selector(previewImg), forControlEvents: .TouchUpInside)

    }
    
    func callMenuModal() {
        let menuVC = MenuViewController()
        menuVC.delegate = self
        menuVC.modalPresentationStyle = .OverCurrentContext
        presentViewController(menuVC, animated: false, completion: nil)
    }
    
    func previewImg() {
        let imgView = UIImageView(frame: CGRectMake(0, 0, tileView.bounds.width, tileView.bounds.height))
        imgView.image = baseImg
        imgView.alpha = 0
        self.tileView.addSubview(imgView)
        self.tileView.sendSubviewToBack(imgView)
        
        self.tileView.clipsToBounds = true
        UIView.animateWithDuration(1, animations: {
            for btn in self.tileArray {
                btn.alpha = 0
            }
            imgView.alpha = 1

            }, completion: {finished in
                sleep(2)
                UIView.animateWithDuration(1, animations: {
                    for btn in self.tileArray {
                        if(btn != clearBtn) {
                            btn.alpha = 1
                        }
                        imgView.alpha = 0
                    }

                    }, completion: { finished in
                        imgView.removeFromSuperview()
                })
        })
        
    }

    func createTiles(level: Int, img: UIImage) {
        for  i in 0  ..< (level*level) {
            let distanceBetweenBtns = Double(tileView.frame.size.width)/Double(level)
            let btn = Tile()
            btn.setupBtn(distanceBetweenBtns, level: level, iValue: i)
            btn.addTarget(self, action: #selector(btnWasPressed), forControlEvents: .TouchUpInside)
            
            if(i == (level*level)-1) {
                btn.imgOrBlackBtn(false)
                btn.alpha = 0
                clearBtn = btn
            } else {
                btn.imgOrBlackBtn(true)
            }
            
            btn.insertImg(img, view: tileView)
            tileView.addSubview(btn)
            tileArray.append(btn)
        }
        randomizeBtnLocation()
    }
    
    func btnWasPressed(sender: Tile) {
        if(sender.btnWasPressed()) {
            numMoves += 1
            movesLbl.text = "Moves: " + String(numMoves)
        }
        checkSolution()
    }
    
    func randomizeBtnLocation() {
        let randomNumOfShuffles = Int(arc4random_uniform(40)+80)
        var lastRoundBtn = tileArray[0]
        var bool = false
        for _ in 0...randomNumOfShuffles {
            for btn in tileArray {
                if (!bool) {
                    bool = true
                    break
                }
                if (btn == lastRoundBtn) {}
                else if (btn.compareBtns(clearBtn.frame.origin.x, senderY: btn.frame.origin.y)) {
                    
                    btn.moveBtn()
                    
                    //Switch array values
                    let arrayValueBtn = getArrayValue(btn)
                    let arrayValueFirstBtn = getArrayValue(clearBtn)
                    
                    swap(&tileArray[arrayValueBtn], &tileArray[arrayValueFirstBtn])
                    lastRoundBtn = btn
                    bool = false
                    break
                }
            }
        }
    }
    
    func checkSolution() {
        //redo this code
        for i in 1...(self.tileArray.count-1) {
            if(Int(self.tileArray[i].titleLabel!.text!)! != Int(self.tileArray[i-1].titleLabel!.text!)!+1) {
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
    
    func backFromMenu(level: Int, img: UIImage) {
        self.dismissViewControllerAnimated(true, completion: nil)
        tileView.layer.borderColor = UIColor.blackColor().CGColor
        for btn in tileArray {
            btn.removeFromSuperview()
        }
        self.tileView.backgroundColor = .blackColor()
        tileArray.removeAll()
        createTiles(level, img: img)
        baseImg = img
    }
}