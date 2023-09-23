//
//  DismissEnvKeyView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI

struct DismissEnvKeyView: View {
    @Environment(\.popupDismiss) var dismiss
    
    let codeBlock = """
struct PopupView: View {
    @Environment(\\.popupDismiss) var dismiss
    var body: some View {
        Image(systemName: "x.circle")
            .resizeable()
            .frame(width: 30, height: 30)
            .onTapGesture {
                dismiss()
            }
    }
}
"""
    var body: some View {
        PopupView {
            ZStack {
                VStack {
                    Text("Tapping outside this popup won't dismis it. Instead, the Environment Value popupDismiss is called when the 'X' button in the upper-right corner of this view is tapped. The code for setting this up looks like this:")
                    
                    CodeBlock(text: codeBlock)
                    
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct DismissEnvKeyView_Previews: PreviewProvider {
    static var previews: some View {
        DismissEnvKeyView()
    }
}
