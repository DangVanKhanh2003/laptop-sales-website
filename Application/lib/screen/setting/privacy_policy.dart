import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chính Sách Bảo Mật",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Chúng tôi cam kết bảo vệ quyền riêng tư của bạn. Chính sách bảo mật này giải thích cách chúng tôi thu thập, sử dụng và bảo vệ thông tin cá nhân của bạn khi sử dụng ứng dụng.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            "1. Thu Thập Thông Tin",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Chúng tôi có thể thu thập thông tin cá nhân của bạn, bao gồm tên, địa chỉ email, và các thông tin khác khi bạn sử dụng ứng dụng. Thông tin này được thu thập nhằm cải thiện trải nghiệm người dùng và cung cấp các dịch vụ tốt hơn.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            "2. Sử Dụng Thông Tin",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Thông tin cá nhân của bạn sẽ được sử dụng để cung cấp dịch vụ, cá nhân hóa trải nghiệm, và cải tiến ứng dụng. Chúng tôi không chia sẻ thông tin cá nhân của bạn với bên thứ ba mà không có sự cho phép của bạn.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            "3. Bảo Vệ Thông Tin",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Chúng tôi áp dụng các biện pháp bảo mật thích hợp để bảo vệ thông tin cá nhân của bạn khỏi mất mát, lạm dụng, và truy cập trái phép. Tuy nhiên, không có phương pháp nào hoàn toàn an toàn và chúng tôi không thể đảm bảo tuyệt đối sự bảo mật.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            "4. Thay Đổi Chính Sách",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Chúng tôi có thể cập nhật chính sách bảo mật này theo thời gian. Mọi thay đổi sẽ được thông báo trên trang này. Bạn nên kiểm tra chính sách bảo mật thường xuyên để cập nhật các thay đổi.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            "Liên Hệ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Nếu bạn có bất kỳ câu hỏi nào về chính sách bảo mật này, vui lòng liên hệ chúng tôi qua email: khanhgia@gmail.com.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
