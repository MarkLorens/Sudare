//
//  CloudKitService.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
//  This is a service to provide the container of CloudKit
//  As well as fetching the user's paired users

import CloudKit

final class CloudKitService {
    private let container = CKContainer(identifier: "iCloud.com.mark.Sudare")
    private var db: CKDatabase { container.publicCloudDatabase }
    
    func myRecordID() async throws -> CKRecord.ID {
        let user = try await container.userRecordID()
        return CKRecord.ID(recordName: "status-\(user.recordName)")
    }
    
    func save(name: String, state: DotState) async
    throws {
        let record = CKRecord(recordType: "Status", recordID: try await myRecordID())
        record["name"] = name
        record["state"] = state.rawValue
        
        _ = try await db.modifyRecords(saving: [record], deleting: [], savePolicy: .changedKeys)
    }
    
    func fetchPairs(_ ids: [CKRecord.ID]) async throws -> [Pair] {
        let results = try await db.records(for: ids)
        
        return results.values.compactMap { result -> Pair? in
            
            guard let r = try? result.get(),
                  let name = r["name"] as? String,
                  let stateString = r["state"] as? String,
                  let state = DotState(rawValue: stateString)
            else {
                return nil
            }
            
            return Pair(name: name, status: state, id: r.recordID)
        }
    }
}
