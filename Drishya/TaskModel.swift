//  TaskModel.swift
//  Drishya
//  Created by UDIT PANDEY on 12/10/26.

import Foundation
import SwiftUI
public import Combine

struct EveryForm: Identifiable {
    let id = UUID()
    var collegeName : String = ""
    var courseName : String = ""
    var skills : String = ""
    var totalMarks : String = ""
    var obtainedMarks : String = ""
    
    enum Fields : Hashable {
        case collegename
        case courseName
        case skills
        case totalMarks
        case obtainedMarks
    }
    
    func Validation()->[Fields: String]{
        var errors: [Fields : String] = [:]
        
        if collegeName.trimmingCharacters(in: .whitespaces).isEmpty {
            errors[.collegename] = "College name Required"
        }
        
        if courseName.trimmingCharacters(in: .whitespaces).isEmpty {
            errors[.courseName] = "Course name is Required"
        }
        
        if skills.trimmingCharacters(in: .whitespaces).isEmpty {
            errors[.skills] = "Enter Atleast one skill"
        }
        
        let tot = Int(totalMarks.trimmingCharacters(in: .whitespaces))
        let obt = Int(obtainedMarks.trimmingCharacters(in: .whitespaces))
        
        if tot == nil {
            errors[.totalMarks] = "Enter valid Number"
        }else if tot! < 0 {
            errors[.totalMarks]  = "Must be greater then 0"
        }
        
        if obt == nil {
            errors[.obtainedMarks] = "Enter valid Number"
        }else if obt! <= 0 {
            errors[.obtainedMarks] = "Cannot be Negative"
        }else if obt! > tot! {
            errors[.obtainedMarks] = " cannot be More then Total"
        }
        
        return errors
    }
}

@Observable
 class formsViewModel {
     var forms: [EveryForm] = [EveryForm()]
     private(set) var errors : [UUID: [EveryForm.Fields: String]] = [:]
    
     func addForm(){
         forms.append(EveryForm())
     }
     
     func removeForm(id: UUID){
         forms.removeAll{ $0.id == id}
         errors[id] = nil
     }
     
     func save(){
         errors = [:]
         for form in forms {
            let forrmsErrors =  form.Validation()
             if !forrmsErrors.isEmpty {
                 errors[form.id] = forrmsErrors
             }
         }
         
         guard errors.isEmpty else {
             print("Validation failed for \(errors.count) form(s)")
             return
         }
         
         for (index , form) in forms.enumerated() {
             print("""
             Form \(index + 1) 
             College  : \(form.collegeName)
             Course   : \(form.courseName)
             Skills   : \(form.skills)
             Total    : \(form.totalMarks)
             Obtained : \(form.obtainedMarks)
            """)
         }
     }
}



final class profileViewModel : ObservableObject {
    
    let allSkils = [
        "Swift", "UIKit", "SwiftUI", "GitSwiftSwift", "Iw", "SQL", "Fire",
                "APNs", "java", "DSA", "Docker", "CI/CD", "SwiftSwiftSwift"
        
    ]
    
  @Published var selectedSkills : [String] = []
  @Published  var hobbies : [String] = []
  @Published  var summary = ""
  @Published var hobby = ""
  
    func isSelected(_ skill : String)-> Bool{
       return  selectedSkills.contains(skill)
    }
    
    func toggleSkill(_ skill : String){
        if isSelected(skill){
            selectedSkills.removeAll{$0 == skill}
        }else{
            selectedSkills.append(skill)
        }
        
        
    }
    
    func removeSkill(_ skill : String){
        selectedSkills.removeAll{ $0 == skill}
    }
    
    func addHobby(){
        let newHobby = hobby.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !newHobby.isEmpty, !hobbies.contains(newHobby) else { return }
        hobbies.append(newHobby)
        hobby = ""
    }
    
    func removeHobby(_ hobby : String){
        hobbies.removeAll{$0 == hobby}
    }
    
    func printAll(){
        print("Summary :" , summary.isEmpty ? "Summary Empty" : summary)
        print("Skill :" , selectedSkills)
        print("Hobbies :", hobbies)
    }
    
}

