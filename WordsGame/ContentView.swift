//
//  ContentView.swift
//  WordsGame
//
//  Created by Gennady Raster on 6.11.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    var body: some View {
        
        NavigationView{
            List{
                
                Section{
                    TextField("Enter a new word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                        
                            Text(word)
                        }
                    }
                }
                
            }
            .navigationTitle("\(rootWord)")
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if answer.count < 1 {return}
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame(){
        // get URL
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // get data from file
            if let dataString = try? String(contentsOf: startWordsURL){
                // get an array of strings
                let dataArray = dataString.components(separatedBy: "\n")
                
                
                rootWord = dataArray.randomElement() ?? "somethingWentWrong"
                
                return
            }
        }
        // crash and report
        fatalError("Could not load start.txt from bundle.")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
