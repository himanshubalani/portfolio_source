import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/consts/style.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../presentation/onhover.dart';
import 'neobrutalbox.dart';

class LiveMusicWidgetPill extends StatefulWidget {
  const LiveMusicWidgetPill({super.key});

  @override
  State<LiveMusicWidgetPill> createState() => _LiveMusicWidgetPillState();
}

class _LiveMusicWidgetPillState extends State<LiveMusicWidgetPill> {
  Map<String, dynamic>? _musicData;
  Timer? _timer;

  final String _firebaseUrl =
      'https://yt-music-tracker-67834-default-rtdb.asia-southeast1.firebasedatabase.app/live_music.json';

  @override
  void initState() {
    super.initState();
    _fetchMusicData();
    _timer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _fetchMusicData(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchMusicData() async {
    try {
      final response = await http.get(Uri.parse(_firebaseUrl));
      if (response.statusCode == 200 && mounted) {
        setState(() => _musicData = json.decode(response.body));
      }
    } catch (e) {
      debugPrint('Failed to fetch live music: $e');
    }
  }

  /// Parses the hex color string from Firebase (e.g. "#A1B2C3")
  Color _parseColor(String hex) => Color(int.parse('0xFF${hex.substring(1)}'));

  /// True if white text should be used on [bg]
  bool _needsWhiteText(Color bg) => bg.computeLuminance() < 0.5;

  @override
  Widget build(BuildContext context) {
    if (_musicData == null || _musicData!['isPlaying'] == false) {
      return const SizedBox.shrink();
    }

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isMobile = MediaQuery.of(context).size.width <= 900;

    final String title = _musicData!['title'] ?? 'Unknown';
    final String artist = _musicData!['artist'] ?? 'Unknown';
    final String albumArt = _musicData!['albumArt'] ?? '';
    final String colorHex = _musicData!['albumColor'] ?? '#FF0000';

    final Color dominantColor = _parseColor(colorHex);
    final bool useWhiteText = _needsWhiteText(dominantColor);
    final Color textColor = useWhiteText ? AppColors.white : AppColors.black;
    final Color iconColor = useWhiteText ? AppColors.white : AppColors.black;

    final String query = Uri.encodeQueryComponent('$title $artist');
    final String ytUrl = 'https://music.youtube.com/search?q=$query';

    return isMobile
        ? _MobileCard(
            title: title,
            artist: artist,
            albumArt: albumArt,
            dominantColor: dominantColor,
            textColor: textColor,
            iconColor: iconColor,
            isDark: isDark,
            ytUrl: ytUrl,
          )
        : _DesktopPill(
            title: title,
            artist: artist,
            albumArt: albumArt,
            dominantColor: dominantColor,
            textColor: textColor,
            iconColor: iconColor,
            isDark: isDark,
            ytUrl: ytUrl,
          );
  }
}

// ─── Mobile Card ─────────────────────────────────────────────────────────────

class _MobileCard extends StatelessWidget {
  final String title, artist, albumArt, ytUrl;
  final Color dominantColor, textColor, iconColor;
  final bool isDark;

  const _MobileCard({
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.dominantColor,
    required this.textColor,
    required this.iconColor,
    required this.isDark,
    required this.ytUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => launchUrlString(ytUrl),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 90.w,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.black : dominantColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
              color: isDark ? dominantColor : AppColors.black, width: 2),
        ),
        child: Row(
          children: [
            // ── Left: Album Art ──────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                bottomLeft: Radius.circular(14.r),
              ),
              child: SizedBox(
                width: 100.w,
                height: double.infinity,
                child: Image.network(
                  albumArt,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.music_note, color: Colors.white),
                  ),
                ),
              ),
            ),

            // ── Right: Content ───────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: "Listening to" + BoxCircles
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Listening to',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? dominantColor : textColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        BoxCircles(
                          hoverEnabled: false,
                          color: isDark ? dominantColor : AppColors.white,
                        ) ,
                        
                      ],
                    ),

                    const Spacer(),

                    // Title + Artist
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? dominantColor : textColor,
                        height: 1.25,
                      ),
                    ),
                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? dominantColor : textColor,
                      ),
                    ),

                    const Spacer(),

                    // Bottom row: YT Music logo + "Music"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(SimpleIcons.youtubemusic,
                            size: 15.sp,
                            color: isDark ? AppColors.white : AppColors.black),
                        SizedBox(width: 4.w),
                        Text(
                          'Music',
                          style: GoogleFonts.robotoFlex(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: isDark ? AppColors.white : AppColors.black,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Desktop Pill ─────────────────────────────────────────────────────────────

class _DesktopPill extends StatelessWidget {
  final String title, artist, albumArt, ytUrl;
  final Color dominantColor, textColor, iconColor;
  final bool isDark;

  const _DesktopPill({
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.dominantColor,
    required this.textColor,
    required this.iconColor,
    required this.isDark,
    required this.ytUrl,
  });

  @override
  Widget build(BuildContext context) {
    return OnHover(
        enableTransform: false,
        builder: (bool isHovered) {
          {
            return InkWell(
              onTap: () => launchUrlString(ytUrl),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? (isHovered ? dominantColor : AppColors.black)
                      : dominantColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                      color: isDark ? dominantColor : AppColors.black,
                      width: 2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            SimpleIcons.youtubemusic,
                            size: 5.w,
                            color: isDark
                                ? (isHovered ? AppColors.black : dominantColor)
                                : AppColors.black,
                          ),
                          // SizedBox(width: (0.5).w),
                          // Text(
                          //   'Music',
                          //   style: GoogleFonts.oswald(
                          //     fontWeight: FontWeight.w700,
                          //     fontSize: 4.sp,
                          //     color: isDark? AppColors.white : AppColors.black,
                          //     // letterSpacing: 0.1,
                          //   ),
                          // ),
                          SizedBox(width: 1.w),
                          Text(
                            ' listening to',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 4.sp,
                              color: isDark
                                  ? (isHovered
                                      ? AppColors.black
                                      : dominantColor)
                                  : AppColors.black,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          SizedBox.square(
                            dimension: 8.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.network(
                                albumArt,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.music_note, size: 12),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Flexible(
                            child: Text(
                              '$title by $artist',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 4.sp,
                                color: isDark
                                    ? (isHovered
                                        ? AppColors.black
                                        : dominantColor)
                                    : AppColors.black,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    BoxCircles(
                      hoverEnabled: false,
                      color: isDark
                          ? (isHovered ? AppColors.white : dominantColor)
                          : AppColors.white,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

//TODO: Use _buildIcon, when hovering the widget, it should fade into the album art of the song. Make Icon a bit larger for this, maybe increase height of the widget. Make icon whole left end of the widget (like from top to bottom) and fade into the right side(decreasing right side opacity). Let's make it larger on hover! So the left end will be all albumArt and then a column with title (maxLines: 2), artist, right side will have Boxcircles() as usual. Hope I don't mess up the layout and repaint everything.
//TODO: Make the widget change color based on albumArt when hovered. So we need one dominant color from the albumArt and set it to the background of this widget. While maintaining accessibility; ie, change text color between black and while depending on the background color.
//TODO: Placement: PLace it in the OtherLinks.

//TODO: Change albumArt logic for podcasts. Go to yt_music_tracker and change logic. Make it so that the notification largeIcon is sent over. use logic like, if using package PocketCasts, then send notification albumArt instead.
//TODO: Future=> Switch yt_music_tracker to native as flutter background service may use a lot of battery. Keywords: WorkManager, Kotlin, Foreground Service
