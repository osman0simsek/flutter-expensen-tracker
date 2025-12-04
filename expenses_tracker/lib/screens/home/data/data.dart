import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    "icon": FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    "color": Colors.yellow[700],
    "name": "Food",
    "totalAmount": "-€45.00",
    "Date": "Today",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    "color": Colors.purple,
    "name": "Shopping",
    "totalAmount": "-€230.00",
    "Date": "Yesterday",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.carSide, color: Colors.white),
    "color": Colors.blue,
    "name": "Transport",
    "totalAmount": "-€60.00",
    "Date": "26 Nov 2025",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.house, color: Colors.white),
    "color": Colors.orange,
    "name": "Rent",
    "totalAmount": "-€1200.00",
    "Date": "25 Nov 2024",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.heartPulse, color: Colors.white),
    "color": Colors.red,
    "name": "Health",
    "totalAmount": "-€80.00",
    "Date": "24 Nov 2025",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.film, color: Colors.white),
    "color": Colors.green,
    "name": "Entertainment",
    "totalAmount": "-€40.00",
    "Date": "23 Nov 2025",
  },
];
