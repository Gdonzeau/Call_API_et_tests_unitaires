//
//  Card.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import SwiftUI

struct Card: View {
    @State private var showSafari: Bool = false
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            
            NavigationLink {
                ArticleView(article: article)
            } label: {
                VStack {
                    HStack(alignment: .center, spacing: 16.0) {
                        articlePicture
                        
                        VStack(alignment: .leading, spacing: 2) {
                            /*
                             * Le Json montre plusieurs fois que le nom de l'auteur est en fait une adresse internet.
                             * Nous le gérons avec l'extension .isHttpAdress, qui permet d'une part d'être sûr que l'optionel
                             * n'est pas à nil (d'où le ! un peu plus bas) et qu'il commence par https.
                             * Si l'adresse est mauvaise, cela n'engendrera pas d'erreurs mais sera signalé sur le navigateur dans SafariView.
                             */
                            if article.author.isHttpAdress() {
                                if let name = article.source?.name {
                                    Text(name)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .lineLimit(2)
                                        .foregroundColor(.white)
                                }
                                Text("Lien vers le site de l'auteur")
                                    .onTapGesture {
                                        showSafari.toggle()
                                    }
                                    .fullScreenCover(isPresented: $showSafari) {
                                        SFSafariViewWrapper(url: URL(string: article.author!)!)
                                    }
                                
                            } else {
                                Text((article.author ?? article.source?.name) ?? DefaultData.author)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    Text(article.title ?? DefaultData.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(3)
                }
            }
            .padding([.top, .leading, .trailing])
            
            Divider().background(Color.white.opacity(0.2))
            
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
        .foregroundColor(.white)
        .padding(20)
        .frame(maxWidth: 512)
        .background(Color(AppColors.cardColor).opacity(0.5))
        .background(.ultraThinMaterial)
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .stroke(Color(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 1)), lineWidth: 1)
            .blendMode(.overlay)
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(AppColors.shadowCard).opacity(0.5), radius: 30, x: 15, y: 15)
        .offset(y: 55)
        
    }
    
    var articlePicture: some View {
        ZStack {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                } placeholder: {
                    Color.gray
                }
                .frame(width: 120, height: 68)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        let previewArticle = Article(author: "George Orwell", title: "La ferme des animaux", url: "1984", description: "", urlToImage: "https://fabienribery.files.wordpress.com/2021/01/lintrigue_james_ensor_1890.jpg", publishedAt: "01-03-1976", content: "La ferme des animaux est une satire du système soviétique", source: Source(id: "007", name: "G. Orwell"))
        
        Card(article: previewArticle)
    }
}
