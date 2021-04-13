//
//  UIDevice+Extension.swift
//  ForceOrientationSample
//
//  Created by 张洋威 on 2021/4/13.
//

import UIKit

extension UIDevice {
    class func changeOrientation() {
        if UIDevice.current.orientation.isLandscape {
            UIDevice.current.setValue(NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        } else {
            UIDevice.current.setValue(NSNumber(integerLiteral: UIInterfaceOrientation.landscapeRight.rawValue), forKey: "orientation")
        }
    }
}
