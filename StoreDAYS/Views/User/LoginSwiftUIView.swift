//
//  LoginSwiftUIView.swift
//  StoreDAYS
//
//  Created by David Gonzalez on 3/30/22.
//

import SwiftUI

struct LoginSwiftUIView: View {
    @ObservedObject var data: Data
    // LOGIN     CREATE ACCOUNT
 
        @State var typeLoginSession = true
  
        var body: some View{
            VStack{
                Image("logo1").resizable().aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                    .frame(width: 250, height: 89, alignment: .center)

                //MARK: BUTTON
                HStack {
                    Spacer()
                    Button("LOGIN"){
                        typeLoginSession = true
                        print("login")
                    }.foregroundColor(typeLoginSession ? .blue : .gray)
                    
                    Spacer()
                    
                    Button("CREATE ACCOUNT"){
                        typeLoginSession = false
                        print("CREATE ACCOUNT")
                    }.foregroundColor(typeLoginSession ? .gray : .blue)
                    
                    Spacer()
                    
                }
                .padding(0.0)
                Spacer(minLength: 42)
                
                // Options LOGIN or CREATE ACCOUNT
                if typeLoginSession == true {
                    LoginSessionViewSwiftUIView(data: data)
                }else{
                    CreateAccountSwiftUIView(data: data)
                }
            }
         
        }
    }
  


struct LoginSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSwiftUIView(data: Data())
    }
}
