import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../custom/buttons.dart';

class BookScreen extends StatefulWidget {
  @override
  BookScreenState createState() => BookScreenState();
}

class BookScreenState extends State<BookScreen> {
  String _time = "Not set";
  var items = [
    "Coop Vasalund",
    "ICA Kvantum",
    "Coop Råsundavägen",
    "Coop Bergshamra",
    "ICA Nära Furuviks",
    "Scania tekniskt centrum",
    "Coop älvsjö"
  ];
  TextEditingController controller = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;
  bool item1Selected = false;
  bool item2Selected = false;
  bool item3Selected = false;
  bool item4Selected = false;
  bool showResult = false;
  bool showButton = false;
  String count = "0";
  int timeSelected = 0;
  int to = 0;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future getCount(int from, int to) async {
    String json = '{"PlaceId": "123", "From": $from , "To": $to}';
    final response = await http.post(
        'https://us-central1-safezone-af096.cloudfunctions.net/getCount',
        headers: requestHeaders,
        body: json);
    if (response.statusCode == 200) {
      this.setState(() {
        showResult = true;
        showButton = true;
        count = 53;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Error try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }

  Future addDate(int from, int to) async {
    String json =
        '{"PlaceId": "123", "UserId": "123", "From": $from, "To": $to}';
    final response = await http.post(
        'https://us-central1-safezone-af096.cloudfunctions.net/addDate',
        headers: requestHeaders,
        body: json);
    if (response.statusCode == 201) {
      this.setState(() {
        showButton = false;
      });
      Fluttertoast.showToast(
          msg: "Thanks You :)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    } else {
      showButton = false;
      Fluttertoast.showToast(
          msg: "Error try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Center(
          child: Text(
            'My Trip',
            style: TextStyle(
                color: Colors.pinkAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.pinkAccent,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: searchTextField = AutoCompleteTextField<String>(
                    itemBuilder: (context, item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      );
                    },
                    itemFilter: (item, query) {
                      return item.toLowerCase().startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemSubmitted: (item) {
                      setState(() =>
                          searchTextField.textField.controller.text = item);
                    },
                    clearOnSubmit: false,
                    key: key,
                    suggestions: items,
                    style: TextStyle(color: Colors.pinkAccent),
                    decoration: InputDecoration(
                      hintText: "Search Place ...",
                      contentPadding: EdgeInsets.only(bottom: -2.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  timeSelected = time.millisecondsSinceEpoch;
                  print('confirm $time');
                  _time = '${time.hour} : ${time.minute} : ${time.second}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              Text(
                                "  $_time",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: FractionalOffset.centerLeft,
              child: Text(
                'Estimate time to stay',
                style: TextStyle(color: Colors.pink),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        showResult = false;
                        item1Selected = true;
                        item2Selected = false;
                        item3Selected = false;
                        item4Selected = false;
                        to = timeSelected + (60000 * 15);
                        getCount(timeSelected, to);
                      });
                    },
                    title: "Less than 15 min",
                    isSelected: item1Selected,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        showResult = false;
                        item1Selected = false;
                        item2Selected = true;
                        item3Selected = false;
                        item4Selected = false;
                        showResult = true;
                        to = timeSelected + (60000 * 30);
                        getCount(timeSelected, to);
                      });
                    },
                    title: "30 min",
                    isSelected: item2Selected,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        showResult = false;
                        item1Selected = false;
                        item2Selected = false;
                        item3Selected = true;
                        item4Selected = false;
                        showResult = true;
                        to = timeSelected + (60000 * 60);
                        getCount(timeSelected, to);
                      });
                    },
                    title: "1 hour",
                    isSelected: item3Selected,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        showResult = false;
                        item1Selected = false;
                        item2Selected = false;
                        item3Selected = false;
                        item4Selected = true;
                        showResult = true;
                        to = timeSelected + (60000 * 120);
                        getCount(timeSelected, to);
                      });
                    },
                    title: "More than 1 hour",
                    isSelected: item4Selected,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: showResult,
              child: Card(
                child: Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  color: Colors.red,
                  width: double.infinity,
                  height: 210.0,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          count,
                          style: TextStyle(
                              fontSize: 150.0,
                              color: Colors.white,
                              fontFamily: 'Coiny'),
                        ),
                      ),
                      Text(
                        "This is how many people will be at the same time",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: showButton,
              child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: RawMaterialButton(
                    fillColor: Colors.red,
                    splashColor: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "It's safe book now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      addDate(timeSelected, to);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
