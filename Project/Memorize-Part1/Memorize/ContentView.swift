//
//  ContentView.swift
//  Memorize
//
//  Created by Hui Hu on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    let theme: [[String]] = [
        ["😶", "😑", "🙃", "🫨", "🧐", "😶", "😑", "🙃", "🫨", "🧐"],
        ["🦋", "🪼", "🐡", "🦆", "🦑", "🦋", "🪼", "🐡", "🦆", "🦑"],
        ["⚾️", "⚽️", "🏈", "🏉", "🎾", "⚾️", "⚽️", "🏈", "🏉", "🎾"]
    ]
    @State var themeIndex: Int = 0
    @State var emojis: [String] = ["🦋", "🪼", "🐡", "🦆", "🦑", "🦋", "🪼", "🐡", "🦆", "🦑"]
    @State var color: Color = Color(.blue)

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).foregroundColor(.white).bold()
            ScrollView {
                cards
            }
            themeSwitchs
        }
        .padding()
        .background(.blue)
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var themeSwitchs: some View {
        HStack {
            Spacer()
            ThemeButton(themeIcon: "face.smiling.inverse", themName: "Face", themeIndex: 0)
            Spacer()
            ThemeButton(themeIcon: "pawprint.fill", themName: "Animal", themeIndex: 1)
            Spacer()
            ThemeButton(themeIcon: "tennisball.fill", themName: "Play", themeIndex: 2)
            Spacer()
        }.padding(.top)
    }

//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label : {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
//    }
//
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
//    }
//
//    var cardCountAdjustrts: some View {
//        HStack {
//            Spacer()
//            cardRemover
//            Spacer()
//            Button("Change Theme"){
//                themeIndex = (themeIndex + 1) % theme.count
//                emojis = theme[themeIndex]
//            }.font(.title2).bold()
//            Spacer()
//            cardAdder
//            Spacer()
//        }
//        .foregroundColor(.white)
//        .imageScale(.large)
//        .font(.title)
//    }

    func ThemeButton(themeIcon: String, themName: String, themeIndex: Int) -> some View {
        return VStack {
            Button{emojis = theme[themeIndex].shuffled()} label: {
                VStack {
                    Image(systemName: themeIcon).foregroundColor(.white).imageScale(.large).font(.title2)
                    Text(themName).foregroundColor(.white)
                }
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)

            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)

            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
            }.opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
//            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
