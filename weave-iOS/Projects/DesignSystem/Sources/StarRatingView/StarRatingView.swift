//
//  StarRatingView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/2/24.
//

import SwiftUI

public struct StarRatingView: View {
    
    /*
     민약 3.5 라면 0.5로 나누기 (7)
     7을 2로 나눠서
     몫은 star 갯수, 나머지는 halfStar 갯수로
     */
    
    var rating: Double
    
    var offset: Int {
        return Int(rating / 0.5)
    }
    
    public init(rating: Double) {
        if rating < 0.0 {
            self.rating = 0.0
            return
        }
        
        if rating > 5.0 {
            self.rating = 5.0
            return
        }
        
        self.rating = rating
    }
    
    public var body: some View {
        let filledStarCount = offset / 2
        let halfStarCount = offset % 2
        let emptyStarCount = 5 - filledStarCount - halfStarCount
        
        HStack(spacing: 8) {
            ForEach(0 ..< filledStarCount, id: \.self) { _ in
                return Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            
            ForEach(0 ..< halfStarCount, id: \.self) { _ in
                return Image(systemName: "star.leadinghalf.filled")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            
            ForEach(0 ..< emptyStarCount, id: \.self) { _ in
                return Image(systemName: "star")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
        }
        .foregroundStyle(DesignSystem.Colors.defaultBlue)
        .padding(.all, 2)
    }
}
