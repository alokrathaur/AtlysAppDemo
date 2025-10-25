//
//  CarouselView.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel: CarouselViewModel
    private let destinations: [DestinationCard]
    private let layoutCalculator: CarouselLayoutCalculator
    
    init(destinations: [DestinationCard], configuration: CarouselConfiguration = .default) {
        self.destinations = destinations
        let vm = CarouselViewModel(items: destinations, configuration: configuration)
        _viewModel = StateObject(wrappedValue: vm)
        self.layoutCalculator = CarouselLayoutCalculator(configuration: configuration)
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                LogoHeaderView()
                
                CarouselContentView(
                    destinations: destinations,
                    viewModel: viewModel,
                    layoutCalculator: layoutCalculator
                )
                
                Spacer()
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        viewModel.dragState = .dragging(translation: value.translation)
                    }
                    .onEnded { value in
                        viewModel.handleDragEnded(value: value)
                        viewModel.dragState = .inactive
                    }
            )
        }
    }
}

private struct LogoHeaderView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 60)
            .padding(.top, 30)
            .padding(.bottom, 20)
    }
}

private struct CarouselContentView: View {
    let destinations: [DestinationCard]
    @ObservedObject var viewModel: CarouselViewModel
    let layoutCalculator: CarouselLayoutCalculator
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                ForEach(Array(destinations.enumerated()), id: \.element.id) { index, destination in
                    createCardView(for: destination, at: index)
                }
            }
            
            CarouselIndicator(
                count: viewModel.itemCount,
                currentIndex: viewModel.currentIndex
            )
        }
    }
    
    private func createCardView(for destination: DestinationCard, at index: Int) -> some View {
        let isCenterCard = (index == viewModel.currentIndex)
        
        // Fixed dimensions
        let cardWidth: CGFloat = 250
        let cardHeight: CGFloat = isCenterCard ? 300 : 200
        
        let offset = layoutCalculator.getOffset(
            for: index,
            currentIndex: viewModel.currentIndex,
            dragTranslation: viewModel.dragState.translation.width,
            isFirstItem: index == 0,
            isLastItem: index == destinations.count - 1
        )
        
        return DestinationCardView(
            destination: destination,
            width: cardWidth,
            height: cardHeight
        )
        .opacity(layoutCalculator.getOpacity(for: index, currentIndex: viewModel.currentIndex))
        .offset(x: offset)
        .zIndex(layoutCalculator.getZIndex(for: index, currentIndex: viewModel.currentIndex))
        .animation(
            .interpolatingSpring(stiffness: 300, damping: 30, initialVelocity: 10),
            value: viewModel.currentIndex
        )
    }
}
