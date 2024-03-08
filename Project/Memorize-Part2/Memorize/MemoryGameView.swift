//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hui Hu on 3/1/24.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("Score " + String(viewModel.score())).font(.largeTitle).foregroundColor(.white).bold()
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            HStack {
//                Spacer()
//                Button("Shuffle") {
//                    viewModel.shuffle()
//                }
                Spacer()
                ZStack {
                    Text("Theme: " + viewModel.themeName()).font(.title3).bold()
                }.padding(2)
                
                Spacer()
            }
            .foregroundColor(.white)
            Button("New Game") {
                viewModel.newGame(archive: false)
            }.foregroundColor(.white)
            .foregroundColor(.white)
            .font(.largeTitle)
            .bold()
        }
        .padding()
        .background(viewModel.getBackgroundColor())
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        let res = viewModel.choose(card)
                        if res {
                            viewModel.newGame(archive: true)
                        }
                    }
            }
        }
    }

}

struct CardView: View {
    let card: GameModel<String>.Card
    
    init(_ card: GameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)

            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)

            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
            }.opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity((card.isFaceUp || !card.isMatched) ? 1 : 0)
    }
}

//struct MemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryGameView(viewModel: GameViewModel())
//    }
//}
