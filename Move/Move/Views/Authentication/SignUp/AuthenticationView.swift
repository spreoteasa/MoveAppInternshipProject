//
//  AuthenticationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//
import Foundation
import SwiftUI
import SwiftMessages
struct AuthenticationView: View {
    @ObservedObject var viewModel: UserViewModel
    let onFinished: () -> Void
    
    var body: some View {
        ZStack {
            AuthenticationBackground()
            GeometryReader { g in
                ScrollView {
                    VStack(alignment: .leading){
                        Image("SmallLogoWhite")
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Let's get started")
                                .font(Font.baiJamjuree.heading1)
                                .foregroundColor(.white)
                            Text("Sign up or login and start riding right away")
                                .font(Font.baiJamjuree.heading2)
                                .foregroundColor(.white)
                                .opacity(0.3)
                            VStack(spacing: 30) {
                                
                                VStack(spacing: 20) {
                                    FloatingTextField(title: "Email", isSecured: false, isPasswordField: false, text: $viewModel.user.email, icon: "clear-text")
                                        .font(Font.baiJamjuree.caption2)
                                    FloatingTextField(title: "Username", isSecured: false, isPasswordField: false, text: $viewModel.user.name, icon: "")
                                        .font(Font.baiJamjuree.caption2)
                                    FloatingTextField(title: "Password", isSecured: true, isPasswordField: true, text: $viewModel.user.password, icon: "eye-closed")
                                        .font(Font.baiJamjuree.caption2)
                                }
                                VStack(alignment: .leading, spacing: 2){
                                    Text("By continuing you agree to Move's")
                                        .font(Font.baiJamjuree.smallText)
                                        .foregroundColor(.white)
                                    termsAndConditions
                                }.frame(maxWidth: .infinity)
                                Button() {
                                    self.viewModel.authenticate()
                                } label: {
                                    Text("Get started!")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.filledButton)
                                .disabled(fieldsAreFilled() ? false : true)
                                .animation(.default, value: fieldsAreFilled())
                                logInText
                                //                                Spacer()
                            }
                        }
                    }
                    .padding()
                    
                }
            }
        }
        
    }
    
    
    var logInText: some View {
        HStack(spacing: 0) {
            Text("You already have an account? You can")
                .font(Font.baiJamjuree.smallText)
                .foregroundColor(.white)
            Button {
                onFinished()
            } label: {
                
                
                Text(" log in here")
                    .underline()
                    .font(Font.baiJamjuree.smallText)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .accentColor(.white)
                
            }
            
        }.frame(maxWidth: .infinity)
        
    }
    
    var termsAndConditions: some View {
        HStack(spacing: 0) {
            Text("[Terms and Conditions](https://tapptitude.com)")
                                            .underline()
                                            .font(Font.baiJamjuree.smallText.bold())
                                            .accentColor(.neutralWhite)
                                        
                                        Text(" and ")
                                            .foregroundColor(.neutralWhite)
                                            .font(Font.baiJamjuree.smallText)
                                        
                                        Text("[Privacy Policy](https://tapptitude.com)")
                                            .underline()
                                            .accentColor(.neutralWhite)
                                            .font(Font.baiJamjuree.smallText
                                                .bold())

        }.padding(.trailing, 82)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity)
            .minimumScaleFactor(0.01)
            .navigationBarHidden(true)
        
    }
    
    func fieldsAreFilled() -> Bool {
        return self.viewModel.user.email != "" && self.viewModel.user.password != "" && self.viewModel.user.name != ""
    }
    
//    func showError() {
//        let view = MessageView.viewFromNib(layout: .cardView)
//        view.configureTheme(.warning)
//
//        view.configureDropShadow()
//
//        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
//        view.configureContent(title: "Something went wrong", body: "User already exists", iconText: iconText)
//
//        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//
//        // Reduce the corner radius (applicable to layouts featuring rounded corners).
//        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
//
//        // Show the message.
//        SwiftMessages.show(view: view)
//    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthenticationView(viewModel: UserViewModel(), onFinished: {})
                .previewInterfaceOrientation(.portrait)
            AuthenticationView(viewModel: UserViewModel(), onFinished: {})
                .previewInterfaceOrientation(.portrait)
        }
    }
}