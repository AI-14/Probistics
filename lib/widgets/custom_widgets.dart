import 'package:flutter/material.dart';
import 'package:charcode/html_entity.dart';

Widget getCustomContainer({String title, String subtitle, Color color}) {
  return Container(
      height: 300.0,
      width: 200.0,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
      ));
}

void showErrorMessage(String errorMessage, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        SizedBox(width: 8.0),
        Expanded(child: Text(errorMessage))
      ]),
      duration: Duration(seconds: 2),
    ));
  }


  Widget outputListDisc(probistics, textStyle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: ListView(
            children: [
              ListTile(
                  title:
                      Text("P(X<x) = ${probistics['LT']}", style: textStyle)),
              ListTile(
                  title: Text("P(X\u2264x) = ${probistics['LTE']}",
                      style: textStyle)),
              ListTile(
                  title:
                      Text("P(X>x) = ${probistics['GT']}", style: textStyle)),
              ListTile(
                  title: Text("P(X\u2265x) = ${probistics['GTE']}",
                      style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($mu)} = ${probistics['Mean']}",
                      style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($sigma)}\u00B2 = ${probistics['Variance']}",
                      style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($sigma)} = ${probistics['Standard Deviation']}",
                      style: textStyle)),
            ],
          ),
        ),
      ),
    );
  }

Widget outputListCont(probistics, textStyle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: ListView(
            children: [
              ListTile(
                  title:
                      Text("P(X<x) = ${probistics['LT']}", style: textStyle)),
              ListTile(
                  title:
                      Text("P(X>x) = ${probistics['GT']}", style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($mu)} = ${probistics['Mean']}",
                      style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($sigma)}\u00B2 = ${probistics['Variance']}",
                      style: textStyle)),
              ListTile(
                  title: Text(
                      "${String.fromCharCode($sigma)} = ${probistics['Standard Deviation']}",
                      style: textStyle)),
            ],
          ),
        ),
      ),
    );
  }