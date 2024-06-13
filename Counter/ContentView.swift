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
        let loadedCounters = UserDefaults.standard.array(forKey: "counters") as? [Int] ?? Array(repeating: 0, count: numberOfCounters)
        let loadedTitles = UserDefaults.standard.stringArray(forKey: "titles") ?? Array(repeating: "Counter", count: numberOfCounters)
        self._counters = State(initialValue: loadedCounters)
        self._titles = State(initialValue: loadedTitles)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                let columns = [GridItem(.adaptive(minimum: 200))] // Adjust minimum width
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<numberOfCounters, id: \.self) { index in
                        VStack {
                            TextField("Title", text: $titles[index], onCommit: saveData)
                                .font(.title)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Text("\(titles[index]): \(counters[index])")
                                .font(.title2)
                                .padding()

                            HStack {
                                Button(action: {
                                    counters[index] -= 1
                                    saveData()
                                }) {
                                    Text("-")
                                        .padding()
                                        .frame(minWidth: 50)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }

                                Spacer()

                                Button(action: {
                                    counters[index] += 1
                                    saveData()
                                }) {
                                    Text("+")
                                        .padding()
                                        .frame(minWidth: 50)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding()

                            Button(action: {
                                counters[index] = 0
                                saveData()
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
                        .frame(minWidth: 200) // Ensure minimum width
                        .background(Color(.systemGray))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
    }

    func saveData() {
        UserDefaults.standard.set(counters, forKey: "counters")
        UserDefaults.standard.set(titles, forKey: "titles")
    }
}
