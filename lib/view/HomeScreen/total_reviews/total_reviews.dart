import 'package:flutter/material.dart';

class TotalRatingScreen extends StatefulWidget {
  const TotalRatingScreen({super.key});

  @override
  State<TotalRatingScreen> createState() => _TotalRatingScreenState();
}

class _TotalRatingScreenState extends State<TotalRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
