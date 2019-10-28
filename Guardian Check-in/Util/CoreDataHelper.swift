//
//  CoreDataHelper.swift
//  CheckIn
//
//  Created by Alexander Stevens on 1/8/19.
//  Copyright © 2019 Anand Kelkar. All rights reserved.
//

import CoreData
import Foundation
import UIKit

public class CoreDataHelper {
    
    class func countOfEntity(_ entityName: String) -> Int {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0 }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        return try! managedContext.count(for: fetchRequest)
    }
    
    class func saveStudentData(_ name:String,_ id:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let descrEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
        let obj = NSManagedObject(entity: descrEntity, insertInto: managedContext)
        obj.setValue(name, forKey: "Name")
        obj.setValue(id, forKey: "id")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    class func saveGuardianData(_ name:String,_ id:String,_ studentId:String,_ relation:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let descrEntity = NSEntityDescription.entity(forEntityName: "Guardian", in: managedContext)!
        let obj = NSManagedObject(entity: descrEntity, insertInto: managedContext)
        obj.setValue(name, forKey: "name")
        obj.setValue(id, forKey: "id")
        obj.setValue(studentId, forKey: "studentId")
        obj.setValue(relation, forKey: "relation")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    class func addToCheckInTable( _ guests: Int, _ APS_ID: String, _ entityName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let descrEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let obj = NSManagedObject(entity: descrEntity, insertInto: managedContext)
        obj.setValue("API Test", forKeyPath: "event_name")
        obj.setValue(guests, forKey: "guests")
        obj.setValue(APS_ID, forKey: "id")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    class func retrieveData(_ entityName: String) -> [Any]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
            
        } catch {
            print("Failed")
        }
        return []
    }
    
    class func updateStudentData(entityName: String, APS_ID: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", APS_ID)
        do {
            let studentObj = try managedContext.fetch(fetchRequest)
            let objectUpdate = studentObj[0] as! NSManagedObject
            objectUpdate.setValue(true, forKey: "checked")
            do{
                try managedContext.save()
                print("Student Updated!")
            }catch{
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    class func deleteAllData(from entityName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        let _ = try! managedContext.execute(request)
        
//        fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Checkins")
//        request = NSBatchDeleteRequest(fetchRequest: fetch)
//        let _ = try! managedContext.execute(request)
        
    }
    
    
    
}
