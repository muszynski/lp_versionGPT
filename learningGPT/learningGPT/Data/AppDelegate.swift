import UIKit
import CoreData

class AppDelegate: UIResponder, UIApplicationDelegate {

    var persistentContainer: NSPersistentContainer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Utwórz persistent container
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer?.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Nie udało się załadować magazynu trwałego: \(error)")
            }
        })

        return true
    }

    // Zwróć kontekst Core Data
    func getContext() -> NSManagedObjectContext {
        return persistentContainer!.viewContext
    }
}
