//
//  PickerView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/8/20.
//

import Foundation

import SwiftUI

struct PickerView: View {
    
    @Binding var pickerSelection:Int
    
    
    var body: some View {
        Picker(selection: $pickerSelection, label: Text("What is your favorite color?")) {
            Text("Bio").tag(0)
            Text("Work shows").tag(1)
        }.pickerStyle(SegmentedPickerStyle())
        .onAppear{
            
               UISegmentedControl.appearance().selectedSegmentTintColor = .systemPurple
               UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .selected)
               UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        }
        
    }
}

