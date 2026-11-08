//
//  AppDelegate.swift
//  Sudare
//
//  Created by Max on 08/11/26.
//
//  This is to connects Sudare to UIKit's application lifecycle.
//  Goddamn UIKit. Please gib SwiftUI-only support
import UIKit
import CloudKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let cloudKit = CloudKitService()
    
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
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any]
    ) async -> UIBackgroundFetchResult {
        
        guard let notification = CKNotification(fromRemoteNotificationDictionary: userInfo) as? CKDatabaseNotification,
              notification.databaseScope == .shared else {
            return .noData
        }
        NotificationCenter.default.post(
            name: SudareNotifications.pairsDidChange,
            object: nil
        )
        return .newData
    }
}
