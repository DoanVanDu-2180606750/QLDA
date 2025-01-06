import 'package:banking/Screen/CardDetails.dart';
import 'package:banking/Screen/SignIn.dart';
import 'package:banking/Services/authGg_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;
  final _authGg = AuthGgService();

  @override
  Widget build(BuildContext context) {
    final theme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    final backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu Example'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'logout') {
                  // Handle logout logic
                } else if (result == 'dark_mode') {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ElevatedButton(
                    onPressed: (){
                      _authGg.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                    }
                  , child: Icon(Icons.logout)
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'dark_mode',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode'),
                      Switch(
                        value: _isDarkMode,
                        onChanged: (bool value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 20),
              _buildMyCardsSection(),
              SizedBox(height: 20),
              _buildStatsGrid(textColor),
              SizedBox(height: 20),
              _buildStatistics(textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for something",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildMyCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Cards", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardDetailsScreen()),
                );
              },
              child: Text("See All"),
            ),
          ],
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCard('Văn Dự', '\$5,756', '12/22', '3778 **** **** 1234'),
              SizedBox(width: 10),
              _buildCard('Bảo Ngân', '\$10,756', '12/22', '3778 **** **** 5678'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String holder, String balance, String validThru, String number) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      width: 340,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance",
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            balance,
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Text(
            "CARD HOLDER",
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            holder,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VALID THRU",
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    validThru,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFeatures: [FontFeature.tabularFigures()],
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildStatCard("My Balance", "\$12,750", Icons.account_balance_wallet, textColor),
          _buildStatCard("Income", "\$5,600", Icons.attach_money, textColor),
          _buildStatCard("Expense", "\$3,460", Icons.money_off, textColor),
          _buildStatCard("Total Saving", "\$7,920", Icons.savings, textColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Icon(icon, color: Colors.blue, size: 24),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expense Statistics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        SizedBox(height: 20),
        _buildPieChart(),
      ],
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 30, title: '30%', color: Color(0xff74b9ff), radius: 60),
            PieChartSectionData(value: 15, title: '15%', color: Color(0xff00b894), radius: 60),
            PieChartSectionData(value: 20, title: '20%', color: Color(0xfffdcb6e), radius: 60),
            PieChartSectionData(value: 35, title: '35%', color: Color(0xffd63031), radius: 60),
          ],
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 30,
        ),
      ),
    );
  }
}
