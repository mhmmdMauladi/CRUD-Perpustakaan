import 'package:flutter/material.dart';
import 'package:perpustakaan/constant.dart';
import 'package:perpustakaan/dashboard_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              "assets/splash.png",
              height: 320,
              width: 320,
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                textAlign: TextAlign.center,
                "Welcome to \nOur Library",
                style: TextStyle(
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(1),
              child: Text(
                textAlign: TextAlign.center,
                "Explore our book collection and \nenjoy a pleasant reading experience",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardPage()));
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColors,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
