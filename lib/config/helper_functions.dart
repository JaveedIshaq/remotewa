/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : Helper Functions

This File contains Colors Helper Functions the App

**************************************************************************** 
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remotewa/config/colors.dart';

/// Get initial 2 letters of the User Name
String getInitials(fullName) {
  List<String> names = fullName.split(' ') as List<String>;

  String initials = '';
  if (names.length > 1) {
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
  } else {
    initials = fullName[0] as String;
  }

  return initials;
}

/// Open Logout Dialogue

/// Dialog to ask exit from App
Future<void> openLogoutDialog(BuildContext context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.only(
              left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 110.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                  ),
                  const Text(
                    'Exit app',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Are you sure to exit app?',
                    style: TextStyle(color: Colors.white70, fontSize: 14.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.cancel,
                      color: primaryColor,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Text(
                    'CANCEL',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.check_circle,
                      color: primaryColor,
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                  Text(
                    'YES',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        );
      })) {
    case 0:
      break;
    case 1:
      exit(0);
  }
}
