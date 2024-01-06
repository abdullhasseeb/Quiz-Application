import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Button extends StatefulWidget {
  String text;
  final onTap;
  final data;
  Button({
    super.key,
    required this.text,
    required this.onTap,
    this.data
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  Color darkColor = const Color(0xff7d4019);
  Color lightColor = orange;
  Color cardColor = white;
  Color lightShadow = Colors.white;
  Color darkShadow = orange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: ()async{
        _onTap();
        await Future.delayed(const Duration(milliseconds: 100 ));
        if(widget.data == null){
          await widget.onTap();
        }else{
          await widget.onTap(widget.data);
        }

      },
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  color: darkShadow,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(1, 1)
              ),
              BoxShadow(
                  color: lightShadow,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(-1, -1)
              )
              // BoxShadow(
              //     blurStyle: BlurStyle.normal,
              //     color: Colors.black.withOpacity(0.5),
              //   blurRadius: 2,
              //   spreadRadius: 0,
              // ),

            ]
        ),
        child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: orange,
                fontSize: 18,
                shadows: const [
                  Shadow(
                    blurRadius: 2,
                    offset: Offset(1, 1),
                    color: Colors.black54
                  )
                ]
              ),
            )
        ),
      ),
    );
  }

  _onTap()async{
    setState(() {
      lightShadow = Colors.transparent;
      darkShadow = Colors.transparent;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      lightShadow = Colors.white;
      darkShadow = orange;
    });
  }
}
