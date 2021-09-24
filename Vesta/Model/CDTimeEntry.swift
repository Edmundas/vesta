//
//  TimeEntry.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-09.
//
//

import Foundation
import CoreData

@objc(CDTimeEntry)
public class CDTimeEntry: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var task: CDTask?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        startDate = Date()
    }
}

extension CDTimeEntry {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTimeEntry> {
        let request = NSFetchRequest<CDTimeEntry>(entityName: "CDTimeEntry")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDTimeEntry.startDate, ascending: true),
            NSSortDescriptor(keyPath: \CDTimeEntry.task?.userOrder, ascending: true)
        ]
        return request
    }
}

extension CDTimeEntry : Identifiable { }
