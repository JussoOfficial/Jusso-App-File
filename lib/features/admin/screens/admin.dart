import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/admin/widgets/pending_card.dart';

class AdminDashboard extends StatelessWidget {
  //
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PendingCard(),

            // Add more instances of PendingCard widget as needed
          ],
        ),
      ),
    );
  }
}
