import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/home/screens/search_user_profile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Padding(
            padding: EdgeInsets.all(21.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          SearchUserCard(
              userId: 'Uid', username: 'Jusso', profileImage: 'profileImage')
        ]),
      ),
    );
  }
}

class SearchUserCard extends StatelessWidget {
  final String userId;
  final String username;
  final String profileImage;

  const SearchUserCard({
    Key? key,
    required this.userId,
    required this.username,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchUserProfile(),
          ),
        );
      },
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.deepOrange,
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
