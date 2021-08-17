import 'package:flutter/material.dart';
import 'package:probistics/widgets/custom_widgets.dart';
import 'package:charcode/html_entity.dart';
import 'package:probistics/utils/cont_prob_dist_calc/lognormal_dist.dart';

class LognormalPage extends StatefulWidget {
  @override
  _LognormalPageState createState() => _LognormalPageState();
}

class _LognormalPageState extends State<LognormalPage> {
  Map<String, String> probistics;
  double theta = 0, omega = 0, x = 0;

  final TextEditingController textEditingControllerOfOmega =
      TextEditingController();

  final TextEditingController textEditingControllerOfTheta =
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
    probistics['LT'] = 'N/A';
    probistics['GT'] = 'N/A';
    probistics['theta'] = 'N/A';
    probistics['Variance'] = 'N/A';
    probistics['Standard Deviation'] = 'N/A';
  }

  bool _validContraints() {
    x = double.parse(textEditingControllerOfX.text);

    if (x < 0)
      return false;
    else
      return true;
  }

  void _calculateProbistics() {
    if (textEditingControllerOfOmega.text.isEmpty ||
        textEditingControllerOfTheta.text.isEmpty ||
        textEditingControllerOfX.text.isEmpty) {
      showErrorMessage("Invalid input: Fields are empty!", context);
    } else if (textEditingControllerOfOmega.text.contains(",") ||
        textEditingControllerOfTheta.text.contains(",") ||
        textEditingControllerOfX.text.contains(",") ||
        textEditingControllerOfOmega.text.contains("-") ||
        textEditingControllerOfTheta.text.contains("-") ||
        textEditingControllerOfX.text.contains("-"))
      showErrorMessage("Invalid input: Special Character!", context);
    else if (_validContraints()) {
      setState(() {
        probistics = LognormalDistribution.getAllCasesOfLognormalDist(
            double.parse(textEditingControllerOfTheta.text),
            double.parse(textEditingControllerOfOmega.text),
            double.parse(textEditingControllerOfX.text));
      });
    } else
      showErrorMessage(
          "Invalid input: x ${String.fromCharCode($notin)} (0, inf).",
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
          title: Text("Lognormal Distribution",
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
                    controller: textEditingControllerOfOmega,
                    labelText: "${String.fromCharCode($omega)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfTheta,
                    labelText: "${String.fromCharCode($theta)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfX, labelText: "x"),
                SizedBox(height: 20.0),
                buildProbistifyButton(),
                SizedBox(height: 2.0),
                Divider(
                  color: Colors.indigoAccent.shade100,
                  indent: 30.0,
                  endIndent: 30.0,
                  thickness: 2.0,
                ),
                SizedBox(child: outputListCont(probistics, textStyle), height: 300.0),
              ],
            ),
          ),
        ));
  }
}
