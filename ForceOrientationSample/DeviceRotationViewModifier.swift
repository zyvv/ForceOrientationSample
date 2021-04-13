//
//  DeviceRotationViewModifier.swift
//  ForceOrientationSample
//
//  Created by 张洋威 on 2021/4/13.
//

import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

