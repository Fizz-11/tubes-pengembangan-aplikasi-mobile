import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
class _AuthScaffold extends StatelessWidget {
  const _AuthScaffold({required this.title, required this.subtitle, required this.children});
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teal,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.fitness_center,
                  size: 70, color: Color(0xFFC8421F)),
            ),
            const SizedBox(height: 12),
            Text('GYMKU', style: AppText.logo(32)),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(40, 22, 40, 28),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(color: Color(0x40000000), blurRadius: 20)
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: AppText.heading(27)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: AppText.label(18)),
                      const SizedBox(height: 22),
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _name = TextEditingController();
  final _pw = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _pw.dispose();
    super.dispose();
  }

  void _submit() {
    final err = context.read<AppState>().login(_name.text, _pw.text);
    if (err != null) toast(context, err);
  }

  void _showForgotPasswordHelp() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset password'),
        content: const Text(
          'Fitur reset password belum tersedia karena aplikasi belum '
          'terhubung ke backend. Silakan hubungi admin gym untuk bantuan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Masuk untuk melanjutkan',
      children: [
        PillField(controller: _name, hint: 'Nama'),
        const SizedBox(height: 18),
        PillField(controller: _pw, hint: 'Password', obscure: true),
        const SizedBox(height: 10),
        TextButton(
          onPressed: _showForgotPasswordHelp,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black45,
            minimumSize: const Size(double.infinity, 44),
            padding: EdgeInsets.zero,
          ),
          child: Text('Lupa Password?',
              style: AppText.body(15, color: Colors.black45)),
        ),
        const SizedBox(height: 36),
        PrimaryButton('Masuk', onPressed: _submit),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Belum punya akun? ',
                style: AppText.body(15, color: Colors.black45)),
            GestureDetector(
              onTap: () => context.go('/register'),
              child: Text('Daftar sekarang',
                  style: AppText.body(15, color: AppColors.teal)),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Demo: Naufal Badu / Gymku123 (member) • Tamu Baru / Gymku123 (belum member) • admin / admin123',
          textAlign: TextAlign.center,
          style: AppText.body(10.5, color: Colors.black38),
        ),
      ],
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pw = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pw.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    final err = context
        .read<AppState>()
        .register(_name.text, _email.text, _pw.text, _confirm.text);
    if (err != null) toast(context, err);
  }

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      title: 'Selamat datang',
      subtitle: 'Daftar untuk melanjutkan',
      children: [
        PillField(controller: _name, hint: 'Nama'),
        const SizedBox(height: 14),
        PillField(
            controller: _email, hint: 'Email', keyboard: TextInputType.emailAddress),
        const SizedBox(height: 14),
        PillField(controller: _pw, hint: 'Password', obscure: true),
        const SizedBox(height: 14),
        PillField(controller: _confirm, hint: 'Konfirmasi password', obscure: true),
        const SizedBox(height: 26),
        PrimaryButton('Daftar', onPressed: _submit),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sudah punya akun? ',
                style: AppText.body(15, color: Colors.black45)),
            GestureDetector(
              onTap: () => context.go('/login'),
              child: Text('Login sekarang',
                  style: AppText.body(15, color: AppColors.teal)),
            ),
          ],
        ),
      ],
    );
  }
}
