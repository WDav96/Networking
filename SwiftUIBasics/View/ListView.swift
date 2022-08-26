//
//  ListView.swift
//  SwiftUIBasics
//
//  Created by Wilson David Molina Lozano on 23/08/22.
//

import SwiftUI

final class ProgrammersModelData: ObservableObject {
    
    @Published var programmers = [Programmer(id: 0, name: "David", lenguages: "Swift", avatar: Image(systemName: "person.fill"), favorite: true),
                               Programmer(id: 1, name: "David", lenguages: "Kotlin", avatar: Image(systemName: "person.fill"), favorite: true),
                               Programmer(id: 2, name: "David", lenguages: "React Native", avatar: Image(systemName: "person.fill"), favorite: false),
                               Programmer(id: 3, name: "David", lenguages: "Flutter", avatar: Image(systemName: "person.fill"), favorite: false)]
}

struct ListView: View {
    
    @EnvironmentObject var programmersModelData: ProgrammersModelData
    @State private var showFavorites = false
    
    private var filteredProgrammers: [Programmer] {
        return programmersModelData.programmers.filter { programmer in
            return !showFavorites || programmer.favorite
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Toggle(isOn: $showFavorites) {
                    Text("Show favorites")
                }.padding()
            
                List(filteredProgrammers, id: \.id) { programmer in
                    NavigationLink(destination: ListDetailView(isFavorite: $programmersModelData.programmers[programmer
                        .id].favorite, programer: programmer)) {
                        RowView(programmer: programmer)
                    }
                }
            }
        }.navigationTitle("Programmers")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(ProgrammersModelData())
    }
}
