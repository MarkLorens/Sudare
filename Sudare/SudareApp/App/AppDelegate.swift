//
//  AppDelegate.swift
//  Sudare
//
//  Created by Max on 08/11/26.
//
//  This is to connects Sudare to UIKit's application lifecycle.
//  Goddamn UIKit. Please gib SwiftUI-only support
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        
        let configuration = UISceneConfiguration(
            name: nil,
            sessionRole: connectingSceneSession.role
        )
        
        configuration.delegateClass = SceneDelegate.self
        
        return configuration
    }
}
