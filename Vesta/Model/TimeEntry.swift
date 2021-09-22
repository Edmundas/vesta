//
//  TimeEntry.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-09.
//
//

import Foundation
import CoreData

@objc(TimeEntry)
public class TimeEntry: NSManagedObject {

}

extension TimeEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeEntry> {
        return NSFetchRequest<TimeEntry>(entityName: "TimeEntry")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var task: Task?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
        startDate = Date()
    }

}

extension TimeEntry : Identifiable {

}
