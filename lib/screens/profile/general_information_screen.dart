import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:washouse_customer/screens/profile/components/general_infor_widget.dart';

import '../../components/constants/color_constants.dart';
import 'components/step_flow_widget.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 22,
          ),
        ),
        centerTitle: true,
        title: const Text('Thông tin chung',
            style: TextStyle(color: textColor, fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'VÌ SAO NÊN CHỌN SỬ DỤNG DỊCH VỤ TRÊN WASHOUSE?',
                style: TextStyle(
                    color: textBoldColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              GeneralInformationWidget(
                  isLeft: true,
                  image: 'assets/images/search.png',
                  title: 'Dễ dàng tìm kiếm',
                  content:
                      'Dễ dàng và nhanh chóng tìm kiếm được dịch vụ phù hợp với nhu cầu của bạn với nhiều tùy chọn lọc.'),
              GeneralInformationWidget(
                  isLeft: false,
                  image: 'assets/images/tag.png',
                  title: 'Giá cả hợp lý, rõ ràng',
                  content:
                      'Chúng tôi mang đến nhiều loại dịch vụ với giá cả cạnh tranh và hợp lý.' +
                          '\n\nGiá dịch vụ được hiển thị rõ ràng trên đơn hàng. Bạn sẽ không phải trả thêm bất kỳ khoản chi phí nào.'),
              GeneralInformationWidget(
                  isLeft: true,
                  image: 'assets/images/shopping-bag.png',
                  title: 'Thao tác tiện lợi',
                  content:
                      'Giao diện thân thiện, thao tác dễ dàng cho phép bạn đặt hàng và thanh toán trực tuyến một cách dễ dàng và nhanh chóng.'),
              GeneralInformationWidget(
                  isLeft: false,
                  image: 'assets/images/updated.png',
                  title: 'Cập nhật thường xuyên',
                  content:
                      'Trạng thái đơn hàng được cập nhật thường xuyên, giúp bạn có thể theo dõi đơn hàng của mình.'),
              GeneralInformationWidget(
                  isLeft: true,
                  image: 'assets/images/coupon.png',
                  title: 'Ưu đãi',
                  content:
                      'Cung cấp vouchers giảm giá, các chương trình giảm giá hấp dẫn giúp tiết kiệm chi phí sử dụng dịch vụ.'),
              SizedBox(height: 20),
              Text(
                'QUY TRÌNH SỬ DỤNG DỊCH VỤ',
                style: TextStyle(
                    color: textBoldColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              StepFlowWidget(
                image: 'assets/images/service_flow/step1.png',
                step: 'Bước 1: Chọn trung tâm',
                content:
                    'Lựa chọn trung tâm giặt ủi phù hợp với nhu cầu của bạn nhất.',
              ),
              StepFlowWidget(
                image: 'assets/images/service_flow/step2.png',
                step: 'Bước 2: Chọn dịch vụ',
                content:
                    'Lựa chọn dịch vụ do trung tâm cung cấp mà bạn muốn sử dụng, tùy theo trung tâm có thể cung cấp dịch vụ vận chuyển hoặc bạn có thể đặt dịch vụ trước và đến trực tiếp trung tâm.',
              ),
              StepFlowWidget(
                image: 'assets/images/service_flow/step3.png',
                step: 'Bước 3: Tiến hành đặt dịch vụ',
                content:
                    'Trung tâm sẽ xác nhận đơn hàng của bạn sau đó nhân viên sẽ đến địa chỉ được cung cấp trong khoảng thời gian bạn chọn để nhận đồ, giao cho trung tâm để xử lý và giao đồ.' +
                        '\n\nNếu bạn chọn tự mang đồ đến trung tâm, hãy tranh thủ đến trung tâm trong khoảng thời gian bạn chọn nhé!',
              ),
              StepFlowWidget(
                image: 'assets/images/service_flow/step4.png',
                step: 'Bước 4: Đánh giá và xếp hạng',
                content:
                    'Bạn có thể đánh giá chất lượng dịch vụ thông qua ứng dụng Washouse hoặc thông qua Website Washouse.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
