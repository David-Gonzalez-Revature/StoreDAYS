//
//  ItemCell3.swift
//  StoreDAYS
//
//  Created by stephen weber on 3/30/22.
//

import SwiftUI
///// There are three item cell subViews. files here is one
/// One for kittens , puppies and animals
/// could have made an enum but this works too
///
struct ItemCell3: View {
    var exoticName = "Harry Potter"
    var exoticLitter = 56
    var exoticPrice = "$45000"
    
    ////  there are three variables grabbed from data and these three files for item cells
    /// are too keep each file small and clear as too its purpose.
    ///
    ///
    /// A cell has an image
    /// then some text
    /// then the price
    ///
    /// all laid out horizontally
    
    
    
    
    
     var body: some View {
         HStack {
             
             Image(exoticName)
             
                 .resizable()
                 .frame(width: 100, height:100)
             Text("There are \(exoticLitter) left from this litter.")
             
             Spacer()
             Text(exoticPrice)
                 .padding(.all, 10.0)
             
             
         }
     }
 }


struct ItemCell3_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell3()
    }
}
