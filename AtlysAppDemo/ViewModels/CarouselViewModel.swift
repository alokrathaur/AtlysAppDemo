//
//  CarouselViewModel.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import Foundation
import SwiftUI

@MainActor
class CarouselViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var dragState: DragState = .inactive
    
    let items: [DestinationCard]
    let configuration: CarouselConfiguration
    
    init(items: [DestinationCard], configuration: CarouselConfiguration = .default) {
        self.items = items
        self.configuration = configuration
        self.currentIndex = 0
        self.dragState = .inactive
    }
    
    var itemCount: Int {
        items.count
    }
    
    var currentItem: DestinationCard? {
        guard currentIndex >= 0 && currentIndex < items.count else { return nil }
        return items[currentIndex]
    }
    
    func navigateToNext() {
        guard currentIndex < items.count - 1 else { return }
        currentIndex += 1
    }
    
    func navigateToPrevious() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }
    
    func handleDragEnded(value: DragGesture.Value) {
        let threshold = configuration.dragThreshold
        
        if value.predictedEndTranslation.width > threshold || value.translation.width > threshold {
            navigateToPrevious()
        } else if value.predictedEndTranslation.width < (-1 * threshold) || value.translation.width < (-1 * threshold) {
            navigateToNext()
        }
    }
    

}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
