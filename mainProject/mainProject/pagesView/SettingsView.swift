//
//  SettingsView.swift
//  mainProject
//
//  Created by Can Özgür on 19.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var profile: FetchedResults<Profile>.Element
    
    @State private var name : String = ""
    @State private var surname : String = ""
    @State private var email : String = ""
    @State private var phoneNumber : String = ""
    
    // adress
    @State private var adresLine1 : String = ""
    @State private var adresLine2 : String = ""
    @State private var city : String = ""
    @State private var country : String = ""
    
    @State var maleGender : Bool = false
    var body: some View {
        ScrollView{
            ZStack{
                Rectangle()
                    .stroke(lineWidth: 10)
                    .frame(width: 300,height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack{
                    //name
                    HStack{
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        
                        TextField("Name", text: $name)
                            .frame(width: 200)
                            .padding()
                            .underline(pattern: .solid)
                    }
                    //surname
                    HStack{
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        TextField("Surname", text: $surname)
                            .frame(width: 200 )
                            .padding()
                            .underline(pattern: .solid)
                    }
                    //email
                    HStack{
                        Image(systemName: "envelope")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(.plain)
                            .frame(width: 200)
                            .padding()
                            .underline(pattern: .solid)
                    }
                    // phone number
                    HStack{
                        Image(systemName: "phone")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        
                        TextField("Enter your email", text: $phoneNumber)
                            .frame(width: 200)
                            .padding()
                            .underline(pattern: .solid)
                    }
                    // Gender
                    
                    HStack{
                        Button(action:  {
                            // button hareketi cinsiyeti versib
                            maleGender.toggle()
                        }, label: {
                            if maleGender{
                                Circle()
                                    .fill(.green)
                                    .frame(width: 20,height: 20)
                                
                                    .overlay(
                                        Circle().stroke(Color.black, lineWidth: 2)
                                    )
                                Text("Male")
                                    .bold()
                                    .padding()
                                    .foregroundStyle(.black)
                            }
                            else{
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .frame(width: 20,height: 20)
                                Text("Male")
                                    .bold()
                                    .padding()
                                    .foregroundStyle(.black)
                            }
                        })
                        
                        
                        
                        Button(action:  {
                            maleGender.toggle()
                        }, label: {
                            if maleGender == false{
                                Circle()
                                    .fill(.green)
                                    .frame(width: 20,height: 20)
                                
                                    .overlay(
                                        Circle().stroke(Color.black, lineWidth: 2)
                                    )
                                Text("Male")
                                    .bold()
                                    .padding()
                                    .foregroundStyle(.black)
                            }
                            else{
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .frame(width: 20,height: 20)
                                Text("Male")
                                    .bold()
                                    .padding()
                                    .foregroundStyle(.black)
                            }
                        })
                        
                    }
                    
                    
                }
                
            }
            
            // ADRESS LINES
            //adres line 1
            VStack(alignment:.leading){
                Text("Adres line 1")
                    .bold()
                    .font(.title2)
                TextField("123 street",text : $adresLine1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 3))
                
            }.padding(.horizontal,60)
            //adres line 2
            VStack(alignment:.leading){
                Text("Adres line 2")
                    .bold()
                    .font(.title2)
                TextField("(optional)",text : $adresLine2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 3))
                
            }.padding(.horizontal,60)
            VStack(alignment:.leading){
                Text("City")
                    .bold()
                    .font(.title2)
                TextField("Istanbul",text : $city)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 3))
                
            }.padding(.horizontal,60)
            VStack{
                
            }
            VStack(alignment:.leading){
                
                Text("Country")
                    .bold()
                    .font(.title2)
                TextField("Turkey",text : $country)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 3))
                
            }.padding(.horizontal,60)
            // save button
            // Adress Save Data
            Button(action: {
                DataController().editUser(profile :profile , adresLine1: adresLine1, adresLine2: adresLine2, city: city, country: country)
                dismiss()
                print("adress saved")
            }, label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color("ColorOfButton"))
                        .frame(width: 200,height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("SAVE")
                        .bold()
                        .font(.title)
                        .foregroundColor(.black)
                }
            })


            
            
        }
    }
    
}

#Preview {
    // Provide a mock Profile for the preview
    let context = DataController.shared.container.viewContext
    let profile = Profile(context: context)
    

    
    return SettingsView(profile: profile)
        .environment(\.managedObjectContext, context)
}
