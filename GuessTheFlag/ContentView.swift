//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Talita Groppo on 22/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "França", "Germany", "Irlanda", "Italy", "Nigeria", "Polonia", "Russia", "Espanha", "Reino Unido", "Estados Unidos"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
   // @State private var myAnswer = 0


    var body: some View {
        ZStack{
         LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
          //  edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(spacing: 30){
        VStack {
        Text("Tap the flag of")
            .foregroundColor(.white)
        Text(countries[correctAnswer])
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
    }
        ForEach(0..<3) { number in
            Button(action: {
                self.flagTapped(MyAnswer: number)
            }) {
                Image(self.countries[number])
                  .renderingMode(.original)
                  .clipShape(Capsule())
                 .overlay(Capsule()
                    .stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
            }
        }
            Text("Your score is \(userScore)")
            Spacer()
}
}
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
}
    func flagTapped(MyAnswer : Int) -> Bool {
        var result = false
        if MyAnswer == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = ""
            result = true
        } else {
            scoreTitle = "wrong"
            userScore -= 1
            scoreMessage = "That's the flag for \(countries[MyAnswer])."
        }
        showingScore = true
        return result
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

