import 'package:flutter/material.dart';

class PesquisaBarra extends StatelessWidget implements PreferredSizeWidget {
  final Function(String? text)?
      onSubmitted; //repassa a função de onSubmitted para o construtor do widget
  final Function()? onClear;
  final Function(String? text)? onChanged;
  final TextEditingController textController;
  final String? hintText; //repassa o hintText para o construtor do widget
  PesquisaBarra(
      {Key? key,
      this.hintText,
      required this.onSubmitted,
      required this.textController,
      this.onChanged,
      this.onClear})
      : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(76);
  void dispose() {
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            )),
        child: TextField(
          onChanged: (text) {
            if (text.isEmpty) return onChanged!(text);
            if (text.length > 3 && onChanged != null) return onChanged!(text);
          },
          onSubmitted: onSubmitted,
          controller: textController,
          textAlignVertical: TextAlignVertical.center,
          decoration: new InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                if (textController.text == '' && onClear != null) onClear!();
                onChanged!("");
                textController.clear();
              },
            ),
            border: new OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdcdddf), width: 1),
              borderRadius: BorderRadius.circular(240),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 30,
            ),
            filled: false,
            hintStyle: new TextStyle(fontSize: 16, color: Color(0xffa1a5aa)),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
