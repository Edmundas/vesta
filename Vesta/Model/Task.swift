//
//  Task.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-09.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

}

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var userOrder: Int16
    @NSManaged public var timeEntries: Set<TimeEntry>?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
    }

}

extension Task : Identifiable {

}
