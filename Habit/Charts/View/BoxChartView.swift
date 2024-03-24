//
//  BoxChartView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-23.
//

import SwiftUI
import DGCharts


//representa uma UI do UIKIT
struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView();
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.leftAxis.axisLineColor = .blue
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.animate(yAxisDuration: 1.0)
        
        uiView.data = addData()
        return uiView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
    
    func addData() -> LineChartData {
        let colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocation: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                   colors: colors as CFArray,
                                        locations: colorLocation) else {return LineChartData()}
        
        let dataSet = LineChartDataSet(entries: entries, label: "Teste")
        let dataSetArray: [ChartDataSetProtocol] = [dataSet]
        
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.blue)
        dataSet.circleColors = [.black]
        dataSet.drawFilledEnabled = true
        dataSet.valueColors = [.black]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
        
        
        
        return DGCharts.LineChartData(dataSets: dataSetArray)
    }
}


class DateAxisValueFormatter: AxisValueFormatter {
    let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        
        
        if position > 0 && position < dates.count {
            
            let date = df.date(from: dates[position])
            
            guard let date = date else {
                return ""
            }
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "en_US_POSIX")
            newFormatter.dateFormat = "dd/MM"
            
            let createrdAt = newFormatter.string(from: date)
            
            return createrdAt
            
        } else {
            return ""
        }
        
    }
}

#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 8.0),
        ChartDataEntry(x: 4.0, y: 4.0)
    ]), dates: .constant([
        "01/01/2024",
        "02/01/2024",
        "03/01/2024"
    ]))
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 350)
}
