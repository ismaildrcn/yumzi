import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumzi/presentation/screens/auth/auth_skeleton.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return AuthSkeleton(
      title: Column(
        children: [
          Text(
            'Verify Your Account',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A verification link has been sent to your email. Please check your inbox and click on the link to verify your account.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Form(
              child: Row(
                spacing: 16,
                children: [
                  _buildTextFormField(),
                  _buildTextFormField(),
                  _buildTextFormField(),
                  _buildTextFormField(),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Handle sign up action
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 56),
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return Expanded(
      child: TextFormField(
        style: GoogleFonts.anta(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          hintText: '0',
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSecondary.withAlpha(32),
          hintStyle: TextStyle(
            fontSize: 22,
            color: Theme.of(context).colorScheme.onSecondary.withAlpha(128),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: TextInputType.number,
        
      ),
    );
  }
}
