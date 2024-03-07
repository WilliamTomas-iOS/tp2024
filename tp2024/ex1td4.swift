//
//  ex1td4.swift
//  tp2024
//
//  Created by William Tomas on 07/03/2024.
//

import SwiftUI

struct Quotes: Codable {
    var quotes: [Quote]
}

struct Quote: Codable {
    var quote: String
    var author: String
}

struct ex1td4: View {
    @State var quote: Quote?

       func getQuote() async throws -> Quote? {

           let endpoint = "https://api.breakingbadquotes.xyz/v1/quotes"
           guard let url = URL(string: endpoint) else { throw MyError.urlError }
           let (data, response) = try await URLSession.shared.data(from: url)

           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               throw MyError.invalidResponse
           }

           do {
               let decoder = JSONDecoder()
               return try decoder.decode([Quote].self, from: data).first
           } catch {
               throw MyError.invalidParsing
           }
       }

       var body: some View {
           VStack(spacing: 20) {
               Text(quote?.quote ?? "quote")

               Text(quote?.author ?? "author")
           }
           .padding()
           .task {
               do {
                   quote = try await getQuote()
               } catch MyError.urlError {
                   print("erreur de création d'url")
               } catch MyError.invalidResponse {
                   print("mauvaise reponse du serveur")
               } catch MyError.invalidParsing {
                   print("mauvais traitement de la donnée")
               } catch {
                   print("erreur inconnue")
               }
           }
       }
   }

enum MyError: Error {
    case urlError
    case invalidResponse
    case invalidParsing
}

#Preview {
    ex1td4()
}

