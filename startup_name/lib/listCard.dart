import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:startup_name/company.dart';

class ListCard extends StatefulWidget {
  final Company company;
  final CompanyController cc;

  ListCard({required this.company, required this.cc}) : super();
  _ListCardState createState() => _ListCardState(company: company, cc: cc);
}

class _ListCardState extends State<ListCard> {
  final Company company;
  final CompanyController cc;
  TextEditingController tec = TextEditingController();
  _ListCardState({required this.company, required this.cc});

  @override
  void dispose() {
    tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontFamily: "Roboto",
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).primaryColorDark,
    );

    String dirt = company.getDirt();
    Icon lock = dirt.length > 0 ? Icon(Icons.lock_open) : Icon(Icons.lock);

    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.network(company.getUrl(), fit: BoxFit.fill),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        company.getName(),
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Founder: ",
                    style: textStyle,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    company.getFounderName(),
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: tec,
                              obscureText: true,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              if (dirt.length > 0) {
                                cc.lockDirt(company);
                              } else {
                                cc
                                    .unlockDirt(company, tec.text)
                                    .then((unlocked) {
                                  if (!unlocked) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Wrong password...")),
                                    );
                                  }
                                });
                              }
                              tec.text = "";
                            },
                            icon: lock,
                            label: Text("dirty secret"),
                          ),
                        ],
                      ),
                      if (dirt.length > 0)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Dirt: ",
                                  style: textStyle,
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  dirt,
                                  style: textStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
