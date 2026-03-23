//
//  Appointment.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI

struct AppointmentComponent: View {
    @Environment(ModelData.self) var modelData
    var appointment : Appointment
    var body: some View {
        @Bindable var modelData = modelData
        
        ForEach(modelData.appointments){appointment in
            VStack{
                HStack{
                    TextLabel(text : "\(appointment.date)")
                    Spacer()
                    TextLabel(text : "\(appointment.hour)")
                }
                HStack{
                    TextLabel(text : "\(appointment.id)")
                    Spacer()
                    
                }
                AnimatedDropdownMenu(location : appointment.location)
                
            }
            .cornerRadius(8)
            .padding()
        }
        
    }
}



struct TextLabel:View{
    var text : String
    var body : some View{
        Text("\(text)").font(.system(size: 20 , weight:.bold, design: .default )).padding()
    }
}

struct  AnimatedDropdownMenu : View {
    @Namespace  private  var animationNamespace
    @State  private  var isExpanded =  false
    @State  private  var selectedOption =  "Seleccione una opción"
    var location : String
    var body: some  View {
        VStack {
            Button (action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text (selectedOption).foregroundStyle(Color.white).bold()
                    Spacer ()
                    Image (systemName: isExpanded ?  "chevron.up" : "chevron.down" )
                }
                .padding()
                //.background( Color .blue.opacity( 0.1 ))
                .cornerRadius( 8 )
                .matchedGeometryEffect(id: "dropdown" , in: animationNamespace)
            }
            
            if isExpanded {
                VStack {
                    
                    Text (location)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background( Color .white)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedOption = location
                                isExpanded =  false
                            }
                        }
                        .matchedGeometryEffect(id: "dropdown- \(location) " , in: animationNamespace)
                    
                }
                .background( Color .gray.opacity( 0.1 ))
                .cornerRadius( 8 )
                .transition(.scale)
            }
        }
    }
}

struct moreButon: View{
    var body: some View{
        
    }
}

#Preview {
    let modelData = ModelData()
    return AppointmentComponent(appointment: modelData.appointments[0]).environment(modelData)
}
