library fluid_slider;

import 'package:flutter/material.dart';

class FluidSlider extends StatefulWidget {
  final min;
  final max;
  final onValue;
  final onSlide;
  final int value;
  final Color sliderColor;
  final Color textColor;

  FluidSlider(
      {Key key,
      @required this.min,
      @required this.max,
      @required this.onValue,
      this.onSlide,
      this.textColor,
      this.value,
      this.sliderColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FluidSliderState(this.textColor);
}

class FluidSliderState extends State<FluidSlider> {
  double indicatorBottom = 3;
  double indicatorLeft = 0;
  double sliderBarWidth = 0;
  bool isBubbleActive = false;
  TextStyle textStyle;
  final Color textColor;

  int sliderValue = 0;

  FluidSliderState(this.textColor) {
    textStyle = TextStyle(color: textColor ?? Colors.white, fontWeight: FontWeight.bold, fontSize: 13);
  }

  @override
  void initState() {
    super.initState();
    // To set initial position -> indicatorLeft = ((widget.value / widget.max) * (sliderBarWidth - 30));
  }

  void onLayoutUpdate(maxWidth) {}

  void onPanStart(DragStartDetails details) {
    setState(() {
      indicatorBottom = 35;
      isBubbleActive = true;
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      indicatorBottom = 3;
      isBubbleActive = false;
    });
    widget.onValue(sliderValue);
  }

  int getSliderValue(double position) {
    return (((indicatorLeft + position) / (sliderBarWidth - 36)) * widget.max).roundToDouble().toInt();
  }

  void onPanUpdate(DragUpdateDetails details) {
    double position = details.delta.dx;
    if (indicatorLeft + position > 0 && indicatorLeft + position < (sliderBarWidth - 36.0)) {
      if (widget.onSlide != null && getSliderValue(position) != sliderValue) {
        widget.onSlide(sliderValue);
      }
      setState(() {
        sliderValue = getSliderValue(position);
        indicatorLeft += position;
      });
    }
  }

  Widget renderRangeIndicator(String rangeIndicatorValue) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(rangeIndicatorValue, style: textStyle),
    );
  }

  Widget sliderBarLayout(context, BoxConstraints constraints) {
    sliderBarWidth = constraints.maxWidth;
    return Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      renderRangeIndicator(widget.min.toString()),
      renderRangeIndicator(widget.max.toString()),
    ]);
  }

  Widget sliderBar() {
    return AnimatedContainer(
        duration: Duration(microseconds: 300),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: widget.sliderColor ?? Colors.indigo,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(188, 188, 188, 1),
                blurRadius: 5.0, // has the effect of softening the shadow
                spreadRadius: 0.5, // has the effect of extending the shadow
                offset: Offset(2, 2),
              )
            ]),
        child: LayoutBuilder(builder: sliderBarLayout));
  }

  Widget sliderIndicator() {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanEnd: onPanEnd,
      onPanUpdate: onPanUpdate,
      child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 250),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: widget.sliderColor ?? Colors.indigo, width: 2),
            color: Colors.white,
          ),
          child: Center(
              child: (Text(sliderValue.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72,
        child: Flex(direction: Axis.vertical, mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Stack(children: [
            Positioned.fill(
                bottom: 0,
                child: Padding(padding: EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 36), child: sliderBar())),
            AnimatedPositioned(
                duration: Duration(milliseconds: 50),
                bottom: indicatorBottom,
                left: indicatorLeft,
                child: Padding(padding: EdgeInsets.only(left: 8, right: 8), child: sliderIndicator()))
          ]))
        ]));
  }
}