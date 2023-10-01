//
//  PresentationModeView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/27/23.
//

import SwiftUI
import PopupManager

struct PresentationModeView: View {
    let poWidth = 0.3
    let poHeight = 0.3
    
    @State var currentTouch = CGPoint.zero
    
    var body: some View {
        PopupView {
            VStack(alignment: .leading) {
                Text("The 'presentationMode' parameter used in all methods of creating a popup view determines how the popup appears and is dismissed. The cases for the PresentationMode enum are:")
                Group {
                    Text("  .fromPoint")
                        .padding(30)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromPoint) {
                            PopupView {
                                Text("From touch point")
                            }
                        }
                    Text("  .fromRect")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromRect) {
                            PopupView {
                                Text("From the center of label view")
                            }
                        }
                    Text("  .fromBottom")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromBottom) {
                            PopupView {
                                Text("From the bottom of the root PopupManager")
                            }
                        }
                    Text("  .fromTop")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromTop) {
                            PopupView {
                                Text("From the top of the root PopupManager")
                            }
                        }
                    Text("  .fromLeading")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromLeading) {
                            PopupView {
                                Text("From the leading edge of the root PopupManager")
                            }
                        }
                    Text("  .fromTrailing")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromTrailing) {
                            PopupView {
                                Text("From the trailing edge of the root PopupManager")
                            }
                        }
                    Text("  .fromCenter")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromCenter) {
                            PopupView {
                                Text("From the center of the root PopupManager")
                            }
                        }
                    Text("  .fromProvided(point:)")
                        .popupLink(widthMultiplier: poWidth, heightMultiplier: poHeight, presentationMode: .fromProvided(point: CGPoint(x: 0, y: 0))) {
                            PopupView {
                                Text("From a point provided by the call, in this case the upper-left corner. Used mostly for ad hoc popups when no link is available.")
                            }
                        }
                }
                .linkFormat()
            }
            .adHocTouchTracker(touchLocation: $currentTouch)
        }
    }
    
//    @Environment(\.adHocPopup) var adHoc
//
//    var text = {
//        if var txt = try? AttributedString(markdown:
//"""
//The 'presentationMode' parameter used in all methods of creating a popup view determines how the popup appears and is dismissed. The cases for the PresentationMode enum are:
//    [.fromPoint](popup1)
//    [.fromRect](popup2)
//    [.fromBottom](popup3)
//    [.fromTop](popup4)
//    [.fromLeading](popup5)
//    [.fromTrailing](popup6)
//    [.fromCenter](popup7)
//
//The default for PopupLinks is .fromRect, and for ad hoc popups .fromPoint(.fromRect and .fromPoint both behave like .fromPoint since there is no label to animate from, such as in this view). All presentations are in relation to the enclosing PopupManager.
//""", options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
//        ) {
//            var linkRange = txt.range(of: ".fromPoint")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromRect")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromBottom")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromTop")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromLeading")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromTrailing")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            linkRange = txt.range(of: ".fromCenter")
//            txt[linkRange!].underlineStyle = Text.LineStyle.single
//            return txt
//        } else {
//            return ""
//        }
//    }
//
//    var body: some View {
//        PopupView {
//            Text(text())
//                .padding()
//                .environment(\.openURL, OpenURLAction { url in
//                    switch url.absoluteString {
//                    case "popup1":
//                        presentPopup("From tap point", mode: .fromPoint)
//                        return .handled
//                    case "popup2":
//                        presentPopup("(In this context, this is the same as .fromPoint. In a PopupLink, the animation would appear from the center of the label.", mode: .fromRect)
//                        return .handled
//                    case "popup3":
//                        presentPopup("From the bottom of the PopupManager", mode: .fromBottom)
//                        return .handled
//                    case "popup4":
//                        presentPopup("From the top of the PopupManager", mode: .fromTop)
//                        return .handled
//                    case "popup5":
//                        presentPopup("From the leading edge", mode: .fromLeading)
//                        return .handled
//                    case "popup6":
//                        presentPopup("From the trailing edge", mode: .fromTrailing)
//                        return .handled
//                    case "popup7":
//                        presentPopup("From the center of the PopupManager", mode: .fromCenter)
//                        return .handled
//                    default:
//                        return .systemAction
//                    }
//                })
//                .tint(Color("LinkYellow"))
//        }
//    }
//
//    func presentPopup(_ title: String, mode: PopupPresentationMode) {
//        adHoc(0.3, 0.3, true, mode, {
//            PopupView {
//                Text(title)
//            }
//        }, {})
//    }
}

