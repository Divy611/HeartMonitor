import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            verticalInterval: 1,
            drawVerticalLine: true,
            horizontalInterval: 40,
            getDrawingHorizontalLine: (value) {
              return FlLine(strokeWidth: 1, color: Colors.grey[300]);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(strokeWidth: 1, color: Colors.grey[300]);
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const titles = ['R1', 'R2', 'R3', 'R4', 'R5'];
                  return Text(
                    titles[value.toInt()],
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  );
                },
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  );
                },
                interval: 40,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 4,
          minY: 0,
          maxY: 150,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 70),
                FlSpot(1, 127),
                FlSpot(2, 78),
                FlSpot(3, 94),
                FlSpot(4, 80),
              ],
              barWidth: 2,
              isCurved: false,
              color: Colors.pink,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: Colors.pink,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.pink.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
