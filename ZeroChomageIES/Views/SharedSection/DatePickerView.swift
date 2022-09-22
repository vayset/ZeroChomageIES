//
//  datePickerView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 13/08/2022.
//

import SwiftUI

struct DatePickerView: View {
    @State private var birthDate = Date()

    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }

            Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
        }
    }
}

struct datePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
