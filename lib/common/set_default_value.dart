String checkStringIsNull(String? value) {
  if (value != null) {
    return value;
  } else {
    return '';
  }
}

bool checkBoolIsNull(bool? value) {
  if (value != null) {
    return value;
  } else {
    return false;
  }
}

int checkIntIsNull(int? value) {
  if (value != null) {
    return value;
  } else {
    return 0;
  }
}

num checkNumIsNull(num? value) {
  if (value != null) {
    return value;
  } else {
    return 0.0;
  }
}

dynamic checkItemIsNull(dynamic value) {
  if (value != null) {
    return value;
  } else {
    return null;
  }
}
