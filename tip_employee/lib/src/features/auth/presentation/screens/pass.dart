import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class Pass extends StatefulWidget {
  const Pass({super.key});

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome!',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Enter your credentials to continue'),
                const SizedBox(height: 25),

                // Email Field
                const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 236, 230, 230),
                        width: 1.5,
                      ),
                    ),
                    hintText: 'Enter your email',
                  ),
                ),

                const SizedBox(height: 20),

                // Passcode Field
                const Text('Passcode', style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your passcode',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 236, 230, 230),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 11, 172, 118),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Continue'),
                ),

                const SizedBox(height: 20),

                // Register Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'registered yet?',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}