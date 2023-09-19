//
//  IntroPopup.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI

struct IntroPopup: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("PopupBackground"))
            
            VStack {
                Text("A popup will expand to a size realative to it's parent PopupManager. The default size (0.75 of both width and height) can be customized.")
                    .foregroundColor(Color("AppBackground"))
                    .padding()
                
                Text("By default, popups are dismissed by tapping outside the popup itself. This behavior can be blocked, and alternate methods of dismissing popups are available.")
                    .foregroundColor(Color("AppBackground"))
                    .padding()
            }
        }
    }
}

struct IntroPopup_Previews: PreviewProvider {
    static var previews: some View {
        IntroPopup()
    }
}
