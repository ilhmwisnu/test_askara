import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_bloc.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_state.dart';

class CryptoDetailPage extends StatelessWidget {
  const CryptoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(context.read<CryptoDetailBloc>().code),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(left: 4, right: 24),
          child: BlocConsumer<CryptoDetailBloc, CryptoDetailState>(
            builder: (context, state) {
              if (state.status == CryptoDetailStatus.loading) {
                return const Center(child: const CircularProgressIndicator());
              }

              if (state.status == CryptoDetailStatus.dataRecieved) {
                return SizedBox(
                  height: screen.size.width,
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
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
                          dotData: FlDotData(show: false),
                          spots: [
                            for (int i = 0; i < state.data.length; i++)
                              FlSpot(
                                  i.toDouble(), double.parse(state.data[i].p!))
                          ],
                        )
                      ],
                    ),
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.linear,
                  ),
                );
              }

              return const SizedBox();
            },
            listener: (context, state) {},
          ),
        ));
  }
}
