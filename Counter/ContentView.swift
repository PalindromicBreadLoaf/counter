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
    @State private var titles: [String]

    init(numberOfCounters: Int) {
        self.numberOfCounters = numberOfCounters
        self._counters = State(initialValue: Array(repeating: 0, count: numberOfCounters))
        self._titles = State(initialValue: Array(repeating: "Counter", count: numberOfCounters))
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<numberOfCounters, id: \.self) { index in
                    VStack {
                        TextField("Title", text: $titles[index])
                            .font(.title)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Text("\(titles[index]): \(counters[index])")
                            .font(.title2)
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

                        Button(action: {
                            counters[index] = 0
                        }) {
                            Text("Reset")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                    }
                    .padding()
                }
            }
        }
    }
}
