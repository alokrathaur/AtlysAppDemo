//
//  ContentView.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import SwiftUI

struct ContentView: View {
    
    // Sample destination data
    private let destinations: [DestinationCard] = [
        DestinationCard(
            imageUrl: "https://media.istockphoto.com/id/845702822/photo/top-view-of-the-new-downtown-of-amman.jpg?s=612x612&w=0&k=20&c=Bm7uu-rw2jq-zl2zyNvMSy4ZyyZCQthJpec1x0brSUk=",
            countryName: "Dubai",
            visaCount: "53K+"
        ),
        DestinationCard(
            imageUrl: "https://i.guim.co.uk/img/media/55b58f9514a6ccb5a57d59d04151af12864acf69/0_374_5616_3370/master/5616.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=416add2213cc99b0e4b11206ea66407b",
            countryName: "Malaysia",
            visaCount: "32K+"
        ),
        DestinationCard(
            imageUrl: "https://i.pinimg.com/736x/19/92/bb/1992bb635a346c5c2ffc72ab56824391.jpg",
            countryName: "Thailand",
            visaCount: "25K+"
        )
    ]
    
    var body: some View {
        CarouselView(destinations: destinations)
    }
}

#Preview {
    ContentView()
}
