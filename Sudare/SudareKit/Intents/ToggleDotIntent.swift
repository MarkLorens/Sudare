//
//  ToggleDotIntent.swift
//  Sudare
//
//  Created by Max on 08/11/26.
//
import Foundation
import AppIntents

extension UserDefaults {
    nonisolated(unsafe) static let sudare = UserDefaults(suiteName: "group.com.mark.Sudare")!
}

struct ToggleDotIntent: AppIntent {
    static let title: LocalizedStringResource = "Toggle Sudare Dot"
    static let openAppWhenRun = false
    
    @Parameter(title: "Status") var state: DotState? // flip on nil
    
    init() {}
    init(state: DotState?) {
        self.state = state
    }
    
    func perform() async throws -> some IntentResult {
        let store = UserDefaults.sudare
        let current = DotState(rawValue: store.string(forKey: "dotState") ?? "") ?? .later
        let new = state ?? (current == .available ? .later : .available)
        
        store.set(new.rawValue, forKey: "dotState")
        
        try await CloudKitService().save(
            name: store.string(forKey: "displayName") ?? "",
            state: new
        )
        return .result()
    }
}
