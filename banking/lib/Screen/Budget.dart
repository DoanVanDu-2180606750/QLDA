
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<Budget> _budgets = [];
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();

  void _addBudget() {
    final enteredAmount = double.tryParse(_amountController.text);
    final name = _nameController.text;

    if (enteredAmount != null && name.isNotEmpty) {
      setState(() {
        _budgets.add(Budget(name, enteredAmount));
      });
      _amountController.clear();
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBudgetForm(),
            SizedBox(height: 20),
            Expanded(child: _buildBudgetList()),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: 'Budget Amount'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addBudget,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: Text('Add Budget'),
        ),
      ],
    );
  }

  Widget _buildBudgetList() {
    return ListView.builder(
      itemCount: _budgets.length,
      itemBuilder: (context, index) {
        final budget = _budgets[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(budget.name),
            trailing: Text('\$${budget.amount.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}

class Budget {
  final String name;
  final double amount;

  Budget(this.name, this.amount);
}