import 'package:flutter/material.dart';
import 'package:probistics/widgets/custom_widgets.dart';
import 'package:charcode/html_entity.dart';
import 'package:probistics/utils/cont_prob_dist_calc/weibull_dist.dart';

class WeibullPage extends StatefulWidget {
  @override
  _WeibullPageState createState() => _WeibullPageState();
}

class _WeibullPageState extends State<WeibullPage> {
  Map<String, String> probistics;
  double alpha = 0, beta = 0, x = 0;

  final TextEditingController textEditingControllerOfBeta =
      TextEditingController();

  final TextEditingController textEditingControllerOfAlpha =
      TextEditingController();

  final TextEditingController textEditingControllerOfX =
      TextEditingController();

  final textStyle = TextStyle(
      color: Colors.orangeAccent.shade100,
      fontSize: 20.0,
      fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    probistics = Map<String, String>();
    probistics['LT'] = 'N/A';
    probistics['GT'] = 'N/A';
    probistics['alpha'] = 'N/A';
    probistics['Variance'] = 'N/A';
    probistics['Standard Deviation'] = 'N/A';
  }

  bool _validContraints() {
    x = double.parse(textEditingControllerOfX.text);
    alpha = double.parse(textEditingControllerOfAlpha.text);
    beta = double.parse(textEditingControllerOfBeta.text);

    if (x <= 0 || alpha <= 0 || beta <= 0)
      return false;
    else
      return true;
  }

  void _calculateProbistics() {
    if (textEditingControllerOfBeta.text.isEmpty ||
        textEditingControllerOfAlpha.text.isEmpty ||
        textEditingControllerOfX.text.isEmpty) {
      showErrorMessage("Invalid input: Fields are empty!", context);
    } else if (textEditingControllerOfBeta.text.contains(",") ||
        textEditingControllerOfAlpha.text.contains(",") ||
        textEditingControllerOfX.text.contains(",") ||
        textEditingControllerOfBeta.text.contains("-") ||
        textEditingControllerOfAlpha.text.contains("-") ||
        textEditingControllerOfX.text.contains("-"))
      showErrorMessage("Invalid input: Special Character!", context);
    else if (_validContraints()) {
      setState(() {
        probistics = WeibullDistribution.getAllCasesOfWeibullDist(
            double.parse(textEditingControllerOfBeta.text),
            double.parse(textEditingControllerOfAlpha.text),
            double.parse(textEditingControllerOfX.text));
      });
    } else
      showErrorMessage(
          "Invalid input: x, ${String.fromCharCode($alpha)}, ${String.fromCharCode($beta)} ${String.fromCharCode($notin)} (0, inf).", context);
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
            fontSize: 20.0, color: Colors.orangeAccent.shade100, height: 0.7),
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
          title: Text("Weibull Distribution",
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
                    controller: textEditingControllerOfBeta,
                    labelText: "${String.fromCharCode($beta)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfAlpha,
                    labelText: "${String.fromCharCode($alpha)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfX, 
                    labelText: "x"
                ),
                SizedBox(height: 20.0),
                buildProbistifyButton(),
                SizedBox(height: 2.0),
                Divider(
                  color: Colors.orangeAccent.shade100,
                  indent: 30.0,
                  endIndent: 30.0,
                  thickness: 2.0,
                ),
                SizedBox(
                    child: outputListCont(probistics, textStyle),
                    height: 300.0),
              ],
            ),
          ),
        ));
  }
}
