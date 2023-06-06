import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:flutter/material.dart';
class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.onPressed}) : super(key: key);
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: whiteColor,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )),
        onPressed: () {  },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:  [

            Image.asset(imgGoogleLogo,fit: BoxFit.fitWidth,height: 35),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(googleSt,style: TextStyle(color: Colors.black,fontSize: 17),),
            ),
          ],
        ), ),
      );

  }
}
