import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResumeShimmerPage(),
    );
  }
}

class ResumeShimmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[100]!,
                highlightColor: Colors.grey[50]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 7.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: 200,
                      height: 7.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    for (int i = 0; i < 3; i++) ...[
                      Row(
                        children: [
                          SizedBox(width: 46.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: 150.0,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                    ],
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
          
              Shimmer.fromColors(
                baseColor: Colors.grey[100]!,
                highlightColor: Colors.grey[50]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Container(
                      width: 200,
                      height: 7.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    for (int i = 0; i < 3; i++) ...[
                      Row(
                        children: [
                          SizedBox(width: 46.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: 150.0,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                    ],
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6.0),
                    for (int i = 0; i < 3; i++) ...[
                      Row(
                        children: [
                          SizedBox(width: 46.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 6.0),
                                Container(
                                  width: 150.0,
                                  height: 6.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
