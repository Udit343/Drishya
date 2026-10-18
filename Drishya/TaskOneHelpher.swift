//  TaskOneHelpher.swift
//  Drishya
//  Created by UDIT PANDEY on 13/10/26.


import SwiftUI

struct TaskOneHelpher: View {
    @Binding var form : EveryForm
    let onDelete: (()->Void)?
    let errors :[EveryForm.Fields : String]
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            FormFields(title: "Enter your college Name",
                        placeHolder: "Enter your  college Name",
                       text: $form.collegeName,
                       error: errors[.collegename])
            
            FormFields(title: "Enter your course Name", placeHolder: "Enter your course Name", text: $form.courseName,error: errors[.courseName])
            
            FormFields(title: "Enter your skills", placeHolder: "Enter your skills", text: $form.skills,error: errors[.skills])
            
            HStack(alignment: .top, spacing: 12){
                FormFields(title: "Total Marks", placeHolder: "Total Marks", text: $form.totalMarks,error: errors[.totalMarks], keyboard: .numberPad,)
                
                FormFields(title: "Obtained Marks", placeHolder: "Obtained Marks", text: $form.obtainedMarks,error: errors[.obtainedMarks], keyboard: .numberPad)
            }
            
            HStack{
                Spacer()
                if let onDelete {
                    Button(action: onDelete){
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 13))
    }
}

struct FormFields : View {
    let title : String
    let placeHolder : String
    @Binding var text : String
    var error : String? = nil
    var keyboard : UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(title)
                .font(.title3)
                .bold()
            
            TextField(placeHolder, text: $text)
                .keyboardType(keyboard)
                .font(.system(size: 18))
                .padding(.horizontal, 13)
                .padding(.vertical, 12)
                .tint(.primary)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                }
            if let error {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    TaskOneHelpher(
        form: .constant(EveryForm()),
        onDelete: {
        print("On delete tapped")
        }, errors: [:]
    )
    
}
