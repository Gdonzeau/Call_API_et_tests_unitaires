//
//  ArticleView.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @State private var showSafari: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(article.title ?? DefaultData.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Text("Écrit par : \(article.author ?? article.source?.name ?? DefaultData.author)")
                    .padding()
                
                Text("Publié le : \(article.publishedAt ?? DefaultData.publishedAt)")
                
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                
                Text(article.content ?? DefaultData.content)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8)
                
                Divider().background(Color.white.opacity(0.2))
                    .padding()
                
                HStack {
                    Image(systemName: "link")
                        .opacity(0.7)
                    if let url = article.url {
                        Text("Lien vers l'article d'origine")
                            .font(.footnote)
                            .opacity(0.7)
                            .fullScreenCover(isPresented: $showSafari) {
                                SFSafariViewWrapper(url: URL(string: url)!)
                            }
                    } else {
                        Text(DefaultData.url)
                            .font(.footnote)
                            .opacity(0.7)
                    }
                }
                .onTapGesture {
                    showSafari.toggle()
                }
            }
            Spacer()
        }
        .background(Color(AppColors.articleBackgroundColor))
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(author: "George Orwell", title: "La ferme des animaux", url: "1984", description: "", urlToImage: "https://fabienribery.files.wordpress.com/2021/01/lintrigue_james_ensor_1890.jpg", publishedAt: "01-03-1945", content: "La Ferme des animaux (titre original : Animal Farm. A Fairy Story1) est un roman court de George Orwell, publié en 1945. Découpé en dix chapitres, il décrit une ferme dans laquelle les animaux se révoltent contre leur maître, prennent le pouvoir, chassent les hommes et vivent en autarcie.", source: Source(id: "007", name: "G. Orwell")))
    }
}
