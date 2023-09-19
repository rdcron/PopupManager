//
//  BasicsView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/18/23.
//

import SwiftUI

struct BasicsView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CellBackground"))
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
                    VStack {
                        Text("PopupManager()")
                            .linkFormat()
                    }
                    .padding(.leading)
                    
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
