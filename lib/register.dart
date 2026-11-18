import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService auth = AuthService();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : () async {
                if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) return;
                setState(() => loading = true);
                final user = await auth.registerWithEmail(
                    emailCtrl.text, passwordCtrl.text);
                if (user != null) {
                  await user.sendEmailVerification();
                }
                if (!mounted) return;
                setState(() => loading = false);
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                      'Verification email sent. Please check your inbox.')),
                  );
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration failed!')),
                  );
                }
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage())),
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
