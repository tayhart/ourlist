//
//  RegistrationView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {
            // Header
            HeaderView(
                title: "Register",
                subtitle: "Start organizing",
                angle: -15,
                backgroundColor: .orange)
            
            // Registration Form
            Form {
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.automatic)
                    .autocorrectionDisabled()
                TextField("Email address", text: $viewModel.email)
                    .textFieldStyle(.automatic)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.automatic)

                OLButton(
                    title: "Create account",
                    background: .green
                ) {
                        viewModel.register()
                }
                    .padding()
            }
            .offset(y: -50)


            Spacer()
        }
    }
}

#Preview {
    RegistrationView()
}
