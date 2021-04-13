//
//  ContentView.swift
//  ForceOrientationSample
//
//  Created by 张洋威 on 2021/4/13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLandscape: Bool = false
    @State private var isHideControlView: Bool = false
    @State private var hideControlViewTimer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    
    private var url: URL = "http://cctvalih5ca.v.myalicdn.com/live/cctv1_2/index.m3u8"
    
    var body: some View {
        VStack {
            ZStack {
                VideoPlayerView(url: url)
                    .edgesIgnoringSafeArea(.all)
                videoPlayerControlView
                    .padding()
                    .onReceive(hideControlViewTimer) { timer in
                        hideControlView(hidden: true)
                    }
            }
            .frame(height: videoPlayerViewHeight())
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                hideControlView(hidden: !isHideControlView)
            }
        }
        .onRotate {
            isLandscape = $0.isLandscape
            hideControlView(hidden: false)
        }
    }
    
    private var videoPlayerControlView: some View {
        VStack {
            Spacer()
            HStack {
                if !isHideControlView {
                    Spacer()
                    Button {
                        UIDevice.changeOrientation()
                    } label: {
                        Image(systemName: isLandscape ? "arrow.down.right.and.arrow.up.left": "arrow.up.left.and.arrow.down.right")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                
            }
        }
    }
}

extension ContentView {
    private func hideControlView(hidden: Bool) {
        withAnimation {
            isHideControlView = hidden
        }
        isHideControlView ? stopTimer() : startTimer()
    }
    
    private func stopTimer() {
        hideControlViewTimer.upstream.connect().cancel()
    }
    
    private func startTimer() {
        stopTimer()
        hideControlViewTimer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    }
    
    private func videoPlayerViewHeight() -> CGFloat {
        let screenWidth = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        return isLandscape ? screenWidth : screenWidth * (9.0/16.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
