//
//  CoreDataService.swift
//  Navigation
//
//  Created by netlanc on 22.02.2024.
//
import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CodeDataNavigation")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError(String(format: NSLocalizedString("coredata.error.load", comment: "Failed to load Core Data stack: %@"), error.localizedDescription))
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(String(format: NSLocalizedString("coredata.error.unresolved", comment: "Unresolved error %@, %@"),nserror, nserror.userInfo))
            }
        }
    }
    
    func saveLikedPostIndex(_ index: Int) {
        let context = persistentContainer.viewContext
        let likedPostIndex = LikedPostIndex(context: context)
        likedPostIndex.index = Int64(index)
        saveContext()
    }
    
    func deleteLikedPostIndex(_ index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LikedPostIndex> = LikedPostIndex.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "index == %d", index)
        
        do {
            if let result = try context.fetch(fetchRequest).first {
                context.delete(result)
                saveContext()
            }
        } catch let error {
            print(String(format: NSLocalizedString("coredata.error.deleting-liked", comment: "Error deleting liked post index: %@"), error.localizedDescription))
        }
    }
    
    func containsLikedPostIndex(_ index: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LikedPostIndex> = LikedPostIndex.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "index == %d", index)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch let error {
            print(String(format: NSLocalizedString("coredata.error.fetching-liked", comment: "Error fetching liked post index: %@"), error.localizedDescription))
            return false
        }
    }
    
    func getLikedPostIndexes() -> [Int] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LikedPostIndex> = LikedPostIndex.fetchRequest()
        
        do {
            let likedPostIndexes = try context.fetch(fetchRequest)
            return likedPostIndexes.map { Int($0.index) }
        } catch let error {
            print(String(format: NSLocalizedString("coredata.error.fetching-liked", comment: "Error fetching liked post indexes: %@"), error.localizedDescription))
            return []
        }
    }
}
