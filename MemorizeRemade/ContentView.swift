//
//  ContentView.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//

import SwiftUI



let emojisArray = ["😆","🤢","😻","🦾","👿","👹", "🤡", "👻","💀","😵‍💫","👾","🤖","😆","🤢","😻","🦾","👿","👹", "🤡", "👻","💀","😵‍💫","👾","🤖"]

let vehiclesArray = ["🚗","🚕","🚙","🚌","🚎","🏎️", "🚓", "🚑","🚗","🚕","🚙","🚌","🚎","🏎️", "🚓", "🚑"]
let foodArray = ["🍏","🍆","🥝","🫐","🥭","🥥", "🍑","🍏","🍆","🥝","🫐","🥭","🥥", "🍑"]



struct ContentView: View {
    @State var emojisToDisplay = emojisArray
    
    var body: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .padding()
            
        ScrollView{
            emojisCards
        }
        .padding()
        HStack(spacing:20){
            ThemeButton(imageName: "car", label: "Vehicle", action: {
                changeTheme(vehiclesArray)
            })
            ThemeButton(imageName: "face.smiling", label: "Emojis", action: {
                changeTheme(emojisArray)
            })
            ThemeButton(imageName: "carrot", label: "Food", action: {
                changeTheme(foodArray)
            })
            
        }
        .foregroundColor(.blue)
        .font(.system(size: 20))
        
    }
    
    var emojisCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
            ForEach(0..<emojisToDisplay.count, id: \.self){ index in
                CardView(content: emojisToDisplay[index])
            }
        })
        
    }
    
    func changeTheme(_ cardType: Array<String>){
        emojisToDisplay = []
        emojisToDisplay = cardType.shuffled()
    }
    
    func toggleFaceUp(){
       
    }
    
}





struct CardView: View {
    let content: String
    @State var isFaceUp:Bool = true
    var isMatched:Bool = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 4)
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(.blue)
                Text(content)
                    .font(.system(size: 150))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
            
            
        }
        .foregroundColor(.orange)
        .onTapGesture {
            isFaceUp.toggle()
        }

        
    }
}

struct ThemeButton: View {
    let imageName: String
    let label: String
    var action: () -> Void
    
    var body: some View {
        VStack(spacing:5){
            Button(action: action , label: {
                Image(systemName: imageName)
            })
            Text(label)
        }
        .frame(width: 100)
        .foregroundColor(.blue)
        .font(.system(size: 20))
    }
}

#Preview {
    ContentView()
}
