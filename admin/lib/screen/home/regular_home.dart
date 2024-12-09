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
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle('Thông tin dự án', isLargeScreen),
                const SizedBox(height: 16),
                _buildText(
                  icon: Icons.book,
                  title: 'Học phần:',
                  content: 'Thực tập cơ sở ngành',
                  isLargeScreen: isLargeScreen,
                ),
                _buildText(
                  icon: Icons.group,
                  title: 'Nhóm:',
                  content: '10',
                  isLargeScreen: isLargeScreen,
                ),
                _buildText(
                  icon: Icons.person,
                  title: 'Giảng viên hướng dẫn:',
                  content: 'Ths. Lê Anh Thắng',
                  isLargeScreen: isLargeScreen,
                ),
                _buildText(
                  icon: Icons.people,
                  title: 'Sinh viên thực hiện:',
                  content: 'Đàm Gia Khánh, Đặng Trọng Anh, Quàng Văn Quang, Nguyễn Hoàng Ánh',
                  isLargeScreen: isLargeScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title, bool isLargeScreen) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isLargeScreen ? 28 : 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildText({
    required IconData icon,
    required String title,
    required String content,
    required bool isLargeScreen,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$title ',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: isLargeScreen ? 22 : 16,
                ),
                children: [
                  TextSpan(
                    text: content,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: isLargeScreen ? 20 : 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
