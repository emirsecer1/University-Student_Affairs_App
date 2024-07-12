
import SwiftUI

@main
struct MyApp: App {
    @StateObject var authViewModel = AuthViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authViewModel)
            }
        }
    }
}

