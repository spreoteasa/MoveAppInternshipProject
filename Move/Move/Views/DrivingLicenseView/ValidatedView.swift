//
//  ValidatedView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.08.2022.
//

import SwiftUI

struct ValidatedView: View {
    let onFinished:() -> Void
    var body: some View {
        ZStack {
            AuthenticationBackground()
            VStack(spacing: 67) {
                Spacer()
                Image("CheckmarkBig")
                Text("We've succesfully validated your driving license")
                    .font(Font.baiJamjuree.heading1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.neutralWhite)
                    .padding(.horizontal, 24)
                Spacer()
                Button() {
                    print("Touched!")
                } label: {
                    Text("Find scooters")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.filledButton)
                .disabled(false)
                .animation(.default)
                .padding(.horizontal, 24)
            }
        }
        
    }
}

struct ValidatedView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatedView(onFinished: {})
    }
}