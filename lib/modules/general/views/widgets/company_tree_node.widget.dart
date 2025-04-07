import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../../models/company_tree_node.model.dart';

class CompanyStructureNode extends StatelessWidget {
  final CompanyTreeNodeModel data;
  final Function(CompanyTreeNodeModel) onTap;

  const CompanyStructureNode({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isRootNode = data.id == 0;
    return InkWell(
      onTap: () => !isRootNode ? onTap(data) : {},
      child: Container(
        width: AppSizes.s200,
        height: AppSizes.s200,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: isRootNode ? Colors.white : Colors.blue,
          borderRadius: BorderRadius.circular(AppSizes.s15),
          border: Border.all(color: Colors.black, width: 0.9),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSizes.s8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35.0,
              child: CachedNetworkImage(
                imageUrl: data.avatar,
                fit: BoxFit.fill,
                placeholder: (context, url) => const ShimmerAnimatedLoading(
                  circularRaduis: AppSizes.s50,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported_outlined,
                  size: AppSizes.s32,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.s20, bottom: AppSizes.s10),
              child: Text(
                data.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isRootNode ? Colors.black : Colors.white,
                    fontSize: AppSizes.s18),
              ),
            ),
            Text(
              data.jobTitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isRootNode ? Colors.black : Colors.white,
                  fontSize: AppSizes.s15),
            ),
          ],
        ),
      ),
    );
  }
}
