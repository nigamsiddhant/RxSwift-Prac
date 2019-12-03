//
//  CoreDataHandler.swift
//  Matrix
//
//  Created by Siddhant Nigam on 02/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataHandler {
    
    static let shared = CoreDataHandler()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let entityName = "UserDetails"
    
     func addDataToDatabase(details: [Details]) {
        for data in details {

            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(data.firstName ?? "", forKey: "firstName")
            newUser.setValue(data.lastName ?? "", forKey: "lastName")
            newUser.setValue(data.emailId ?? "", forKey: "emailId")
            newUser.setValue(data.imageUrl ?? "", forKey: "imageUrl")
            do {
               try context.save()
              } catch {
               print("Failed saving")
            }
        }
       
        
    }
    
    func fetchDetails() -> [Details] {
        var details = [Details]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                details.append(Details(emailId: data.value(forKey: "emailId") as? String ?? "", lastName: data.value(forKey: "lastName") as? String ?? "", imageUrl: data.value(forKey: "imageUrl") as? String ?? "", firstName: data.value(forKey: "firstName") as? String ?? ""))
          }
            
            
            
        } catch {
            
            print("Failed")
        }
        
        return details
    }
    
    
    func deleteAllData(completionHandler: (Bool) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            completionHandler(true)
        } catch {
            UIUtility.showErrorAlert("", message: "Something Went Wrong.")
            completionHandler(false)
        }
    }
}
