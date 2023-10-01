//
//  AdHocLinkView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI
import PopupManager

struct AdHocView: View {
    @Environment(\.adHocPopup) var adHoc
    
    
    @State private var currentTouch = CGPoint.zero
    @State private var isDragging = false
    
    let adHodCodeBlock =
"""
@Environment(\\.adHocPopup) var adHoc
...
adHoc(0.6, 0.6, true, .fromTop, {
    PopupView {
        AlertPopup()
    }
}, {})
"""
    
    var text = {
        if var txt = try? AttributedString(markdown:
"""
Ad hoc popup can be created by using the [adHocPopup](popup1) Environment Value. Because Swift currently doesn't allow argument labels or default values for parameters in closures ([SE-0111](https://github.com/apple/swift-evolution/blob/main/proposals/0111-remove-arg-label-type-significance.md)), the [code](popup4) for ad hoc popups is not very pretty. It does, however, allow a popup to be activated by a function call or system event. One use is to create [in-line links](popup2) using AttributedString and accessing the openURL environment value to intercept the link and open a [popup](popup3).
""") {
            var linkRange = txt.range(of: "adHocPopup")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "code")
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
                adHoc(0.75, 0.75, true, .fromRect, {
                Text("One tapped")
            }, {})
                return .handled
            case "link2":
                adHoc(0.75, 0.75, true, .fromRect, {
                Text("Two tapped")
            }, {})
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
                        adHoc(0.85, 0.6, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                VStack {
                                    CodeBlock(text: "public typealias AdHocPopup = (CGFloat, CGFloat, Bool, @escaping () -> any View, () -> ()) -> ()")
                                        .minimumScaleFactor(0.4)
                                 
                                    Text("The parameters corespond to 'widthMultiplier, heightMultiplier, touchOutsideDismisses, the popup closure itself, and th onDismiss callback closure. No 'PopupLink' is involved, there is no parameter to define one.")
                                }
                            }
                        }, {})
                        return .handled
                    case "popup2":
                        adHoc(0.85, 0.95, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                CodeBlock(text: openUrlExample)
                                    .minimumScaleFactor(0.5)
                                    
                            }
                        }, {})
                        return .handled
                    case "popup3":
                        adHoc(0.5, 0.5, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                Text("Since ad hoc popups don't have a specific link, there is no view center to animate from. Therefore, setting presentaionMode to either .fromPoint or .fromRect has the .fromPoint behavior.")
                            }
                        }, {})
                        return .handled
                    case "popup4":
                        adHoc(0.5, 0.5, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                VStack {
                                    CodeBlock(text: adHodCodeBlock)
                                    Text("Even if no 'onDismiss' callback is set, an empty closure must be provided as the final argument.")
                                }
                            }
                        }, {})
                        return .handled
                    default:
                        return .systemAction
                    }
                })
                .tint(Color("LinkYellow"))
                .adHocTouchTracker(touchLocation: $currentTouch)
        }
        
    }
}

