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
    
    private var privateDB: CKDatabase{ container.privateCloudDatabase }
    private var sharedDB: CKDatabase { container.sharedCloudDatabase }
    
    private let zoneID = CKRecordZone.ID(zoneName: "Status") // owner = current user
    private var myRecordID: CKRecord.ID { CKRecord.ID(recordName: "status", zoneID: zoneID) }
    
    func setUp() async throws { // Call once at launch
        _ = try await privateDB.modifyRecordZones(saving: [CKRecordZone(zoneID: zoneID)], deleting: [])
    }
    
    func save(name: String, state: DotState) async
    throws {
        let record = CKRecord(recordType: "status", recordID: myRecordID)
        record["name"] = name
        record["state"] = state.rawValue
        
        _ = try await privateDB.modifyRecords(saving: [record], deleting: [], savePolicy: .changedKeys)
    }
    
    func fetchPairs() async throws -> [Pair] {
        // TODO: - Try to eventually validate record type and ownership rather than assuming every shared zone contains a valid Sudare dot.
        let zones = try await sharedDB.allRecordZones()
        let ids = zones.map { CKRecord.ID(recordName: "status", zoneID: $0.zoneID) }
        let results = try await sharedDB.records(for: ids)
        
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
    
    func makeShare() async throws -> CKShare {
        let shareID = CKRecord.ID(recordName: CKRecordNameZoneWideShare, zoneID: zoneID)
        
        if let existing = try? await privateDB.record(for: shareID) as? CKShare { return existing }
        
        let share = CKShare(recordZoneID: zoneID)
        share[CKShare.SystemFieldKey.title] = "Sudare status"
        share.publicPermission = .readOnly
        
        let (results, _) = try await privateDB.modifyRecords(saving: [share], deleting: [])
        guard let saved = try results[share.recordID]?.get() as? CKShare else{
            throw CKError(.internalError)
        }
        return saved
    }
    
    func subscribeToPairs() async throws {
        let sub = CKDatabaseSubscription(subscriptionID: "pairs-changes")
        let info = CKSubscription.NotificationInfo()
        info.shouldSendContentAvailable = true
        sub.notificationInfo = info
        _ = try await sharedDB.modifySubscriptions(saving: [sub], deleting: [])
    }
}
