//
//  PhotosScreen.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import SwiftUI
import Kingfisher

struct PhotosScreen: View {
    @ObservedObject private var viewModel: PhotosViewModel

    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                
                ForEach(viewModel.photos) { photo in
                    PhotoView(photo: photo)
                }
                
                if let error = viewModel.error {
                    ErrorRetryView(
                        description: error.localizedDescription,
                        action: onErrorRetry
                    )
                }
                
                if viewModel.hasMore {
                    progressView
                }
            }
            .padding()
        }
        .refreshable {
            /// has added task since there is an issue where async task is killed in iOS 16.4
            Task {
                await viewModel.refresh()
            }
        }
        .navigationTitle("Photos")
    }

    private func onErrorRetry() {
        Task {
            await viewModel.getPhotos()
        }
    }
}

// MARK: - SubViews
extension PhotosScreen {
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .onAppear {
                Task {
                    await viewModel.getPhotos()
                }
            }
            .frame(maxWidth: .infinity)
    }
}

struct PhotoView: View {
    let photo: Photo

    var body: some View {
        NavigationLink(value: photo) {
            VStack(alignment: .leading, spacing: 8) {
                KFImage(URL(string: photo.url))
                    .resizable(resizingMode: .stretch)
                    .frame(height: 150)
                VStack(alignment: .leading, spacing: 4) {
                    Text(photo.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(photo.description)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.black)
                Divider()
            }
        }
        .buttonStyle(.borderless)
    }
}

struct PhotosScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotosScreen(
            viewModel: .init(
                photosService: PhotosServicePreview()
            )
        )
    }
}
