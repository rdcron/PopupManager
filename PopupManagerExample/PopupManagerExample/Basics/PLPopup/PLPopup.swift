//
//  PLPopup.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/21/23.
//

import SwiftUI
import PopupManager

struct PLPopup: View {
    var body: some View {
        PopupView(infoText: "_Code for these links can be found in:_\n**/Basics/PLPopup/PLPopup.swift**") {
            VStack {
                Text("'PopupLink()' designates a tappable label view and provides a closure for the popup activated by that label. The primary initializer for 'PopupLink()' is:")
                CodeBlock(text: "public init(widthMultiplier:heightMultiplier:touchOutsideDismisses:animationSource:popup:label:)")
                
                Text("Parameter descriptions")
                    .linkFormat()
                    .popupLink(widthMultiplier: 0.6, heightMultiplier: 0.6) {
                        ParamDetailsView()
                    }
                
                Text(" In addition to the 'PopupLink()' format shown in the 'PopupManager()' example above, there are two more methods of declaring a 'PopupLink()'. All methods ultimately call the primary initializer and have access to the same parameters, though not necessarily in the same order.")
                
                PopupLink(widthMultiplier: 0.55, heightMultiplier: 0.55, "Text-Shortcut") {
                    TextShortcutPLView()
                }
                .linkFormat()
                
                Text("View Modifier")
                    .linkFormat()
                    .popupLink(heightMultiplier: 0.6) {
                        ViewModifierPLView()
                    }
                
                Text("_Since 'PopupManager' is stack-based, popup views can contain their own 'PopupLink()s' which open new popup views._")
                    .font(.system(size: 22))
            }
            .padding()
        }
    }
}

struct PLPopup_Previews: PreviewProvider {
    static var previews: some View {
        PLPopup()
    }
}
