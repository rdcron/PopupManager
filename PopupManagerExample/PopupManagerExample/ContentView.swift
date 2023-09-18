//
//  ContentView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/17/23.
//

import PopupManager
import MarkdownUI
import SwiftUI

struct ContentView: View {
    let mdText = """
```Swift
func test() -> String {
    return "Hi"
}
"""
    
    var body: some View {
        PopupManager {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .popupLink {
                        Markdown(mdText)
                    }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
