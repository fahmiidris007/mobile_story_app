import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
import 'package:mobile_story_app/screen/Authentication/register/register_page.dart';
import 'package:mobile_story_app/screen/home/home_page.dart';
import 'package:mobile_story_app/screen/story/list/list_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<AuthenticationProvider>(
                builder: (context, provider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await provider.login(
                                emailController.text, passwordController.text);
                            if (provider.state == ResultState.success) {
                              context.goNamed('home');
                            } else if (provider.state == ResultState.loading) {
                              const CircularProgressIndicator();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(provider.message),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        context.goNamed('register');
                      },
                      child: const Text('Register'),
                    )),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
