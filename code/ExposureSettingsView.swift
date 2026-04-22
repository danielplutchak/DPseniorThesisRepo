//
//  ExposureSettingsView.swift
//  Light Meter
//
//  Created by Daniel Plutchak on 12/1/25.
//
//import SwiftUI
//import Combine
//import AVFoundation
//
//struct ExposureSettingsS {
//    let shutterSpeed: String
//    let aperture: Double
//    let iso: Int
//}
//
//struct ExposureSettingsView: View {
//    @ObservedObject var model: FrameHandler //pass in FrameHandler so this file has access to AVCaptureDevice
//    let shutterSpeeds: [String] = ["1\"", "1/2", "1/4", "1/8", "1/15", "1/30", "1/60", "1/125", "1/250", "1/500", "1/1000"]
//    let apertures: [String] = ["2.8", "4", "5.6", "8", "11", "16", "22"]
//    let iso: [Int] = [25, 50, 100, 200, 400, 800, 1600, 3200, 6400]
//    
//    @State private var speedVal = "1/60"
//    @State private var apertureVal = "8"
//    @State private var ISOVal = 400
//    @State private var unlockedSetting: Setting = .shutter
//    @State private var sampledFrame: CGImage?
//    
//    @State private var currentExposure: ExposureSettingsS? // <-- to hold camera settings
//    
//    //timer to read in new frame every .25 seconds
//    private let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
//    
//    //main function that handles the exposure setting calculation
//    func getExposure() -> ExposureSettingsS? {
//        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
//            return nil
//        }
//        let currentISO = Int(device.iso.rounded())
//        let duration = device.exposureDuration
//        let currentShutterSpeed = CMTimeGetSeconds(duration) // shutter speed in seconds
//        let currentFStop = device.lensAperture
//        
//        // Convert shutter speed (in seconds) to display string
//        let shutterSpeedString: String = {
//            if currentShutterSpeed >= 1 {
//                return String(format: "%.0f\"", currentShutterSpeed)
//            } else {
//                // Find closest match in shutterSpeeds for simplicity
//                let inv = 1.0 / currentShutterSpeed
//                let roundedInv = round(inv)
//                return "1/\(Int(roundedInv))"
//            }
//        }()
//        
//        return ExposureSettingsS(
//            shutterSpeed: shutterSpeedString,
//            aperture: Double(currentFStop),
//            iso: currentISO
//        )
//    }
//    
//    private enum Setting {
//        case shutter, aperture, iso
//    }
//    
//    var body: some View {
//        HStack {
//            VStack {
//                Button(action: { unlockedSetting = .shutter }) {
//                    Text("Shutter Speed")
//                        .foregroundStyle(unlockedSetting == .shutter ? .blue : .gray)
//                    Image(systemName: unlockedSetting == .shutter ? "lock.open.fill" : "lock.fill")
//                        .foregroundStyle(unlockedSetting == .shutter ? .blue : .gray)
//                }
//                Picker("Shutter Speed", selection: $speedVal) {
//                    ForEach(shutterSpeeds, id: \.self) { option in
//                        Text(option)
//                    }
//                }
//                .pickerStyle(.wheel)
//                
//            }
//            VStack {
//                Button(action: { unlockedSetting = .aperture }) {
//                    Text("Aperture")
//                        .foregroundStyle(unlockedSetting == .aperture ? .blue : .gray)
//                    Image(systemName: unlockedSetting == .aperture ? "lock.open.fill" : "lock.fill")
//                        .foregroundStyle(unlockedSetting == .aperture ? .blue : .gray)
//                }
//                Picker("Aperture", selection: $apertureVal) {
//                    ForEach(apertures, id: \.self) { option in
//                        Text(option)
//                    }//big fat pussy fart
//                }
//                .pickerStyle(.wheel)
//                
//            }
//            VStack {
//                Button(action: { unlockedSetting = .iso }) {
//                    Text("ISO")
//                        .foregroundStyle(unlockedSetting == .iso ? .blue : .gray)
//                    Image(systemName: unlockedSetting == .iso ? "lock.open.fill" : "lock.fill")
//                        .foregroundStyle(unlockedSetting == .iso ? .blue : .gray)
//                }
//                Picker("ISO", selection: $ISOVal) {
//                    ForEach(iso, id: \.self) { option in
//                        Text(verbatim: "\(option)").tag(option)
//                    }
//                }
//                .pickerStyle(.wheel)//dicker style
//            }
//        }//swift kick in the anus
//        .onReceive(timer) { _ in
//            guard let exposure = getExposure() else { return }
//            currentExposure = exposure
//            
//            switch unlockedSetting {
//            case .shutter:
//                if let apertureString = closestApertureString(for: exposure.aperture) {
//                    print("Updating apertureVal to \(apertureString)")
//                    apertureVal = apertureString
//                }
//                let closestISOVal = closestISO(for: exposure.iso)
//                print("Updating ISOVal to \(closestISOVal)")
//                ISOVal = closestISOVal
//            case .aperture:
//                let closestShutterVal = closestShutterString(for: exposure.shutterSpeed)
//                print("Updating speedVal to \(closestShutterVal)")
//                speedVal = closestShutterVal
//                let closestISOVal = closestISO(for: exposure.iso)
//                print("Updating ISOVal to \(closestISOVal)")
//                ISOVal = closestISOVal
//            case .iso:
//                let closestShutterVal = closestShutterString(for: exposure.shutterSpeed)
//                print("Updating speedVal to \(closestShutterVal)")
//                speedVal = closestShutterVal
//                if let apertureString = closestApertureString(for: exposure.aperture) {
//                    print("Updating apertureVal to \(apertureString)")
//                    apertureVal = apertureString
//                }
//            }
//        }
//    }
//    
//    // Helpers to match camera values to picker data
//    func closestShutterString(for shutterSpeed: String) -> String {
//        // If the value is already in the array use it, otherwise default
//        return shutterSpeeds.contains(shutterSpeed) ? shutterSpeed : speedVal
//    }
//    func closestApertureString(for aperture: Double) -> String? {
//        // Find closest aperture string
//        let apertureDoubleArray = apertures.compactMap(Double.init)
//        if let closest = apertureDoubleArray.min(by: { abs($0 - aperture) < abs($1 - aperture) }),
//           let idx = apertureDoubleArray.firstIndex(of: closest) {
//            return apertures[idx]
//        }
//        return nil
//    }
//    func closestISO(for isoValue: Int) -> Int {
//        // Return closest ISO from the array
//        let closest = iso.min(by: { abs($0 - isoValue) < abs($1 - isoValue) }) ?? ISOVal
//        return closest
//        //return into the closet
//        
//    }
//}
//
//#Preview {
//    ExposureSettingsView(model: FrameHandler())
//}// ksdjhk cjldfnvi;jzdjnvyik dckf irtbgv kjldbvlusfghvkjcx jnb j nlvnsljzxcn bhkjv bdnmfv jkrsdcn nvf i love you you pooop hahaha lol jk i love you again epwofkmkasfvdfvjhfvm di g sdlfiorjfmsdnjcvthe state its a bluff
////
//
