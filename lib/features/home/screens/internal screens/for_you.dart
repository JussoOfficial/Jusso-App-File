import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/home/widgets/for_you_content_widget.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key});

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: [
      ForYouContentWidget(),
    ]);
  }
}
