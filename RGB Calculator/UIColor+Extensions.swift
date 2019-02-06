//
//  UIColor+Extensions.swift
//  RGB Calculator
//
//  Created by Nadezda Panchenko on 05/02/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import UIKit

extension UIColor {
    var hsba: (h: CGFloat, s: CGFloat,b: CGFloat,a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
    
    var isLight: Bool  {
        return (self.hsba.h) < 0.2
    }
}
extension UIColor {
    func getComplement() -> [UIColor] {
        let hsbaColor = self.hsba
        return [UIColor(hue: abs(hsbaColor.h-0.5), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1)]
    }
    
    func getSplitComplement() -> [UIColor] {
        let hsbaColor = self.hsba
        return [UIColor(hue: abs(hsbaColor.h-0.42), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-0.58), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1)]
    }
    
    func getTriadic() -> [UIColor] {
        let hsbaColor = self.hsba
        return [UIColor(hue: abs(hsbaColor.h-0.33), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-0.66), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1)]
    }
    func getTetradic() -> [UIColor] {
        let hsbaColor = self.hsba
        return [UIColor(hue: abs(hsbaColor.h-0.25), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-0.5), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-0.75), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1)]
    }
    func getAnalogous(position: Int) -> [UIColor]{
        let hsbaColor = self.hsba
        let indexArray: [CGFloat] = [-0.25, -0.16, -0.08, 0.08, 0.16, 0.25]
        let index = (position+3+2 < indexArray.count) ? position+3:indexArray.count-position-3
        
        return [UIColor(hue: abs(hsbaColor.h-indexArray[index]), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-indexArray[index+1]), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1), UIColor(hue: abs(hsbaColor.h-indexArray[index+2]), saturation: hsbaColor.s, brightness: hsbaColor.b, alpha: 1)]
    }
}
