//
//  IntroView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI
import PopupManager

struct IntroView: View {
    var body: some View {
        CellView {
            VStack {                
                Text("Welcome to PopupManager! This package adds a new kind of modal view to SwiftUI, allowing you to define a link which also serves as the animation origin of your popup.")
//                    .multilineTextAlignment(.leading)
//                    .foregroundColor((Color("DarkText")))
//                    .padding()
                
                Text("Try it out!")
                    .linkFormat()
                    .popupLink(heightMultiplier: 0.6) {
                        IntroPopup()
                    }
            }
        }
    }
}

