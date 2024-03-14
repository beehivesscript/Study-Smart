//
//  timepage.swift
//  Study Smart
//

import SwiftUI
import Combine

struct timepage: View {
    @State private var inputMinutes: Int = 25 //default to 25 mins
    @State private var inputSeconds: Int = 0
    @State private var totalSeconds: Int = 0
    @State private var timer: AnyCancellable? = nil
    @State private var isTimerRunning: Bool = false //status of timer - running? not running?
    @State private var showAlert = false //status of popup - showing or not?
    
    var body: some View {
        ZStack {
            Color("mwhite").ignoresSafeArea()
            
            VStack {
                Text("Countdown Timer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color("mblue"))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("mblue"), lineWidth: 2)
                            .frame(width: 300, height: 40)
                    }
                Text("Please input the time you'd like to study for")
                
                HStack {
                    TextField("Minutes", text: Binding<String>(
                        get: { String(self.inputMinutes) },
                        set: {
                            if let newInput = Int($0) {
                                self.inputMinutes = newInput
                                calculateTotalSeconds()
                            }
                        }
                    ))
                    .frame(width: 200.0)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("mred"))
                    
                    Text("min")
                        .foregroundColor(Color("mblue"))
                        .fontWeight(.medium)
                    TextField("Seconds", text: Binding<String>(
                        get: { String(self.inputSeconds) },
                        set: {
                            if let newInput = Int($0) {
                                self.inputSeconds = newInput
                                calculateTotalSeconds()
                            }
                        }
                    ))
                    .frame(width: 200.0)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("mred"))
                    
                    Text("sec")
                        .foregroundColor(Color("mblue"))
                        .fontWeight(.medium)
                }//hstack
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(Color("mred"))
                
                Button(action: {
                    startTimer()
                }) {
                    Text("Start")
                        .font(.headline)
                        .padding()
                        .background(Color("mblue"))
                        .foregroundColor(Color("mblack"))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    resetTimer()
                }) {
                    Text("Reset")
                        .font(.headline)
                        .padding()
                        .background(Color("mred"))
                        .foregroundColor(Color("mblack"))
                        .cornerRadius(10)
                }
                
                Text("Time Remaining: \(formattedTime(totalSeconds))")
                    .font(.headline)
                    .foregroundColor(Color("mblack"))
                    .padding()
                
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Timer Finished"),
                    message: Text("Continue?"),
                    dismissButton: .default(Text("OK")) {
                        resetTimer()
                    }
                ) //alert tutorial: Daniel Budd, "Create Button Pop up Alerts - 08 - Introduction to SwiftUI," YouTube, accessed 31 January, 2024
            }
        }
    } //view
    
    private func calculateTotalSeconds() {
        totalSeconds = inputMinutes * 60 + inputSeconds
    }
    
    private func startTimer() {
            if isTimerRunning {
                timer?.cancel()
            } else {
                totalSeconds = inputMinutes * 60 + inputSeconds
                timer = Timer.publish(every: 1, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        if self.totalSeconds > 0 {
                            self.totalSeconds -= 1
                        } else {
                            self.timer?.cancel()
                            showAlert = true //
                        }
                    }
            }
            isTimerRunning.toggle()
        }
    
    private func formattedTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    
    private func switchToBreakTimer() {
           totalSeconds = 5 * 60 // Switch to 5 minutes break
           isTimerRunning.toggle()
       }

    
    private func resetTimer() {
        timer?.cancel()
        totalSeconds = 0
        inputMinutes = 25
        inputSeconds = 0
        isTimerRunning = false
    }
}

#Preview {
    timepage()
}
