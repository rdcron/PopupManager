//
//  HueAdjustView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI
import PopupManager

struct HueAdjustView: View {
    @Binding var hue: Double
    @Binding var sat: Double
    @Binding var bright: Double
    
    var body: some View {
        PopupView {
            ZStack {
                VStack(spacing: 40) {
                    VStack(spacing: 5) {
                        Text("Hue")
                        
                        Slider(value: $hue, in: 0.0 ... 1.0) {
                            Text("Hue adjustment slider")
                        } minimumValueLabel: {
                            Text("0.0")
                        } maximumValueLabel: {
                            Text("1.0")
                        }
                        .tint(Color("LinkYellow"))
                    }
                    
                    VStack(spacing: 5) {
                        Text("Saturation")
                        
                        Slider(value: $sat, in: 0.0 ... 1.0) {
                            Text("Saturation adjustment slider")
                        } minimumValueLabel: {
                            Text("0.0")
                        } maximumValueLabel: {
                            Text("1.0")
                        }
                        .tint(Color("LinkYellow"))
                    }
                    
                    VStack(spacing: 5) {
                        Text("Brightness")
                        
                        Slider(value: $bright, in: 0.0 ... 1.0) {
                            Text("Brightness adjustment slider")
                        } minimumValueLabel: {
                            Text("0.0")
                        } maximumValueLabel: {
                            Text("1.0")
                        }
                        .tint(Color("LinkYellow"))
                    }
                    
                    Button("Reset") {
                        print("Reset")
                        withAnimation {
                            hue = 0.522
                            sat = 0.72
                            bright = 0.81
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color("PopupButtonBackground")))
                }
                .minimumScaleFactor(0.6)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .linkFormat()
                            .padding()
                            .popupLink {
                                InfoPopupView {
                                    Text("SwiftUI's Slider doesn't seem to work well with this package, and after looking around on the internet, this seems to possibly be a bug with Slider itself. PopupManager intercepts all touches to keep track of the most recent touch location(this is necessary for some functions such as ad hoc popup presentation) before passing those touches to the enclosed views. So far this seems to work fine for everything except Slider. Therefore, the package includes PMSlider, which is made to be as close to the built-in slider as possible. Existing sliders should work as is just by importing PopupManager and putting 'PM' in front of the Slider declaration. Custom built sliders should also work fine.")
                                }
                            }
                    }
                }
            }
        }
    }
}

