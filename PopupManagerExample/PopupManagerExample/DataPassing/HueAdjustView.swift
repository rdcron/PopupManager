//
//  HueAdjustView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct HueAdjustView: View {
    @Binding var hue: Double
    
    var body: some View {
        PopupView {
            Slider(value: $hue, in: 0.0 ... 1.0) {
                Text("Hue adjustment slider")
            } minimumValueLabel: {
                Text("0.0")
            } maximumValueLabel: {
                Text("1.0")
            }
        }
    }
}

