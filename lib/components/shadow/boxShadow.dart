import 'package:flutter/material.dart';

BoxShadow boxShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(4, 8),
  );
}
