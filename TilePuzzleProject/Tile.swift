//
//  Button.swift
//  TilePuzzleProject
//
//  Created by Kiley  Caravella on 6/15/16.
//  Copyright © 2016 Kiley Caravella. All rights reserved.
//

import UIKit

class Tile: UIButton {
    
    func setupBtn (sizeOfBtn: Double, level: Int, iValue: Int) {
        
        //var x
        var x = Double((iValue%level))
        x *= sizeOfBtn
        
        //var y
        var y = Double((iValue/level))
        y *= sizeOfBtn
        
        self.frame = CGRect(x: x, y: y, width: sizeOfBtn, height: sizeOfBtn)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2.0
        self.setTitle(String(iValue+1), forState: .Normal)
    }
    
    func insertImg(img: UIImage, view: UIView) {
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x:(0 - self.frame.origin.x), y:(0 - self.frame.origin.y),
                               width:view.frame.size.width, height:view.frame.size.height)
        self.addSubview(imgView)
        self.clipsToBounds = true
    }

    func imgOrBlackBtn(imgBtnBool: Bool) {
        if(!imgBtnBool) {
            self.layer.borderColor = UIColor.clearColor().CGColor
            self.backgroundColor = .clearColor()
        }
        self.titleLabel?.textColor = .clearColor()
    }
    
    func btnWasPressed() -> Bool{
        if (self.titleLabel!.text == "") {
            return false
        }
        if(compareBtns(self.frame.origin.x, senderY: self.frame.origin.y)) {
            
            UIView.animateWithDuration(0.5, animations: {
                self.moveBtn()
            })
            return true
        }
        return false
    }
    
    func moveBtn() {
        let holdValueX = self.frame.origin.x
        let holdValueY = self.frame.origin.y
        self.frame.origin.x = clearBtn.frame.origin.x
        self.frame.origin.y = clearBtn.frame.origin.y
        clearBtn.frame.origin.x = holdValueX
        clearBtn.frame.origin.y = holdValueY
    }
    
    func compareBtns(senderX: CGFloat, senderY: CGFloat) -> Bool {
        let clearX = clearBtn.frame.origin.x
        let clearY = clearBtn.frame.origin.y
        if (senderX == clearBtn.frame.origin.x) {
            if (senderY + CGFloat(clearBtn.frame.size.width) == clearY || senderY - CGFloat(clearBtn.frame.size.width) == clearY) {
                return true
            }
        } else if (senderY == clearY) {
            if (senderX + CGFloat(clearBtn.frame.size.width) == clearX || senderX - CGFloat(clearBtn.frame.size.width) == clearX) {
                return true
            }
        }
        return false
    }
}
