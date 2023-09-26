//
//  AdHocLinkView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI
import PopupManager

struct AdHocLinkView: View {
    @Environment(\.adHocPopup) var adHoc
    var text = {
        if var txt = try? AttributedString(markdown:
"""
Ad hoc links can be created by using the [adHocPopup](popup1) Environment Value. This allows a popup to be activated by a function call or system event. One use is to create [in-line links](popup2) using AttributedString and accessing the openURL environment value to intercept the link and open a [popup](popup3).
""") {
            var linkRange = txt.range(of: "adHocPopup")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "in-line links")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "popup.")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            return txt
        } else {
            return ""
        }
    }
    
    var openUrlExample: String =
"""
@Environment(\\.adHocPopup) var adHoc
var inlineLinks = {
    if let txt = try? AttributedString(markdown:
\"\"\"
Here's a [link](link1), and here's another [link](link2).
\"\"\") {
            return txt
    } else {
        return \"\"
    }
}

var body: some View {
    Text(text())
        .environment(\\.openURL, OpenURLAction { url in
            switch url.absolutString {
            case "link1":
                adHoc(0.75, 0.75, true) {
                    Text("One tapped")
                }
                return .handled
            case "link2":
                adHoc(0.75, 0.75, true) {
                    Text("Two tapped")
                }
                return .handled
            default:
                return .discarded // or .systemAction to forward an unhandled url
            }
        }
}
"""
    
    var body: some View {
        PopupView {
            Text(text())
                .environment(\.openURL, OpenURLAction { url in
                    switch url.absoluteString {
                    case "popup1":
                        adHoc(0.85, 0.6, true, .fromPoint) {
                            PopupView {
                                VStack {
                                    CodeBlock(text: "public typealias AdHocPopup = (CGFloat, CGFloat, Bool, @escaping () -> any View) -> ()")
                                        .minimumScaleFactor(0.4)
                                 
                                    Text("The parameters corespond to 'widthMultiplier, heightMultiplier, touchOutsideDismisses, and the popup closure itself.")
                                }
                            }
                        }
                        return .handled
                    case "popup2":
                        adHoc(0.85, 0.95, true, .fromPoint) {
                            PopupView {
                                CodeBlock(text: openUrlExample)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                        return .handled
                    case "popup3":
                        adHoc(0.5, 0.5, true, .fromPoint) {
                            PopupView {
                                Text("Currently, there is no way to animate from the tap location when using an ad hoc popup. These popups simply animate from the center of the PopupManager.")
                            }
                        }
                        return .handled
                    default:
                        return .discarded
                    }
                })
                .tint(Color("LinkYellow"))
        }
    }
}

