//
//  CardView.swift
//  Study Smart
//

import SwiftUI

//reference: Paul Hudson (Hacking With Swift), "Project 17: Flashzilla," Accessed 31 January, 2024
//https://www.hackingwithswift.com/books/ios-swiftui

struct CardView: View {
    @State private var cards = [Card]()
    @State private var showingEditScreen = false
    
    var body: some View {
        VStack {
            ZStack {
                Image("background")
                    .renderingMode(.original)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    
                    VStack {
                        ZStack {
                            ForEach(0..<cards.count, id: \.self) { index in
                                flashcardpage(card: cards[index]) {
                                    withAnimation {
                                        removeCard(at: index)
                                    }
                                }
                                    .stacked(at: index, in: cards.count)
                            }
                        } //zstack
                    } //vstack
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showingEditScreen = true
                        } label : {
                            Image(systemName: "rectangle.stack.badge.plus.fill")
                                .padding(.all, 10.0)
                                .background(Color("mblack"))
                                .clipShape(Circle())
                                .fixedSize(horizontal: true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true)
                        }
                        .padding(.top) //label
                    }
                    .padding(.all, 300.0) //hstack
                        Spacer()
                        .foregroundColor(.white)
                        .padding()
                    } //vstack
                } //zstack
            .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardView.init)
        .onAppear(perform: resetCards)
        }
        }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        } // let data
    } //loadData
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
    func resetCards () {
        cards = Array(repeating: Card.example, count: 10)
        loadData()
    }
        }

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}


