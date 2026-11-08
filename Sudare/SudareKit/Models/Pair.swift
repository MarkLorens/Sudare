//
//  Pair.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
import CloudKit

struct Pair: Identifiable {
    let name: String
    let status: DotState
    let id: CKRecord.ID
}
