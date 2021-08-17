import 'package:flutter/material.dart';
import 'package:probistics/widgets/custom_widgets.dart';
import 'package:charcode/html_entity.dart';
import 'package:probistics/utils/cont_prob_dist_calc/normal_dist.dart';

class NormalPage extends StatefulWidget {
  @override
  _NormalPageState createState() => _NormalPageState();
}

class _NormalPageState extends State<NormalPage> {
  Map<String, String> probistics;
  double mean = 0, stDev = 0, x = 0;

  final TextEditingController textEditingControllerOfStDev =
      TextEditingController();

  final TextEditingController textEditingControllerOfMean =
      TextEditingController();

  final TextEditingController textEditingControllerOfX =
      TextEditingController();

  final textStyle = TextStyle(
      color: Colors.yellowAccent.shade100, fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    probistics = Map<String, String>();
    probistics['LT'] = 'N/A';
    probistics['GT'] = 'N/A';
    probistics['Mean'] = 'N/A';
    probistics['Variance'] = 'N/A';
    probistics['Standard Deviation'] = 'N/A';
  }

  bool _validContraints() {
    stDev = double.parse(textEditingControllerOfMean.text);

    if (stDev < 0) return false;
    else return true;
  }

  void _calculateProbistics() {
    if (textEditingControllerOfStDev.text.isEmpty ||
        textEditingControllerOfMean.text.isEmpty ||
        textEditingControllerOfX.text.isEmpty) {
      showErrorMessage("Invalid input: Fields are empty!", context);
    } else if (textEditingControllerOfStDev.text.contains(",") ||
        textEditingControllerOfMean.text.contains(",") ||
        textEditingControllerOfX.text.contains(",") ||
        textEditingControllerOfStDev.text.contains("-") ||
        textEditingControllerOfMean.text.contains("-") ||
        textEditingControllerOfX.text.contains("-"))
      showErrorMessage("Invalid input: Special Character!", context);
    else if (_validContraints()) {
      setState(() {
        probistics = NormalDistribution.getAllCasesOfNormalDist(
            double.parse(textEditingControllerOfMean.text),
            double.parse(textEditingControllerOfStDev.text),
            double.parse(textEditingControllerOfX.text));
      });
    } else
      showErrorMessage(
          "Invalid input: x ${String.fromCharCode($notin)} [a, b] or a > b",
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
        style:
            TextStyle(fontSize: 20.0, color: Colors.yellowAccent.shade100, height: 0.7),
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

  Widget _outputList() {
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Normal Distribution",
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
                    controller: textEditingControllerOfStDev, labelText: "${String.fromCharCode($sigma)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfMean, labelText: "${String.fromCharCode($mu)}"),
                SizedBox(height: 10.0),
                _buildInputField(
                    controller: textEditingControllerOfX, labelText: "x"),
                SizedBox(height: 20.0),
                buildProbistifyButton(),
                SizedBox(height: 2.0),
                Divider(
                  color: Colors.yellowAccent.shade100,
                  indent: 30.0,
                  endIndent: 30.0,
                  thickness: 2.0,
                ),
                SizedBox(child: _outputList(), height: 300.0),
              ],
            ),
          ),
        ));
  }
}
