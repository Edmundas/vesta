//
//  Task.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-09.
//
//

import Foundation
import CoreData

@objc(CDTask)
public class CDTask: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var userOrder: Int16
    @NSManaged public var timeEntries: Set<CDTimeEntry>?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension CDTask {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        let request = NSFetchRequest<CDTask>(entityName: "CDTask")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDTask.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \CDTask.title, ascending: true)
        ]
        return request
    }
}

extension CDTask : Identifiable { }
