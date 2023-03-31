import 'package:flutter/material.dart';

import '../resource/models/center.dart';

class CenterUtils {
  bool checkHasDelivery(LaundryCenter centers) {
    if (centers.hasDelivery!) {
      return true;
    } else {
      return false;
    }
  }

  bool checkHasRating(LaundryCenter centers) {
    if (centers.rating != null) {
      return true;
    } else {
      return false;
    }
  }
}
