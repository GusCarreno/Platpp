//
//  SceneDelegate.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let videosViewModel = VideosViewModel()
        let contentView = VideosListView(viewModel: videosViewModel)
        
        let connectivityMonitor = ConnectivityMonitor.shared
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
