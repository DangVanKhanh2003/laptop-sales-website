import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120.0,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 16.0,
                  width: 80.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 4.0),
                Container(
                  height: 16.0,
                  width: 60.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
