//
//  CarouselIndicator.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import SwiftUI

struct CarouselIndicator: View {
    let count: Int
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut, value: currentIndex)
            }
        }
    }
}
