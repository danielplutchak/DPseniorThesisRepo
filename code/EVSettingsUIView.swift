//
//  EVSettingsUIView.swift
//  Light Meter
//
//  Created by Daniel Plutchak on 4/16/26.
//

import SwiftUI
import Combine
import AVFoundation
import Foundation

struct ExposureSettings {
    let shutterSpeed: String
    let aperture: String
    let iso: Int
}

private enum Setting {
    case shutterSetting, apertureSetting, isoSetting
}

struct EVSettingsUIView: View {
    //pass in FrameHandler so this file has access to AVCaptureDevice
    @ObservedObject var model: FrameHandler
    //values for pickers
    let speedVals: [String] = ["2\"", "1\"", "1/2", "1/4", "1/8", "1/15", "1/30", "1/60", "1/125", "1/250", "1/500", "1/1000"]
    let apertureVals: [String] = ["1.8", "2.8", "4", "5.6", "8", "11", "16", "22"]
    let isoVals: [Int] = [25, 50, 100, 200, 400, 800, 1600, 3200, 6400]
    
    //@State allows variables to update
    //picker values, set to default values
    @State private var speedVal = "1/60"
    @State private var apertureVal = "8"
    @State private var ISOVal = 400

    //unlocked setting is the setting where value will be getting calculated
    @State private var unlockedSetting: Setting = .shutterSetting
    //holds current exposure settings camera is displaying
    @State private var currentExposure: ExposureSettings?
    
    //timer to read in new frame every .1 seconds
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    //convert aperture values into a string
    func formatAperture(_ aperture: Float) -> String {
        let value = Double(aperture)
        
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(value))"
        } else {
            return String(format: "%.1f", value)
        }
    }
    
    //convert shutter speed (in seconds) to display string
    func formatShutterSpeed(_ seconds: Double) -> String {
        if seconds >= 1 {
            return "\(Int(round(seconds)))\""
        } else {
            let denominator = Int(round(1.0 / seconds))
            return "1/\(denominator)"
        }
    }
    
    //this function gets the current EV of the camera to store it in currentExposure
    func getCurrentExposure() -> ExposureSettings? {
        //sets up device as back camera and guards against crashing if camera is not found
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return nil
        }
        
        let currentISO = Int(device.iso.rounded())
        let duration = device.exposureDuration
        let currentSpeedInSeconds = CMTimeGetSeconds(duration) //shutter speed in seconds (0.25 for example)
        let currentFStop = device.lensAperture
        var shutterString = ""
        
        //safeguards against exposureDuration returning indefinite time, sets time to max available
        if currentSpeedInSeconds.isNaN {
            shutterString = "2\""
        } else {
            shutterString = formatShutterSpeed(currentSpeedInSeconds)
        }
        
        let apertureString = formatAperture(currentFStop)
        
        return ExposureSettings(
            shutterSpeed: shutterString,
            aperture: apertureString,
            iso: currentISO
        )
    }
    
    //parses shutter speed string to convert back into a double for closest calculation
    func shutterStringToSeconds(_ value: String) -> Double {
        //if the value contains quotations, remove the quote mark and return as double
        if value.contains("\"") {
            return Double(value.replacingOccurrences(of: "\"", with: "")) ?? 1.0
        } else if value.contains("/") { //if value is a fraction, calculate the double using the numerator and denomenator
            let parts = value.split(separator: "/")
            if parts.count == 2,
               let num = Double(parts[0]),
               let denom = Double(parts[1]) {
                return num / denom
            }
        }
        //error return
        print("parse error, returned 0")
        return 0
    }
    
    //helper functions to get the closest available values listed in val arrays
    func closestShutterSpeed(to seconds: Double) -> String {
        //.min(by:) loops through the array, returns smaller value based on conditions
        //conditions converts values to seconds and finds difference with passed in parameter
        //returns closest value with smallest difference
        return speedVals.min(by: {
            abs(shutterStringToSeconds($0) - seconds) <
            abs(shutterStringToSeconds($1) - seconds)
        }) ?? speedVals[0]
    }
    
    func closestAperture(to value: Double) -> String {
        //.min(by:) loops through array and returns smaller value
        //conditions convert string values into doubles and finds difference with passed in parameter
        return apertureVals.min(by: {
            abs((Double($0) ?? 0) - value) <
            abs((Double($1) ?? 0) - value)
        }) ?? apertureVals[0]
    }
    
    func closestISO(to value: Int) -> Int {
        //.min(by:) loops through array and returns smaller value
        //finds difference between closest values and returns closest
        return isoVals.min(by: {
            abs($0 - value) < abs($1 - value)
        }) ?? isoVals[0]
    }
    
    //calculates EV value to solve for target setting
    func getEV(_ currentExp: ExposureSettings) -> Double{
        let shutterSpeedSeconds = shutterStringToSeconds(currentExp.shutterSpeed)
        let apertureVal = Double(currentExp.aperture) ?? 1.0 //the optional value is only there to safeguard against a bad input
        let isoVal = Double(currentExp.iso)
        
        //first use shutter speed and aperture to get initial EV
        let initialEV = log2((apertureVal * apertureVal) / shutterSpeedSeconds)
        
        //then calculate iso Adjustment
        let isoAdjustment = log2(isoVal / 100.0)
        let EV = initialEV - isoAdjustment
        
        return EV
    }
    
    //following functions solve for target settings using locked exposure setting values from picker and EV value
    
    //***SHUTTER SPEED***
    func solveForShutterSpeed(_ currentExp: ExposureSettings) -> String? {
        let EV = getEV(currentExp)
        let givenAperture = Double(apertureVal) ?? 1.0
        let givenISO = Double(ISOVal)
        
        //check for errors
        if givenAperture == 1.0 {
            print("Error getting apertureVal when solving for shutter speed")
        }
        
        let isoAdj = givenISO / 100.0
        let denominator = pow(2.0, EV) * isoAdj
        
        let shutterInSeconds = pow(givenAperture, 2.0) / denominator
        
        return closestShutterSpeed(to: shutterInSeconds)
    }
    //***APERTURE***
    func solveForAperture(_ currentExp: ExposureSettings) -> String? {
        let EV = getEV(currentExp)
        let givenSpeed = shutterStringToSeconds(speedVal)
        let givenISO = Double(ISOVal)
        
        let isoAdj = givenISO / 100.0
        let preRootVal = givenSpeed * pow(2.0, EV) * isoAdj
        
        let aperture = sqrt(preRootVal)
        
        return closestAperture(to: aperture)
    }
    //***ISO***
    func solveForISO(_ currentExp: ExposureSettings) -> Int? {
        let EV = getEV(currentExp)
        let givenSpeed = shutterStringToSeconds(speedVal)
        let givenAperture = Double(apertureVal) ?? 1.0
        
        //check for errors
        if givenAperture == 1.0 {
            print("Error getting apertureVal when solving for ISO")
        }
        
        let numerator = pow(givenAperture, 2.0)
        let denominator = pow(2.0, EV) * givenSpeed
        
        let isoDouble = 100 * (numerator / denominator)
        
        return closestISO(to: Int(isoDouble))
    }
    
    
    var body: some View{
        HStack{
            VStack{
                //SHUTTER SPEED
                Button(action: { unlockedSetting = .shutterSetting }) {
                    Text("Shutter Speed")
                        .foregroundStyle(unlockedSetting == .shutterSetting ? .blue : .gray)
                    Image(systemName: unlockedSetting == .shutterSetting ? "lock.open.fill" : "lock.fill")
                        .foregroundStyle(unlockedSetting == .shutterSetting ? .blue : .gray)
                }
                Picker("Shutter Speed", selection: $speedVal) {
                    ForEach(speedVals, id: \.self) { option in
                        Text(option)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.wheel)
                .animation(.easeInOut, value: speedVal)
            }
            
            VStack{
                //APERTURE
                Button(action: { unlockedSetting = .apertureSetting }) {
                    Text("Aperture")
                        .foregroundStyle(unlockedSetting == .apertureSetting ? .blue : .gray)
                    Image(systemName: unlockedSetting == .apertureSetting ? "lock.open.fill" : "lock.fill")
                        .foregroundStyle(unlockedSetting == .apertureSetting ? .blue : .gray)
                }
                Picker("Aperture", selection: $apertureVal) {
                    ForEach(apertureVals, id: \.self) { option in
                        Text(option)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.wheel)
                .animation(.easeInOut, value: apertureVal)
            }
            
            VStack{
                //ISO
                Button(action: { unlockedSetting = .isoSetting }) {
                    Text("ISO")
                        .foregroundStyle(unlockedSetting == .isoSetting ? .blue : .gray)
                    Image(systemName: unlockedSetting == .isoSetting ? "lock.open.fill" : "lock.fill")
                        .foregroundStyle(unlockedSetting == .isoSetting ? .blue : .gray)
                }
                Picker("ISO", selection: $ISOVal) {
                    ForEach(isoVals, id: \.self) { option in
                        Text(verbatim: "\(option)").tag(option)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.wheel)
                .animation(.easeInOut, value: ISOVal)
            }
        }
        .onReceive(timer){ _ in
            //safe way to unwrap optional, returns out of .onReceive if getCurrentExposure() returns nil
            guard let exposure = getCurrentExposure() else {
                //print("Error occured when getting current exposure")
                return
            }
            currentExposure = exposure
            
            
            //find what needs to be solved for using unlocked setting and call solve function for respective setting
            if unlockedSetting == .shutterSetting {
                
                //if let makes sure variable is not nil, is contained in the Picker array, and it a new value than what is already displayed in the Picker
                if let newSpeedVal = solveForShutterSpeed(exposure),
                   speedVals.contains(newSpeedVal),
                   speedVal != newSpeedVal {
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        //updating this value will reflect the change onto the picker
                        speedVal = newSpeedVal
                    }
                    
                    
                    print("Shutter speed updated to " + speedVal)
                }
                    
                
            } else if unlockedSetting == .apertureSetting {
                
                //if let makes sure variable is not nil, is contained in the Picker array, and it a new value than what is already displayed in the Picker
                if let newApertureVal = solveForAperture(exposure),
                   apertureVals.contains(newApertureVal),
                   apertureVal != newApertureVal {
                    
                    withAnimation(.easeInOut(duration: 0.3)){
                        //updating this value will reflect the change onto the picker
                        apertureVal = newApertureVal
                    }
                    
                    print("Aperture updated to " + apertureVal)
                }
                
            } else if unlockedSetting == .isoSetting {
                
                //if let makes sure variable is not nil, is contained in the Picker array, and it a new value than what is already displayed in the Picker
                if let newISOVal = solveForISO(exposure),
                   isoVals.contains(newISOVal),
                   ISOVal != newISOVal {
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        //updating this value will reflect the change onto the picker
                        ISOVal = newISOVal
                    }
                
                    print("ISO updated to " + String(ISOVal))
                }
                
            }
            
        } //onReceive
    }//var body
}//ui view
            
#Preview {
    EVSettingsUIView(model: FrameHandler())
}
