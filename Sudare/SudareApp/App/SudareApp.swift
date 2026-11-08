//
//  SudareApp.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//

import SwiftUI

@main
struct SudareApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GlanceView()
        }
    }
}

