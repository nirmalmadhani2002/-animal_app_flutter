import 'package:flutter/material.dart';

Row appBar() {
  return Row(
    children: [
      const SizedBox(width: 26),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "aplanet",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.8), //Color(0xffC19E82),
            ),
          ),
          const Text(
            "We love the planet",
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
      const Spacer(),
      const Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
      const SizedBox(width: 26),
    ],
  );
}
