import 'package:flutter/material.dart';
import 'package:probistics/pages/continuous/exponential_page.dart';
import 'package:probistics/pages/continuous/lognormal_page.dart';
import 'package:probistics/pages/continuous/normal_page.dart';
import 'package:probistics/pages/continuous/uniform_page.dart';
import 'package:probistics/pages/continuous/weibull_page.dart';
import 'package:probistics/widgets/custom_widgets.dart';

class ContinuousList extends StatefulWidget {
  @override
  _ContinuousListState createState() => _ContinuousListState();
}

class _ContinuousListState extends State<ContinuousList> {
  int _scrolledIndex = 0;

  final _contListOptionsPages = [
    UniformCPage(),
    NormalPage(),
    ExponentialPage(),
    WeibullPage(),
    LognormalPage()
  ];

  void setScrolledIndexValue({int value}) {
    setState(() {
      _scrolledIndex = value;
    });
  }

  void _navigateToSelectedContPage(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _contListOptionsPages[_scrolledIndex];
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: GestureDetector(
        child: ListWheelScrollView(
          itemExtent: 140,
          physics: BouncingScrollPhysics(),
          diameterRatio: 1.3,
          offAxisFraction: 0.0,
          onSelectedItemChanged: (int index) =>
              setScrolledIndexValue(value: index),
          children: [
            getCustomContainer(
                title: "Uniform",
                subtitle: "Distribution - Continuous.",
                color: Colors.blue.shade100
            ),
            getCustomContainer(
                title: "Normal",
                subtitle: "Distribution - Zscore.",
                color: Colors.yellowAccent.shade100
            ),
            getCustomContainer(
                title: "Exponential",
                subtitle: "Distribution - Based on poisson point process.",
                color: Colors.purpleAccent.shade100
            ),
            getCustomContainer(
                title: "Weibull",
                subtitle: "Distribution - Maximum entropy.",
                color: Colors.orangeAccent.shade100
            ),
            getCustomContainer(
                title: "Lognormal",
                subtitle: "Distribution - Normally distributed logarithm.",
                color: Colors.indigoAccent.shade100
            ),
          ],
        ),
        onTap: () => _navigateToSelectedContPage(_scrolledIndex),
      ),
    );
  }
}
