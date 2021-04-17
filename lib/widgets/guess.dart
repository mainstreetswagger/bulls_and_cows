import 'dart:ui';
import 'package:bulls_and_cows/blocs/game_bloc.dart';
import 'package:flutter/material.dart';

class GuessTextField extends StatefulWidget {
  @override
  _GuessTextFieldState createState() => _GuessTextFieldState();
}

class _GuessTextFieldState extends State<GuessTextField> {
  // final _formKey = GlobalKey<FormState>();
  List<String> _logs = [];
  MediaQueryData media;
  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context);
    return Theme(
      data: ThemeData(),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            media.size.width * .1,
            media.size.height * .1,
            media.size.width * .1,
            media.size.height * .1),
        child: Form(
          // key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                form(),
                SizedBox(height: media.size.height * .02),
                logsTitle(),
                logsRows(),
              ]),
        ),
      ),
    );
  }

  Widget form() {
    return StreamBuilder(
        stream: bloc.clientsNumber,
        builder: (context, snapshot) {
          return Row(children: [
            Expanded(flex: 7, child: fourDigitField(snapshot)),
            Expanded(flex: 1, child: Container()),
            Expanded(flex: 2, child: buttonCheck(snapshot)),
          ]);
        });
  }

  Widget fourDigitField(AsyncSnapshot snapshot) {
    return TextFormField(
        onChanged: (newValue) {
          bloc.changeClientsNumber(newValue);
        },
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.blueGrey),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            errorText: snapshot.error,
            labelStyle: TextStyle(
                color: Colors.deepPurple.shade900, fontWeight: FontWeight.bold),
            labelText: '4-digits',
            hintText: 'enter four digits',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Colors.deepPurpleAccent, width: 2.0)),
            prefixIcon:
                const Icon(Icons.calculate, color: Colors.deepPurpleAccent)));
  }

  Widget buttonCheck(AsyncSnapshot snapshot) {
    var _onPressed = null;
    if (snapshot.hasData) {
      _onPressed = () {
        print(_logs);
        setState(() {
          _logs.add(snapshot.data);
        });
      };
    }
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)),
      child: Text('Check', style: TextStyle(color: Colors.red.shade500)),
      onPressed: _onPressed,
      // () {
      //   addMessageRow('message');
      //   // if (_formKey.currentState.validate()) {}
      // },
    );
  }

  Widget logsTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 4, child: Divider(color: Colors.purple, thickness: 3.0)),
            Expanded(
                flex: 2,
                child: Title(
                  color: Colors.black,
                  child: Text('Logs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                )),
            Expanded(
                flex: 4, child: Divider(color: Colors.purple, thickness: 3.0)),
          ],
        ),
      ],
    );
  }

  Widget logsRows() {
    return Expanded(
      child: ListView.builder(
          itemCount: _logs.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: media.size.height * .01),
                Text(
                  'attempt: $index => ${_logs[index]}',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            );
          }),
    );
  }
}
