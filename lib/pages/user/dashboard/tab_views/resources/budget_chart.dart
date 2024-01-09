import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/models/participant_model.dart';

class BudgetChart extends StatefulWidget {
  final List<ParticipantModel> participants;
  const BudgetChart({super.key, required this.participants});

  @override
  State<BudgetChart> createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  List<Color> colors = [
    Color(0xFF0D47A1),
    Color(0xFF1565C0),
    Color(0xFF1976D2),
    Color(0xFF1E88E5),
    Color(0xFF2196F3),
    Color(0xFF42A5F5),
    Color(0xFF64B5F6),
    Color(0xFF90CAF9),
    Color(0xFFBBDEFB),
    Color(0xFFE3F2FD),
  ];
  List<PieChartSectionData> showSections() {
    List<PieChartSectionData> sections = [];
    for (var i = 0; i < widget.participants.length; i++) {
      final percentage =
          widget.participants[i].contribution!['inPercent']! * 100;
      sections.add(
        showData(percentage, widget.participants[i].firstName!, colors[i % 10]),
      );
    }
    return sections;
  }

  PieChartSectionData showData(double value, String label, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '$value %',
      badgeWidget: Text(label),
      titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
      badgePositionPercentageOffset: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: AspectRatio(
        aspectRatio: 2.6,
        child: PieChart(
          PieChartData(
            sections: showSections(),
          ),
        ),
      ),
    );
  }
}
