//
//  TasksData.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-31.
//

import Foundation

class TasksViewModel: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("tasks.data")
    }
    
    @Published var tasks: [TaskOld] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return
            }
            guard let decodedTasks = try? JSONDecoder().decode([TaskOld].self, from: data) else {
                fatalError("Can't decode saved tasks data.")
            }
            DispatchQueue.main.async {
                self?.tasks = decodedTasks
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let tasks = self?.tasks else { fatalError("Self out of scope.") }
            guard let data = try? JSONEncoder().encode(tasks) else { fatalError("Error encoding data.") }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Can't write to file.")
            }
        }
    }
}
