//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Shivangi Dutta on 16/05/25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    let predator : ApexPredators
    @State var position : MapCameraPosition
    @Namespace var nameSpace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack (alignment: .bottomTrailing){
                    // background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear,
                                              location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                VStack(alignment: .leading) {
                    //Dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current location
                    NavigationLink{
                        PredatorMap(position: .camera(
                            MapCamera(
                                centerCoordinate: predator.location,
                                distance: 1000,
                                heading: 250,
                                pitch: 60))
                        )
                        .navigationTransition(
                            .zoom(
                                sourceID: 1,
                                in: nameSpace))
                    }label: {
                        Map(position: $position){
                            Annotation(predator.name, coordinate:
                                        predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                                        .annotationSubtitles(.hidden)
                        }
                        
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment : .topLeading){
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius : 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    .matchedTransitionSource(id: 1, in: nameSpace)
                
                    //appears in
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("⁍ " + movie)
                            .font(.subheadline)
                    }
                    
                    //Movie moments
                    
                    Text("Movie moments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to webpage
                    
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    
                    
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
            .toolbarBackground(.automatic)
            
        }
    }
}
#Preview {
    let predator = Predators().apexPredators[1]
    NavigationStack{
        PredatorDetail(predator: predator,
                       position: .camera(
                        MapCamera(centerCoordinate: predator.location, distance: 30000)))
        .preferredColorScheme(.dark)
    }
}
