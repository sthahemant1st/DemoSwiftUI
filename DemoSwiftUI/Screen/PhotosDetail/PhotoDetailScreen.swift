//
//  PhotosDetailScreen.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import SwiftUI
import Kingfisher

struct PhotoDetailScreen: View {
    @StateObject private var viewModel: PhotosDetailsViewModel

    init(viewModel: PhotosDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack {
                PhotoView(photo: viewModel.photo)

                if let user = viewModel.user {
                    userView(user)
                }
            }
            .padding()
        }
        .navigationTitle("Photo Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getPhotoUser()
        }
    }
}

private extension PhotoDetailScreen {
    func userView(_ user: User) -> some View {
        VStack(alignment: .leading) {
            Text("Posted By:")
                .font(.body)
                .bold()
            HStack {
                KFImage(URL(string: user.profilePicture))
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            Text("\(user.firstName) \(user.lastName)")
                .font(.body)
                .fontWeight(.bold)
            Text(user.email)
            Text(user.phone)
            Text(user.gender)
                .padding(.bottom, 8)

            VStack(alignment: .leading, spacing: 6) {
                Text("Address: \(user.street), \(user.city), \(user.state), \(user.country)")
                Text("Job: " + user.job)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
struct PhotoDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailScreen(
            viewModel: .init(
                userService: UserServicePreview(),
                photo: .dummy
            )
        )
    }
}
