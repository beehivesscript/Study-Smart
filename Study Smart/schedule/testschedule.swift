//
//  testschedule.swift
//  Study Smart
//

//reference: Codecademy, "Tables," accessed 31 January, 2024 https://www.codecademy.com/resources/docs/swiftui/tables
//reference: Karin Prater (Swifty Place), "Getting Started with SwiftUI Tables: A Beginner's Guide," accessed 31 January, 2024 
//  https://www.swiftyplace.com/blog/chy7hvne

import SwiftUI

struct testschedule: View {
    //structure: Object(field: input, field: input)
    
    @State private var schedule = [
        Interval(id: "1", time: "4:15-4:40", one: "Group 3", two: "Group 4", three: "Group 6", four: "Group 2", five: "Group 4", six: ""),
        Interval(id: "2", time: "4:45-5:10", one: "Group 3", two: "Group 5", three: "Group 4", four: "Group 6", five: "Group 4", six: ""),
        Interval(id: "3", time: "5:15-5:40", one: "Group 5", two: "Group 1", three: "Group 6", four: "Group 3", five: "Group 3", six:  ""),
        Interval(id: "4", time: "5:55-6:20", one: "Group 5", two: "Group 2", three: "Group 1", four: "Group 4", five: "Group 5", six: ""),
        Interval(id: "5", time: "6:25-6:50", one: "Group 1", two: "Group 2", three: "Group 4", four: "Group 5", five: "Group 6", six: ""),
        Interval(id: "6", time: "6:15-6:40", one: "Group 4", two: "Group 5", three: "Group 1", four: "Group 2", five: "Group 2", six: "")
    ]

    @State private var id: String = ""
    @State private var time: String = ""
    @State private var one: String = ""
    @State private var two: String = ""
    @State private var three: String = ""
    @State private var four: String = ""
    @State private var five: String = ""
    @State private var six: String = ""
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                NavigationView {
                    List {
                        Text("Enter your subjects")
                            .fontWeight(.bold)
                            .foregroundColor(Color("mred"))
                        HStack {
                            Text("Group 1")
                            TextField("Lang & Lit", text: $one)
                        }
                        HStack {
                            Text("Group 2")
                            TextField("Foreign Language", text: $two)
                        }
                        HStack {
                            Text("Group 3")
                            TextField("Social Science", text: $three)
                        }
                        HStack {
                            Text("Group 4")
                            TextField("Science", text: $four)
                        }
                        HStack {
                            Text("Group 5")
                            TextField("Math", text: $five)
                        }
                        HStack {
                            Text("Group 6")
                            TextField("Art/Extra Science", text: $six)
                        }
                    }//list
                    .foregroundColor(Color("mred"))
                }//navigation view
                
                VStack {
                    
                    Text("Input your subjects in the menu on the left \n and compare them to the schedule below")
                    Table(schedule) {
                        TableColumn("Time", value: \.time)
                        TableColumn("Monday", value: \.one)
                        TableColumn("Tuesday", value: \.two)
                        TableColumn("Wednesday", value: \.three)
                        TableColumn("Thursday", value: \.four)
                        TableColumn("Friday", value: \.five)
                    }///table
                    .padding(.trailing, 59.189)
                    .frame(width: /*@START_MENU_TOKEN@*/698.206, height: 500.736/*@END_MENU_TOKEN@*/)//column
                    .foregroundColor(Color("mblack"))
                    
                }///vstack
                
                
            }
            .padding(.trailing, 161.186)//table: people
            
            }//hstack
        }//zstack
    }//view
        
struct Interval: Identifiable {
    //here is where the data in the array is declared
    var id: String
    var time: String
    var one: String
    var two: String
    var three: String
    var four: String
    var five: String
    var six: String
}

#Preview {
    testschedule()
}
