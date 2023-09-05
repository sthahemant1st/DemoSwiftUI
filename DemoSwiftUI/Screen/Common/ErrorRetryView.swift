//
//  ErrorRetryView.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import SwiftUI

struct ErrorRetryView: View {
    let title: String
    let description: String
    let actionText: LocalizedStringKey
    let action: VoidFunction

    init(
        title: String = "Error!",
        description: String,
        actionText: LocalizedStringKey = "Retry",
        action: @escaping VoidFunction
    ) {
        self.title = title
        self.description = description
        self.actionText = actionText
        self.action = action
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.red)

            Text(title)
                .font(.body)
                .fontWeight(.bold)

            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .lineSpacing(8)

            Button(action: action) {
                Text("Retry")
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)

        }
        .padding(.all, 16)
    }
}

struct ErrorRetryView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorRetryView(
            description: "This the description for error",
            actionText: "Retry",
            action: {}
        )
    }
}
