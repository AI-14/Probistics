import 'package:flutter/material.dart';
import 'package:charcode/html_entity.dart';
import 'package:probistics/utils/disc_prob_dist_calc/binom_dist.dart';
import 'package:probistics/widgets/custom_widgets.dart';

class BinomialPage extends StatefulWidget {
  @override
  _BinomialPageState createState() => _BinomialPageState();
}

class _BinomialPageState extends State<BinomialPage> {
  Map<String, String> probistics;
  int n = 0, x = 0;
  double p = 0;

  final TextEditingController textEditingControllerOfN =
      TextEditingController();

  final TextEditingController textEditingControllerOfP =
      TextEditingController();

  final TextEditingController textEditingControllerOfX =
      TextEditingController();

  final textStyle = TextStyle(
      color: Colors.indigoAccent.shade100,
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
    x = int.parse(textEditingControllerOfX.text);
    n = int.parse(textEditingControllerOfN.text);
    p = double.parse(textEditingControllerOfP.text);

    if (x < 0 || x > n || n > 150 || n < 1 || p < 0.0 || p > 1.0)
      return false;
    else
      return true;
  }

  void _calculateProbistics() {
    if (textEditingControllerOfN.text.isEmpty ||
        textEditingControllerOfP.text.isEmpty ||
        textEditingControllerOfX.text.isEmpty) {
      showErrorMessage("Invalid input: Fields are empty!", context);
    } else if (textEditingControllerOfN.text.contains(",") ||
        textEditingControllerOfP.text.contains(",") ||
        textEditingControllerOfX.text.contains(",") ||
        textEditingControllerOfN.text.contains(".") ||
        textEditingControllerOfX.text.contains(".") ||
        textEditingControllerOfN.text.contains("-") ||
        textEditingControllerOfP.text.contains("-") ||
        textEditingControllerOfX.text.contains("-"))
      showErrorMessage("Invalid input: Special Character!", context);
    else if (_validContraints()) {
      setState(() {
        probistics = BinomialDistribution.getAllCasesOfBinomDist(
            int.parse(textEditingControllerOfN.text),
            double.parse(textEditingControllerOfP.text),
            int.parse(textEditingControllerOfX.text));
      });
    } else
      showErrorMessage(
          "Invalid input: x ${String.fromCharCode($notin)} [0, n] or n ${String.fromCharCode($notin)} [1, 150] or p ${String.fromCharCode($notin)} [0, 1]",
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
            fontSize: 20.0, color: Colors.indigoAccent.shade100, height: 0.7),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buildProbistifyButton() {
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
          title: Text("Binomial Distribution",
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
                    controller: textEditingControllerOfN, labelText: "n"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfP, labelText: "p"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfX, labelText: "x"),
                SizedBox(height: 20.0),
                _buildProbistifyButton(),
                SizedBox(height: 2.0),
                Divider(
                  color: Colors.indigoAccent.shade100,
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
