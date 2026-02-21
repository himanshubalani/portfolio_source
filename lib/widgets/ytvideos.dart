import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:url_launcher/url_launcher_string.dart';

class YtClips extends StatelessWidget {
  YtClips({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56.0, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.coralRed,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(width: 2, color: AppColors.black),
              ),
              padding: EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 300.h,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.black),
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.youtube,
                  ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cliplist.length,
                  itemBuilder: (context, index) => _ClipCard(
                    clip: cliplist[index],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Transform.rotate(
            angle: -0.16,
            child: SvgPicture.asset(
              'assets/images/inthewildbanner.svg',
              fit: BoxFit.cover,
              width: 50.w,
            ),
          ),
        ),
      ],
    );
  }
}

class _ClipCard extends StatefulWidget {
  final Map<String, dynamic> clip;

  const _ClipCard({required this.clip});

  @override
  State<_ClipCard> createState() => _ClipCardState();
}

class _ClipCardState extends State<_ClipCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: _launchClip,
          borderRadius: BorderRadius.circular(10.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            width: 70.w,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.lightLimeGreen
                  : AppColors.offwhite,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(width: 2, color: AppColors.black),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ThumbnailImage(
                      imageUrl: widget.clip['thumbnail'] as String,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.clip['title'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Get.width <= 900 ? 12.sp : 4.sp,
                            fontWeight: _isHovered
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontFamily:
                                GoogleFonts.rubik().fontFamily,
                            color: AppColors.darklavendar,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          widget.clip['uploader'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: _isHovered
                                    ? Colors.black87
                                    : Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchClip() async {
    final url = widget.clip['link'] as String;
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}

class _ThumbnailImage extends StatelessWidget {
  final String imageUrl;

  const _ThumbnailImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double kwidth = 70.w;
    double kheight = 50.w * 0.3;
    return Container(
      width: kwidth,
      height: kheight,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border(
          bottom: BorderSide(width: 2, color: AppColors.black),
        ),),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[600],
            ),
          );
        },
      ),
    );
  }
}

const List<Map<String, dynamic>> cliplist = [
  {
    'title': 'Akash and Yogini from Peerlist review my portfolio.',
    'link':
        'https://www.youtube.com/live/0x5m0K-82Rw?si=doAfF1ifEDYheA18&t=4090',
    'uploader': 'TechThrusters',
    'thumbnail': 'https://i.ytimg.com/vi/0x5m0K-82Rw/maxresdefault.jpg',
  },
  {
    'title': 'The Studio Andrew replies to my comment in a video',
    'link': 'https://www.youtube.com/clip/UgkxUgVSUq5sBVPYRmOgJc7quel95cUj5GpQ',
    'uploader': 'The Studio',
    'thumbnail': 'https://i.ytimg.com/vi/0oL_IT4hJp8/maxresdefault.jpg',
  },
  {
    'title': 'I win GHW Security Opening Ceremony Surprise Surprise!',
    'link': 'https://www.youtube.com/clip/UgkxKnwdjeHbtt59plTPjX99kD8dfX5V7bFZ',
    'uploader': 'MLH',
    'thumbnail':
        'https://i.ytimg.com/vi/0ex5OyQvVQM/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGGUgVShVMA8=&rs=AOn4CLCJ_xQlnbUzAwLrxBi1yHtCj1350A',
  },
  {
    'title': 'Ryan and Mary showcase my Design, PS: I won a swag drop.',
    'link': 'https://www.youtube.com/clip/UgkxYNicg4-eSQaR8Xz_TGaVPM4gWW7cO_qC',
    'uploader': 'MLH',
    'thumbnail':
        'https://i.ytimg.com/vi/Ywe5JgzmmAU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gWigoMA8=&rs=AOn4CLAn9E0DcLeyhehbW8DHaop-QypvMg',
  },
  {
    'title': 'Mary and Jacklyn like my redesign',
    'link': 'https://www.youtube.com/clip/UgkxzAhYPjFTCdaDzwjp-4SvA2-cuYOaWpUk',
    'uploader': 'MLH',
    'thumbnail':
        'https://i.ytimg.com/vi/Y9WqSeFJYyU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gFyhKMA8=&rs=AOn4CLCWJn92zGcnjKQjdc2BGibfhjWEYA'
  }
];