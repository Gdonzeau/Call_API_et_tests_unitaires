//
//  ContentView.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private var search = ""
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    AppColors.contentViewBackgroundColor.ignoresSafeArea()
                    ScrollView {
                        VStack {
                            if let articles = viewModel.articles {
                                ForEach(articles, id: \.self) { article in
                                    Card(article: article)
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                    .navigationTitle("Recherche d'articles")
                }
            }
            .searchable(text: $search, prompt: "Entrez vos mots clés")
            .onSubmit(of: .search) {
                viewModel.gettingUrl(search: search)
                Task {
                    do {
                        viewModel.gettingUrl(search: search)
                        if !viewModel.isError {
                            try await viewModel.getNews()
                        }
                    } catch let error {
                        print("Erreur : \(error)")
                    }
                }
            }
            .alert(viewModel.error?.failureReason ?? "Erreur", isPresented: $viewModel.isError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.error?.errorDescription ?? "Une erreur est survenue")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
