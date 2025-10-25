//
//  CarouselConfiguration.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import Foundation

struct CarouselConfiguration {
    let itemHeight: CGFloat
    let itemWidth: CGFloat
    let overlapPercentage: CGFloat
    let dragThreshold: CGFloat
    
    static let `default` = CarouselConfiguration(
        itemHeight: 300,
        itemWidth: 250,
        overlapPercentage: 0.2,
        dragThreshold: 200
    )
}
