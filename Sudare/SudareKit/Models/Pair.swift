//
//  Pair.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
import Foundation

struct Pair: Identifiable {
    let name: String
    let status: DotState
    let id = UUID()
}
