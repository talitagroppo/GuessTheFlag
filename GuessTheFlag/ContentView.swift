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
    @State private var animateAmount = 0.0
    @State private var selection: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
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
                        withAnimation() {
                            selection = number == correctAnswer
                            self.animateAmount += 360
                        }
                        self.flagTapped(MyAnswer: number)
                    })
                    {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .rotation3DEffect((selection && number == correctAnswer) ? Angle.degrees(animateAmount) : Angle.degrees(0), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .shadow(color: .black, radius: 2)
                            .opacity((selection && number != correctAnswer) ? 0.25 : 1)
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
    func flagTapped(MyAnswer : Int) {
        if MyAnswer == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = ""
        } else {
            scoreTitle = "wrong"
            userScore -= 1
            scoreMessage = "That's the flag for \(countries[MyAnswer])."
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        self.selection = false
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

