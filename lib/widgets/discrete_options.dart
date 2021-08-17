import 'package:flutter/material.dart';
import 'package:probistics/pages/discrete/binomial_page.dart';
import 'package:probistics/pages/discrete/geometricII_page.dart';
import 'package:probistics/pages/discrete/geometricI_page.dart';
import 'package:probistics/pages/discrete/hypergeometric_page.dart';
import 'package:probistics/pages/discrete/negative_binom_page.dart';
import 'package:probistics/pages/discrete/poisson_page.dart';
import 'package:probistics/pages/discrete/uniform_page.dart';
import 'package:probistics/widgets/custom_widgets.dart';

class DiscreteList extends StatefulWidget {
  @override
  _DiscreteListState createState() => _DiscreteListState();
}

class _DiscreteListState extends State<DiscreteList> {
  int _scrolledIndex = 0;

  final _discreteListOptionsPages = [
    UniformPage(),
    BinomialPage(),
    GeometricIPage(),
    GeometricIIPage(),
    HypergeometricPage(),
    NegativeBinomialPage(),
    PoissonPage()
  ];

  void setScrolledIndexValue({int value}) {
    setState(() {
      _scrolledIndex = value;
    });
  }

  void _navigateToSelectedDiscretePage(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _discreteListOptionsPages[_scrolledIndex];
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
                subtitle: "Distribution - Based on uniformity.",
                color: Colors.orangeAccent.shade100),
            getCustomContainer(
                title: "Binomial",
                subtitle: "Distribution - Based on FITS principle.",

                color: Colors.indigoAccent.shade100),
            getCustomContainer(
                title: "Geometric I",
                subtitle: "Distribution - KFailures",
                color: Colors.purpleAccent..shade100),
            getCustomContainer(
                title: "Geometric II",
                subtitle: "Distribution - KTrials",
                color: Colors.yellowAccent.shade100),
            getCustomContainer(
                title: "Hypergeometric",
                subtitle: "Distribution - Based on finite population size.",
                color: Colors.blue.shade100),
            getCustomContainer(
                title: "Negative Binomial",
                subtitle: "Distribution - RSuccesses",
                color: Colors.pink.shade100),
            getCustomContainer(
                title: "Poisson",
                subtitle: "Distribution - Based on fixed interval.",
                color: Colors.greenAccent.shade100),
          ],
        ),
        onTap: () => _navigateToSelectedDiscretePage(_scrolledIndex),
      ),
    );
  }
}
