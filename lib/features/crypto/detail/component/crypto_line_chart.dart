import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../models/crypto.dart';

class CryptoLineChart extends StatelessWidget {
  const CryptoLineChart({
    super.key,
    required this.cryptoData,
  });

  final List<Crypto> cryptoData;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);

    return SizedBox(
      height: screen.size.width,
      child: LineChart(
        LineChartData(
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
              axisNameSize: 0,
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: Colors.blue,
              isCurved: true,
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.4),
                      Colors.blue.withOpacity(0.3),
                      Colors.blue.withOpacity(0.2),
                      Colors.blue.withOpacity(0),
                    ],
                  )),
              dotData: const FlDotData(show: false),
              spots: [
                for (int i = 0; i < cryptoData.length; i++)
                  FlSpot(i.toDouble(), double.parse(cryptoData[i].p!))
              ],
            )
          ],
        ),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      ),
    );
  }
}
