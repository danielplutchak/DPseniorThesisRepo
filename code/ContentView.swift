//
//  ContentView.swift
//  Light Meter
//
//  Created by Daniel Plutchak on 10/29/25.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct ContentView: View {
    @StateObject private var model = FrameHandler()
    
    
    var body: some View {
        VStack{
            FrameView(image: model.currentFrame)
                .padding()
            
            //wheel view and functionality
            EVSettingsUIView(model: model)

        }
        .padding()
        .background(Gradient(colors: gradientColors))
        
    }
}

#Preview {
    ContentView()
}

