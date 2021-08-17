import 'package:flutter/material.dart';
import 'package:probistics/utils/disc_prob_dist_calc/hypergeom_dist.dart';
import 'package:charcode/html_entity.dart';
import 'package:probistics/widgets/custom_widgets.dart';
import 'dart:math';

class HypergeometricPage extends StatefulWidget {
  @override
  _HypergeometricPageState createState() => _HypergeometricPageState();
}

class _HypergeometricPageState extends State<HypergeometricPage> {
  Map<String, String> probistics;
  int K = 0, N = 0, n = 0, x = 0;

  final TextEditingController textEditingControllerOfK =
      TextEditingController();

  final TextEditingController textEditingControllerOfN =
      TextEditingController();

  final TextEditingController textEditingControllerOfn =
      TextEditingController();

  final TextEditingController textEditingControllerOfX =
      TextEditingController();

  final textStyle = TextStyle(
      color: Colors.blue.shade100,
      fontSize: 20.0,
      fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    probistics = Map<String, String>();
    probistics['E'] = 'N/A';
    probistics['LT'] = 'N/A';
    probistics['LTE'] = 'N/A';
    probistics['GT'] = 'N/A';
    probistics['GTE'] = 'N/A';
    probistics['Mean'] = 'N/A';
    probistics['Variance'] = 'N/A';
    probistics['Standard Deviation'] = 'N/A';
  }

  bool _validContraints() {
    n = int.parse(textEditingControllerOfn.text);
    K = int.parse(textEditingControllerOfK.text);
    N = int.parse(textEditingControllerOfN.text);
    x = int.parse(textEditingControllerOfX.text);

    int lowerLimitX = max(0, n + K - N);
    int upperLimitX = min(n, K);

    if (N < 0 ||
        N > 150 ||
        K < 0 ||
        K > N ||
        n < 0 ||
        n > N ||
        x < lowerLimitX ||
        x > upperLimitX)
      return false;
    else
      return true;
  }

  void _calculateProbistics() {
    if (textEditingControllerOfK.text.isEmpty ||
        textEditingControllerOfN.text.isEmpty ||
        textEditingControllerOfn.text.isEmpty ||
        textEditingControllerOfX.text.isEmpty) {
      showErrorMessage("Invalid input: Fields are empty!", context);
    } else if (textEditingControllerOfK.text.contains(",") ||
        textEditingControllerOfN.text.contains(",") ||
        textEditingControllerOfn.text.contains(",") ||
        textEditingControllerOfX.text.contains(",") ||
        textEditingControllerOfK.text.contains(".") ||
        textEditingControllerOfN.text.contains(".") ||
        textEditingControllerOfn.text.contains(".") ||
        textEditingControllerOfX.text.contains(".") ||
        textEditingControllerOfK.text.contains("-") ||
        textEditingControllerOfN.text.contains("-") ||
        textEditingControllerOfX.text.contains("-") ||
        textEditingControllerOfn.text.contains("-"))
      showErrorMessage("Invalid input: Special Character!", context);
    else if (_validContraints()) {
      setState(() {
        probistics = HypergeometricDistribution.getAllCasesOfHypergeometricDist(
            int.parse(textEditingControllerOfK.text), int.parse(textEditingControllerOfN.text), 
            int.parse(textEditingControllerOfn.text), int.parse(textEditingControllerOfX.text));
      });
    } else
      showErrorMessage(
          "Invalid input: N ${String.fromCharCode($notin)} [0, 500] and K, n ${String.fromCharCode($notin)} [0, N] and x ${String.fromCharCode($notin)} [max(0, n + K - N), min(n, K)]",
          context);
  }

  Widget _buildInputField(
      {TextEditingController controller, String labelText}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => controller.clear(),
            )),
        style: TextStyle(
            fontSize: 20.0, color: Colors.blue.shade100, height: 0.7),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget buildProbistifyButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton.icon(
        label: Text("Probistify"),
        onPressed: _calculateProbistics,
        icon: Icon(Icons.bar_chart_rounded),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Uniform Distribution",
              style: TextStyle(
                color: Colors.blueAccent,
              )),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black),
            child: ListView(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                _buildInputField(
                    controller: textEditingControllerOfK, labelText: "K"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfN, labelText: "N"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfn, labelText: "n"),
                SizedBox(height: 20.0),
                _buildInputField(
                    controller: textEditingControllerOfX, labelText: "x"),
                buildProbistifyButton(),
                SizedBox(height: 2.0),
                Divider(
                  color: Colors.blueAccent.shade100,
                  indent: 30.0,
                  endIndent: 30.0,
                  thickness: 2.0,
                ),
                SizedBox(child: outputListDisc(probistics, textStyle), height: 300.0),
              ],
            ),
          ),
        ));
  }
}
