import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PendingCard extends StatefulWidget {
  const PendingCard({Key? key}) : super(key: key);

  @override
  _PendingCardState createState() => _PendingCardState();
}

class _PendingCardState extends State<PendingCard> {
  late Future<List<Map<String, dynamic>>> _businessUsersFuture;

  @override
  void initState() {
    super.initState();
    _businessUsersFuture = _fetchBusinessUsers();
  }

  Future<List<Map<String, dynamic>>> _fetchBusinessUsers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // Retrieve the business users collection
      QuerySnapshot querySnapshot =
          await firestore.collection('BusinessUsers').get();

      // Extract required data parameters
      List<Map<String, dynamic>> businessUsersList = [];
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        businessUsersList.add({
          'status': doc['status'],
          'accountType': doc['accountType'],
          'businessName': doc['businessName'],
        });
      });

      return businessUsersList;
    } catch (e) {
      print('Error fetching business users: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _businessUsersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> businessUsersList = snapshot.data ?? [];
          return Column(
            children: businessUsersList
                .map((businessUser) => _buildPendingCard(businessUser))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildPendingCard(Map<String, dynamic> businessUser) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${businessUser['businessName']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${businessUser['status']}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Account Type: ${businessUser['accountType']}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown and button widgets here...
              ],
            ),
          ],
        ),
      ),
    );
  }
}
