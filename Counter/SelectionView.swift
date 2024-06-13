//
//  SelectionView.swift
//  Counter
//
//  Created by Bread Loaf on 13/06/2024.
//

import SwiftUI

import SwiftUI

struct SelectionView: View {
    @State private var numberOfCounters: Int = 1
    @State private var navigateToCounters: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Number of Counters")
                    .font(.largeTitle)
                    .padding()
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)

                Stepper(value: $numberOfCounters, in: 1...10) {
                    Text("\(numberOfCounters) \(numberOfCounters == 1 ? "Counter" : "Counters")")
                        .font(.title)
                }
                .padding()

                Button(action: {
                    navigateToCounters = true
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .navigationDestination(isPresented: $navigateToCounters) {
                    ContentView(numberOfCounters: numberOfCounters)
                }
            }
            .frame(minWidth: 300, minHeight: 200)
            .padding()
        }
    }
}

#Preview {
    SelectionView()
}
