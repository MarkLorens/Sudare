//
//  DotState.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
import Foundation

enum DotState: String, Identifiable, CaseIterable{
    case available, later
    var title: String { rawValue.capitalized }
    var id: Self { self }
}
