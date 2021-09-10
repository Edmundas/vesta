//
//  Task+CoreDataProperties.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-09.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var userOrder: Int64
    @NSManaged public var timeEntries: Set<TimeEntry>?

}

// MARK: Generated accessors for timeEntries
extension Task {

    @objc(addTimeEntriesObject:)
    @NSManaged public func addToTimeEntries(_ value: TimeEntry)

    @objc(removeTimeEntriesObject:)
    @NSManaged public func removeFromTimeEntries(_ value: TimeEntry)

    @objc(addTimeEntries:)
    @NSManaged public func addToTimeEntries(_ values: NSSet)

    @objc(removeTimeEntries:)
    @NSManaged public func removeFromTimeEntries(_ values: NSSet)

}

extension Task : Identifiable {

}
