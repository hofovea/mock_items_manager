import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mock_items_manager/app/feats/auth/domain/providers/auth_provider.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';
import 'package:mock_items_manager/utils/router/router.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _login = '';
  String _password = '';

  void _signUp() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<AuthProvider>(context, listen: false).signUp(_login, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Consumer<AuthProvider>(
        builder: (BuildContext context, AuthProvider value, Widget? child) {
          if (Provider.of<AuthProvider>(context).currentUser != null) {
            context.router.replace(const DashboardRoute());
          }
          return Form(
            key: _formKey,
            child: Stack(
              children: [
                if (Provider.of<AuthProvider>(context).errorMessage != null) ...[
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cancel_outlined, size: 125),
                          const SizedBox(height: 15),
                          Flexible(
                            child: Text(
                              textAlign: TextAlign.center,
                              Provider.of<AuthProvider>(context).errorMessage!,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Login'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your login';
                        }
                        return null;
                      },
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false).resetFailure();
                      },
                      onSaved: (value) {
                        _login = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false).resetFailure();
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign Up'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false).resetFailure();
                        context.router.replace(const SignInFormRoute());
                      },
                      child: const Text('Already got an account? Sign In'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
