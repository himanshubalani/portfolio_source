import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/consts/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'livemusicpill.dart';

class YtClips extends StatefulWidget {
  const YtClips({super.key});

  @override
  State<YtClips> createState() => _YtClipsState();
}

class _YtClipsState extends State<YtClips> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (_scrollController.offset - 300.0)
          .clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      (_scrollController.offset + 300.0)
          .clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildScrollButton(
      IconData icon, VoidCallback onPressed, bool isDark) {
    // Const size — no .w/.h so it doesn't rebuild on every frame
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          color: isDark ? AppColors.lightLimeGreen : AppColors.offwhite,
          border: Border.all(color: AppColors.black, width: 2),
        ),
        child: Icon(icon, color: AppColors.black, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 900
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context);
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 52.0, vertical: 12.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.52,
            decoration: BoxDecoration(
              color: isDark ? AppColors.black : AppColors.offwhite,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                width: 3,
                color: isDark ? AppColors.coralRed : AppColors.black,
              ),
            ),
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0),
                  child: const LiveMusicWidgetPill(),
                ), // const — it manages its own state
                SizedBox(
                  height: 1.w,
                ),
                Container(
                  height: 65.sp,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: AppColors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                    color: isDark ? AppColors.black : AppColors.transparent,
                  ),
                  // RepaintBoundary isolates the list from the parent tree
                  child: RepaintBoundary(
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: cliplist.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Extracted to its own StatefulWidget — no StatefulBuilder
                          return _SectionDescriptionCard(isDark: isDark);
                        }
                        return _DesktopClipCard(clip: cliplist[index - 1]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Arrow buttons: vertically centred in the list area
        Positioned(
          left: 8.0,
          top: 130.h,
          child: _buildScrollButton(
              Icons.arrow_back_ios_new, _scrollLeft, isDark),
        ),
        Positioned(
          right: 8.0,
          top: 130.h,
          child: _buildScrollButton(
              Icons.arrow_forward_ios, _scrollRight, isDark),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.black : AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                width: 2,
                color: isDark ? AppColors.coralRed : AppColors.black,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Live Music Card
                LiveMusicWidgetPill(),
                // Description card
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.black : AppColors.offwhite,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 2,
                      color: isDark ? AppColors.coralRed : AppColors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      "I've appeared in a few live streams over the years. "
                          "Here are some available on YouTube.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color:
                        isDark ? AppColors.coralRed : AppColors.black,
                      ),
                    ),
                  ),
                ),
                // Clip list — RepaintBoundary keeps scrolling repaints local
                RepaintBoundary(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      color: isDark ? AppColors.black : AppColors.transparent,
                    ),
                    child: Column(
                      children: cliplist
                          .map((clip) => _MobileClipCard(clip: clip))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Extracted from StatefulBuilder — proper widget lifecycle ────────────────

class _SectionDescriptionCard extends StatefulWidget {
  final bool isDark;
  const _SectionDescriptionCard({required this.isDark});

  @override
  State<_SectionDescriptionCard> createState() =>
      _SectionDescriptionCardState();
}

class _SectionDescriptionCardState extends State<_SectionDescriptionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: SectionDescription(isHovered: _isHovered, isDark: widget.isDark),
      ),
    );
  }
}

// ─── SectionDescription (unchanged except const constructor) ─────────────────

class SectionDescription extends StatelessWidget {
  const SectionDescription({
    super.key,
    required this.isHovered,
    required this.isDark,
  });

  final bool isHovered;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          width: 60.w,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.lightLimeGreen
                : (isDark ? AppColors.black : AppColors.offwhite),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              width: 2,
              color: isDark ? AppColors.coralRed : AppColors.black,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "I've appeared in a few live streams over the years. "
                  "Here are some available on YouTube.",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
                color: isHovered
                    ? AppColors.darkLavendar
                    : (isDark ? AppColors.coralRed : AppColors.black),
                height: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IgnorePointer( // decorative — don't intercept hover
            child: Transform.flip(
              flipX: true,
              child: SvgPicture.asset(
                'assets/svgs/pennant banner.svg',
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Desktop clip card ───────────────────────────────────────────────────────

class _DesktopClipCard extends StatefulWidget {
  final ClipData clip;
  const _DesktopClipCard({required this.clip});

  @override
  State<_DesktopClipCard> createState() => _DesktopClipCardState();
}

class _DesktopClipCardState extends State<_DesktopClipCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: MouseRegion(
        // Single MouseRegion — no nested ones needed
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _launchClipUrl(widget.clip.link),
          borderRadius: BorderRadius.circular(10.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            width: 70.w,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.lightLimeGreen
                  : (isDark ? AppColors.black : AppColors.offwhite),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: isDark ? AppColors.youtube : AppColors.black,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _ThumbnailImage(imageUrl: widget.clip.thumbnail),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.clip.title,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 4.sp,
                            fontWeight: _isHovered
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                            color: isDark
                                ? (_isHovered
                                ? AppColors.darkLavendar
                                : AppColors.white)
                                : AppColors.black,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          widget.clip.uploader,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? (_isHovered
                                ? Colors.black87
                                : Colors.grey[400])
                                : (_isHovered
                                ? Colors.black87
                                : Colors.grey[600]),
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
}

// ─── Mobile clip card ────────────────────────────────────────────────────────

class _MobileClipCard extends StatefulWidget {
  final ClipData clip;
  const _MobileClipCard({required this.clip});

  @override
  State<_MobileClipCard> createState() => _MobileClipCardState();
}

class _MobileClipCardState extends State<_MobileClipCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _launchClipUrl(widget.clip.link),
          borderRadius: BorderRadius.circular(10.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            height: 95.w,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.lightLimeGreen
                  : (isDark ? AppColors.black : AppColors.offwhite),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: isDark ? AppColors.youtube : AppColors.black,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    height: double.infinity,
                    child: _ThumbnailImage(
                        imageUrl: widget.clip.thumbnail, isMobile: true),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.clip.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: _isHovered
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              color: isDark
                                  ? (_isHovered
                                  ? AppColors.darkLavendar
                                  : AppColors.white)
                                  : AppColors.darkLavendar,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            widget.clip.uploader,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color: isDark
                                  ? (_isHovered
                                  ? Colors.black87
                                  : Colors.grey[400])
                                  : (_isHovered
                                  ? Colors.black87
                                  : Colors.grey[700]),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
}

// ─── Thumbnail ───────────────────────────────────────────────────────────────

class _ThumbnailImage extends StatelessWidget {
  final String imageUrl;
  final bool isMobile;

  const _ThumbnailImage({required this.imageUrl, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: isMobile ? double.infinity : 70.w,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[300],
        border: Border(
          bottom: BorderSide(
            width: isMobile ? 0 : 2,
            color: isMobile
                ? Colors.transparent
                : (isDark ? AppColors.lightLimeGreen : AppColors.black),
          ),
          right: BorderSide(
            width: isMobile ? 2 : 0,
            color: isMobile
                ? (isDark ? AppColors.lightLimeGreen : AppColors.black)
                : Colors.transparent,
          ),
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        // Caches decoded image — avoids re-decode on every rebuild
        cacheWidth: isMobile ? 360 : 480,
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
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.image_not_supported,
            color: isDark ? Colors.grey[500] : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}


class ClipData {
  final String title;
  final String link;
  final String uploader;
  final String thumbnail;

  const ClipData({
    required this.title,
    required this.link,
    required this.uploader,
    required this.thumbnail,
  });
}

Future<void> _launchClipUrl(String urlString) async {
  if (urlString.isEmpty) return; // Prevent crashes if url is empty
  final Uri url = Uri.parse(urlString);
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $url');
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}

// Fixed the syntax errors with empty unterminated strings for the "link:" property here
const List<ClipData> cliplist = [
  ClipData(
    title: 'Akash and Yogini from Peerlist review my portfolio.',
    link: 'https://www.youtube.com/live/0x5m0K-82Rw?si=doAfF1ifEDYheA18&t=4090',
    uploader: 'TechThrusters',
    thumbnail: 'https://i.ytimg.com/vi/0x5m0K-82Rw/maxresdefault.jpg',
  ),
  ClipData(
   title: 'The Studio Andrew replies to my comment in a video',
    link: 'https://www.youtube.com/clip/UgkxUgVSUq5sBVPYRmOgJc7quel95cUj5GpQ',
    uploader: 'The Studio',
   thumbnail: 'https://i.ytimg.com/vi/0oL_IT4hJp8/maxresdefault.jpg',
  ),
  ClipData(
    title: 'I win GHW Security Opening Ceremony Surprise Surprise!',
    link:  'https://www.youtube.com/clip/UgkxKnwdjeHbtt59plTPjX99kD8dfX5V7bFZ',
    uploader:  'MLH',
    thumbnail: 'https://i.ytimg.com/vi/0ex5OyQvVQM/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGGUgVShVMA8=&rs=AOn4CLCJ_xQlnbUzAwLrxBi1yHtCj1350A',
 ),
  ClipData(
    title: 'Ryan and Mary showcase my Design, PS: I won a swag drop.',
    link: 'https://www.youtube.com/clip/UgkxYNicg4-eSQaR8Xz_TGaVPM4gWW7cO_qC',
    uploader: 'MLH',
    thumbnail: 'https://i.ytimg.com/vi/Ywe5JgzmmAU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gWigoMA8=&rs=AOn4CLAn9E0DcLeyhehbW8DHaop-QypvMg',
  ),
  ClipData(
    title: 'Mary and Jacklyn like my redesign',
    link:  'https://www.youtube.com/clip/UgkxzAhYPjFTCdaDzwjp-4SvA2-cuYOaWpUk',
    uploader: 'MLH',
    thumbnail: 'https://i.ytimg.com/vi/Y9WqSeFJYyU/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gFyhKMA8=&rs=AOn4CLCWJn92zGcnjKQjdc2BGibfhjWEYA'
  ),
];
