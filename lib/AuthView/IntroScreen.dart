import 'package:flutter/material.dart';

import 'Login.dart';
import 'PageIndicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: controller,
            children: const [
              FirstScreen(),
              SecondScreen(),
              ThirdScreen(),
              FourthScreen(),
              FifthScreen(),
            ],
          ),
          PageIndicator(
            controller: controller,
            itemCount: 5,
          )
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/introimage.png',
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/1.png',
              scale: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'No middleman charges',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'correct the sentences- direct transection between user and merchant. No middleman charges for your products. Provide top-notch service to stand out in the market competition. it\'s your key to success!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/introimage.png',
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/2.png',
              scale: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'Everything you need in one place',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Hojayega makes it easy - no middle commission rates. Connect directly with your favorite shopkeepers or find the the best service providers in the city. seamless and simple',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/introimage.png',
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/2.png',
              scale: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'Boost Your Business Effortlessly',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: Text(
            //     'Discover the perfect solution to boost your business effortlessly – Hojayega! It',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // )
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Discover the perfect solution to boost your business effortlessly – Hojayega! It',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/introimage.png',
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/3.png',
              scale: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'Effortlessly Schedule Appointment Dates',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Get best service.Pre Book the service. save time and money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/introimage.png',
              fit: BoxFit.fill,
            )),
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/4.png',
              scale: 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'It\'s Flexibility At Your Fingertips!',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'No need to stress about updating your portfolio rates daily with Hojayega! Easily adjust and offer the best rates to yourloyal clients whenever you want',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                ),
              ),
          ),
        ),
      ],
    );
  }
}
