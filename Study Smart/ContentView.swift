//
//  ContentView.swift
//  Study Smart
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        ZStack {
            Image("background")
                .renderingMode(.original)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
            
            NavigationView {
                List {
                    NavigationLink(destination: HomeView()) {
                        Text("Home")
                        Image(systemName: "house")
                    }
                    NavigationLink(destination: timepage()) {
                        Text("Timer")
                        Image(systemName: "clock.circle")
                    }
                    NavigationLink(destination: testschedule()) {Text("Schedule")
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    NavigationLink(destination: CardView()) {Text("Flashcard tool")
                        Image(systemName: "menucard")
                    }
                }
                Text("Click the 'menu' button to explore the pages!")
            } //navigation view
        } //zstack
    }//view

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }//catch
        }//animation
    }//addItem

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }//catch
        }//animation
    }//deleteItems
}//view

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}



