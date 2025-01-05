import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
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
        title: Text('Overview', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://th.bing.com/th/id/R.3b95fceac75e5d202e20c8847bad9ec6?rik=mIBiNcWyucttuA&riu=http%3a%2f%2fd3d71ba2asa5oz.cloudfront.net%2f72001808%2fimages%2fty-joey-001.jpg&ehk=aYZrGS1CkNJbMS5BvsorCNljHXQTj04Q3wM8glQM3iM%3d&risl=&pid=ImgRaw&r=0'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 16),
            _buildQuickTransfer(),
            SizedBox(height: 30),
            _buildRecentTransactions(),
          ],
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

  Widget _buildQuickTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Transfer',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildUserCard('Livia Bator', 'CEO'),
            _buildUserCard('Randy Press', 'Director'),
            _buildUserCard('Workman', 'Designer'),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Transactions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildTransactionItem(Icons.account_balance_wallet, "Deposit from my", "28 January 2021", "-\$850", Colors.red),
        _buildTransactionItem(Icons.paypal, "Deposit Paypal", "25 January 2021", "+\$2,500", Colors.green),
        _buildTransactionItem(Icons.person, "Jemi Wilson", "21 January 2021", "+\$5,400", Colors.green),
      ],
    );
  }

  Widget _buildTransactionItem(IconData icon, String title, String date, String amount, Color amountColor) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon, color: Colors.white)),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(amount, style: TextStyle(color: amountColor, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildUserCard(String name, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Text(name[0]),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
