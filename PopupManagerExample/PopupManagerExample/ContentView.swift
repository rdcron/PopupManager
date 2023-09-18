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
```
"""
    
    var body: some View {
        GeometryReader { geo in
            PopupManager {
                VStack {
                    PopupLink("Test") {
                        Markdown(mdText)
                            .markdownTheme(.gitHub)
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
