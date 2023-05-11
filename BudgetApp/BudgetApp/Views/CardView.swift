//
//  CardView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 5/5/2023.
//

import SwiftUI

struct CardView: View {
    var cardImageName: String
    var cardTitle: String
    var cardSubtitle: Double
    var cardImageColor: Color
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Image(systemName: cardImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                    .clipped()
                    .foregroundColor(cardImageColor)
                
                LazyVStack(alignment: .center, spacing: 8) {
                    Text(cardTitle)
                        .font(.subheadline)
                        .padding(8)
                    
                    Text("\(cardSubtitle, specifier: "%0.2f")")
                        .font(.title2)
                }
                
            }
            .frame(width: 200, height: 120)
        }
    }
    
    private let cardAndImageWidth: CGFloat = 150
    private let cardHeight: CGFloat = 150
    private let imageHeight: CGFloat = 116
    private let cornerRadius: CGFloat = 5
}
