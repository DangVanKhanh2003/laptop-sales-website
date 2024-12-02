import 'package:flutter/material.dart';

class RegularHome extends StatelessWidget {
  const RegularHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildText('Học phần:', 'Đồ án chuyên ngành', isLargeScreen),
                _buildText('Nhóm:', '7', isLargeScreen),
                _buildText('Giảng viên hướng dẫn:', 'Ths. Trần Phương Nhung',
                    isLargeScreen),
                _buildText(
                  'Sinh viên thực hiện:',
                  'Đàm Gia Khánh, Trần Văn Khang, Đặng Văn Khánh',
                  isLargeScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String title, String content, bool isLargeScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$title ',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: isLargeScreen ? 24 : 16,
          ),
          children: [
            TextSpan(
              text: content,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: isLargeScreen ? 22 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
