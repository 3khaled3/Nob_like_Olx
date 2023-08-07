import 'package:flutter/material.dart';
import 'package:nob/core/widget/customtextFaild.dart';

import 'widget/AddImageButtom.dart';

class addProductView extends StatelessWidget {
  const addProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Product Titel",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          customTextfaild(labelText: "Product Titel"),
          Row(
            children: [
              Text(
                "Product Description",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          customTextfaild(
            labelText: "Product Description",
            maxLines: 4,
          ),
          AddImageButtom()
        ],
      ),
    );
  }


}

