//Validator for Emails
String? Function(String?)? emailValidator() {
  return (value) {
    bool emailIsValid =
        RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value!);
    if (!emailIsValid) {
      return 'Email Address Invalid';
    } else {
      return null;
    }
  };
}

//Validator for password
String? Function(String?)? passwordValidator() {
  return (value) {
    bool passwordIsValid =
        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value!);
    if (!passwordIsValid) {
      return 'One Alphabet, One Numeric and 8 characters';
    } else {
      return null;
    }
  };
}
