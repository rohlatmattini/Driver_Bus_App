// lib/modules/complaints/views/screen/complaints_view.dart
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/complaints_controller.dart';
import '../widgets/attachment_picker.dart';
import '../widgets/complaint_text_field.dart';
import '../widgets/complaints_app_bar.dart';
import '../widgets/complaints_header.dart';
import '../widgets/send_complaint_button.dart';

class ComplaintsView extends GetView<ComplaintsController> {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const ComplaintsAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ComplaintsHeader(),
              SizedBox(height: 25.h),

              ComplaintTextField(controller: controller.complaintController),

              SizedBox(height: 20.h),
              AttachmentsSection(),

              SizedBox(height: 40.h),

              Obx(
                () => SendComplaintButton(
                  onPressed: controller.sendComplaint,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
