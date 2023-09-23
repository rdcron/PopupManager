//
//  BasicsView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI
import PopupManager

struct BasicsView: View {
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Basics/BasicsView.swift**"
    
    var body: some View {
        CellView(infoText: infoText) {
            VStack {
                HStack {
                    Text("The Basics")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkText"))
                        .padding()
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {

                        PopupLink(widthMultiplier: 0.65, heightMultiplier: 0.7) {
                            PMPopup()
                        } label: {
                            Text("PopupManager()")
                                .linkFormat()
                        }

                        PopupLink(widthMultiplier: 0.9, heightMultiplier: 0.9) {
                            PLPopup()
                        } label: {
                            Text("PopupLink()")
                                .linkFormat()
                        }
                        
                    }
                    .padding(.leading, 40)
                    
                    Spacer()
                }
            }

        }
    }
}

struct BasicsView_Previews: PreviewProvider {
    static var previews: some View {
        BasicsView()
    }
}
