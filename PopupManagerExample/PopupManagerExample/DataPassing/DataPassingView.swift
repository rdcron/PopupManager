//
//  DataPassingView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/24/23.
//

import SwiftUI

struct DataPassingView: View {
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/DataPassing/DataPassingView.swift**"
    
    @State private var nextLinkHue = 0.165
    
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
                
                Text("Since popup views are normal view, the same strategies used for passing data in other SwiftUI views can be applied here. For example, the folling link opens a popup with a slider which alters the hue of the 'Next Page' link at the bottom of the page.")
                
                Text("Adjust Hue")
                    .linkFormat()
                    .popupLink(widthMultiplier: 0.3, heightMultiplier: 0.3) {
                        HueAdjustView(hue: $nextLinkHue)
                    }
                
                Spacer()
                
                NavigationLink {
                    Page2View()
                } label: {
                    Text("Next Page")
                        .underline()
                        .foregroundColor(Color(hue: nextLinkHue, saturation: 0.5, brightness: 1.0))
                }
            }
        }
    }
}
