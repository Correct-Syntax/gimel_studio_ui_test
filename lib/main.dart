// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gimel_studio_ui_test/tool_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum Tool {
  cursor,
  node,
  rectangle,
  circle,
  text,
  image,
  eyedropper,
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Tool currentTool = Tool.cursor;

  void onSelectTool(Tool tool) {
    setState(() {
      currentTool = tool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gimel Studio',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF292929),
        body: Column(
          children: [
            Container(
              height: 36.0,
              color: Color(0xFF1C1C1C),
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Icon.png',
                    width: 16.0,
                    height: 16.0,
                    isAntiAlias: true,
                    cacheHeight: 100,
                    cacheWidth: 100,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(width: 6.0),
                  PhosphorIcon(
                    PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                    color: const Color.fromARGB(134, 255, 255, 255),
                    size: 8.0,
                  ),
                  SizedBox(width: 18.0),
                  Text(
                    'File',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 14.0),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 14.0),
                  Text(
                    'View',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 14.0),
                  Text(
                    'Help',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 24.0),
                  Container(
                    width: 180.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF272727),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nature website mock...',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          PhosphorIcon(
                            PhosphorIcons.x(PhosphorIconsStyle.bold),
                            color: Colors.white60,
                            size: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'App mockup',
                            style: TextStyle(
                              color: const Color.fromARGB(134, 255, 255, 255),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          PhosphorIcon(
                            PhosphorIcons.x(PhosphorIconsStyle.bold),
                            color: const Color.fromARGB(134, 255, 255, 255),
                            size: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // Sidebar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        ToolItem(
                          isSelected: currentTool == Tool.cursor,
                          normalIcon: PhosphorIcons.cursor(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.cursor(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.cursor),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.node,
                          normalIcon: PhosphorIcons.navigationArrow(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.navigationArrow(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.node),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.rectangle,
                          normalIcon: PhosphorIcons.rectangle(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.rectangle(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.rectangle),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.circle,
                          normalIcon: PhosphorIcons.circle(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.circle(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.circle),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.text,
                          normalIcon: PhosphorIcons.textT(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.textT(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.text),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.image,
                          normalIcon: PhosphorIcons.imageSquare(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.imageSquare(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.image),
                        ),
                        SizedBox(height: 3),
                        ToolItem(
                          isSelected: currentTool == Tool.eyedropper,
                          normalIcon: PhosphorIcons.eyedropper(PhosphorIconsStyle.light),
                          selectedIcon: PhosphorIcons.eyedropper(PhosphorIconsStyle.fill),
                          onTap: () => onSelectTool(Tool.eyedropper),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: Color(0xFF272727),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Canvas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 800,
                                height: 500,
                                margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all()
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/birch-tree.png',
                                    ),
                                    Text(
                                      'Text object',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            child: Row(
                              children: [
                                Text(
                                  'birch-tree.png (1920x1080)',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                Container(
                                  height: 30,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 52, 52, 52),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Change image',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Transform.rotate(
                                          angle: -pi / 6,
                                          child: Container(
                                            width: 60,
                                            height: 1,
                                            color: Color.fromARGB(255, 138, 39, 32),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Fill',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  'Stroke:',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Transform.rotate(
                                          angle: -pi / 6,
                                          child: Container(
                                            width: 60,
                                            height: 1,
                                            color: Color.fromARGB(255, 138, 39, 32),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Container(
                                  height: 30,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1F1F1F),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: 130,
                                          height: 1,
                                          color: Colors.white54,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Transform.rotate(
                                          angle: -pi / 6,
                                          child: Container(
                                            width: 60,
                                            height: 1,
                                            color: Color.fromARGB(255, 138, 39, 32),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'None',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                PhosphorIcon(
                                  PhosphorIcons.angle(PhosphorIconsStyle.light),
                                  color: Colors.white70,
                                  size: 18.0,
                                ),
                                const SizedBox(width: 6.0),
                                Container(
                                  height: 30,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1F1F1F),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: Color(0xFF363636),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 2,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF363636),
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '1px',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            'Corner radius',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Tabs
                          Container(
                            height: 30,
                            color: Color(0xFF1F1F1F),
                            child: Row(
                              children: [
                                SizedBox(width: 2),
                                Container(
                                  height: 24,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF262626),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Node Editor',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      PhosphorIcon(
                                        PhosphorIcons.pushPin(PhosphorIconsStyle.light),
                                        color: Colors.white60,
                                        size: 12.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Node editor
                          Expanded(
                            child: Container(
                              height: 100,
                              color: Color(0xFF262626),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 36,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF333333),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: Color(0xFF1F1F1F)),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 16.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/birch-tree.png',
                                                width: 34,
                                              ),
                                              const SizedBox(width: 6.0),
                                              Text(
                                                'Image',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: -6,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFCBCE17),
                                                borderRadius: BorderRadius.circular(50.0),
                                                border: Border.all(color: Color(0xFF1F1F1F)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -4,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Transform.rotate(
                                              angle: -pi / 4,
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF17CEBC),
                                                  border: Border.all(color: Color(0xFF1F1F1F)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 124,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFCBCE17),
                                                borderRadius: BorderRadius.circular(50.0),
                                                border: Border.all(color: Color(0xFF1F1F1F)),
                                              ),
                                            ),
                                          ),
                                        ),

                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: PhosphorIcon(
                                                PhosphorIcons.circleHalf(PhosphorIconsStyle.light),
                                                color: Colors.white70,
                                                size: 12.0,
                                              ),
                                            ),
                                          ),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
