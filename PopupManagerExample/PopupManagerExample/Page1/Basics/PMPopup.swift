//
//  PMPopup.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/19/23.
//

import SwiftUI
import MarkdownUI

struct PMPopup: View {
    let codeBlock =
    """
PopupManager {
    PopupLink {
        RoundedRectangle(cornerRadius: 20)
            .fill(.blue)
    } label: {
        Text("Blue Rectangle")
}
"""
    
    var body: some View {
        PopupView {
            VStack {
                Text("PopupManager() is a View that wraps some content view. Within the PopupManager, PopupLink()s can be used to set a link and provide it with a closure that defines the popup.")
                    .padding()
                
                    CodeBlock(text: codeBlock)

                
                Text("The example above will place the tappable text\"Blue Rectangle\" which, when tapped, will trigger a blue RoundedRectangle popup.")
                    .padding()
            }
        }
    }
}

struct PMPopup_Previews: PreviewProvider {
    static var previews: some View {
        PMPopup()
    }
}
