import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  final List<Expense> expenses;

  const MyChart({super.key, required this.expenses});

  @override
  State<MyChart> createState() => _MyChartState();
}

/// Bir günü ve o gündeki toplam harcamayı tutan küçük model
class _DayTotal {
  final DateTime date;
  final double total;

  _DayTotal({required this.date, required this.total});
}

class _MyChartState extends State<MyChart> {
  // 1 birim = 100 TL, max 1000 TL (10 birim) göstereceğiz
  static const double _unit = 100;
  static const double _maxY = 10;

  late List<_DayTotal> _dayTotals;

  @override
  Widget build(BuildContext context) {
    _dayTotals = _calculateDayTotals();

    if (_dayTotals.isEmpty) {
      return const Center(child: Text('Henüz harcama yok'));
    }

    return BarChart(mainBarData());
  }

  /// Harcamaları güne göre gruplayıp son 8 günü alıyoruz
  List<_DayTotal> _calculateDayTotals() {
    final Map<DateTime, double> totals = {};

    for (final expense in widget.expenses) {
      final day = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );

      totals[day] = (totals[day] ?? 0) + expense.amount.toDouble();
    }

    final days = totals.keys.toList()..sort();
    if (days.isEmpty) return [];

    // En fazla son 8 günü göster
    final startIndex = days.length > 8 ? days.length - 8 : 0;
    final selected = days.sublist(startIndex);

    return selected.map((d) => _DayTotal(date: d, total: totals[d]!)).toList();
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          // y = toplam / 100 → 100 TL = 1 birim
          toY: y,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            transform: const GradientRotation(pi / 40),
          ),
          width: 20,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: _maxY,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  /// Kaç gün varsa o kadar sütun
  List<BarChartGroupData> showingGroups() {
    return List.generate(_dayTotals.length, (i) {
      final total = _dayTotals[i].total;
      final y = (total / _unit).clamp(0, _maxY).toDouble(); // 100 TL = 1 birim
      return makeGroupData(i, y);
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      maxY: _maxY, // 10 birim → 1000 TL
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTiles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  /// Alt eksen: günler (01, 02, 03...)
  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final index = value.toInt();
    if (index < 0 || index >= _dayTotals.length) {
      return const SizedBox.shrink();
    }

    final day = _dayTotals[index].date.day.toString().padLeft(2, '0');

    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text(day, style: style),
    );
  }

  /// Sol eksen: 100, 200, 300 ... 1000
  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    // Sadece tam değerleri göster (1, 2, 3 ... 10)
    if (value % 1 != 0 || value <= 0 || value > _maxY) {
      return Container();
    }

    final labelValue = (value * _unit).toInt(); // 1 → 100 TL, 2 → 200 TL ...

    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text('$labelValue', style: style),
    );
  }
}
