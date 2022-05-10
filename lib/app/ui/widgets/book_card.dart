import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gosheno/app/ui/widgets/scores_widget.dart';

import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.imageAddress,
    required this.offCount,
    required this.moreContent,
    required this.bookTitle,
    required this.writer,
    required this.tag,
    required this.onTap,
    this.showTimer,
  }) : super(key: key);
  final String imageAddress;
  final int offCount;
  final String moreContent;
  final String bookTitle;
  final String writer;
  final bool? showTimer;
  final String tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kWhiteColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 10,
                            child: Hero(
                              tag: tag,
                              child: Image.asset(
                                imageAddress,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kGreenAccentColor,
                              ),
                              child: Text(
                                '$offCount%',
                                style: kBodyText.copyWith(
                                  color: kWhiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moreContent,
                          style: const TextStyle(
                              color: kGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 150,
                          child: Text(
                            bookTitle,
                            style: kBodyMedium.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          writer,
                          style: const TextStyle(
                            color: kGreyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const ScoresWidget(),
                    showTimer == true
                        ? Column(
                            children: [
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                    color: kBorderColor,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: const [
                                    Text('06:22:38'),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const Positioned(
                right: 5,
                top: 10,
                child: Icon(FeatherIcons.bookmark),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: InkWell(
              highlightColor: kLightGreyColor.withOpacity(0.4),
              onTap: onTap,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
