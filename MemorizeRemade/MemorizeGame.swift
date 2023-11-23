//
//  MemorizeGame.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable{
    
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
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { return cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    
    // HA DELLE FUNZIONI CHE FANNO DELLE COSE, NEL NOSTRO CASO HA UNA FUNZIONE DI SCELTA
    // visto che la carta che passo è una copia di quella che ho nel modello devo andare a cercarla per andare a fare qualcosa tipo modificarla
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { cardToCheck in cardToCheck.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            }
            
            //  QUALSIASI DELLE COSE SOPRA SE NON ACCADONO VADO A GIRARE COMUNQUE LA CARTA E METTERLA FACE UP
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    // per togliere questa funzione e andare ad utilizzare la potenza degli array in swift possiamo fare come sopra
    
    // MARK: andare a rivedere questa cosa con al funzione choose sopra perchè fa capire che possiamo non utilizzare questa funzione
    //private func index(of card: Card) -> Int? {
    //    for index in cards.indices {
    //        if cards[index].id == card.id {
    //            return index
    //        }
    //    }
    //    return nil
    //}
    
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    // DEVO ANDARE A DEFINIRE COME E' FATTA UNA CARTA E QUINDI INNESTO UN UNA STRUTTURA DI CARTA
    // VADO A METTERE IDENTIFIABLE COME PROTOCOLLO PER NON AVERE SELF.ID NEL FOREACH
    struct Card: Equatable, Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        // IL MIO CONTENTUNO LO CREO DONT CARE PERCHè POTREBBE ESSERE QUALSIASI COSA
        let content: CardContent
        
        
        
        
        let id: String
    }
}


extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
    
}
