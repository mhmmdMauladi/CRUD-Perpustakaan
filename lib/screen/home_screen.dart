import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/model/book_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 0,
      ),
      children: [
        const Gap(60),
        buildHeader(),
        const Gap(30),
        buildMyAppointment(),
        const Gap(20),
        buildSearch(),
        const Gap(20),
        buildCategories(),
        const Gap(40),
        buildNearBooks(),
      ],
    );
  }

  Widget buildNearBooks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New Books",
          style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color(0xff0D1B34),
            height: 1,
          ),
        ),
        const Gap(16),
        ListView.builder(
          itemCount: books.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(2, 12),
                    color: const Color(0xff5A75A7).withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          books.elementAt(index).image,
                          width: 90,
                          height: 90,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              books.elementAt(index).name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color(0xff0D1B34),
                                height: 1,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              books.elementAt(index).author,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: const Color(0xff8696BB),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  const Divider(
                    color: Color(0xffF5F5F5),
                    height: 1,
                    thickness: 1,
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star, // Example icon
                              color: Color(0xffFEB052), // Adjust color
                              size: 24.0, // Adjust size
                            ),
                            const Gap(8),
                            Text(
                              books.elementAt(index).rate.toString(),
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xffFEB052),
                                height: 1,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              '(${books.elementAt(index).review} reviews)',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xffFEB052),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.menu_book_rounded,
                              color: Color(0xff4894FE),
                              size: 24.0,
                            ),
                            const Gap(8),
                            Text(
                              'Read Now',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: const Color(0xff4894FE),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildCategories() {
    final categories = [
      {'icon': 'assets/Image.png', 'title': 'Media \nDigital'},
      {'icon': 'assets/Play.png', 'title': 'Video \nTutorial'},
      {'icon': 'assets/User.png', 'title': 'Class \nOnline'},
      {'icon': 'assets/Category.png', 'title': 'Semua \nFitur'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((e) {
        return Column(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: const BoxDecoration(
                color: Color(0xffFAFAFA),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                e['icon']!,
                width: 28,
                height: 28,
              ),
            ),
            const Gap(8),
            Text(
              e['title']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: const Color(0xff8696BB),
                height: 1,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildSearch() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/ic_search.png',
            width: 24,
            height: 24,
          ),
          const Gap(12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search book or library',
                hintStyle: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: const Color(0xff8696BB),
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildMyAppointment() {
    return Container(
      height: 138,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff4894FE),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/user-1.png',
                  width: 48,
                  height: 48,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Imran Syahir. S.Kom',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Librarian',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: const Color(0xffCBE1FF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/ic_arrow_right.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const Spacer(),
          Divider(
            color: Colors.white.withOpacity(0.15),
            height: 1,
            thickness: 1,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(
                        'assets/ic_calendar.png',
                      ),
                      size: 16,
                      color: Colors.white,
                    ),
                    const Gap(8),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const ImageIcon(
                      AssetImage(
                        'assets/ic_clock.png',
                      ),
                      size: 16,
                      color: Colors.white,
                    ),
                    const Gap(8),
                    Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.now()), // Display current time
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: const Color(0xffFFFFFF),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: const Color(0xff8696BB),
                  height: 1,
                ),
              ),
              const Gap(6),
              Text(
                "Hi' Risa Diah",
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xff0D1B34),
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        ClipOval(
          child: Image.asset(
            'assets/profile.png',
            width: 56,
            height: 56,
          ),
        ),
      ],
    );
  }
}
