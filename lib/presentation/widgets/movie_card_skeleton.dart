part of 'movie_card.dart';

class MovieCardSkeleton extends StatelessWidget {
  MovieCardSkeleton({super.key}) : isCarouselView = false;
  MovieCardSkeleton.carousel({super.key}) : isCarouselView = true;
  final random = Random();
  final bool isCarouselView;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Decorations.kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isCarouselView
              ? [
                  _buildImageSkeleton(450),
                  const SizedBox(height: 8.0),
                  _buildTitleSkeleton(),
                  const SizedBox(height: 8.0),
                  _buildDescriptionSkeleton(80),
                ]
              : [
                  _buildImageSkeleton(),
                  const SizedBox(height: 8.0),
                  _buildTitleSkeleton(),
                  const SizedBox(height: 8.0),
                  _buildDescriptionSkeleton(),
                  const SizedBox(height: 8.0),
                  _buildDescriptionSkeleton(130),
                  const SizedBox(height: 8.0),
                  _buildDescriptionSkeleton(80),
                ],
        ),
      ),
    );
  }

  Widget _buildImageSkeleton([double? height]) {
    height = height ?? random.nextInt(100) + 150;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          width: double.infinity,
          height: height.toDouble(),
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildTitleSkeleton() => Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          width: 150,
          height: 20,
          color: Colors.grey[700],
        ),
      );

  Widget _buildDescriptionSkeleton([double width = double.infinity]) => Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          width: width,
          height: 14,
          color: Colors.grey[700],
        ),
      );
}
