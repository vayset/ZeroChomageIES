//
//  ContentView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 10/10/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let color = Color(red: 82 / 255, green: 84 / 255, blue: 100 / 255)
    let colorBlue = Color(red: 32 / 255, green: 195 / 255, blue: 175 / 255)

    
    var body: some View {
        VStack {
            VStack{
                Text("Zero").font(.custom("Ubuntu-Medium", size: 40)).foregroundColor(color)
                Text("Chomeur").font(.custom("Ubuntu-Medium", size: 40)).foregroundColor(color)
                Image("Illustration")
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Text("Zero chomeur est creer pour aider a vous orientez").font(.custom("Ubuntu-Medium", size: 16)).foregroundColor(color).multilineTextAlignment(.center).padding()
            }
            Spacer()
            Button(action: {
                   //do action
            }) {
                Text("Suivant")
                    .frame(width: 340 , height: 50, alignment: .center)
            }
             .background(colorBlue)
             .foregroundColor(Color.white)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
