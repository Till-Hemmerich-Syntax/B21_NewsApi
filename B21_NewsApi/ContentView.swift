//
//  ContentView.swift
//  B21_NewsApi
//
//  Created by Till Hemmerich on 22.11.24.
//

import SwiftUI
import AVKit
struct ArticleDetailView:View {
    var article : Article
    var body: some View {
        ZStack{
            LinearGradient(colors:[Color.blue.opacity(0.5),Color.white.opacity(0.7)],startPoint:.top,endPoint:.bottom)
                .ignoresSafeArea()
            VStack{
                Text(article.title)
                    .font(.headline)
                if(article.urlToImage != nil){
                    AsyncImage(url: URL(string:article.urlToImage!)) { image in
                        image
                            .resizable()
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(article.content ?? "")
                Spacer()
                Link("\(article.source.name) : \(article.author ?? "Unknown")", destination: URL(string:article.url)!)
            }.padding(.horizontal)
        }.navigationTitle(article.title)
    }
}

struct ContentView: View {
    @State var articles : [Article] = []
    @State var totalResults : Int = 0
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(colors:[Color.blue.opacity(0.5),Color.white.opacity(0.7)],startPoint:.top,endPoint:.bottom)
                    .ignoresSafeArea()
                VStack{
                    Text("Results: \(totalResults)")
                    List{
                        ForEach(articles, id: \.self){ article in
                            NavigationLink {
                                ArticleDetailView(article: article)
                            } label: {
                                VStack{
                                    Text(article.title)
                                    Text(article.author ?? "")
                                }
                            }

                        }
                    }.scrollContentBackground(.hidden)
                }
            }
            
        }.task{
            do{
                self.articles = try await getNewsFromAPI()
            }catch{
                print(error)
            }
        }
    }
    private func getNewsFromAPI()async throws -> [Article]{
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2024-11-21&to=2024-11-21&sortBy=popularity&apiKey=\(NEWSAPIKEY)"
        
        let urlString2 = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(NEWSAPIKEY)"
        
        guard let url = URL(string: urlString2) else {
            throw HTTPError.invalidURL
        }
        
        let (data,urlResponse) = try await URLSession.shared.data(from: url)
        //urlResponse
        let response = try JSONDecoder().decode(News.self, from: data)
        self.totalResults = response.totalResults
        return response.articles.filter({$0.title != "[Removed]"})
            
    }
}

#Preview {
    ContentView()
}
