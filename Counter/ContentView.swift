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

    let colors: [Color] = [
        .red, .green, .blue, .orange, .purple, .pink, .yellow, .gray, .cyan, .brown
    ]

    init(numberOfCounters: Int) {
        self.numberOfCounters = numberOfCounters
        
        let loadedCounters = UserDefaults.standard.array(forKey: "counters") as? [Int] ?? []
        let loadedTitles = UserDefaults.standard.stringArray(forKey: "titles") ?? []

        self._counters = State(initialValue: Self.resizeArray(array: loadedCounters, toSize: numberOfCounters, defaultValue: 0))
        self._titles = State(initialValue: Self.resizeArray(array: loadedTitles, toSize: numberOfCounters, defaultValue: "Counter"))
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                let columns = [GridItem(.adaptive(minimum: 200))]
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<numberOfCounters, id: \.self) { index in
                        VStack {
                            TextField("Title", text: $titles[index], onCommit: saveData)
                                .font(.title)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Text("\(counters[index])")
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
                                        .background(colors[index % colors.count])
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
                                        .background(colors[index % colors.count])
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
                        .frame(minWidth: 200)
                        .background(Color(.darkGray))
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
    
    static func resizeArray<T>(array: [T], toSize size: Int, defaultValue: T) -> [T] {
        if array.count > size {
            return Array(array.prefix(size))
        } else if array.count < size {
            return array + Array(repeating: defaultValue, count: size - array.count)
        } else {
            return array
        }
    }
}
