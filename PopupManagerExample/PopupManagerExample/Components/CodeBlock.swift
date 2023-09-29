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
    
    @State var blockSize = CGSize.zero
    
    var body: some View {
        ZStack {
            Text(highlightText(text))
                .padding()
                .padding()
                .background( GeometryReader { geo in
                    Color("AppBackground")
                        .preference(key: CodeWidthKey.self, value: geo.size)
                }
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onPreferenceChange(CodeWidthKey.self) { newVal in
                    blockSize = newVal
                }
                
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(Color("DarkText"))
                        .frame(maxWidth: 25, maxHeight: 25)
                        .padding()
                        .foregroundColor(Color("LinkYellow"))
                        .popupLink(widthMultiplier: 0.4, heightMultiplier: 0.4) {
                            InfoPopupView {
                                Text("Text highlighting is provided by John Sundell's 'Splash' Swift package.")
                            }
                        }
                }
                .frame(width: blockSize.width)
            }
            .frame(height: blockSize.height)
        }

        
    }

    
    func highlightText(_ input: String) -> AttributedString {
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: .presentation(withFont: .init(size: 24))))
        return AttributedString(highlighter.highlight(input))
    }
}

struct CodeWidthKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
