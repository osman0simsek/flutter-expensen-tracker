import 'package:expenses_tracker/screens/stats/charts.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transaction",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: MyChart(expenses: expenses),
            ),
          ],
        ),
      ),
    );
  }
}
