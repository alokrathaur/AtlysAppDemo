//
//  CarouselLayoutCalculator.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import Foundation
import SwiftUI

struct CarouselLayoutCalculator {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    private let overlapPercentage: CGFloat
    
    init(configuration: CarouselConfiguration) {
        self.itemWidth = configuration.itemWidth
        self.itemHeight = configuration.itemHeight
        self.overlapPercentage = configuration.overlapPercentage
    }
    
    private var overlapOffset: CGFloat {
        // 20% overlap: 250 * 0.8 = 200
        return itemWidth * 0.8
    }
    
    func getOffset(for index: Int, currentIndex: Int, dragTranslation: CGFloat, isFirstItem: Bool, isLastItem: Bool) -> CGFloat {
        let constrainedTranslation = getConstrainedTranslation(
            currentIndex: currentIndex,
            dragTranslation: dragTranslation,
            isFirstItem: isFirstItem,
            isLastItem: isLastItem
        )
        
        let position = index - currentIndex
        
        return constrainedTranslation + (CGFloat(position) * overlapOffset)
    }
    
    func getHeight(for index: Int, currentIndex: Int) -> CGFloat {
        // Center card: full height (300), side cards: reduced height (200)
        return index == currentIndex ? itemHeight : 200
    }
    
    func getOpacity(for index: Int, currentIndex: Int) -> Double {
        let distance = abs(index - currentIndex)
        return distance <= 3 ? 1.0 : 0
    }
    
    func getZIndex(for index: Int, currentIndex: Int) -> Double {
        return index == currentIndex ? 1.0 : 0.0
    }
    
    private func getConstrainedTranslation(currentIndex: Int, dragTranslation: CGFloat, isFirstItem: Bool, isLastItem: Bool) -> CGFloat {
        var translation = dragTranslation
        
        // Prevent dragging left beyond first item
        if isFirstItem && translation < 0 {
            translation = max(translation, -50)
        }
        
        // Prevent dragging right beyond last item
        if isLastItem && translation > 0 {
            translation = min(translation, 50)
        }
        
        return translation
    }
}
