import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoothListModal extends StatelessWidget {
  const BoothListModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .1,
      minChildSize: .1,
      maxChildSize: 0.5,
      expand: true,
      builder: (BuildContext context, myscrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white, // 모달 배경색
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffFF7D7D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  controller: myscrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(thickness: .1),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  leading: Text(
                                    '영차 주막',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  title: Text(
                                    '경영대 앞',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  subtitle: Text(
                                    '10:00 ~ 18:00',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 90,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: .5,
                                color:
                                    const Color(0xff707070).withOpacity(0.65),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BoothItemModal extends StatelessWidget {
  const BoothItemModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white, // 모달 배경색
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '제목',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.sp),
              ),
              Text(
                '위치',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.65),
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                '시간~시간',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            '경영대에서 영차 주막을 오픈했습니다. \n이경영 배우님의 컨셉을 따라하여 기획했습니다. ',
            style: TextStyle(
              height: 1.3,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp,
              color: Colors.black.withOpacity(0.63),
            ),
          ),
          SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amber),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//bloc data 받아야함
//드래그블에 itemmodal showmodal