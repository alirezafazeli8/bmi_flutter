import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _heightControler = TextEditingController();
  TextEditingController _weightControler = TextEditingController();

  // states
  // bmi resault state
  double _bmiResault = 0;
  // text resault state
  String _textResault = "";
  // male select state
  bool maleSelect = false;
  // woman select state
  bool womanSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resize avoid bottom
      resizeToAvoidBottomInset: false,
      // app bar
      appBar: AppBar(
        // app bar title
        title: const Text(
          "BMI CALCULATOR",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[800],
        elevation: 10,
      ),
      // body section
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // male icon container
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      maleSelect = true;
                      womanSelect = false;
                    });
                  },
                  child: Container(
                    color: maleSelect ? Colors.indigo[600] : Colors.indigo[300],
                    width: 150,
                    height: 150,
                    child: maleSelect
                        ? const Icon(
                            Icons.male_rounded,
                            size: 100,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.male_rounded,
                            size: 100,
                            color: Colors.indigo,
                          ),
                  ),
                ),
                // woman icon container
                GestureDetector(
                  onTap: () {
                    setState(() {
                      maleSelect = false;
                      womanSelect = true;
                    });
                  },
                  child: Container(
                    color:
                        womanSelect ? Colors.indigo[600] : Colors.indigo[300],
                    width: 150,
                    height: 150,
                    child: womanSelect
                        ? const Icon(
                            Icons.female_rounded,
                            size: 100,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.female_rounded,
                            size: 100,
                            color: Colors.indigo,
                          ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // height text field container
                Container(
                  width: 100,
                  height: 100,
                  child: TextField(
                    controller: _heightControler,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Height",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // weight text field container
                Container(
                  width: 100,
                  height: 100,
                  child: TextField(
                    controller: _weightControler,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Weight",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // calculate button
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.indigo[100]),
            onPressed: () {
              // check weight and height input is not empty
              if (_heightControler.text.isNotEmpty &&
                  _weightControler.text.isNotEmpty) {
                double height = double.parse(_heightControler.text);
                double weight = double.parse(_weightControler.text);
                setState(() {
                  _bmiResault = weight / (height * height);

                  if (_bmiResault > 25) {
                    _textResault = "You are over weight";
                  } else if (_bmiResault >= 18 && _bmiResault <= 25) {
                    _textResault = "Normal Weight";
                  } else {
                    _textResault = "You are under weight";
                  }
                });
              }
            },
            child: const Text(
              "Calculate",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.indigo,
              ),
            ),
          ),
          // Bars section
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      LeftBar(warWidth: 30),
                      LeftBar(warWidth: 50),
                      LeftBar(warWidth: 30),
                    ],
                  ),
                  // bmi resault
                  Text(
                    _bmiResault.roundToDouble().toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 70),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      RightBar(warWidth: 30),
                      RightBar(warWidth: 50),
                      RightBar(warWidth: 30),
                    ],
                  ),
                ],
              )),
          // bmi text resault section
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Visibility(
                visible: _textResault.isNotEmpty,
                child: Text(
                  _textResault,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 35),
                ),
              ))
        ],
      ),
      backgroundColor: Colors.indigo[500],
    );
  }
}

// right bar
class RightBar extends StatelessWidget {
  final double warWidth;
  const RightBar({Key? key, required this.warWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          width: warWidth,
          height: 20,
          // color: Colors.red,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
            ),
            color: Colors.yellow,
          ),
        ));
  }
}

class LeftBar extends StatelessWidget {
  final double warWidth;
  const LeftBar({Key? key, required this.warWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          width: warWidth,
          height: 20,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              bottomRight: Radius.circular(7),
            ),
            color: Colors.yellow,
          ),
        ));
  }
}
