import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            20,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(children: [
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: Container(
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                    title: Container(
                      height: 16,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ),
                    subtitle: Container(
                      height: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
