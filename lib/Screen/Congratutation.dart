import 'package:flutter/material.dart';
import 'package:hojayega_seller/Screen/HomeScreen.dart';
import '../Helper/color.dart';
import 'BottomBar.dart';
import 'CreateOnlineStore.dart';
class Congratutation extends StatefulWidget {
  const Congratutation({Key? key}) : super(key: key);

  @override
  State<Congratutation> createState() => _SuccessfullyState();
}

class _SuccessfullyState extends State<Congratutation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Image.asset("assets/images/done.png", height: 100,),
            const SizedBox(height: 15),
            const Text("Congratulations!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20),
              child: Text("Your Store Has Been Created. Now, Add Your Products And You're Ready To Go Live",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.7,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.secondary),
                child: const Center(
                  child: Text("Got It",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: colors.appbarColor),
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
