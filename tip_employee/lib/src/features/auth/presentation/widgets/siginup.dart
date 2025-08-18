import 'package:flutter/material.dart';

class Siginup extends StatefulWidget {
  const Siginup({super.key});

  @override
  State<Siginup> createState() => _LoginState();
}

class _LoginState extends State<Siginup> {
  bool _obscurePassword = true;
  @override
 Widget build(BuildContext context) {
    return   Form(
  
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          
              Container(
               color: const Color.fromARGB(255, 236, 234, 234),
                child: Column(
                  children: [
                    SizedBox(height: 25),

                    TextField(
                      decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5,
                          ),
                        ),
                        hintText: 'Your name',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5,
                          ),
                        ),
                        hintText: 'enter your Email',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),

                    TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter your password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.lock),
                        hintText: 'confirm your password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('At least 8 character'),
                    Text('At least 1 number'),
                    Text('both upper and lower case letters'),
                    SizedBox(height: 50),
                    Text(
                      'By signing up you agree to our By signing up you agree to our By signing up you agree to our By signing up you agree to our',
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          11,
                          172,
                          118,
                        ),
                        foregroundColor: const Color.fromARGB(
                          255,
                          248,
                          245,
                          245,
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: Center(child: Text('Sign up')),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
        ]

          
      
      ),
    ),
  );
  }
}