import 'package:axons/screen/create_pin.dart';
import 'package:axons/screen/login_with_pin.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget showLoginWithPin() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'เข้าสู่ระบบ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            LoginWithPin(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/axons.jpg", scale: 6),
              const SizedBox(height: 30),
              const Text(
                "จัดการฟาร์มกุ้ง",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 15),
              const Text(
                "ยินดีต้อนรับเข้าสู่ระบบการจัดการจองครบวงจร เพื่อคนเกษตรกรไทย ด้วยวัตรกรรมระดับสากล",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    isDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return showLoginWithPin();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "สมัครสมาชิก",
                  style: TextStyle(color: Colors.indigo, fontSize: 18),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "version 1.0",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                "© 2022 AXONS. All Rights Reserved.",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
