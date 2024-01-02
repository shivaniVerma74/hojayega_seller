import 'package:flutter/material.dart';
import '../Helper/color.dart';
import 'CreateOnlineStore.dart';
class ThankYou extends StatefulWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  State<ThankYou> createState() => _SuccessfullyState();
}

class _SuccessfullyState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Image.asset("assets/images/done.png"),
            const SizedBox(height: 15),
            const Text("Thanks for signing up!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(" Your Verification Will Be Done In 3 Working Days, So You Can Go Live On Our Platform. While You Wait, Take A Moment To Set Up Your Store Or Portfolio.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOnlineStore()));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.8,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                child: const Center(
                  child: Text("Done",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: colors.appbarColor),
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
