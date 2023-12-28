import 'package:flutter/material.dart';


class PageIndicator extends StatefulWidget {
  const  PageIndicator({super.key, required this.itemCount, required this.controller});
  final int itemCount;
  final PageController controller;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}
class _PageIndicatorState extends State<PageIndicator> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() { setState(() {
    });});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.removeListener(() {setState(() {
    });});
  }
  @override
  Widget build(BuildContext context) {
    Widget indicatorElements(index){
      double width = 10;
      double height = 10;
      if(widget.controller.page == index){
        width=15;
        height=15;
      }
      return AnimatedContainer(
        duration:const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(2),
        height: height,
        width: width,
        decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
        ),
      );
    }
    return SizedBox(
      height: 50,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.itemCount,
          itemBuilder:(context, index){
            return indicatorElements(index);
          }
      ),
    );
  }
}
