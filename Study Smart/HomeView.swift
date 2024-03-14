//
//  HomeView.swift
//  Study Smart
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Welcome to Study Smart! \n Click the button in the upper-left corner \n to access the tools")
            .background(
            Image("background")
            )
            .multilineTextAlignment(.center)
            .foregroundColor(Color("mblack"))
    }//view
}//page

#Preview {
    HomeView()
}



