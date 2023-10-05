//
//  ClearStackTwo.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI

struct ClearStackTwo: View {
    @Environment(\.clearPopupStack) var clearStack
    
    let codeBlock = """
struct PopupView: View {
    @Environment(\\.clearPopupStack) var clearStack
    var body: some View {
        Image(systemName: "x.circle")
            .resizeable()
            .frame(width: 30, height: 30)
            .onTapGesture {
                clearStack()
            }
    }
}
"""
    
    var body: some View {
        PopupView {
            ZStack {
                VStack {
                    Text("Tapping the 'X' button in the upper-right corner will dismiss all active popups. This code is similar to dismissing just the top popup.")
                        .padding()
                    
                    CodeBlock(text: codeBlock)
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                clearStack()
                            }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ClearStackTwo_Previews: PreviewProvider {
    static var previews: some View {
        ClearStackTwo()
    }
}
