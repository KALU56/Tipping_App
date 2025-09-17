import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tip_employee/app/routes/app_routes.dart';

import '../../data/models/auth_model.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController employeeCodeController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureEmployeeCode = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Signup successful!")));
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/Signup.svg', height: 100),
                const SizedBox(height: 16),
                _buildTextField('First Name', firstNameController),
                const SizedBox(height: 8),
                _buildTextField('Last Name', lastNameController),
                const SizedBox(height: 8),
                _buildTextField('Email', emailController),
                const SizedBox(height: 16),
                _buildTextField('Password', passwordController, obscureText: _obscurePassword, toggleObscure: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                }),
                const SizedBox(height: 16),
                _buildTextField('Employee Code', employeeCodeController, obscureText: _obscureEmployeeCode, toggleObscure: () {
                  setState(() => _obscureEmployeeCode = !_obscureEmployeeCode);
                }),
                const SizedBox(height: 25),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state is AuthLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              final firstName = firstNameController.text.trim();
                              final lastName = lastNameController.text.trim();
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final employeeCode = employeeCodeController.text.trim();

                              context.read<AuthBloc>().add(SignupRequested(
                                    SignupModel(
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email,
                                      password: password,
                                      employeeCode: employeeCode,
                                    ),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50)),
                            child: const Text('Sign Up'),
                          );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: theme.textTheme.bodyMedium),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: Text("Login",
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, VoidCallback? toggleObscure}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            suffixIcon: toggleObscure != null
                ? IconButton(
                    icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: toggleObscure,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
