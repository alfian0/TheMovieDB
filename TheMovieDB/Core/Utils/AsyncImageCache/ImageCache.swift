//
//  ImageCache.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import UIKit
import SwiftUI
import Combine

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(url: URL) -> UIImage? {
        get { cache.object(forKey: url as NSURL) }
        set {
          newValue == nil ? cache.removeObject(forKey: url as NSURL) : cache.setObject(newValue!, forKey: url as NSURL)
        }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL
    private var cache: ImageCache
    private var cancellable: AnyCancellable?

    init(url: URL, cache: ImageCache) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancellable?.cancel()
    }

    func load() {
        if let cachedImage = cache[url] {
            self.image = cachedImage
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
                if let image = $0 {
                    self?.cache[self!.url] = image
                }
            }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    init(url: URL,
         cache: ImageCache,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
        self.placeholder = placeholder()
        self.image = image
        _loader = ObservedObject(wrappedValue: ImageLoader(url: url, cache: cache))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var content: some View {
        Group {
            if let uiImage = loader.image {
                image(uiImage)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
