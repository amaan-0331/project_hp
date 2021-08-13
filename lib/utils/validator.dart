String? Function(String?)? emailValidator() {
  return (value) {
    bool nicIsValid =
        RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value!);
    if (!nicIsValid) {
      return 'Email Address Invalid';
    } else {
      return null;
    }
  };
}

String? Function(String?)? passwordValidator() {
  return (value) {
    bool nicIsValid =
        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value!);
    if (!nicIsValid) {
      return 'One Alphabet, One Numeric and 8 characters';
    } else {
      return null;
    }
  };
}
// String Function(String) nicValidator() {
//   return (value) {
//     bool nicIsValid =
//         RegExp(r"^(?:19|20)?\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$").hasMatch(value);
//     if (!nicIsValid) {
//       return 'Enter Valid NIC number!';
//     } else {
//       return null;
//     }
//   };
// }
