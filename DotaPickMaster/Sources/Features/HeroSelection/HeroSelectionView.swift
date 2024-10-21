//
//  HeroSelectionView.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import SwiftUI
import Kingfisher

struct HeroSelectionView: View {
    @ObservedObject var viewModel: HeroPickerViewModel
    @State private var selectedAttribute: Hero.PrimaryAttr? = nil
    @State private var selectedRoles: Set<Hero.Role> = []
    @State private var searchText: String = ""
    @State private var sortOption: SortOption = .none
    
    enum SortOption: String, CaseIterable, Identifiable {
        case none = "None"
        case winRate = "Win Rate"
        case name = "Name"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
                TextField("Search Heroes", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView {
                Picker("Primary Attribute", selection: $selectedAttribute) {
                    Text("All").tag(Hero.PrimaryAttr?.none)
                    ForEach(Hero.PrimaryAttr.allCases) { attribute in
                        Text(attribute.displayName).tag(attribute as Hero.PrimaryAttr?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.purple.opacity(0.1))
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Hero.Role.allCases) { role in
                            Button(action: {
                                withAnimation {
                                    if selectedRoles.contains(role) {
                                        selectedRoles.remove(role)
                                    } else {
                                        selectedRoles.insert(role)
                                    }
                                }
                            }) {
                                Text(role.displayName)
                                    .padding(8)
                                    .background(selectedRoles.contains(role) ? Color.blue.opacity(0.7) : Color.gray.opacity(0.5))
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            .animation(.easeInOut, value: selectedRoles)

                        }
                    }
                    .padding(.horizontal)
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 16)], spacing: 16) {
                    ForEach(sortedHeroes) { hero in
                        VStack {
                            KFImage(URL(string: hero.imageUrl))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 56)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                            Text("\(String(format: "%.2f", hero.winRate))%")
                                .foregroundStyle(hero.winRate >= 50.0 ? Color.green : Color.red)
                            Text(hero.localizedName)
                                .font(.caption)
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Heroes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("Sort By", selection: $sortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .foregroundColor(.blue)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.05))
        )
        .onAppear {
            viewModel.getHeroes()
        }
    }
    
    private var filteredHeroes: [Hero] {
        viewModel.heroes.filter { hero in
            let matchesAttribute = selectedAttribute == nil || hero.primaryAttr == selectedAttribute
            let matchesRole = selectedRoles.isEmpty || !selectedRoles.isDisjoint(with: hero.roles)
            let matchesSearchText = searchText.isEmpty || hero.localizedName.localizedCaseInsensitiveContains(searchText)
            return matchesAttribute && matchesRole && matchesSearchText
        }
    }
    
    private var sortedHeroes: [Hero] {
        switch sortOption {
        case .winRate:
            return filteredHeroes.sorted { $0.winRate > $1.winRate }
        case .name:
            return filteredHeroes.sorted { $0.localizedName < $1.localizedName }
        case .none:
            return filteredHeroes
        }
    }
}

#Preview {
    HeroSelectionView(viewModel: .init())
}
