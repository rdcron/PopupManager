//
//  ViewModifierPLView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/22/23.
//

import SwiftUI

struct ViewModifierPLView: View {
    let codeBlock = """
Image(systemName: "rectangle.portrait.and.arrow.forward")
    .resizable()
    .frame(width: 50, height: 50)
    .popupLink(widthMultiplier: 0.3, heightMultiplier: 0.4) {
        DocumentExportView()
    }
"""
    
    var body: some View {
        PopupView {
            VStack {
                Text("A 'PopupLink()' can be applied to a view as a view modifier:")
                CodeBlock(text: codeBlock)
                Text("This example will place the SF Symbol \"rectangle.portrait.and.arrow.forward\", and set it as a popupLink label which will open the 'DocumentExportView()'.")
            }
        }
    }
}

struct ViewModifierPLView_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierPLView()
    }
}
