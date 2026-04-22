import SwiftUI
import AVFoundation


struct FrameView: View {
    var image : CGImage?
    private let label = Text("Frame")
    
    var body: some View {
        if let image = image {
            Image (image, scale: 3.8, orientation: .up, label: label)
        } else {
            Color.black
        }
        
        
    }
}
