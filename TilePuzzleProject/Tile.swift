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
            self.setTitle("", forState: .Normal)
        } else {
            self.titleLabel?.textColor = .clearColor()
        }
    }
    
    func btnWasPressed() {
        if (self.titleLabel!.text == "") {
            return
        }
        if(compareBtns(self.frame.origin.x, clearX: clearBtn.frame.origin.x,
            senderY: self.frame.origin.y, clearY: clearBtn.frame.origin.y)) {
            
            UIView.animateWithDuration(0.5, animations: {
                self.moveBtn()
            })
        }
    }
    
    func moveBtn() {
        let holdValueX = self.frame.origin.x
        let holdValueY = self.frame.origin.y
        self.frame.origin.x = clearBtn.frame.origin.x
        self.frame.origin.y = clearBtn.frame.origin.y
        clearBtn.frame.origin.x = holdValueX
        clearBtn.frame.origin.y = holdValueY
    }
    
    func compareBtns(senderX: CGFloat, clearX: CGFloat, senderY: CGFloat, clearY: CGFloat) -> Bool {
        if (senderX == clearX) {
            if (senderY + CGFloat(distanceBetweenBtns) == clearY || senderY - CGFloat(distanceBetweenBtns) == clearY) {
                return true
            }
        } else if (senderY == clearY) {
            if (senderX + CGFloat(distanceBetweenBtns) == clearX || senderX - CGFloat(distanceBetweenBtns) == clearX) {
                return true
            }
        }
        return false
    }
}
