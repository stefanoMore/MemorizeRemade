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
    // DEVO METTERE OBSERVEDOBJEC PERCHè OGNI VOLTA CHE QUALCOSA CAMBIA IO VADO A FARE UN UPDATE
    // PER QUESTO MOTIVO NON SI METTE MAI UGUALE A QUALCOSA PERCHè DEVO VEDERE QUANDO CAMBIA
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .padding()
            
        ScrollView{
            emojisCards
                .animation(.default, value: viewModel.cards)
            // che tipo di animazione e poi value è quello che deve succedere quando quella cosa cambia
        }
        .padding()
        
        Button("Shuffle"){
            viewModel.shuffle()
        }        //HStack(spacing:20){
        //    //ThemeButton(imageName: "car", label: "Vehicle", action: {
        //    //    changeTheme(vehiclesArray)
        //    //})
        //    //ThemeButton(imageName: "face.smiling", label: "Emojis", action: {
        //    //    changeTheme(emojisArray)
        //    //})
        //    //ThemeButton(imageName: "carrot", label: "Food", action: {
        //    //    changeTheme(foodArray)
        //    //})
        //
        //}
        .foregroundColor(.blue)
        .font(.system(size: 20))
        
    }
    
    var emojisCards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],spacing: 0, content: {
            ForEach(viewModel.cards){ card in
                // to remove the card here because is redundatn i can init the card in the cardView
                CardView(card)
                    .padding(5)
                    .onTapGesture{
                        viewModel.choose(card)
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
    
    // this is the init to set the card and remove the reduntatn in the forEach
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 4)
                    .aspectRatio(2/3, contentMode: .fit)
                Text(card.content)
                    .font(.system(size: 150))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .foregroundColor(.orange)
        // questa cosa la faccio per togliere le card quando vado a trovare il match, faccio così altrimenti mi scompaiono subito
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)

        
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


/// Qui posso mettere un nuovo view model da ricreare ogni volta perchè viene runnato ogni volta che vado ad aggiornare il codice. quindi ci sta. Ma non da qualche altra parte. Se lo metto così da altre parti potrebbe essere che aggiorno cose anche quando non voglio per esempio.
#Preview {
    EmojiContentView(viewModel: EmojiMemoryGameViewModel())
}
