//
//  IntroPopup.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI

struct IntroPopup: View {
    var body: some View {
        PopupView {
            GeometryReader { geo in
                let textWidth = geo.size.width * 0.9
                VStack {
                    Spacer()
                    
                    Text("A popup will expand to a size realative to it's parent PopupManager. The default size (0.75 of both width and height) can be customized. Both width and height multiplier parameters are clamped between 0.1 and 1.0.")
                        .frame(maxWidth: textWidth)
                        .padding(.bottom)
                    
                    Text("By default, tapping outside the popup itself will dismiss it. This behavior can be blocked, and alternate methods of dismissing popups will be covered in later sections.")
                        .frame(maxWidth: textWidth)
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

struct IntroPopup_Previews: PreviewProvider {
    static var previews: some View {
        IntroPopup()
    }
}
