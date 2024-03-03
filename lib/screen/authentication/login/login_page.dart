import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/provider/authentication_provider.dart';
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
        title: Text(AppLocalizations.of(context)!.loginTitle),
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.labelEmail,
                        hintText: AppLocalizations.of(context)!.hintEmail,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.errorEmail;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.labelPassword,
                        hintText: AppLocalizations.of(context)!.hintPassword,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.errorPassword;
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: context.watch<AuthenticationProvider>().isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await provider.login(emailController.text,
                                      passwordController.text, context);
                                  if (provider.state == ResultState.success) {
                                    context.replaceNamed('list');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(provider.message),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.loginButton,
                                style: const TextStyle(color: Colors.white),
                              )),
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        context.goNamed('register');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.registerButton,
                        style: const TextStyle(color: Colors.white),
                      ),
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
