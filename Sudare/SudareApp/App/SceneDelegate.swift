//
//  SceneDelegate.swift
//  Sudare
//
//  Created by Max on 08/11/26.
//
//  Receives CloudKit sharing invitations when the user accepts one
//  Supposedly
import UIKit
import CloudKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let container = CKContainer (
        identifier: "iCloud.com.mark.Sudare"
    )
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let metadata = connectionOptions.cloudKitShareMetadata {
            accept(metadata)
        }
    }
    
    func windowScene(
        _ windowScene: UIWindowScene,
        userDidAcceptCloudKitShareWith metadata: CKShare.Metadata) {
        accept(metadata)
    }
    
    private func accept(_ metadata: CKShare.Metadata) {
        Task {
            do {
                try await container.accept(metadata)
                
                print("Successfully accepted Sudare invitation!")
                NotificationCenter.default.post(
                    name: SudareNotifications.didAcceptCloudKitShare,
                    object: nil
                )
            } catch {
                print("Could not accept invitation:", error)
            }
        }
    }
}

