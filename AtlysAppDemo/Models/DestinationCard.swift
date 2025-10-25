//
//  DestinationCard.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import Foundation

struct DestinationCard: Identifiable {
    let id = UUID()
    let imageUrl: String
    let countryName: String
    let visaCount: String
}
