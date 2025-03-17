import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'stats_component.dart';
import 'trend_graph_component.dart';
import 'shareholder_stats_component.dart';
import 'time_selector_component.dart';

class DashboardSliderComponent extends StatefulWidget {
  final Map<String, dynamic> companyData;
  final Map<String, dynamic> shareData;
  final Map<String, dynamic> shareholderData;
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const DashboardSliderComponent({
    required this.companyData,
    required this.shareData,
    required this.shareholderData,
    required this.selectedPeriod,
    required this.onPeriodSelected,
    super.key,
  });

  @override
  State<DashboardSliderComponent> createState() => _DashboardSliderComponentState();
}

class _DashboardSliderComponentState extends State<DashboardSliderComponent> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> getChartData(String period, bool isCompanyValuation) {
    final Random random = Random();
    double baseValue = isCompanyValuation ? 12200 : widget.shareData["shareValue"];
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> data = [];

    double formatValue(double value) {
      return double.parse(value.toStringAsFixed(2));
    }

    String formatTime(DateTime time) {
      switch (period) {
        case 'day':
          return DateFormat('hh:mm a').format(time);
        case 'week':
          return DateFormat('E').format(time);
        case 'month':
          return DateFormat('MMM dd').format(time);
        case 'year':
          return DateFormat('MMM').format(time);
        default:
          return '';
      }
    }

    switch (period) {
      case 'day':
        for (int i = 0; i < 24; i++) {
          baseValue += random.nextDouble() * (isCompanyValuation ? 100 : 0.1) - (isCompanyValuation ? 50 : 0.05);
          data.add({
            "time": formatTime(now.add(Duration(hours: i))),
            "value": formatValue(baseValue)
          });
        }
        break;
      case 'week':
        for (int i = 0; i < 7; i++) {
          baseValue += random.nextDouble() * (isCompanyValuation ? 300 : 0.3) - (isCompanyValuation ? 150 : 0.15);
          data.add({
            "time": formatTime(now.add(Duration(days: i))),
            "value": formatValue(baseValue)
          });
        }
        break;
      case 'month':
        for (int i = 0; i < 30; i++) {
          baseValue += random.nextDouble() * (isCompanyValuation ? 500 : 0.5) - (isCompanyValuation ? 200 : 0.2);
          data.add({
            "time": formatTime(now.add(Duration(days: i))),
            "value": formatValue(baseValue)
          });
        }
        break;
      case 'all':
        for (int i = 0; i < 12; i++) {
          baseValue += random.nextDouble() * (isCompanyValuation ? 2000 : 2) - (isCompanyValuation ? 1000 : 1);
          data.add({
            "time": formatTime(now.add(Duration(days: i * 30))),
            "value": formatValue(baseValue)
          });
        }
        break;
      default:
        return [];
    }

    return data;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define pages dynamically inside build method
    final List<Widget> pages = [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsComponent(
              title: "Valuation",
              totalValue: widget.companyData["totalValue"],
              percentageIncrease: widget.companyData["percentageIncrease"],
              amountIncrease: widget.companyData["amountIncrease"],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Fixed height for the graph to fit within the page
              child: TrendGraphComponent(
                chartData: getChartData(widget.selectedPeriod, true),
              ),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsComponent(
              title: "Share Price",
              totalValue: widget.shareData["shareValue"],
              percentageIncrease: widget.shareData["percentageIncrease"],
              amountIncrease: widget.shareData["amountIncrease"],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Fixed height for the graph to fit within the page
              child: TrendGraphComponent(
                chartData: getChartData(widget.selectedPeriod, false),
              ),
            ),
          ],
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 300, // Fixed height for the slider
          child: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
                (index) => buildDot(index),
          ),
        ),
      ],
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Theme.of(context).colorScheme.secondary : Colors.grey,
      ),
    );
  }
}