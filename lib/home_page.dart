import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentRadio;

  bool switchValue = false;

  var radioGroup = {
    0: 'Amazing (20%)',
    1: 'Good (15%)',
    2: 'Okay (10%)',
  };

  double tipAmount = 0;
  double? costService;

  int roundedTip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(
              Icons.room_service,
              color: Colors.green,
            ),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cost of service",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                ),
                onChanged: (costo) {
                  if (costo == "") {
                    costService = null;
                  }
                  costService = double.parse(costo);
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.dinner_dining,
              color: Colors.green,
            ),
            title: Text(
              "How was the service?",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: radioGroupGenerator(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.credit_card,
              color: Colors.green,
            ),
            title: Text(
              "Round up tip",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: Switch(
                value: switchValue,
                onChanged: (newValue) {
                  switchValue = newValue;
                  print(switchValue);
                  setState(() {});
                }),
          ),
          Center(
            child: MaterialButton(
              minWidth: 375,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: Colors.green,
              child: Text(
                "CALCULATE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print(costService);
                if (costService == null) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Por favor, agrega un valor"),
                    ));
                  setState(() {});
                } else {
                  _tipCalculation();
                  print(tipAmount);
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("Tip amount: \$${tipAmount.toStringAsFixed(2)}"),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    switch (currentRadio) {
      case 0:
        tipAmount = costService! * .20;
        break;
      case 1:
        tipAmount = costService! * .15;
        break;
      case 2:
        tipAmount = costService! * .10;
        break;
    }

    if (switchValue) {
      tipAmount = tipAmount.ceil().toDouble();
    }

    setState(() {});
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map((e) => ListTile(
              leading: Radio(
                value: e.key,
                groupValue: currentRadio,
                onChanged: (int? newValue) {
                  currentRadio = newValue;
                  setState(() {});
                },
              ),
              title: Text("${e.value}"),
            ))
        .toList();
  }
}
