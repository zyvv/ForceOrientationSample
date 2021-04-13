//
//  VideoPlayerView.swift
//  ForceOrientationSample
//
//  Created by 张洋威 on 2021/4/13.
//

import AVKit
import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    
    typealias UIViewType = VideoPlayerUIView
    
    let url: URL
    
    func makeUIView(context: Context) -> VideoPlayerUIView {
        VideoPlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) {
        if uiView.currentUrl == url { return }
        uiView.play(url: url)
    }
}

class VideoPlayerUIView: UIView {

    var player: AVPlayer?
    
    var currentUrl: URL?
            
    private var playerLayerView: VideoPlayerLayerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func play() {
        if let player = player {
            player.play()
        }
    }
    
    func play(url: URL) {
        let asset = AVURLAsset(url: url)
        currentUrl = url
        playAsset(asset: asset)
    }
    
    func playAsset(asset: AVAsset) {
        let item = AVPlayerItem(asset: asset)
        play(item)
    }
    
    func pause() {
        player?.pause()
    }
    
    func deallocPlayerView() {
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        player = nil
        disconnectPlayerView()
    }
    
    private func play(_ item: AVPlayerItem) {
        configPlayer(item)
        self.play()
    }
        
    private func configPlayer(_ playerItem: AVPlayerItem) {
        player = AVPlayer(playerItem: playerItem)
        contectPlayerView()
    }
    
    private func contectPlayerView() {
        playerLayerView?.removeFromSuperview()
        playerLayerView = VideoPlayerLayerView(frame: .zero)
        guard let playerLayerView = playerLayerView else { return }
        if let layer = playerLayerView.layer as? AVPlayerLayer {
            layer.player = player
        }
        addSubview(playerLayerView)
        playerLayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerLayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerLayerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerLayerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            playerLayerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
        
    private func disconnectPlayerView() {
        playerLayerView?.removeFromSuperview()
        if let layer = playerLayerView?.layer as? AVPlayerLayer {
            layer.player = nil
        }
    }
}

private class VideoPlayerLayerView: UIView {

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

