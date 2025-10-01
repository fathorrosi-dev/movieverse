import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieverse/domain/entities/movie/movie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Movie> movies;
  final Duration autoPlayInterval;
  final bool autoPlay;
  final double height;

  const CarouselWithIndicator({
    super.key,
    required this.movies,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlay = true,
    this.height = 277.0,
  });

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator>
    with SingleTickerProviderStateMixin {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late final AnimationController _fadeController;
  int _currentIndex = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  String? _getOptimizedImageUrl(String? path) {
    if (path == null) return null;
    // Get device pixel ratio for optimal image quality
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width * pixelRatio;
    // Choose appropriate TMDB image size based on screen width
    final imageSize = width <= 500 ? 'w500' : 'original';
    return "https://image.tmdb.org/t/p/$imageSize$path";
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.movies.length,
              options: CarouselOptions(
                height: widget.height,
                viewportFraction: 1.0,
                autoPlay: widget.autoPlay && !_isHovered,
                autoPlayInterval: widget.autoPlayInterval,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                  _fadeController.forward(from: 0.0);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final movie = widget.movies[index];
                return FadeTransition(
                  opacity: _fadeController,
                  child: _buildCarouselItem(movie),
                );
              },
            ),
            // Navigation arrows
            if (_isHovered) ...[
              _buildNavigationButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () => _carouselController.previousPage(),
                alignment: Alignment.centerLeft,
              ),
              _buildNavigationButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () => _carouselController.nextPage(),
                alignment: Alignment.centerRight,
              ),
            ],
            // Page indicator
            Positioned(
              bottom: 16,
              right: 16,
              child: AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: widget.movies.length,
                effect: const WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(Movie movie) {
    return Hero(
      tag: 'movie_${movie.id}',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _getOptimizedImageUrl(movie.backdropPath) ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                child: const Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            // Movie info
            Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.title ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  if (movie.releaseDate != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      movie.releaseDate!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
