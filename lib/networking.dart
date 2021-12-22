import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Pet {
  final String id;
  final String name;
  final String avatar;
  var createdAt;
  var bornOn;
  int age;
  Pet(
      {required this.id,
      required this.name,
      required this.avatar,
      this.createdAt,
      this.bornOn,
      required this.age});
}

class PetProvider with ChangeNotifier {
  List<Pet> _petListsend = [];
  List<Pet> petList = [];

  List<Pet> get getPets {
    // print(petList[0]);
    findAgeinMonths("2020-12-28T04:26:47.647Z", "2021-11-20T23:18:04.475Z");

    return _petListsend;
  }

  Future<void> fetchSetPets() async {
    final urlToPets =
        Uri.parse("https://60d075407de0b20017108b89.mockapi.io/api/v1/animals");
    final response = await http.get(urlToPets);
    final extractedPets = json.decode(response.body) as List<dynamic>;
    if (extractedPets == null) {
      return;
    }
    extractedPets.forEach((element) {
      petList.add(Pet(
        id: element["id"],
        name: element["name"],
        avatar: element["avatar"],
        age: findAgeinMonths(element["createdAt"], element["bornAt"]),
      ));
    });
    _petListsend = petList;
    notifyListeners();
  }

  int findAgeinMonths(String date1, String date2) {
    DateTime date_beg = DateTime.parse(date1.toString());
    DateTime date_end = DateTime.parse(date2.toString());
    int month1 = int.parse(DateFormat("MM").format(date_beg));
    int month2 = int.parse(DateFormat("MM").format(date_end));
    int year1 = int.parse(DateFormat("yy").format(date_beg));
    int year2 = int.parse(DateFormat("yy").format(date_end));
    int res = ((month1 - month2).abs()) + (((year1 - year2).abs()) * 12);

    return res;
  }
}
