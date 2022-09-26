
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DefaultFormField extends StatelessWidget {
  late TextEditingController controller;
  late TextInputType type;
  bool isPassword ;
  late Function validate;
  late String label;
  late IconData prefix;
  IconData? suffix;
  Function? suffixPressed;
  bool isClickable ;
  DefaultFormField({
    required this.controller,
    required this.type,
    required this.validate,
  required this.label,
  required this.prefix,
    this.isClickable = true,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      validator: (s){
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed!(),
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  double width ;
  Color background ;
  bool isUpperCase;
  double radius ;
  late Function function;
  late String text;
  DefaultButton({
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.background = Colors.blue,
    this.isUpperCase  = true,
    this.radius = 3.0,

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  late Function function;
  late String text;
  DefaultTextButton({
    required this.function,
    required this.text,
});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:(){
          function();
        },

        child: Text(text.toUpperCase()),
    );
  }
}

void showToast ({required String text , required ToastStates state,}) =>   Fluttertoast.showToast(
  msg:  text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {SUCCESS , ERROR , WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
     color = Colors.green ;
          break;
    case ToastStates.ERROR:
      color = Colors.red ;
      break;
    case ToastStates.WARNING:
      color = Colors.amber ;
      break;
  }
  return color;
}
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );


