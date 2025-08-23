import 'package:flutter/material.dart';

class Transacton extends StatefulWidget {
  const Transacton({super.key});

  @override
  State<Transacton> createState() => _TransactonState();
}

class _TransactonState extends State<Transacton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
               Container(
                child: Column(
                  children: [
                    Text('$10000')
                    Text('acount')
                  ],

                ),
                
               ),
                 Container(
                child: Column(
                  children: [
                    Text('$10000')
                    Text('with drw')
                  ],

                ),
                
               ),
               horizontal scroll(
                //today,//month//year
               )
               Row(
                children: [
                   //search bar
                   Spacer(),


                ],
               )
               Container(
               text(todAY)
               ...
               yesterday
               ..
               last 7 day
               )
              
              ],
            )
          ],
        ),
      ),
    );
  }
}