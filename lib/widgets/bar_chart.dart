import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/models/chart_data.dart';


/// SfCartesian ColumnSeries Chart
class BarChart{
   late List<ChartData> chartData;
   late Color chartColor;
   late String chartType;

  /// Returns the cartesian stacked line chart.
  SfCartesianChart buildColumnSeriesChart({
    required List<ChartData> chartData,
    required Color chartColor,
    required String chartType}) {

    this.chartData = chartData;
    this.chartColor = chartColor;
    this.chartType = chartType;

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: const Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: 0, //0
      ),

      primaryYAxis: NumericAxis(
          minimum: 0.0,
          axisLine: const AxisLine(width: 0),
          labelFormat: r'{value}',
          labelStyle: const TextStyle(fontSize: 12),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getColumnSeries(),
      trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
    );
  }

   /// Returns the list of chart seris which need to render
   /// on the stacked line chart.
   List<ChartSeries<ChartData, String>> _getColumnSeries() {
     return <ChartSeries<ChartData, String>> [
       ColumnSeries<ChartData, String>(
           dataSource: chartData,
           xValueMapper: (ChartData sales, _) => sales.x.toString(),
           yValueMapper: (ChartData sales, _) => sales.y,
           dataLabelMapper: (ChartData sales, _)
           {
             if(chartType == 'sleep')
             {
               int hour = sales.y ~/ 60 ;
               int min = sales.y % 60;

               return ('$hour시 $min분').toString();
             }
             else{
               return sales.y.toString();
             }
           },
           color: chartColor,
           width: 0.8,
           spacing: 0.2,
           dataLabelSettings:  DataLabelSettings(
               isVisible: true,
               textStyle: TextStyle(color: chartColor, fontWeight: FontWeight.w600, fontSize: 9)),
          // markerSettings: const MarkerSettings(isVisible: true, borderColor: Color(0xFFf6c86d))
       ),

     ];
   }

}
