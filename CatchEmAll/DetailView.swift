//
//  DetailedView.swift
//  CatchEmAll
//
//  Created by Zhejun Zhang on 3/17/25.
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            HStack {
                creatureImage
                
                //                AsyncImage(url: URL(string: creatureDetail.imageURL)){
                //                    image in
                //                    image
                //                        .resizable()
                //                        .scaledToFit()
                //                        .background(.white)
                //                        .clipShape(RoundedRectangle(cornerRadius:16))
                //                        .shadow(radius: 8, x: 5, y: 5)
                //                        .overlay {
                //                            RoundedRectangle(cornerRadius: 16)
                //                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                //                        }
                //                } placeholder: {
                //                    RoundedRectangle(cornerRadius: 10)
                //                        .foregroundStyle(.clear)
                //                }
                //                .frame(width: 96, height: 96)
                //                .padding(.trailing)
                
                VStack {
                    HStack(alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.1f", creatureDetail.height))
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    HStack(alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.1f", creatureDetail.weight))
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .task {
            creatureDetail.urlString = creature.url
            await creatureDetail.getData()
        }
    }
}

extension DetailView {
    var creatureImage: some View {
        AsyncImage(url: URL(string: creatureDetail.imageURL)){ phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius:16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
            } else if phase.error != nil {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius:16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
            } else {
                //                        RoundedRectangle(cornerRadius: 10)
                //                            .foregroundStyle(.clear)
                
                ProgressView()
                    .tint(.red)
                    .scaleEffect(4)
            }
        }
        .frame(width: 96, height: 96)
        .padding(.trailing)
    }
}

#Preview {
    DetailView(creature: Creature(name:"bulbasaur",url:"https://pokeapi.co/api/v2/pokemon/1/"))
}
