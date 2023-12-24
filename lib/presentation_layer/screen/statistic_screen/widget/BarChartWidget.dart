import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_manger/presentation_layer/screen/statistic_screen/statistic_controller/statistic_controller.dart';
import 'package:task_manger/presentation_layer/src/style_packge.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final StatisticController _controller = Get.put(StatisticController());

    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Container(
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    // Renders bar chart
                    BarSeries<ChartData, String>(
                      dataSource: _controller.spots,
                      xValueMapper: (ChartData data, _) => data.name.toString(),
                      yValueMapper: (ChartData data, _) => data.value,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true, // Enables the data label
                        labelPosition: ChartDataLabelPosition.inside,

                        // Positions the data label
                        // You can also use other properties to style the data labels
                      ),
                    )
                  ],
                  plotAreaBorderWidth: 1,
                  isTransposed: true,
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChartData {
  String name;
  double value;

  ChartData(this.name, this.value);
}
