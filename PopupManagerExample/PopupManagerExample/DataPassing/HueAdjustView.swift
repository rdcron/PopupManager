//
//  HueAdjustView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct HueAdjustView: View {
    @Binding var hue: Double
    @Binding var sat: Double
    @Binding var bright: Double
    
    var body: some View {
        PopupView {
            VStack {
                Text("Hue")
                
                Slider(value: $hue, in: 0.0 ... 1.0) {
                    Text("Hue adjustment slider")
                } minimumValueLabel: {
                    Text("0.0")
                } maximumValueLabel: {
                    Text("1.0")
                }
                .tint(Color("LinkYellow"))
                
                Text("Saturation")
                
                Slider(value: $sat, in: 0.0 ... 1.0) {
                    Text("Saturation adjustment slider")
                } minimumValueLabel: {
                    Text("0.0")
                } maximumValueLabel: {
                    Text("1.0")
                }
                .tint(Color("LinkYellow"))
                
                Text("Brightness")
                
                Slider(value: $bright, in: 0.0 ... 1.0) {
                    Text("Brightness adjustment slider")
                } minimumValueLabel: {
                    Text("0.0")
                } maximumValueLabel: {
                    Text("1.0")
                }
                .tint(Color("LinkYellow"))
                
                Button("Reset") {
                    hue = 0.522
                    sat = 0.72
                    bright = 0.81
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(Color("PopupButtonBackground")))

            }
            .minimumScaleFactor(0.6)
        }
    }
}

