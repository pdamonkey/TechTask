//
//  CachedAsyncImage.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL

    var body: some View {
        if let cachedImage {
            Image(uiImage: cachedImage)
                .resizable()
        } else {
            AsyncImage(url: url) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
                    .frame(width: 30, height: 30)
                    .progressViewStyle(.circular)
                    .tint(.gray)
                    .task {
                        await storeCachedImage()
                    }
            }
        }
    }

    private var cachedImage: UIImage? {
        let urlRequest = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) else { return nil }

        return UIImage(data: cachedResponse.data)
    }

    private func storeCachedImage() async {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let cachedResponse = CachedURLResponse(response: response, data: data)
            let urlRequest = URLRequest(url: url)
            URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CachedAsyncImage(url: URL(string: "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/7A6E0452-E3F3-4FE7-A645-88D8A6B3DFA6-richie-flores.jpg")!)
        .frame(width: 30, height: 30)
        .clipShape(.circle)
        .padding()
}
