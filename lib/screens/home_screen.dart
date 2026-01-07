import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lesson_18/device_type_util.dart';
import 'package:lesson_18/inheritated_app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isLargeScreen = width > 600;
    final isDarkMode =
        InheritatedAppTheme.of(context).theme.value == ThemeMode.dark;

    final horizontalPadding = isLargeScreen ? 40.0 : 20.0;
    final cardAspectRatio = isLargeScreen ? 2.5 : 1.5;
    final crossAxisCount = isLargeScreen ? 2 : 1;
    final titleFontSize = isLargeScreen ? 28.0 : 22.0;
    final cardSpacing = isLargeScreen ? 20.0 : 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getDeviceTitle(context),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: titleFontSize,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: isLargeScreen ? 28 : 24,
            ),
            onPressed: () {
              InheritatedAppTheme.of(context).theme.toggleMode();
            },
            tooltip: isDarkMode ? 'Светлая тема' : 'Темная тема',
          ),
          SizedBox(width: isLargeScreen ? 16 : 8),
        ],
      ),
      body: Stack(
        children: [
          if (isLargeScreen) ...[
            Positioned(
              left: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: SvgPicture.network(
                "https://app.rekassa.kz/static/icons/left-shape.svg",
                fit: BoxFit.scaleDown,
                width: 50.0,
                height: 50.0,
              ),
            ),
            Positioned.fill(
              child: Image.network(
                "https://static.tildacdn.pro/tild3139-6630-4230-b030-626238616130/1.webp",
                fit: BoxFit.scaleDown,
                width: 400.0,
                height: 400.0,
              ),
            ),
            Positioned(
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: SvgPicture.network(
                "https://app.rekassa.kz/static/icons/right-shape.svg",
                fit: BoxFit.scaleDown,
                width: 50.0,
                height: 50.0,
              ),
            ),
          ],
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    SizedBox(height: isLargeScreen ? 40 : 20),
                    _buildWelcomeSection(context, isLargeScreen),
                    SizedBox(height: cardSpacing * 2),
                    _buildInfoSection(context, isLargeScreen, isDarkMode),
                    SizedBox(height: cardSpacing * 2),
                    _buildAdaptiveCardGrid(
                      context,
                      isLargeScreen,
                      crossAxisCount,
                      cardAspectRatio,
                      cardSpacing,
                    ),
                    SizedBox(height: isLargeScreen ? 60 : 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDeviceTitle(BuildContext context) {
    if (DeviceTypeUtil.isDesktop(context)) {
      return "Десктоп версия";
    } else if (DeviceTypeUtil.isTablet(context)) {
      return "Планшет версия";
    } else if (DeviceTypeUtil.isMobile(context)) {
      return "Мобильная версия";
    }
    return "Адаптивное приложение";
  }

  Widget _buildWelcomeSection(BuildContext context, bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 32 : 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.waving_hand,
            size: isLargeScreen ? 48 : 36,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(height: isLargeScreen ? 16 : 12),
          Text(
            "Добро пожаловать!",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isLargeScreen ? 32 : 24,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isLargeScreen ? 12 : 8),
          Text(
            "Адаптивное приложение с темами",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isLargeScreen ? 18 : 14,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
      BuildContext context, bool isLargeScreen, bool isDarkMode) {
    final width = MediaQuery.of(context).size.width;

    if (isLargeScreen) {
      return Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              context,
              icon: Icons.phone_android,
              title: "Адаптивность",
              description: "Интерфейс подстраивается под размер экрана",
              isLargeScreen: isLargeScreen,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: _buildThemeCard(context, isLargeScreen, isDarkMode),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildInfoCard(
            context,
            icon: Icons.phone_android,
            title: "Адаптивность",
            description: "Интерфейс подстраивается под размер экрана",
            isLargeScreen: isLargeScreen,
          ),
          const SizedBox(height: 16),
          _buildThemeCard(context, isLargeScreen, isDarkMode),
        ],
      );
    }
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool isLargeScreen,
  }) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: isLargeScreen ? 40 : 32,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(height: isLargeScreen ? 16 : 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: isLargeScreen ? 20 : 18,
                ),
          ),
          SizedBox(height: isLargeScreen ? 8 : 6),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: isLargeScreen ? 16 : 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard(
      BuildContext context, bool isLargeScreen, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: isLargeScreen ? 40 : 32,
                color: Theme.of(context).iconTheme.color,
              ),
              Switch.adaptive(
                value: isDarkMode,
                onChanged: (value) {
                  InheritatedAppTheme.of(context).theme.toggleMode();
                },
              ),
            ],
          ),
          SizedBox(height: isLargeScreen ? 16 : 12),
          Text(
            "Переключение темы",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: isLargeScreen ? 20 : 18,
                ),
          ),
          SizedBox(height: isLargeScreen ? 8 : 6),
          Text(
            isDarkMode ? "Темная тема активна" : "Светлая тема активна",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: isLargeScreen ? 16 : 14,
                ),
          ),
        ],
      ),
    );
  }

  // Адаптивная сетка карточек
  Widget _buildAdaptiveCardGrid(
    BuildContext context,
    bool isLargeScreen,
    int crossAxisCount,
    double cardAspectRatio,
    double cardSpacing,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio:
            isLargeScreen ? 2.5 : 2.2, // ← ИЗМЕНЕНО: было 1.8, стало 2.2
        crossAxisSpacing: cardSpacing,
        mainAxisSpacing: cardSpacing,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return _buildFeatureCard(context, index, isLargeScreen);
      },
    );
  }

  // Карточка функции
  Widget _buildFeatureCard(
      BuildContext context, int index, bool isLargeScreen) {
    final icons = [
      Icons.dashboard,
      Icons.favorite,
      Icons.settings,
      Icons.notifications,
      Icons.person,
      Icons.message,
      Icons.camera,
      Icons.map,
      Icons.calendar_today,
      Icons.shopping_cart,
      Icons.star,
      Icons.help,
    ];

    final titles = [
      "Дашборд",
      "Избранное",
      "Настройки",
      "Уведомления",
      "Профиль",
      "Сообщения",
      "Камера",
      "Карты",
      "Календарь",
      "Корзина",
      "Рейтинг",
      "Помощь",
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Нажато: ${titles[index]}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 16 : 12,
            vertical: isLargeScreen ? 16 : 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icons[index],
                size: isLargeScreen ? 40 : 28,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(height: isLargeScreen ? 12 : 6),
              Flexible(
                child: Text(
                  titles[index],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: isLargeScreen ? 16 : 14,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: isLargeScreen ? 6 : 3),
              Flexible(
                child: Text(
                  "Карточка #${index + 1}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: isLargeScreen ? 12 : 10,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
