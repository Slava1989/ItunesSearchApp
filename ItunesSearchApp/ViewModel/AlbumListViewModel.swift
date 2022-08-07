//
//  AlbumListViewModel.swift
//  ItunesSearchApp
//
//  Created by Veaceslav Chirita on 05.08.2022.
//

import Foundation
import Combine

//https://itunes.apple.com/search?term=jack+johnson&entity=album&limt=7
//https://itunes.apple.com/search?term=jack+johnson&entity=song
//https://itunes.apple.com/search?term=jack+johnson&entity=movie

class AlbumListViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var albums: [Album] = []

    let limit: Int = 20

    var subscribtions = Set<AnyCancellable>()

    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.fetchAlbums(for: term)
        }.store(in: &subscribtions)
    }

    func fetchAlbums(for searchTerm: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limt=limit") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("url session error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        self.albums = result.results
                    }

                } catch {
                    print("decoding error \(error)")
                }

            }
        }.resume()
    }


}
