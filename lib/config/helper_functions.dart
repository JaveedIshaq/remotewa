/* 
************************** File Information *******************************

Date        : 2021/09/18

Author      : Javeed Ishaq (www.javeedishaq.com)

Description : Helper Functions

This File contains Colors Helper Functions the App

**************************************************************************** 
*/

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
