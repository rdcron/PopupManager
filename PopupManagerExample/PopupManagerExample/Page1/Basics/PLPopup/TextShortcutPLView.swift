//
//  TextShortcutPLView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/21/23.
//

import SwiftUI

struct TextShortcutPLView: View {
    let codeBlock = """
PopupLink("Text-Shorcut Example") {
    RoundedRectangle(cornerRadius: 15)
        .fill(.green)
}
.font(.largeTitle)
"""
    
    var body: some View {
        PopupView {
            VStack {
                Text("This initializer is useful when the label is text.")
                CodeBlock(text: codeBlock)
                Text("Text formatting viewModifiers can be applied to the 'PopupLink()'.")
            }
        }
    }
}

struct TextShortcutPLView_Previews: PreviewProvider {
    static var previews: some View {
        TextShortcutPLView()
    }
}
