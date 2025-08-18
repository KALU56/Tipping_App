import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
 
  final ImageProvider image;
  final int count;
  final Color backgroundColor;

  const TaskCard({
    super.key,
    required this.title,
    required this.image,
   
    required this.count,
    this.backgroundColor = const Color.fromARGB(255, 136, 205, 245),

  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 50,
        child: GestureDetector(
       
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 25,
                  height: 25,
        
                  decoration: BoxDecoration(
                    image: DecorationImage(image:image),
                  ),
                ),
                const SizedBox(height: 10),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(count.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}