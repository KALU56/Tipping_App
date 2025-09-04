import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_state.dart';
import '../../data/models/auth_model.dart';

import '../blocs/auth_event.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureEmployCode = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController employCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Signup successful!")));
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/Signup.svg', height: 100),
                  const SizedBox(height: 10),
                  Text('Create Your Account',
                      style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  _buildTextField('First name', firstNameController),
                  const SizedBox(height: 8),
                  _buildTextField('Last name', lastNameController),
                  const SizedBox(height: 8),
                  _buildTextField('Email', emailController),
                  const SizedBox(height: 16),
                  _buildPasswordField('Password', passwordController, _obscurePassword, (v) {
                    setState(() => _obscurePassword = !_obscurePassword);
                  }),
                  const SizedBox(height: 16),
                  _buildPasswordField('Employ-code', employCodeController, _obscureEmployCode, (v) {
                    setState(() => _obscureEmployCode = !_obscureEmployCode);
                  }),
                  const SizedBox(height: 25),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return state is AuthLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(SignupRequested(
                                      SignupModel(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        employCode: employCodeController.text,
                                      ),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Signup'),
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
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(controller: controller, decoration: InputDecoration(hintText: 'Enter your $label')),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, void Function(bool) toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () => toggle(obscureText),
            ),
          ),
        ),
      ],
    );
  }
}
