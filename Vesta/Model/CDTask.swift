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

}

extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var userOrder: Int16
    @NSManaged public var timeEntries: Set<CDTimeEntry>?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
    }

}

extension CDTask : Identifiable {

}
