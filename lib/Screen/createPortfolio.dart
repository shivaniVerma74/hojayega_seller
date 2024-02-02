import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/color.dart';

class CreatePortfolio extends StatefulWidget {
  const CreatePortfolio({Key? key}) : super(key: key);

  @override
  State<CreatePortfolio> createState() => _CreatePortfolioState();
}

class _CreatePortfolioState extends State<CreatePortfolio> {
  int? selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
              child: const Icon(Icons.arrow_back, color: colors.primary,)),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        title: const Text('Service Details'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Beauty Parlour',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedItemIndex = index;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/images/imgpsh_fullsize_anim.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Text("teststtst")
                            ],
                          ),
                        ),
                        if (selectedItemIndex == index)
                          const Positioned(
                             top: 10,
                            left: 15,
                            child: CircleAvatar(
                              backgroundColor: colors.secondary,
                              radius: 10,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: size.height * 0.64,
                width: size.height * 0.44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0XFF112c48),
                  ),
                ),
                child: MyListView(),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Hair Service',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Haircut',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '350/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Wash',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '100/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Spa',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Hair Color Touch Up',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '300/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Grooming',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(left: 10, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Shaving',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '350/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Nail Spa',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '100/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Groomin Feet',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 5, right: 10),
                //       child: Row(
                //         children: const [
                //           Padding(
                //             padding: EdgeInsets.only(right: 3, left: 10),
                //             child: Icon(
                //               Icons.circle,
                //               size: 10,
                //             ),
                //           ),
                //           Text(
                //             'Grooming Hand',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '300/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: 5, right: 3),
                //             child: Icon(
                //               Icons.circle,
                //               size: 22,
                //               color: Colors.green,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.only(left: 20, top: 10),
                //       child: Text(
                //         'Combo Offer',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Color(0XFF112c40),
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 25, right: 30),
                //       child: Row(
                //         children: const [
                //           Text(
                //             'Shaving + hair color +\n hair wash',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //           Spacer(),
                //           Text(
                //             '500/-',
                //             style:
                //             TextStyle(fontSize: 18, color: Color(0XFF112c40)),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           CircleAvatar(
                //             child: Center(child: Icon(Icons.add,color: colors.whiteTemp,)),
                //             backgroundColor: colors.secondary,
                //             maxRadius: 13,
                //           ),
                //           SizedBox(width: 5,),
                //           CircleAvatar(
                //             child: Icon(Icons.delete,color: colors.whiteTemp,),
                //             backgroundColor: colors.darkRed,
                //             maxRadius: 13,
                //           ),
                //           SizedBox(width: 5,),
                //           CircleAvatar(
                //             child: Icon(Icons.remove_red_eye,color: colors.whiteTemp,),
                //             backgroundColor: colors.primary,
                //             maxRadius: 13,
                //           ),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     Center(
                //       child: Container(
                //         height: 30,
                //         width: 280,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
                //         child: Center(
                //           child: const Text(
                //             'Note:rate might change as per work',
                //             style: TextStyle(
                //                 fontSize: 15, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         //  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentBooking()));
                //       },
                //       child: Center(
                //         child: Container(
                //           height: 40,
                //           width: 270,
                //           decoration: BoxDecoration(
                //
                //               borderRadius: BorderRadius.circular(10),
                //               color: Colors.green),
                //           child: const Center(
                //               child: Text(
                //                 'Done',
                //                 style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.white),
                //               )),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<bool> checkboxValues = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Three Text widgets
            SizedBox(width: MediaQuery.of(context).size.height*.01
            ),
            CircleAvatar(
              child: Text(
                '1',
                style: TextStyle(
                    color: Colors.white, fontSize: 10),
              ),
              backgroundColor: colors.primary,
              maxRadius: 8,
            ),
            SizedBox(width: MediaQuery.of(context).size.height*.01),
            Text("Hair Cut"),
           SizedBox(width: MediaQuery.of(context).size.height*.15
           ),
            Text("350/-"),
            // for (int i = 1; i <= 3; i++)
            //   Text(
            //     'Row ${index + 1}, Text $i',
            //     style: TextStyle(fontSize: 16),
            //   ),

            // Checkbox widget
            Checkbox(
              value: checkboxValues[index],
              onChanged: (value) {
                setState(() {
                  checkboxValues[index] = value!;
                });
              },
            ),
          ],
        );
      },
    );
  }
}



