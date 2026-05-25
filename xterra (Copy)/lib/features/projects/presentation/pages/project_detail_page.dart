import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _bg = Color(0xFFF7F7F7);
const _f2 = Color(0xFFF2F2F2);
const _d9 = Color(0xFFD9D9D9);
const _ef = Color(0xFFEFEFEF);
const _ee = Color(0xFFEEEEEE);
const _d6 = Color(0xFFD6D6D6);
const _da = Color(0xFFDADADA);
const _textPrimary = Color(0xFF111111);
const _textSecondary = Color(0xFF555555);
const _textLight = Color(0xFF888888);
const _brand = Color(0xFF2563EB);

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  int _floorPlanTab = 0;
  bool _descExpanded = false;

  static const _floorPlanTabs = [
    'All',
    '2 BHK - Small (4)',
    '2 BHK - Large (4)',
    '3 BHK',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHero(context)),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                _buildPropertyHeader(),
                SizedBox(height: 8.h),
                _buildUnitTypes(),
                SizedBox(height: 8.h),
                _buildMediaResources(),
                SizedBox(height: 8.h),
                _buildFloorPlan(),
                SizedBox(height: 8.h),
                _buildHighlights(),
                SizedBox(height: 8.h),
                _buildMoreAbout(),
                SizedBox(height: 8.h),
                _buildAmenities(),
                SizedBox(height: 8.h),
                _buildLocation(),
                SizedBox(height: 8.h),
                _buildDeveloper(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero ──────────────────────────────────────────────────────────────────

  Widget _buildHero(BuildContext context) {
    return Stack(
      children: [
        _HeroImage(),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8.h,
          left: 12.w,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, size: 18.sp, color: _textPrimary),
            ),
          ),
        ),
      ],
    );
  }

  // ── Property header ───────────────────────────────────────────────────────

  Widget _buildPropertyHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Prestige Lakeside Habitat',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _ef,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/ic_new_launch.svg',
                      width: 13.w,
                      height: 13.w,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'New Launch',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        color: _textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 13.sp, color: _textLight),
              SizedBox(width: 3.w),
              Text(
                'Whitefield, Bengaluru, Karnataka',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.sp,
                  color: _textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              _buildTag('RERA Approved', icon: Icons.verified_user),
              _buildTag('Possession by 2027'),
              _buildTag('High conversion rate'),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _ee),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Expanded(
                  child: _buildStat('Prices Start From', '₹ 85 Lac', 'Onwards'),
                ),
                Container(width: 0.5, height: 52.h, color: _ee),
                Expanded(
                  child: _buildStat('High conversion', '120+', 'Buyers'),
                ),
                Container(width: 0.5, height: 52.h, color: _ee),
                Expanded(
                  child: _buildStat(
                    'Fast Selling Property',
                    '35% sold',
                    'In last one month',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, {IconData? icon}) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: _ef,
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 12.sp, color: Color(0XFFA1A1A1)),
          SizedBox(width: 4.w),
        ],
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.sp,
            color: _textSecondary,
          ),
        ),
      ],
    ),
  );

  Widget _buildStat(String label, String value, String sub) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: _textSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          sub,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.sp,
            color: _textLight,
          ),
        ),
      ],
    ),
  );

  // ── Unit types ────────────────────────────────────────────────────────────

  Widget _buildUnitTypes() {
    const units = [
      _UnitData(
        '2 BHK - Small',
        '4 Variants',
        '₹85 Lac - 1 Cr',
        '20',
        'assets/images/floor_plans/floor_plan_1.png',
      ),
      _UnitData(
        '2 BHK - Large',
        '4 Variants',
        '₹85 Lac - 1 Cr',
        '30',
        'assets/images/floor_plans/floor_plan_2.png',
      ),
      _UnitData(
        '3 BHK - Small',
        '2 Variants',
        '₹85 Lac - 1 Cr',
        '10',
        'assets/images/floor_plans/floor_plan_3.png',
      ),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unit Types and Variants',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          ...units.asMap().entries.map(
            (e) => Column(
              children: [
                if (e.key > 0)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Divider(color: _d6, height: 1, thickness: 1),
                  ),
                _buildUnitCard(e.value),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          _OutlinedBtn(
            label: 'View All Unit Types',
            trailingIcon: Icons.keyboard_arrow_down,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildUnitCard(_UnitData unit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: SizedBox(
            width: 82.w,
            height: 82.h,
            child: Image.asset(
              unit.imagePath,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, _, _) => Container(
                    color: _f2,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/ic_building.svg',
                        width: 28.w,
                        colorFilter: const ColorFilter.mode(
                          _d9,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    unit.type,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  Text(
                    unit.variants,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                unit.priceRange,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.sp,
                  color: _textSecondary,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '+ ${unit.units} Units Available',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11.sp,
                      color: Color(0XFF555555),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: _da,
                        border: Border.all(color: _d9),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: _textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Media & resources ─────────────────────────────────────────────────────

  Widget _buildMediaResources() {
    const items = [
      _MediaItem('Brochure', 'assets/images/ic_pdf.svg'),
      _MediaItem('Videos', 'assets/images/ic_video.svg'),
      _MediaItem('3D Floor Plan', 'assets/images/ic_layer_group.svg'),
      _MediaItem('Gallery', 'assets/images/ic_gallery.svg'),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Media & Resources',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map(_buildMediaItem).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaItem(_MediaItem item) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 58.h,
            decoration: BoxDecoration(
              color: _f2,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: _d9),
            ),
            child: Center(
              child: SvgPicture.asset(item.asset, width: 26.w, height: 26.w),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            item.label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Floor plan ────────────────────────────────────────────────────────────

  Widget _buildFloorPlan() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Floor Plan',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _floorPlanTabs.asMap().entries.map((e) {
                    final selected = e.key == _floorPlanTab;
                    return GestureDetector(
                      onTap: () => setState(() => _floorPlanTab = e.key),
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? _ef : Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          e.value,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            color:
                                selected
                                    ? Color(0XFF555555)
                                    : Color(0XFF333333),
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                _FloorPlanCard(
                  facing: 'East Facing',
                  area: '1590 sq.ft.',
                  price: '₹ 85 Lac',
                  imagePath: 'assets/images/floor_plans/floor_plan_1.png',
                ),
                SizedBox(width: 12.w),
                _FloorPlanCard(
                  facing: 'West Facing',
                  area: '1750 sq.ft.',
                  price: '₹ 90 Lac',
                  imagePath: 'assets/images/floor_plans/floor_plan_2.png',
                ),
                SizedBox(width: 12.w),
                _FloorPlanCard(
                  facing: 'North Facing',
                  area: '1680 sq.ft.',
                  price: '₹ 88 Lac',
                  imagePath: 'assets/images/floor_plans/floor_plan_3.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Highlights ────────────────────────────────────────────────────────────

  Widget _buildHighlights() {
    const highlights = [
      _HighlightData(
        '52 Acres Lush Greenery',
        'Low density luxury living',
        'assets/images/highlights/ic_greenery.svg',
      ),
      _HighlightData(
        '20+ Amenities',
        'All amenities you will ever need',
        'assets/images/highlights/ic_amenities.svg',
      ),
      _HighlightData(
        'Spacious Homes',
        '2, 3 and 4 BHK spacious units',
        'assets/images/highlights/ic_interior.svg',
      ),
      _HighlightData(
        'Excellent Connectivity',
        'Just 500m from main road',
        'assets/images/highlights/ic_navigate.svg',
      ),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Highlights of Prestige Lakeside Habitat',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.2,
            children: highlights.map(_buildHighlightCard).toList(),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _OutlinedBtn(label: 'View All Highlights', onTap: () {}),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _OutlinedBtn(
                  label: 'Share Property',
                  leadingIcon: Icons.share_outlined,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(_HighlightData h) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(h.asset, width: 28.w, height: 28.w),
          SizedBox(height: 10.h),
          Text(
            h.title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            h.sub,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              color: _textLight,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ── More about ────────────────────────────────────────────────────────────

  Widget _buildMoreAbout() {
    const desc =
        'Prestige Lakeside Habitat is a premium residential development nestled near the serene Varthur Lake. The project offers well-designed 3 & 4 BHK apartments with world-class amenities, lush landscaping, and excellent connectivity to major IT hubs.';

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More about this Project',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            desc,
            maxLines: _descExpanded ? null : 4,
            overflow:
                _descExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
              color: _textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: () => setState(() => _descExpanded = !_descExpanded),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _descExpanded ? 'Read Less' : 'Read More',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.sp,
                    color: _textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  _descExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 18.sp,
                  color: _textPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Amenities ─────────────────────────────────────────────────────────────

  Widget _buildAmenities() {
    const amenities = [
      _AmenityItem('Gym', 'assets/images/amenities/ic_amenity_gym.svg'),
      _AmenityItem('Pool', 'assets/images/amenities/ic_amenity_pool.svg'),
      _AmenityItem('Parking', 'assets/images/amenities/ic_amenity_parking.svg'),
      _AmenityItem(
        'Security',
        'assets/images/amenities/ic_amenity_security.svg',
      ),
      _AmenityItem(
        'Garden & Green Space',
        'assets/images/amenities/ic_amenity_garden.svg',
      ),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amenities',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.sp,
                        color: _textLight,
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: 14.sp, color: _textLight),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / 3;
              return Wrap(
                runSpacing: 16.h,
                children:
                    amenities
                        .map(
                          (item) => SizedBox(
                            width: itemWidth,
                            child: _buildAmenityItem(item),
                          ),
                        )
                        .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(_AmenityItem item) {
    return Row(
      children: [
        SvgPicture.asset(item.asset, width: 44.w, height: 44.w),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            item.label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
              color: _textPrimary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  // ── Location ──────────────────────────────────────────────────────────────

  Widget _buildLocation() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'View on Map',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.sp,
                        color: _textLight,
                      ),
                    ),
                    Icon(Icons.arrow_forward, size: 14.sp, color: _textLight),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: _f2,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: _d9),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map_outlined, size: 36.sp, color: _d9),
                  SizedBox(height: 6.h),
                  Text(
                    'Map View',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: _textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14.sp, color: _textLight),
              SizedBox(width: 4.w),
              Text(
                'Varthur Road, Whitefield, Bengaluru - 560066',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.sp,
                  color: _textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Developer ─────────────────────────────────────────────────────────────

  Widget _buildDeveloper() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Developer',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: _ef,
                  shape: BoxShape.circle,
                  border: Border.all(color: _d9),
                ),
                child: Center(
                  child: Text(
                    'PG',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: _textSecondary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prestige Group',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: _textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '15+ years of experience',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: _textLight,
                    ),
                  ),
                  Text(
                    '12 projects delivered',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: _textLight,
                    ),
                  ),
                  Text(
                    '5 ongoing projects',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: _textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: _d6, height: 1, thickness: 1),
          SizedBox(height: 12.h),
          _buildTrustBadge(
            Icons.check_circle_outline,
            'Trusted by 2000+ homeowners',
          ),
          SizedBox(height: 8.h),
          _buildTrustBadge(
            Icons.access_time_outlined,
            'On-time delivery track record',
          ),
          SizedBox(height: 8.h),
          _buildTrustBadge(Icons.verified_outlined, 'RERA compliant projects'),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 16.sp, color: const Color(0xFF4CAF50)),
      SizedBox(width: 8.w),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13.sp,
          color: _textSecondary,
        ),
      ),
    ],
  );
}

// ── Extracted widgets ──────────────────────────────────────────────────────────

class _HeroImage extends StatelessWidget {
  static const _thumbnailImages = [
    'assets/images/projects/project_1.png',
    'assets/images/projects/project_2.png',
    'assets/images/projects/project_3.png',
    'assets/images/projects/project_4.png',
    'assets/images/projects/project_6.png',
    'assets/images/projects/project_7.png',
  ];

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 460.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Main image fills entire area
          Positioned.fill(
            child: Image.asset(
              'assets/images/projects/project_extra.jpg',
              fit: BoxFit.cover,
              errorBuilder:
                  (_, _, _) => Container(color: const Color(0xFFA0A8B0)),
            ),
          ),
          // Fast Selling badge — top-left, below back button
          Positioned(
            top: topPad + 58.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🔥', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(width: 6.w),
                  Text(
                    'Fast Selling Inventory',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Thumbnail strip + pagination overlaid at the bottom of the hero
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Thumbnails row
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          _thumbnailImages.asMap().entries.map((entry) {
                            final i = entry.key;
                            final path = entry.value;
                            final isSelected = i == 0;
                            final isLast = i == _thumbnailImages.length - 1;
                            return Container(
                              width: 82.w,
                              height: 64.h,
                              margin: EdgeInsets.only(right: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    isSelected
                                        ? Border.all(
                                          color: Colors.white,
                                          width: 2.5,
                                        )
                                        : null,
                                boxShadow:
                                    isSelected
                                        ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.25,
                                            ),
                                            blurRadius: 6,
                                          ),
                                        ]
                                        : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      path,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, _, _) => Container(
                                            color: const Color(0xFF8A9099),
                                          ),
                                    ),
                                    if (isLast)
                                      Container(
                                        color: Colors.black.withValues(
                                          alpha: 0.45,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+18',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                // Pagination row — on the image
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1/22',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ...List.generate(4, (i) {
                        final isActive = i == 0;
                        return Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.only(left: 5.w),
                          decoration: BoxDecoration(
                            color:
                                isActive
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloorPlanCard extends StatelessWidget {
  final String facing;
  final String area;
  final String price;
  final String imagePath;

  const _FloorPlanCard({
    required this.facing,
    required this.area,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 48.w;
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with 3D badge
          Stack(
            children: [
              SizedBox(
                height: 220.h,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, _, _) => Container(
                        color: _f2,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/ic_layer_group.svg',
                            width: 40.w,
                            colorFilter: const ColorFilter.mode(
                              _d9,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_3d.svg',
                        width: 12.w,
                        height: 12.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        '3D >',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Text section
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  facing,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Super Built-up Area',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    color: Color(0XFF777777),
                  ),
                ),
                Text(
                  area,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    color: Color(0XFF333333),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  price,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedBtn extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback onTap;

  const _OutlinedBtn({
    required this.label,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(color: const Color(0xFFDADADA)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 16.sp, color: _textPrimary),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.sp,
                color: _textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (trailingIcon != null) ...[
              SizedBox(width: 4.w),
              Icon(trailingIcon, size: 18.sp, color: _textPrimary),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Data models ────────────────────────────────────────────────────────────────

class _UnitData {
  final String type, variants, priceRange, units, imagePath;
  const _UnitData(
    this.type,
    this.variants,
    this.priceRange,
    this.units,
    this.imagePath,
  );
}

class _MediaItem {
  final String label, asset;
  const _MediaItem(this.label, this.asset);
}

class _HighlightData {
  final String title, sub, asset;
  const _HighlightData(this.title, this.sub, this.asset);
}

class _AmenityItem {
  final String label, asset;
  const _AmenityItem(this.label, this.asset);
}
