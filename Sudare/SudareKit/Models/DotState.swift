//
//  DotState.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
import Foundation
import AppIntents

nonisolated enum DotState: String, Identifiable, CaseIterable{
    case available, later
    var title: String { rawValue.capitalized }
    var id: Self { self }
}

extension DotState: AppEnum {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Status"
    static let caseDisplayRepresentations: [DotState : DisplayRepresentation] = [
        .available: "Available", .later: "Later"
    ]
}
