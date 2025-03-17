import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TrendGraphComponent extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;

  const TrendGraphComponent({required this.chartData, super.key}); 

  @override
  Widget build(BuildContext context) {
    // Initialize NumberFormat inside build method
    final NumberFormat f = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'AED ',
      decimalDigits: 2,
      customPattern: '¤#,##0.00;(¤#,##0.00)', // Accounting format with parentheses for negatives
    );

    final flSpots = _convertToFlSpots(chartData);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary, 
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: flSpots,
                isCurved: true,
                color: Colors.white,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 3,
                      color: Colors.white,
                      strokeWidth: 0,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(8),
                tooltipRoundedRadius: 8,
                tooltipBorder: BorderSide(color: Colors.white.withOpacity(0.2)),
                tooltipMargin: 8,
                getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.8),
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final index = touchedSpot.x.toInt();
                    final time = chartData[index]['time'];
                    final value = f.format(chartData[index]['value']);

                    return LineTooltipItem(
                      '$time\n$value',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
              touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
              getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return TouchedSpotIndicatorData(
                    FlLine(
                      color: Colors.white.withOpacity(0.3),
                      strokeWidth: 1,
                    ),
                    FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: Colors.white.withOpacity(0.5),
                        );
                      },
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _convertToFlSpots(List<Map<String, dynamic>> data) {
    List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]['value']));
    }
    return spots;
  }
}