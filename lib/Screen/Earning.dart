import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/color.dart';

class Earning extends StatefulWidget {
  const Earning({Key? key}) : super(key: key);

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  int selected = 0;
  String? date1;
  String? date2;
  bool showDate = true;
  DateTime initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text('Earnings'),
        backgroundColor: colors.primary
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: selected == 0
                                ? colors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: colors.primary)),
                        child: Center(
                          child: Text(
                            'Earnings',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selected == 0
                                    ? Colors.white
                                    : colors.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: selected == 1
                                  ? colors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: colors.primary)),
                          child: Center(
                            child: Text(
                              'Acc Summary',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected == 1
                                      ? Colors.white
                                      : colors.primary),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          selected == 0 ?
          Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(top: 0, left: 13,),
                child: Row(
                  children: [
                    const Text(
                      'Date:',
                      style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date1 ?? " Select date",
                      style: const TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      date2 != null ? " to $date2 " : " to Select date",
                      style: const TextStyle(
                          color:colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    showDate
                        ? IconButton(
                        onPressed: () async {
                          DateTime? selectedDate1 = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2023, 12, 31));

                          if (selectedDate1 != null) {
                            setState(() {
                              initialDate =
                                  selectedDate1.add(const Duration(days: 1));
                              date1 =
                              "${selectedDate1.day}/${selectedDate1
                                  .month}/${selectedDate1.year}";
                              showDate = false;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color:colors.primary,
                        ))
                        : IconButton(
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: initialDate,
                              lastDate: DateTime(2023, 12, 31));

                          if (selectedDate != null) {
                            setState(() {
                              date2 =
                              "${selectedDate.day}/${selectedDate
                                  .month}/${selectedDate.year}";
                              showDate = true;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: colors.primary,
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ): SizedBox()
        ],
      ),
    );
  }
}
