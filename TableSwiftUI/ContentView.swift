//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Denham, Wyatt on 4/3/24.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Pickett Trail", neighborhood: "Outdoor", desc: "As one of the most hidden trails in Georgetown, Pickett Trail is a one way in and out trail of moderate difficulty. Following the San Gabriel River from Blue Hole Park, Pickett Trail features stunning views and river access points to make taking a swim while hiking easy. Come check out this unique and isolated trail when looking for an active date!", lat: 30.64048818183633, long: -97.68284387368278, imageName: "pickett"),
    Item(name: "Blue Bonnet Cafe", neighborhood: "Food", desc: "When driving through the Hill Country, make sure to pay a visit to Blue Bonnet Cafe in Marble Falls. With a menu that includes Texas-sized comfort food and delicious southern classics, this cafe is a beloved eatery for both locals and tourists in the area. Make sure to try their award-winning pie!", lat: 30.57079911210365, long: -98.2760207025191, imageName: "bluebonnet"),
    Item(name: "Toy Joy", neighborhood: "Shopping", desc: "This unique toy store has an equally unique paintjob both inside and out! On every neon green and pink surface you can find toys, games, collectibles, and more. Come try their icecream and specialty sodas for a deliciously fun sweet treat!", lat: 30.330679293405723, long: -97.73940329860007, imageName: "yummi"),
    Item(name: "Zilker Botanical Garden", neighborhood: "Outdoor", desc: "Zilker Botanical Garden is one of the top outdoor destinations in the downtown Austin area. With a huge number of gardens featuring local plants and artwork, this relaxing space would be the perfect place to take some pictures in the flowers.", lat: 30.26976167470999, long:  -97.77228659087537, imageName: "botanical"),
    Item(name: "Pavement", neighborhood: "Shopping", desc: "Located in the thrift district on Guadalupe Street, Pavements is directly next to Buffalo Exchange and Flamingos and features an assortment of quirky affordable clothing and accessories!. ", lat: 30.296995030984885, long: -97.74209309157521, imageName:"pavement")
]

struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
 
    
    var body: some View {
        NavigationView {
        VStack {
                   List(data, id: \.name) { item in
                       NavigationLink(destination: DetailView(item: item)) {
                       HStack {
                           Image(item.imageName)
                               .resizable()
                               .frame(width: 50, height: 50)
                               .cornerRadius(10)
                       VStack(alignment: .leading) {
                               Text(item.name)
                                   .font(.headline)
                               Text(item.neighborhood)
                                   .font(.subheadline)
                           }
                       } // end HStack
                       } // end NavigationLink
                   } // end List
            
Map(coordinateRegion: $region, annotationItems: data) { item in
MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
    Image(systemName: "mappin.circle.fill")
        .foregroundColor(.red)
         .font(.title)
         .overlay(
         Text(item.name)
             .font(.headline)
             .foregroundColor(.black)
             .fixedSize(horizontal: true, vertical: false)
             .offset(y: 45)
        )
        }
} // end map
.frame(height: 340)
.padding(.bottom, -30)
            
} // end VStack
    .listStyle(PlainListStyle())
    .navigationTitle(" CenTex Date Spots")
    } // end NavigationView
    } // end body
} // end ContentView

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width)
                    .padding(15)
                Text("Type: \(item.neighborhood)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(15)
                // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

    Map(coordinateRegion: $region, annotationItems: [item]) { item in
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(.red)
                .font(.title)
                .overlay(
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .fixedSize(horizontal: true, vertical: false)
                        .offset(y: 45)
                        )
                 }
                 } // end Map
                     .frame(height: 300)
                     .padding(.bottom, -30)
                   
                    } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
            
         } // end body
      } // end DetailView

#Preview {
    ContentView()
}
                    
    
