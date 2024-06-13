//
//  ContentView.swift
//  Counter
//
//  Created by Bread Loaf on 13/06/2024.
//

import SwiftUI

struct ContentView: View {
    var numberOfCounters: Int
    @State private var counters: [Int]

    init(numberOfCounters: Int) {
        self.numberOfCounters = numberOfCounters
        self._counters = State(initialValue: Array(repeating: 0, count: numberOfCounters))
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<numberOfCounters, id: \.self) { index in
                    VStack {
                        Text("Counter \(index + 1): \(counters[index])")
                            .font(.title)
                            .padding()

                        HStack {
                            Button(action: {
                                counters[index] += 1
                            }) {
                                Text("Increase")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                counters[index] -= 1
                            }) {
                                Text("Decrease")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}



/*#Preview {
    ContentView()
}*/
