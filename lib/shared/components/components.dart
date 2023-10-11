import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
  );
}

void navigateAndReplace({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
    (route) => false,
  );
}

void buildToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates {
  success,
  error,
  warning,
}

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amberAccent;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
      top: 10,
    ),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.black45,
    ),
  );
}

Widget defaultTextForm({
  required String label,
  required TextEditingController controller,
  bool obscureText = false,
  required TextInputType textInputType,
  required IconData prefIcon,
  bool isPassword = false,
  void Function(String)? onSubmitted,
  void Function(String)? onChange,
  required String? Function(String?)? onValidate,
  void Function()? onTap,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      validator: onValidate,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefIcon,
        ),
        labelText: label,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onTap,
                child: obscureText
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(
                        Icons.visibility,
                      ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget defaultButton({
  Color backgroundColor = Colors.blue,
  double width = double.infinity,
  required String text,
  Color textColor = Colors.white,
  bool isUpper = true,
  double radius = 10,
  required void Function() onPressed,
}) =>
    Container(
      width: width,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

Widget defaultTextButton({
  required Function() onPressed,
  required String text,
  bool isLight = true,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: isLight ? LightMode.swatchColor : DarkMode.swatchColor,
      ),
    ),
  );
}
