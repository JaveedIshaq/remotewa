String getInitials(fullName) {
  List<String> names = fullName.split(" ");

  String initials = "";
  if (names.length > 1) {
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
  } else {
    initials = fullName[0];
  }

  return initials;
}
