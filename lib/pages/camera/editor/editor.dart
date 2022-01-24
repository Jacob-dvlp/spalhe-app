import 'dart:io';
import 'package:spalhe/controllers/moments/editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class PhotoEditor extends StatelessWidget {
  final File image;
  const PhotoEditor({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(
      init: EditorController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: RepaintBoundary(
              child: Stack(
                children: [
                  Screenshot(
                    controller: _.screenshotController,
                    child: Stack(
                      children: const [
                        // MatrixGestureDetector(
                        //   shouldRotate: false,
                        //   shouldTranslate: false,
                        //   onMatrixUpdate: (m, tm, sm, rm) {
                        //     _.updateImageView(m);
                        //   },
                        //   child: Transform(
                        //     transform: _.imageview.value,
                        //     child: Center(
                        //       child: Image.file(
                        //         image,
                        //         fit: BoxFit.contain,
                        //         height: MediaQuery.of(context).size.height,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Stack(
                        //   children: List.generate(
                        //     _.texts.length,
                        //     (index) => MatrixGestureDetector(
                        //       clipChild: true,
                        //       onMatrixUpdate: (Matrix4 m, Matrix4 tm,
                        //           Matrix4 sm, Matrix4 rm) {
                        //         _.changePositionText(index, m);
                        //       },
                        //       child: Transform(
                        //         transform: _.positions[index],
                        //         child: Center(
                        //           child: Text(
                        //             _.texts[index]['text'],
                        //             style: TextStyle(
                        //               fontSize: 58,
                        //               fontWeight: FontWeight.bold,
                        //               color: _.colors[_.texts[index]['color']],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.white,
                                  onPressed: () => Get.back(),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.text_fields_outlined),
                                  color: Colors.white,
                                  onPressed: _.setTextEnable,
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.check),
                              color: Colors.white,
                              onPressed: _.loading ? null : _.createMoment,
                            ),
                          ]),
                    ),
                  ),
                  if (_.textEnable)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              children: List.generate(
                                _.colors.length,
                                (index) => GestureDetector(
                                  onTap: () => _.selectColor(index),
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: _.colorSelected == index
                                        ? BoxDecoration(
                                            color: _.colors[index],
                                            border: Border.all(
                                              color: Colors.purple,
                                              width: _.colorSelected == index
                                                  ? 3
                                                  : 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          )
                                        : BoxDecoration(
                                            color: _.colors[index],
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: _.textController,
                                    decoration: const InputDecoration(
                                      hintText: 'Insira um texto',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send),
                                  color: Colors.white,
                                  onPressed: _.addText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
