//
//  EmojiMemoryGameViewModel.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//


// QUI IMPORTO SWIFT UI PERCHè è PARTE DELL'UI
import SwiftUI



class EmojiMemoryGameViewModel {
    // creo la variabile modello che si rifà al modello del gioco
    // la stessa cosa la devo fare anche sun content view, affinchè si rifaccia a questa schermata
    
    
    //se non metto private allora ho una connessione tra ui e model perchè potrei scrivere emojiMemoryGameViewModel.model.somethingInTheModel. Con private non posso accedere dall'UI al modello
    
    // TUTTE QUESTE SONO PROTEZIONI A LIVELLO DI VIEW MODEL
    // devo andare a inizializzare il modello, ma mettere delle carte non avrebbe senso perchè le carte sono nel modello.
    // La cosa che ha senso fare per esempio è inizializzare il numero di coppie che devo avere di carte quindi faccio...
    
    // per andare a passare una funzione di tipo cardContentFactory vado a creare una funzione globale
    
    
    // DEVO ANDARE A METTERE STATIC ALLA MIA VARIABILE ALTRIMENTI NON MI VIENE INIZIALLIZATA PER PASSARLA NELLA FUNZIONE COSTRUTTRICE DELLE CARTE
    private static let emojis = ["😆","🤢","😻","🦾","👿","👹", "🤡", "👻","💀","😵‍💫","👾","🤖"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairOfCards: 15) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
               return "‼️"
            }
            
        }
    }
    
    private var model = createMemoryGame()
    
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    /// INTENT FUNCTION
    /// QUESTO FUNZIONI NON VOGLIONO AVERE DEI NOME ESTERNI. QUANDO ANDIAMO A CHIAMARE QUESTA FUNZIONE IN UN ALTRO
    func choose(_ card: MemoryGame<String>.Card){
        return model.choose(card)
    }
    
    func toogle(_ card: MemoryGame<String>.Card){
        return model.toggle(card)
    }
    
}
