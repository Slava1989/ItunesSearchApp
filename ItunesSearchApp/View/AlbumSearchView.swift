//
//  AlbumSearchView.swift
//  ItunesSearchApp
//
//  Created by Veaceslav Chirita on 21.08.2022.
//

import SwiftUI

struct AlbumPlaceholderView: View {
    @Binding var searchTerm: String

    let suggestons = ["rammstein", "cry to me", "maneskin"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestons, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }
            }
        }
    }
}

struct AlbumSearchView: View {
    @StateObject var viewModel = AlbumListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.searchTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
