import "package:flutter/material.dart";
Color backGround = const Color.fromRGBO(53, 73, 94, 1.0);
Color appBar = const Color.fromRGBO(238, 133, 114, 1.0);
Color buttons = const Color.fromRGBO(52, 116, 116, 1.0);
Color accentColor = const Color.fromRGBO(99, 183, 175, 1.0);
class InputField extends StatelessWidget {
  Icon fieldIcon;
  String hintText;
  bool isPass;
  TextEditingController fieldController = new TextEditingController();

  InputField(this.fieldIcon,this.hintText,this.isPass,this.fieldController,);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: Material(
        elevation: 20.0,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: backGround,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: fieldIcon,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    
                    hintText: hintText,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: fieldController,
                  obscureText: isPass,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
