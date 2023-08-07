import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddImageButtom extends StatelessWidget {
  final void Function()? onTap;
  const AddImageButtom({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: MediaQuery.sizeOf(context).width*.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: const Color.fromARGB(0, 158, 158, 158),
              ),
              child: Material(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  10,
                ),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Add Image",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            )
          ),
    );
  }
}
