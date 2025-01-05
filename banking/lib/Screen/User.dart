import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isCurrencyNotificationEnabled = true;
  bool _isMerchantOrderEnabled = false;
  bool _isRecommendationEnabled = true;
  bool _isTwoFactorAuthEnabled = false;

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
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(text: 'Edit Profile'),
            Tab(text: 'Preference'),
            Tab(text: 'Security'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildEditProfile(),
            _buildPreference(),
            _buildSecurity(),
          ],
        ),
      ),
    );
  }

  Widget _buildEditProfile() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://th.bing.com/th/id/R.3b95fceac75e5d202e20c8847bad9ec6?rik=mIBiNcWyucttuA&riu=http%3a%2f%2fd3d71ba2asa5oz.cloudfront.net%2f72001808%2fimages%2fty-joey-001.jpg&ehk=aYZrGS1CkNJbMS5BvsorCNljHXQTj04Q3wM8glQM3iM%3d&risl=&pid=ImgRaw&r=0'),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  // Handle edit photo
                },
                color: Colors.blueAccent,
                iconSize: 24,
                padding: EdgeInsets.all(5),
                constraints: BoxConstraints(),
                visualDensity: VisualDensity.compact,
              )
            ],
          ),
          SizedBox(height: 20),
          _buildTextField("Your Name", "Charlene Reed"),
          SizedBox(height: 20),
          _buildTextField("User Name", "Charlene Reed"),
          SizedBox(height: 20),
          _buildTextField("Email", "user@gmail.com"),
          SizedBox(height: 20),
          _buildTextField("Password", "********", obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle profile update
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildPreference() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          _buildTextField("Currency", "USD"),
          SizedBox(height: 20),
          _buildTextField("Time Zone", "(GMT-12:00) International Date Line West"),
          SizedBox(height: 20),
          Text('Notification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildSwitchTile(
            "I send or receive digital currency",
            _isCurrencyNotificationEnabled,
            (value) {
              setState(() {
                _isCurrencyNotificationEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            "I receive merchant order",
            _isMerchantOrderEnabled,
            (value) {
              setState(() {
                _isMerchantOrderEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            "There are recommendations for my account",
            _isRecommendationEnabled,
            (value) {
              setState(() {
                _isRecommendationEnabled = value;
              });
            },
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle save action
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurity() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Two-factor Authentication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildSwitchTile(
            "Enable or disable two-factor authentication",
            _isTwoFactorAuthEnabled,
            (value) {
              setState(() {
                _isTwoFactorAuthEnabled = value;
              });
            },
          ),
          SizedBox(height: 20),
          Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildTextField("Current Password", "Charlene@123", obscureText: true),
          SizedBox(height: 20),
          _buildTextField("New Password", "Charlene@123", obscureText: true),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle password change
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        hintText: placeholder,
      ),
    );
  }

  Widget _buildSwitchTile(String text, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
