//  Tas2.swift
//  Drishya
//  Created by UDIT PANDEY on 14/10/26.


import SwiftUI

struct Tas2: View {
    @StateObject var viewModel = profileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 24){
                summarySectionView(summary: $viewModel.summary)
                SkillsectionView(viewModel: self.viewModel)
                HobbiesSelectionView(viewModel: self.viewModel)
                
                Button("Print all in console") {
                    viewModel.printAll()
                }
                .buttonStyle(.borderedProminent)
                
                
            }
            .padding(20)
        }
        .scrollDismissesKeyboard(.interactively)
    }
}


struct sectionTtile : View {
    let text : String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 20 , weight: .semibold))
    }
}



struct GradientBadge : View {
    let systemName : String
    var size : CGFloat = 20
    var iconSize : CGFloat = 9
    
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: iconSize, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(
                Circle().fill(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                )
            )
    }
}



struct RemoveChip : View {
    var title : String
    var color : Color
    var onRemove : () -> Void
    
    var body: some View {
        Text(title)
            .font(.system(size: 17))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(color, in: Capsule())
            .overlay(alignment: .topTrailing){
                Button(action : onRemove){
                    GradientBadge(systemName: "xmark")
                }
                .buttonStyle(.plain)
                .offset(x: 6, y : -6)
            }
            .padding(.top, 6)
            .padding(.trailing, 6)
    }
}



struct skillChip : View {
    let title : String
    let isSelected : Bool
    let onTap : ()->Void
    
    var body: some View {
        Button(action : onTap){
            Text(title)
                .font(.system(size: 17))
                .foregroundStyle(isSelected ? .white : .black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.green : Color.clear, in: .capsule)
                .overlay(
                    Capsule().stroke(Color.black, lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(.plain)
    }
}



struct summarySectionView : View {
    @Binding var summary : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            sectionTtile(text: "Summary")
            
            ZStack(alignment: .topLeading){
                TextEditor(text: $summary)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                
                if summary.isEmpty {
                    Text("Enter Summary.....")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray.opacity(0.7))
                        .padding(.horizontal, 17)
                        .padding(.vertical, 16)
                        .allowsHitTesting(false)
                }
            }
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            )
            
        }
    }
}


struct SkillsectionView : View {
    @ObservedObject var viewModel : profileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing:  16){
            sectionTtile(text: "Skill")
            selectedSkillsBox
            allSkillsList
        }
       
    }
    
    private var selectedSkillsBox: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 10){
                if viewModel.selectedSkills.isEmpty{
                    Text("Selecte Skills below")
                        .font(.system(size: 19))
                        .foregroundStyle(.gray)
                        .padding(.leading, 8)
                }
                ForEach(viewModel.selectedSkills,id: \.self){ skill in
                    RemoveChip(title: skill, color: .green){
                        withAnimation{viewModel.removeSkill(skill)}
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minHeight: 60)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.gray.opacity(0.35), lineWidth: 1)
        )
    }
    
    private var allSkillsList : some View{
        FlowLayout(Hspacing: 10, VSpacing: 10){
            ForEach(viewModel.allSkils, id: \.self){ skill in
                skillChip(
                        title: skill,
                        isSelected: viewModel.isSelected(skill),
                        onTap: {
                        withAnimation {
                        viewModel.toggleSkill(skill)
                            }
                        }
                    )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}



struct HobbiesSelectionView : View {
    @ObservedObject var viewModel : profileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            sectionTtile(text: "hobbies")
            
            FlowLayout(Hspacing: 10, VSpacing: 10){
                HobbyInputField(text: $viewModel.hobby,
                                onAdd: {
                                   withAnimation { viewModel.addHobby()
                                }
                })
                
                ForEach(viewModel.hobbies, id: \.self) { hobby in
                RemoveChip(title: hobby, color: .red) {
                    withAnimation { viewModel.removeHobby(hobby) }
                                    }
                                }
                            }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        
        }
    }

private struct HobbyInputField : View {
    @Binding var text : String
    var onAdd : ()->Void
    var body: some View {
        HStack{
            TextField("Add your Hobby here", text : $text)
                .font(.system(size: 17))
                .submitLabel(.done)
                .onSubmit (onAdd)
                .tint(.primary)
            
            
            Button(action: onAdd){
                GradientBadge(
                    systemName: "plus",
                    size: 30,
                    iconSize: 14
                )
                
            }
            .buttonStyle(.plain)
    }
        .padding(.leading, 16)
        .padding(.trailing, 8)
        .padding(.vertical, 6)
        .frame(width: 260)
        .overlay(Capsule().stroke(Color.gray.opacity(0.35), lineWidth: 1))
        .padding(.top, 6)
}
   
}


#Preview {
    Tas2()
}
