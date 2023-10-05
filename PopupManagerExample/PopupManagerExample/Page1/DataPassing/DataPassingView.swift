//
//  DataPassingView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct DataPassingView: View {
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/DataPassing/DataPassingView.swift**"
    
    @State private var borderHue = 0.522
    @State private var borderSat = 0.72
    @State private var borderBright = 0.81
    
    var body: some View {
        CellView(infoText: infoText) {
            VStack {
                HStack {
                    Text("Passing Data")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkText"))
                        .padding()
                    Spacer()
                }
                
                Text("Since popup views are normal views, the same strategies used for passing data in other SwiftUI views can be applied here. For example, the following link opens a popup that adjusts the color this cell's border.")
                
                Text("Adjust Color")
                    .linkFormat()
                    .popupLink(widthMultiplier: 0.3, heightMultiplier: 0.6) {
                        HueAdjustView(hue: $borderHue, sat: $borderSat, bright: $borderBright)
                    }
                
               
                
               
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 21).stroke(Color(hue: borderHue, saturation: borderSat, brightness: borderBright), lineWidth: 10))
    }
}
