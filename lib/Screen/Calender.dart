import 'package:flutter/material.dart';
import '../Helper/color.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(8), // Adjust padding inside container
          child: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white, //(0xff112C48),
        iconTheme: const IconThemeData(color: colors.secondary),
        title: const Text("Calendar"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: Container(
        //       height: 40,
        //       width: 40,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(5), color: Colors.white),
        //       child: IconButton(
        //         icon: const Icon(Icons.notifications),
        //         onPressed: () {
        //           // Add your notification icon tap logic here
        //         },
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),
              child:
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colors.darkColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Date: 25 Nov 83",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Time: 5:00pm",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Date: Dipti Vaidya",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Ph no: 888888899992",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text("Hair cut",),
                                // Text("Hair colour touch up",),
                                // Text("Hair Wash",),
                                // SizedBox(
                                //     width: 150,
                                //     child: Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                              ],
                            ),
                            //               SizedBox(
                            // width: 80,
                            //               ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Paid',
                                    style: TextStyle(color: colors.grad1Color)),
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset(
                                      'assets/images/placeholder.png'),
                                )
                              ],
                            ),
                            // Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hair cut",
                            ),
                            Text(
                              "Hair colour touch up",
                            ),
                            Text(
                              "Hair Wash",
                            ),
                            Text(
                              "Note : I want to get it dont before 6:00. have to go to part.",
                              style: TextStyle(
                                  fontSize: 10, color: colors.grad1Color),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: colors.darkColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Date: 25 Nov 83",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Time: 5:00pm",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Date: Dipti Vaidya",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Ph no: 888888899992",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text("Hair cut",),
                                // Text("Hair colour touch up",),
                                // Text("Hair Wash",),
                                // SizedBox(
                                //     width: 150,
                                //     child: Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                              ],
                            ),
                            //               SizedBox(
                            // width: 80,
                            //               ),
                            Column(
                              children: const [
                                Text(
                                  'Canceled',
                                  style: TextStyle(color: colors.grad1Color),
                                ),
                              ],
                            ),
                            // Text("Note : I want to get it dont before 6:00. have to go to part.",style: TextStyle(fontSize: 10,color: colors.grad1Color),),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hair cut",
                            ),
                            Text(
                              "Hair colour touch up",
                            ),
                            Text(
                              "Hair Wash",
                            ),
                          ],
                        ),
                      ),
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
