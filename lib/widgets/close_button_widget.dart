import 'package:flutter/material.dart';


Widget closeButtonWidget( BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Icon(Icons.close, color: Colors.black),
      ),
    ),
  );
}
