import 'package:flutter/material.dart';

class WaitingAcceptView extends StatelessWidget {
  const WaitingAcceptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/waiting_for_accept.jpg',
              fit: BoxFit.contain,
            ),
            const Column(
              children: [
                Text(
                  'لقد تم تسجيل الدخول بنجاح',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Text(
                  'يتبقى الموافقة من قبل المسؤولين',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
