int calculateCrossAxisCount(double screenWidth) {
  if (screenWidth <= 157) {
    return 2;
  } else if (screenWidth <= 232.5) {
    return 3;
  } else if (screenWidth <= 311) {
    return 4;
  } else if (screenWidth <= 389.5) {
    return 5;
  } else if (screenWidth <= 468) {
    return 6;
  } else if (screenWidth <= 546.5) {
    return 7;
  } else if (screenWidth <= 625) {
    return 8;
  } else if (screenWidth <= 703.5) {
    return 9;
  } else if (screenWidth <= 782) {
    return 10;
  } else if (screenWidth <= 860.5) {
    return 11;
  } else if (screenWidth <= 939) {
    return 12;
  } else if (screenWidth <= 1017.5) {
    return 13;
  } else if (screenWidth <= 1096) {
    return 14;
  } else if (screenWidth <= 1174.5) {
    return 15;
  } else if (screenWidth <= 1253) {
    return 16;
  } else {
    return 17;
  }
}
