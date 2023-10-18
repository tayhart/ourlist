//
//  LoginView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(
                    title: "Our List",
                    subtitle: "Get things done - together",
                    angle: 15,
                    backgroundColor: .yellow)
                
                //Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }

                    TextField("Email address", text: $viewModel.email)
                        .textFieldStyle(.automatic)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.automatic)

                    OLButton(
                        title: "Login",
                        background: .blue) {
                            viewModel.login()
                    }
                    .padding()
                }
                .offset(y: -50)

                //Create account
                VStack{
                    Text("New around here?")
                    NavigationLink("Create an account",
                                   destination: RegistrationView())
                }


                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
