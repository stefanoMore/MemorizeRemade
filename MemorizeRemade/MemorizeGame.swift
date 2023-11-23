//
//  MemorizeGame.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//

import Foundation


struct MemoryGame<CardContent> {
    
    //QUANDO VADO A CREARE UN MODELLO DEVO CAPIRE COSA FA QUESTO MODELLO
    // VADOO A DICHIARARE ALCUNE COSE
    
    //SICURAMENTE HA DELLE CARTE IN QUESTO CASO
    
    // UN ALTRA PROTEZIONE CHE POSSO METTERE è PRIVATE (SET) OVVERE CHE POSSO ANDARE A GETTARLA MA NON POSSO SETTARLA. SETTARE è PRIVATO E INTERNO SOLO AL MODELLO
    // ACCESSO CONTROL
    private(set) var cards: Array<Card>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // chiaramente voglio aggiungere numberOfPairOfCards x 2
        
        // MARK: Quando vado a creare una carta nell'init non so niente di che tipologia è la carta. Quindi cosa faccio: tra gli input vado a creare una funzione che parla con il viewModel per andare a vedere che tipo di carta voglio creare. Gli passo l'index per andare a prendere la carta nel determinato posto che mi restituisca un card content da usare
        for pairIndex in 0..<max(2,numberOfPairOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    
    // HA DELLE FUNZIONI CHE FANNO DELLE COSE, NEL NOSTRO CASO HA UNA FUNZIONE DI SCELTA
    func choose(_ card: Card){
        
    }
    
     mutating func toggle(_ card: Card){
    }
    
    // DEVO ANDARE A DEFINIRE COME E' FATTA UNA CARTA E QUINDI INNESTO UN UNA STRUTTURA DI CARTA
    struct Card {
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        // IL MIO CONTENTUNO LO CREO DONT CARE PERCHè POTREBBE ESSERE QUALSIASI COSA
        let content: CardContent
        
        
        
        
        let id: String
    }
}
