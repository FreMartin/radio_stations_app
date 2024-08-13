import 'package:flutter/material.dart';

class CustomHomePageContainer extends StatelessWidget {
  const CustomHomePageContainer({
    super.key,
    required this.homePage,
  });

  final String homePage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Home Page:', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 18
          ),
        ),
    
        Text(
          homePage, 
          style: const TextStyle(
            color: Color.fromARGB(255, 13, 94, 160),
            fontWeight: FontWeight.bold, 
            decoration: TextDecoration.underline,
            decorationColor:Color.fromARGB(255, 13, 94, 160) ,
            fontFamily: 'Roboto',
            fontSize: 15
          ),
        ),
      ],
    );
  }
}
