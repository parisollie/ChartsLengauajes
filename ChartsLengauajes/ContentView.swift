//
//  ContentView.swift
//  ChartsLengauajes
//
//  Created by Paul F on 23/03/25.
//  Actualizado

import SwiftUI
import Charts

struct LanguageData: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Double
    let color: Color // Agregamos un color para cada lenguaje
}

// Elimina esta línea, ya no es necesaria:
// extension Double: Plottable {} // Permite usar Double con chartAngleSelection

struct ContentView: View {
    let languages = [
        LanguageData(name: "iOS", percentage: 30, color: .blue),
        LanguageData(name: "Android", percentage: 20, color: .green),
        LanguageData(name: "SQL", percentage: 15, color: .orange),
        LanguageData(name: "Flutter", percentage: 15, color: .red),
        LanguageData(name: "React Native", percentage: 15, color: .purple)
    ]
    
    @State private var selectedPercentage: Double?
    
    var body: some View {
        VStack {
            Text("Programming Language Usage")
                .font(.title2)
                .padding()
            
            Chart(languages) { language in
                SectorMark(
                    angle: .value("Usage", language.percentage),
                    innerRadius: .ratio(0.6),
                    angularInset: 5
                )
                .foregroundStyle(language.color) // Usamos el color definido
                .opacity(selectedPercentage == nil || selectedPercentage == language.percentage ? 1 : 0.4)
            }
            .chartAngleSelection(value: $selectedPercentage) // Ahora compatible con Plottable
            .frame(height: 300)
            .padding()
            
            // Leyenda personalizada centrada
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(languages) { language in
                    HStack {
                        Circle()
                            .fill(language.color)
                            .frame(width: 10, height: 10)
                        Text("\(language.name) (\(language.percentage, specifier: "%.0f")%)")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
            
            if let selected = selectedPercentage, let language = languages.first(where: { $0.percentage == selected }) {
                Text("Selected: \(language.name) - \(selected, specifier: "%.0f")%")
                    .font(.headline)
                    .padding()
            }
        }//FinalV
    }
}

#Preview {
    ContentView()
}
