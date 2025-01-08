import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Transaction> _transactions = [
    Transaction(Icons.arrow_upward, "Spotify Subscription", "28 Jan, 12:30 AM", -2500),
    Transaction(Icons.arrow_downward, "Freepik Sales", "25 Jan, 10:40 PM", 750),
    Transaction(Icons.arrow_upward, "Mobile Service", "20 Jan, 10:40 PM", -150),
    Transaction(Icons.arrow_upward, "Wilson", "15 Jan, 03:29 PM", -1050),
    Transaction(Icons.arrow_downward, "Emilly", "14 Jan, 10:40 PM", 140),
    // Add more transactions for other months
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            
          },
        ),
        title: Text('Transaction', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://th.bing.com/th/id/R.3b95fceac75e5d202e20c8847bad9ec6?rik=mIBiNcWyucttuA&riu=http%3a%2f%2fd3d71ba2asa5oz.cloudfront.net%2f72001808%2fimages%2fty-joey-001.jpg&ehk=aYZrGS1CkNJbMS5BvsorCNljHXQTj04Q3wM8glQM3iM%3d&risl=&pid=ImgRaw&r=0'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBarChart(),
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'All Transactions'),
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTransactionList(
                    _transactions, 
                    (transaction) => true,
                  ),
                  _buildTransactionList(
                    _transactions.where((t) => t.amount > 0).toList(),
                    (transaction) => transaction.amount > 0,
                  ),
                  _buildTransactionList(
                    _transactions.where((t) => t.amount < 0).toList(),
                    (transaction) => transaction.amount < 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          barGroups: List.generate(12, (index) {
            return _buildBarData(index, _getMonthlyTotal(index), isTouched: index == DateTime.now().month - 1);
          }),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              )
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  );
                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                  return Text(months[value.toInt()], style: style);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getMonthlyTotal(int month) {
    double total = 0;
    final dateFormat = DateFormat("d MMM, h:mm a");
    for (var transaction in _transactions) {
      final transactionMonth = dateFormat.parse(transaction.date).month;
      if (transactionMonth == month + 1) {
        total += transaction.amount;
      }
    }
    return total.abs(); // Ensure positive values for graph representation
  }

  BarChartGroupData _buildBarData(int x, double y, {bool isTouched = false}) {
    final Color barColor = isTouched ? Colors.blue : Colors.grey[300]!;
    return BarChartGroupData(
      x: x,
      barRods: [BarChartRodData(toY: y, color: barColor, width: 16)],

    );
  }

  Widget _buildTransactionList(List<Transaction> transactions, [bool Function(Transaction)? filter]) {
    return ListView(
      children: transactions.map((transaction) {
        return _buildTransactionItem(
          transaction.icon,
          transaction.title,
          transaction.date,
          transaction.amount,
          transaction.amount > 0 ? Colors.green : Colors.red,
        );
      }).toList(),
    );
  }

  Widget _buildTransactionItem(IconData icon, String title, String date, double amount, Color amountColor) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: amountColor.withOpacity(0.1),
        child: Icon(icon, color: amountColor),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text('${amount > 0 ? '+' : ''}\$${amount.abs()}', style: TextStyle(color: amountColor, fontWeight: FontWeight.bold)),
    );
  }
}

class Transaction {
  final IconData icon;
  final String title;
  final String date;
  final double amount;

  Transaction(this.icon, this.title, this.date, this.amount);
}
