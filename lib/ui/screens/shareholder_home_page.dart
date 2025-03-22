import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../components/dashboard/header_component.dart';
import '../components/dashboard/stats_component.dart';
import '../components/dashboard/trend_graph_component.dart';
import '../components/dashboard/time_selector_component.dart';
import '../components/dashboard/shareholder_stats_component.dart';
import '../components/dashboard/quick_actions_component.dart';
import '../components/dashboard/dashboard_slider_component.dart';
import 'package:railbus/ui/screens/news_and_announcements_screen.dart';
import 'transaction_history_screen.dart';
import 'support_request_screen.dart';
import 'package:railbus/ui/screens/new_transaction_screen.dart';

class ShareholderHomePage extends StatefulWidget {
  const ShareholderHomePage({super.key});

  @override
  State<ShareholderHomePage> createState() => _ShareholderHomePageState();
}

class _ShareholderHomePageState extends State<ShareholderHomePage> {
  int _selectedIndex = 0;
  String selectedPeriod = 'month';

  double get sharePrice {
    return companyData["totalValue"] / shareholderData["shares"];
  }

  // Simulated data (replace with API data in a real app)
  final Map<String, dynamic> shareholderData = {
    "name": "Ahmed Al Mansoori",
    "shares": 1500.0,
    "percentageOwnership": 2.5,
    "valuation": 183000.0,
  };

  final Map<String, dynamic> companyData = {
    "totalValue": 12200000.0,
    "percentageIncrease": 5.0,
    "amountIncrease": 100500.0,
  };

  final Map<String, dynamic> shareData = {
    "shareValue": 1220.0,
    "percentageIncrease": 6.1,
    "amountIncrease": 67.0,
  };

  List<Map<String, dynamic>> getChartData(String period) {
    final Random random = Random();
    double baseValue = 12200; // Starting value
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> data = [];

    double formatValue(double value) {
      return double.parse(value.toStringAsFixed(2)); // Ensure 2 decimal places
    }

    String formatTime(DateTime time) {
      return DateFormat('hh:mm a').format(time); // Format: "09:00 AM"
    }

    switch (period) {
      case 'day':
        for (int i = 0; i < 24; i++) {
          baseValue += random.nextDouble() * 100 - 50;
          data.add({
            "time": formatTime(now.add(Duration(hours: i))),
            "value": formatValue(baseValue)
          });
        }
        break;

      case 'week':
        for (int i = 0; i < 7; i++) {
          baseValue += random.nextDouble() * 300 - 150;
          data.add({
            "time": DateFormat('E').format(now.add(Duration(days: i))),
            "value": formatValue(baseValue)
          });
        }
        break;

      case 'month':
        for (int i = 0; i < 30; i++) {
          baseValue += random.nextDouble() * 500 - 200;
          data.add({
            "time": DateFormat('MMM dd').format(now.add(Duration(days: i))),
            "value": formatValue(baseValue)
          });
        }
        break;

      case 'all':
        for (int i = 0; i < 12; i++) {
          baseValue += random.nextDouble() * 2000 - 1000;
          data.add({
            "time": DateFormat('MMM').format(now.add(Duration(days: i * 30))),
            "value": formatValue(baseValue)
          });
        }
        break;

      default:
        return [];
    }

    return data;
  }

  void _onPeriodSelected(String period) {
    setState(() {
      selectedPeriod = period;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Quick Action Handlers
  void _onBuySharesTap() async{
    // Navigate to NewTransactionScreen and wait for result
    final newTransaction = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewTransactionScreen()),
    );
  }

  void _onTransactionHistoryTap() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _onAnnualReportsTap() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _onNewsTap() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildDashboard(),
      const TransactionHistoryScreen(),
      const NewsAndAnnouncementsScreen(),
      const SupportRequestScreen(),
    ];

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderComponent(shareholderName: shareholderData["name"]),
                const SizedBox(height: 24),
                DashboardSliderComponent(
                  companyData: companyData,
                  shareData: shareData,
                  shareholderData: shareholderData,
                  selectedPeriod: selectedPeriod,
                  onPeriodSelected: _onPeriodSelected,
                ),
                const SizedBox(height: 16),
                TimeSelectorComponent(
                  selectedPeriod: selectedPeriod,
                  onPeriodSelected: _onPeriodSelected,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShareholderStatsComponent(
                  shares: shareholderData["shares"],
                  percentageOwnership: shareholderData["percentageOwnership"],
                  valuation: shareholderData["valuation"],
                ),
                const SizedBox(height: 24),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                QuickActionsComponent(
                  onBuySharesTap: _onBuySharesTap,
                  onTransactionHistoryTap: _onTransactionHistoryTap,
                  onAnnualReportsTap: _onAnnualReportsTap,
                  onNewsTap: _onNewsTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}