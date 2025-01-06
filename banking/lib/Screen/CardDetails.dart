import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => CardDetailsScreenState();
}

class CardDetailsScreenState extends State<CardDetailsScreen> {
  final List<CardItem> cardItems = [
    CardItem('Văn Dự', 'MB', '\$5,756',  '12/22', '3778 **** **** 1234' ),
    CardItem('Bảo Ngân','MB', '\$10,756', '12/22', '3778 **** **** 5678'),
  ];
  int money = Random( 100).nextInt(10000);
  final _cardTypeController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: cardItems.map((card) => _buildCard(card)).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Card Expense Statistics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildPieChart(),
            SizedBox(height: 20),
            _buildLegend(),
            SizedBox(height: 20),
            Text('Add New Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildAddCardForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(CardItem cardItem) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Balance', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
                  SizedBox(height: 8),
                  Text(cardItem.balance, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Type', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize : 16)),
                  SizedBox(height: 8),
                  Text(cardItem.type, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
              
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('CARD HOLDER', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  SizedBox(height: 4),
                  Text(cardItem.holder, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('VALID THRU', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                      SizedBox(height: 4),
                      Text(cardItem.validThru, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Text(
                cardItem.number,
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

  Widget _buildPieChart() {
    return Center(
      child: SizedBox(
        height: 200,
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(color: Color(0xff74b9ff), value: 25, radius: 60, title: ''),
              PieChartSectionData(color: Color(0xff0984e3), value: 25, radius: 60, title: ''),
              PieChartSectionData(color: Color(0xff6c5ce7), value: 25, radius: 60, title: ''),
              PieChartSectionData(color: Color(0xff7c4dff), value: 25, radius: 60, title: ''),
            ],
            sectionsSpace: 2,
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    // Build legend items as needed
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegendItem('DBL Bank', Color(0xff74b9ff)),
            _buildLegendItem('BRC Bank', Color(0xff0984e3)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegendItem('ABM Bank', Color(0xff6c5ce7)),
            _buildLegendItem('MCP Bank', Color(0xff7c4dff)),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        SizedBox(width: 8),
        Text(title),
      ],
    );
  }

  Widget _buildAddCardForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit Card information.",
            style: TextStyle(fontSize: 12),
            softWrap: true,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _cardTypeController,
            decoration: InputDecoration(
              labelText: "Card Type",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Name On Card",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _numberController,
            decoration: InputDecoration(
              labelText: "Card Number",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _expiryController,
            decoration: InputDecoration(
              labelText: "Expiration Date",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  cardItems.add(CardItem(
                    _nameController.text,
                    _cardTypeController.text,
                    '\$ $money',
                    _expiryController.text,
                    _numberController.text,
                  ));
                });
                // Clear form
                _cardTypeController.clear();
                _nameController.clear();
                _numberController.clear();
                _expiryController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Add Card'),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem {
  final String holder;
  final String type;
  final String balance;
  final String validThru;
  final String number;

  CardItem(this.holder, this.type, this.balance, this.validThru, this.number);
}