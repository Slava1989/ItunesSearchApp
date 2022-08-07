//
//  AlbumListView.swift
//  ItunesSearchApp
//
//  Created by Veaceslav Chirita on 07.08.2022.
//

import SwiftUI

struct AlbumListView: View {

    @StateObject var viewModel = AlbumListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.albums) { album in
                Text(album.collectionName)
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
