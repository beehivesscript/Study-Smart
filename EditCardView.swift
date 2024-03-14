//
//  EditCardView.swift
//  Study Smart
//

import SwiftUI
import Foundation

//reference: Paul Hudson (Hacking With Swift), "Project 17: Flashzilla," Accessed 31 January, 2024
//https://www.hackingwithswift.com/books/ios-swiftui

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newText = ""
    @State private var newDefinition = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new") {
                    TextField("Question", text:$newText)
                    TextField("Definition", text:$newDefinition)
                    Button("Add", action: addCard)
                }//section
                
                Section {
                    ForEach(0..<cards.count, id: \.self) {index in
                        VStack(alignment: .leading) {
                            Text(cards[index].text)
                                .font(.headline)
                            
                            Text(cards[index].definition)
                                .foregroundColor(.secondary)
                        } //vstack
                    } //index
                    .onDelete(perform: removeCards)
                } //section
            }//list
            .navigationTitle("Edit")
            .toolbar {
                Button("Done", action: done)
            } //toolbar
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }//navi
    }
        func done() {
            dismiss()
        } //done
        
        func loadData() {
            if let data = UserDefaults.standard.data(forKey: "Cards") {
                if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                    cards = decoded
                }
            } // let data
        } //loadData
        
        func saveData() {
            if let data = try? JSONEncoder().encode(cards) {
                UserDefaults.standard.set(data, forKey: "Cards")
            }
            
        } //savedata
        
        func addCard (){
            let trimmedText = newText.trimmingCharacters(in: .whitespaces)
            let trimmedDefinition = newDefinition.trimmingCharacters(in: .whitespaces)
            guard trimmedText.isEmpty == false && trimmedDefinition.isEmpty == false else { return }
            
            let card = Card(text: trimmedText, definition: trimmedDefinition)
            cards.insert(card, at: 0)
            saveData()
        }//addCard
        
        func removeCards(at offsets: IndexSet) {
            cards.remove(atOffsets: offsets)
            saveData()
        } //removeCards
        
    }//view

#Preview {
    EditCardView()
}


