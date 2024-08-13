import 'package:flutter/material.dart';

class CustomGenreContainer extends StatelessWidget {
  const CustomGenreContainer({
    super.key,
    required this.genre,
  });

  final String genre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 400,
      child: SingleChildScrollView(
        child: Container(
          decoration:  BoxDecoration(
            color:const Color.fromARGB(255, 189, 192, 194),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3)
    
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          
          padding: const EdgeInsets.all(15),
          child: Text('In this Radio Station you can enjoy of music like $genre', 
            style: const TextStyle(
              fontStyle: FontStyle.normal, 
              fontFamily: 'Roboto',
              fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}