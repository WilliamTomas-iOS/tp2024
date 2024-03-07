//
//  ex2td4.swift
//  tp2024
//
//  Created by William Tomas on 07/03/2024.
//

import SwiftUI

struct Personnages: Codable {
    let results: [Personnage]
}

struct Personnage: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let episode: [String]
}

struct ex2td4: View {
    @State var personnages: Personnages?

    @State var currentPage: Int = 1

       func getPersonnages() async throws -> Personnages {

           let endpoint = "https://rickandmortyapi.com/api/character/?page=\(currentPage)"
           guard let url = URL(string: endpoint) else { throw MyError.urlError }
           let (data, response) = try await URLSession.shared.data(from: url)

           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               throw MyError.invalidResponse
           }

           do {
               let decoder = JSONDecoder()
               print(response)
               return try decoder.decode(Personnages.self, from: data)
           } catch {
               throw MyError.invalidParsing
           }
       }
    var body: some View {
        NavigationStack {
            if let personnages {
                List {
                    ForEach(personnages.results) { personnage in
                        NavigationLink(value: personnage) {
                            Text(personnage.name)
                        }
                    }
                }
                .navigationDestination(for: Personnage.self) { personnage in
                    PersonnageDetailView(personnage: personnage)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Précédent") {
                            currentPage -= 1
                            self.personnages = nil
                        }
                    }

                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Suivant") {
                            currentPage += 1
                            self.personnages = nil
                        }
                    }
                }

            } else {
                ProgressView()
                    .task {
                        do {
                            personnages = try await getPersonnages()
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
    }
}

#Preview {
    ex2td4()
}

struct PersonnageDetailView: View {
    let personnage: Personnage
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: personnage.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
            }
            .frame(width: 200, height: 200)

            Text(personnage.name)
                .font(.largeTitle)

            HStack {
                Text("Status:")
                Spacer()
                Text(personnage.status)
            }

            HStack {
                Text("Espèce:")
                Spacer()
                Text(personnage.species)
            }

            HStack {
                Text("Gender:")
                Spacer()
                Text(personnage.gender)
            }

            Text("Apparait dans: \(personnage.episode.count) épisodes")
        }
        .padding()
    }
}
