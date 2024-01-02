import 'package:flutter/material.dart';

import '../Helper/color.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({Key? key}) : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          title: const Text('Delivery '),
          backgroundColor: colors.primary),
       body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/homered.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: const [
                        Text("Delivery Card Balance ", style: TextStyle(fontWeight: FontWeight.w600, color: colors.whiteTemp,fontSize: 19 ),),
                       SizedBox(height: 10,),
                        Text("RS. 500", style: TextStyle(fontWeight: FontWeight.w600, color: colors.whiteTemp,fontSize: 23 )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add Money"),
            ],
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.whiteTemp),
                child: TextFormField(
                  // controller: ,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fill This Field';
                    }
                    return null;
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Add Money",
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    // labelText: 'Email/Phone Number',
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.grey.shade200)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
