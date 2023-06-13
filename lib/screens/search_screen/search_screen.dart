import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/strings.dart';
import 'package:e_commerce/customs/bg_widget.dart';
import 'package:flutter/material.dart';

import '../../consts/images.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              70.heightBox,
               Align(
                 alignment: Alignment.center,
                 child: SizedBox(
                   width: MediaQuery.of(context).size.width-40,
                   child: TextField(
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                       focusedBorder:  OutlineInputBorder(
                         borderSide: const BorderSide(color: myBlack,width: 1),
                         borderRadius: BorderRadius.circular(10),
                       ),
                       suffixIconColor: myBlack,
                      filled: true,
                       hoverColor: myWhite,
                       focusColor: myWhite,
                      isDense: true,
                       fillColor: myWhite,
                       suffixIcon: IconButton(onPressed: () {},
                           icon: const Icon(Icons.search,size: 30,)),
                       hintText: searchHint,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20)
                       )


                     ) ,),
                 ),
               )
            ],

          ),
        ),
    );

  }
}
