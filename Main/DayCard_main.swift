import SwiftUI


/*
 MVVM Architecture
 
 Model - manages single data point
 View - manages the UI
 ViewModel - manages data (models) for views
 */

@main
struct AppStutioApp_main: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            
        }
    }
}
