import 'package:flutter/material.dart';
import 'package:pradyek101/data/model/add_data.dart';
import 'package:pradyek101/data/utilities.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int index1;
  Chart({Key? key, required this.index1}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  List<AddData> ? a;
  bool j = true;
  bool m = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.index1)
    {
      case 0:
        a = today();
        j = true;
        m = true;
        break;
      case 1:
        a = year();
        m = false;
        break;
      default:
    }
    return Container(
        width: double.infinity,
        height: 300,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <SplineSeries<SalesData, String>>[
            SplineSeries<SalesData, String>(
              color: Colors.pink,
              width: 3,
              dataSource: <SalesData>[
                ...List.generate(time(a!, m ? true : false).length, (index) {
                  return SalesData(
                      m
                          ? j
                            ? a![index].dateTime.hour.toString()
                            : a![index].dateTime.day.toString()
                          : a![index].dateTime.month.toString(),
                      j
                          ? index > 0
                            ? time(a!, true)[index] + time(a!, true)[index - 1]
                            : time(a!, true)[index]
                          : index > 0
                            ? time(a!, false)[index] +
                              time(a!, false)[index - 1]
                            : time(a!, false)[index]);
                })
            ],
              xValueMapper: (SalesData sales,_)=>sales.year,
              yValueMapper: (SalesData sales,_)=>sales.sales,
            )
          ],
        ),
      );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}