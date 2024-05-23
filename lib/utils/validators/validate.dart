class Validators {
  //VALIDATE EMAIL
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  //VALIDATE PASSWORD

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  //VALIDATE USERNAME

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 6) {
      return 'Username must be at least 6 characters long';
    }
    if (value.contains(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9]'))) {
      return 'Username cannot contain special characters';
    }
    return null;
  }

//VALIDATE BIO
  static String? validateBio(String? value) {
    if (value!.length > 30) {
      return 'Bio cannot exceed 30 characters.';
    }
    return null;
  }

  //VALIDATE BUSINESS NAME

  static String? validateBusinessName(String? value) {
    if (value!.length > 30) {
      return 'Bio cannot exceed 30 characters.';
    }
    return null;
  }

  //VALIDATE BUSINESS ADDRESS

  static String? validateBusinessAddress(String? value) {
    if (value!.length > 30) {
      return 'Business address cannot exceed 30 characters.';
    }
    return null;
  }

  //VALIDATE BUSINESS REGISTRATION NUMBER
  static String? validateBusinessRegistrationNumber(String? value) {
    if (value!.length > 6) {
      return 'Business address cannot exceed 6 characters.';
    }
    return null;
  }
}
