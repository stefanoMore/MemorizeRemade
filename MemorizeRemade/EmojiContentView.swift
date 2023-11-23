//
//  EmojiContentView.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//

import SwiftUI



let emojisArray = ["😆","🤢","😻","🦾","👿","👹", "🤡", "👻","💀","😵‍💫","👾","🤖","😆","🤢","😻","🦾","👿","👹", "🤡", "👻","💀","😵‍💫","👾","🤖"]

let vehiclesArray = ["🚗","🚕","🚙","🚌","🚎","🏎️", "🚓", "🚑","🚗","🚕","🚙","🚌","🚎","🏎️", "🚓", "🚑"]
let foodArray = ["🍏","🍆","🥝","🫐","🥭","🥥", "🍑","🍏","🍆","🥝","🫐","🥭","🥥", "🍑"]

/// LA PARTE UI è  REACTIVE STATELESS  --> QUALCOSA CAMBIA NEL VIEW MODEL, QUESTA RI RIAGGIORNA

struct EmojiContentView: View {
// va a puntare al viewModel
    var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .padding()
            
        ScrollView{
            emojisCards
        }
        .padding()
        HStack(spacing:20){
            //ThemeButton(imageName: "car", label: "Vehicle", action: {
            //    changeTheme(vehiclesArray)
            //})
            //ThemeButton(imageName: "face.smiling", label: "Emojis", action: {
            //    changeTheme(emojisArray)
            //})
            //ThemeButton(imageName: "carrot", label: "Food", action: {
            //    changeTheme(foodArray)
            //})
            
        }
        .foregroundColor(.blue)
        .font(.system(size: 20))
        
    }
    
    var emojisCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], content: {
            ForEach(viewModel.cards, id: \.self.id){ card in
                CardView(card: card)
                    .onTapGesture{
                        viewModel.toogle(card)
                    }
            }
        })
        
    }
    
   // func changeTheme(_ cardType: Array<String>){
   //     emojisToDisplay = []
   //     emojisToDisplay = cardType.shuffled()
   // }
    
    func toggleFaceUp(){
       
    }
    
}





struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 4)
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(.blue)
                Text(card.content)
                    .font(.system(size: 150))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
            
        }
        .foregroundColor(.orange)

        
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
    EmojiContentView(viewModel: EmojiMemoryGameViewModel())
}
