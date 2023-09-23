//
//  CodeBlock.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/21/23.
//

import SwiftUI
import Splash

struct CodeBlock: View {
    let text: String
    
    var body: some View {
        Text(highlightText(text))
            .padding()
            .background(Color("AppBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }

    
    func highlightText(_ input: String) -> AttributedString {
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: .presentation(withFont: .init(size: 24))))
        return AttributedString(highlighter.highlight(input))
    }
}

struct CodeBlock_Previews: PreviewProvider {
    static var previews: some View {
        CodeBlock(text: "Test")
    }
}
