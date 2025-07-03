//
//  Destination.swift
//  TravelApp
//
//  Created by Randimal Geeganage on 2025-05-10.
//

import Foundation

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    // Add other properties as needed

    static let sampleDestinations: [Destination] = [
        Destination(name: "Stockholm", description: "The capital of Sweden", imageName: "stockholm"),
        Destination(name: "Paris", description: "The city of love", imageName: "paris"),
        Destination(name: "Tokyo", description: "A vibrant metropolis", imageName: "tokyo")
    ]
}
