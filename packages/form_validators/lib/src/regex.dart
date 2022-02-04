/// Regular expression used for validating username input.
final usernameRegex =
    RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');

/// Regular expression used for validating email input.
final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

/// Regular expression used for validating password input.
final passwordRegex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

/// Regular expression used for validating phone input.
final phoneRegex = RegExp(r'^[0-9]*$');
