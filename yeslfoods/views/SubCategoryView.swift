import SwiftUI

struct SubCategoryView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var vm: HomeViewModel

    let categoryTitle: String
    let sections: [(String, [FoodItem])]
    var addAction: (FoodItem) -> Void = { _ in }

    @State private var expandedSections: Set<String> = []

    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)

                Text(categoryTitle)
                    .font(.custom("Poppins-SemiBold", size: 22))
                    .foregroundColor(.white)
                    .padding(.leading, 8)

                Spacer()

                Circle()
                    .fill(Color(red: 0/255, green: 81/255, blue: 183/255))
                    .frame(width: 36, height: 36)
                    .overlay(Text("RT").foregroundColor(.white))
                    .padding(.trailing, 16)
            }
            .frame(height: 80)
            .background(Color(red: 245/255, green: 132/255, blue: 33/255))
            .ignoresSafeArea(edges: .top)

            ScrollView {
                LazyVStack(spacing: 18) {
                    ForEach(sections, id: \.0) { section in
                        SubSectionView(title: section.0, items: section.1, isExpanded: expandedSections.contains(section.0)) { expanded in
                            withAnimation {
                                if expanded { expandedSections.insert(section.0) } else { expandedSections.remove(section.0) }
                            }
                        } addAction: { item in
                            addAction(item)
                        }
                        .padding(.horizontal)
                    }
                    Spacer(minLength: 24)
                }
                .padding(.top, 16)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .onAppear {
            if expandedSections.isEmpty, let first = sections.first?.0 {
                // open the first section by default
                expandedSections.insert(first)
            }
        }
        .navigationBarHidden(true)
    }
}

private struct SubSectionView: View {
    let title: String
    let items: [FoodItem]
    var isExpanded: Bool
    var toggleExpansion: (Bool) -> Void
    var addAction: (FoodItem) -> Void

    var body: some View {
        VStack(spacing: 12) {
            Button(action: { toggleExpansion(!isExpanded) }) {
                HStack {
                    Text(title)
                        .font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }

            if isExpanded {
                VStack(spacing: 12) {
                    ForEach(items) { item in
                        FoodCardView(item: item, addAction: addAction)
                    }
                }
            }
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeViewModel()
        

        return NavigationStack {
            SubCategoryView(
                categoryTitle: "Snacks",
                sections: vm.sections(for: "Snacks"),
                addAction: { _ in /* no-op for preview */ }
            )
            .environmentObject(vm)
            .environmentObject(TabRouter())        
        }
        .previewDevice("iPhone 14")
    }
}
