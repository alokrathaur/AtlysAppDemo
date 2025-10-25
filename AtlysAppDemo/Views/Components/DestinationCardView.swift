//
//  DestinationCardView.swift
//  AtlysAppDemo
//
//  Created by Alok Rathaur on 26/10/25.
//

import SwiftUI

struct DestinationCardView: View {
    let destination: DestinationCard
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(url: destination.imageUrl, width: width, height: height)
                .frame(width: width, height: height)
                .background(.white)
                .cornerRadius(15)
                .clipped()
            
            DestinationLabelsView(destination: destination)
        }
        .frame(width: width, height: height)
    }
}

private struct DestinationLabelsView: View {
    let destination: DestinationCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            
            Text(destination.countryName)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 2)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            
            HStack {
                Text("\(destination.visaCount) Visas on Atlys")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.4, green: 0, blue: 0.8))
            }
            .cornerRadius(6)
        }
        .padding(.leading, 16)
        .padding(.bottom, 16)
    }
}

private struct AsyncImageView: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
                    .frame(width: width, height: height)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
    }
}
