//
//  flashcardpage.swift
//  Study Smart
//

import SwiftUI

//reference: Paul Hudson (Hacking With Swift), "Project 17: Flashzilla," Accessed 31 January, 2024
//https://www.hackingwithswift.com/books/ios-swiftui

struct Card: Codable {
    let text: String
    let definition: String
    
    static let example = Card(text: "what is the mitochondria?", definition: "the powerhouse of the cell")
}


struct flashcardpage: View {
    let card: Card
    var remove: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    Color("mwhite")
                        .opacity(1 - Double(abs(offset.width / 50)))
                )//fill
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? Color("mred") : Color("mgreen")) //swipe left for correct (green), right for incorrect (red)
                    )//background
            
            VStack {
                Text(card.text)
                    .font(.largeTitle)
                    .foregroundColor(Color("mblack"))
                
                if isShowingAnswer {
                    Text(card.definition)
                        .font(.title)
                        .foregroundColor(Color("mbrown"))
                }//isShowingAnswer
                
            }//vstack
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width/5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        remove?()
                    } else {
                        offset = .zero
                    }//else
                }//.onEnded
            )//gesture
        
        .onTapGesture {
            isShowingAnswer.toggle()
        }//.onTapGesture
    } //some view
} //page view

struct flashcardpage_Previews: PreviewProvider {
    static var previews: some View {
        flashcardpage(card: Card.example)
    }
}
