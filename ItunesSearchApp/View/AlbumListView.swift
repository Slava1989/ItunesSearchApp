//
//  AlbumListView.swift
//  ItunesSearchApp
//
//  Created by Veaceslav Chirita on 07.08.2022.
//

import SwiftUI

struct AlbumListView: View {

    @ObservedObject var viewModel: AlbumListViewModel

    var body: some View {

        List {
            ForEach(viewModel.albums) { album in
                Text(album.collectionName)
            }

            switch viewModel.state {
                case .good:
                    Color.clear
                        .onAppear {
                            viewModel.loadMore()
                        }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
            }
        }
        .listStyle(.plain)

    }
}
