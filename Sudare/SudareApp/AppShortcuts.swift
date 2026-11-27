//
//  AppShortcuts.swift
//  Sudare
//
//  Created by Max on 12/11/26.
//

import AppIntents

struct SudareShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: ToggleDotIntent(), phrases: ["Toggle my \(.applicationName) dot"],
                    shortTitle: "Toggle dot", systemImageName: "circle.lefthalf.filled"
        )
    }
}
