//
//  URL+Extension.swift
//  ForceOrientationSample
//
//  Created by 张洋威 on 2021/4/13.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(string: "\(value)")!
    }
}
