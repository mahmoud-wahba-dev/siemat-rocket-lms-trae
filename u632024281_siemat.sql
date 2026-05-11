-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 07 mai 2026 à 21:37
-- Version du serveur : 11.8.6-MariaDB-log
-- Version de PHP : 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `u632024281_siemat`
--

-- --------------------------------------------------------

--
-- Structure de la table `abandoned_cart_rules`
--

CREATE TABLE `abandoned_cart_rules` (
  `id` int(10) UNSIGNED NOT NULL,
  `target_type` enum('all','courses','store_products','bundles','meetings') NOT NULL DEFAULT 'all',
  `target` varchar(255) DEFAULT NULL,
  `action` enum('send_reminder','send_coupon') NOT NULL,
  `discount_id` int(10) UNSIGNED DEFAULT NULL,
  `action_cycle` int(10) UNSIGNED NOT NULL,
  `repeat_action` tinyint(1) NOT NULL DEFAULT 0,
  `repeat_action_count` int(10) UNSIGNED DEFAULT NULL,
  `minimum_cart_amount` double(15,2) UNSIGNED DEFAULT NULL,
  `maximum_cart_amount` double(15,2) UNSIGNED DEFAULT NULL,
  `start_at` bigint(20) UNSIGNED DEFAULT NULL,
  `end_at` bigint(20) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `abandoned_cart_rules`
--

INSERT INTO `abandoned_cart_rules` (`id`, `target_type`, `target`, `action`, `discount_id`, `action_cycle`, `repeat_action`, `repeat_action_count`, `minimum_cart_amount`, `maximum_cart_amount`, `start_at`, `end_at`, `enable`, `created_at`) VALUES
(1, 'all', NULL, 'send_reminder', NULL, 12, 1, 5, 200.00, 1000.00, 1709269200, 1837137600, 0, 1709794892),
(2, 'courses', 'all_courses', 'send_coupon', 25, 18, 1, 3, 50.00, NULL, 1709330400, 1838246400, 0, 1709888086);

-- --------------------------------------------------------

--
-- Structure de la table `abandoned_cart_rule_histories`
--

CREATE TABLE `abandoned_cart_rule_histories` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `cart_rule_id` int(10) UNSIGNED DEFAULT NULL,
  `rule_action` enum('send_reminder','send_coupon') NOT NULL,
  `type` enum('auto','manual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'auto',
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `abandoned_cart_rule_specification_items`
--

CREATE TABLE `abandoned_cart_rule_specification_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `abandoned_cart_rule_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `abandoned_cart_rule_translations`
--

CREATE TABLE `abandoned_cart_rule_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `abandoned_cart_rule_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `abandoned_cart_rule_translations`
--

INSERT INTO `abandoned_cart_rule_translations` (`id`, `abandoned_cart_rule_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Cart Reminder Rule'),
(2, 2, 'en', 'Discount Offer Rule');

-- --------------------------------------------------------

--
-- Structure de la table `abandoned_cart_rule_users_groups`
--

CREATE TABLE `abandoned_cart_rule_users_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `abandoned_cart_rule_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `accounting`
--

CREATE TABLE `accounting` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `order_item_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `meeting_time_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `promotion_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_payment_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_order_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'This field is filled in the seller''s financial document to find the installment order',
  `gift_id` int(10) UNSIGNED DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT 0,
  `tax` tinyint(1) NOT NULL DEFAULT 0,
  `amount` decimal(13,2) DEFAULT NULL,
  `type` enum('addiction','deduction') NOT NULL,
  `type_account` enum('income','asset','subscribe','promotion','registration_package','installment_payment') DEFAULT NULL,
  `store_type` enum('automatic','manual') NOT NULL DEFAULT 'automatic',
  `referred_user_id` int(10) UNSIGNED DEFAULT NULL,
  `is_affiliate_amount` tinyint(1) NOT NULL DEFAULT 0,
  `is_affiliate_commission` tinyint(1) NOT NULL DEFAULT 0,
  `is_registration_bonus` tinyint(1) NOT NULL DEFAULT 0,
  `is_cashback` tinyint(1) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `advertising_banners`
--

CREATE TABLE `advertising_banners` (
  `id` int(10) UNSIGNED NOT NULL,
  `position` enum('home1','home2','course','course_sidebar','product_show','bundle','bundle_sidebar','upcoming_course','upcoming_course_sidebar') NOT NULL,
  `size` int(10) UNSIGNED NOT NULL DEFAULT 12,
  `link` varchar(255) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `advertising_banners`
--

INSERT INTO `advertising_banners` (`id`, `position`, `size`, `link`, `published`, `created_at`) VALUES
(6, 'course_sidebar', 12, '/instructor-finder', 1, 1607886391),
(7, 'course_sidebar', 12, '/reward-courses', 1, 1607886440),
(8, 'product_show', 12, '/forums', 1, 1656569687),
(9, 'bundle_sidebar', 12, '/reward-courses', 1, 1656571896);

-- --------------------------------------------------------

--
-- Structure de la table `advertising_banners_translations`
--

CREATE TABLE `advertising_banners_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `advertising_banner_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `advertising_banners_translations`
--

INSERT INTO `advertising_banners_translations` (`id`, `advertising_banner_id`, `locale`, `title`, `image`) VALUES
(4, 6, 'en', 'Meeting Booking - Course page', '/store/1/default_images/banners/meeting-banner-side.png'),
(5, 7, 'en', 'Reward - Course page', '/store/1/default_images/banners/rewards-banner-side.png'),
(13, 6, 'ar', 'حجز اجتماع - صفحة الدورة', '/store/1/default_images/banners/reserve_a_meeting_ar.png'),
(14, 6, 'es', 'Reservar una reunión - página del curso', '/store/1/default_images/banners/reserve_a_meeting_es.png'),
(15, 7, 'ar', 'التحقق من صحة الشهادة - صفحة الدورة', '/store/1/default_images/banners/validate_certificates_banner_ar.png'),
(16, 7, 'es', 'Validación del certificado - página del curso', '/store/1/default_images/banners/validate_certificates_banner_es.png'),
(17, 8, 'en', 'Forums - Product page', '/store/1/default_images/banners/forum-banner-full.png'),
(18, 8, 'ar', 'المتجر - صفحة المنتج', '/store/1/default_images/banners/store_ar.png'),
(19, 8, 'es', 'Tienda - Página del producto', '/store/1/default_images/banners/store_es.png'),
(20, 9, 'en', 'Rewards - Bundle Sidebar', '/store/1/default_images/banners/rewards-banner-side.png'),
(21, 9, 'ar', 'حزمة الدورة - الشريط الجانبي', '/store/1/default_images/banners/bundle_ar.png'),
(22, 9, 'es', 'Paquete de cursos - Barra lateral', '/store/1/default_images/banners/bundle_es.png');

-- --------------------------------------------------------

--
-- Structure de la table `affiliates`
--

CREATE TABLE `affiliates` (
  `id` int(10) UNSIGNED NOT NULL,
  `affiliate_user_id` int(10) UNSIGNED NOT NULL,
  `referred_user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `affiliates_codes`
--

CREATE TABLE `affiliates_codes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(32) NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agora_history`
--

CREATE TABLE `agora_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL,
  `start_at` int(10) UNSIGNED NOT NULL,
  `end_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `agora_history`
--

INSERT INTO `agora_history` (`id`, `session_id`, `start_at`, `end_at`) VALUES
(32, 108, 1763894637, 1763895113);

-- --------------------------------------------------------

--
-- Structure de la table `ai_contents`
--

CREATE TABLE `ai_contents` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `service_type` enum('text','image') NOT NULL,
  `service_id` int(10) UNSIGNED DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `prompt` text DEFAULT NULL,
  `result` text DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ai_contents`
--

INSERT INTO `ai_contents` (`id`, `user_id`, `service_type`, `service_id`, `keyword`, `language`, `prompt`, `result`, `created_at`) VALUES
(1, 1, 'text', 5, 'Laravel', 'English', 'Generate a text with the Laravel subject in English language with less than 100 word for a blog short description.', '{\"text\":\"Discover the power of Laravel \\u2013 an elegant and intuitive PHP framework designed for web artisans. With its extensive set of tools and libraries, Laravel empowers developers to create robust and scalable web applications with ease. Whether you\\u2019re a beginner or a seasoned professional, delve into the world of Laravel and unlock unparalleled efficiency and productivity in your coding journey. Join us as we explore the wonders of Laravel and its seamless integration capabilities, making web development a breeze.\",\"images\":[]}', 1694943786);

-- --------------------------------------------------------

--
-- Structure de la table `ai_content_templates`
--

CREATE TABLE `ai_content_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('text','image') NOT NULL,
  `enable_length` tinyint(1) NOT NULL DEFAULT 0,
  `length` int(10) UNSIGNED DEFAULT NULL,
  `image_size` enum('256','512','1024') DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ai_content_templates`
--

INSERT INTO `ai_content_templates` (`id`, `type`, `enable_length`, `length`, `image_size`, `enable`, `created_at`) VALUES
(1, 'text', 1, 5, NULL, 1, 1694939030),
(2, 'text', 1, 40, NULL, 1, 1694940999),
(3, 'text', 1, 300, NULL, 1, 1694941070),
(4, 'text', 1, 5, NULL, 1, 1694941199),
(5, 'text', 1, 100, NULL, 1, 1694941500),
(6, 'text', 1, 300, NULL, 1, 1694941560),
(7, 'image', 0, NULL, '512', 1, 1694942113),
(8, 'text', 1, 160, NULL, 1, 1694942972),
(9, 'text', 1, 160, NULL, 1, 1694970677),
(10, 'text', 1, 300, NULL, 1, 1694970808),
(11, 'text', 1, 150, NULL, 1, 1694971282),
(12, 'text', 0, NULL, NULL, 1, 1694994114),
(13, 'text', 0, NULL, NULL, 1, 1694994456),
(14, 'text', 1, 200, NULL, 1, 1694994762),
(15, 'text', 1, 200, NULL, 1, 1694995011),
(16, 'text', 1, 300, NULL, 1, 1694995299),
(17, 'text', 1, 100, NULL, 1, 1694995502),
(18, 'text', 1, 5, NULL, 1, 1695024064),
(19, 'text', 1, 300, NULL, 1, 1695024166),
(20, 'text', 1, 160, NULL, 1, 1695024265);

-- --------------------------------------------------------

--
-- Structure de la table `ai_content_template_translations`
--

CREATE TABLE `ai_content_template_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `ai_content_template_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `prompt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ai_content_template_translations`
--

INSERT INTO `ai_content_template_translations` (`id`, `ai_content_template_id`, `locale`, `title`, `prompt`) VALUES
(1, 1, 'en', 'Course Title', 'Generate a text with the [keyword] subject in [language] language with less than [length] word for a course title.'),
(2, 2, 'en', 'Course Short Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words.'),
(3, 3, 'en', 'Course Long Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words.'),
(4, 4, 'en', 'Blog Title', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a blog title.'),
(5, 5, 'en', 'Blog Short Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a blog short description.'),
(6, 6, 'en', 'Blog Long Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a blog description.'),
(7, 7, 'en', 'Genrate Image', 'Generate an image with the [keyword] subject.'),
(8, 8, 'en', 'Course SEO Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a course SEO description.'),
(9, 9, 'en', 'Blog SEO Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a blog SEO description.'),
(10, 10, 'en', 'Upcoming Course Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for an upcoming course.'),
(11, 11, 'en', 'Quiz Question', 'Generate a question with the [keyword] subject in the [language] language with less than [length] words.'),
(12, 12, 'en', 'Generate FAQ', 'Generate a faq with the [keyword] subject in the [keyword] language.'),
(13, 13, 'en', 'Course Requirements', 'Generate requirements for a course with [keyword] subject in [language].'),
(14, 14, 'en', 'Form Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a form description.'),
(15, 15, 'en', 'Course Advertising Description', 'Generate a text with the [keyword] subject in [language] with less than [length] words for a course advertising description.'),
(16, 16, 'en', '\"About Us\" Page Description', 'Generate a text with the [keyword] subject in [language] with less than [length] words for the \"About Us\" page description.'),
(17, 17, 'en', 'Generate Notice', 'Generate a text with the [keyword] subject in [language] with less than [length] words for notice.'),
(18, 18, 'en', 'Store Product Title', 'Generate a text with the [keyword] subject in [language] language with less than [length] word for a product title.'),
(19, 19, 'en', 'Store Product Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a store product description.'),
(20, 20, 'en', 'Store Product SEO Description', 'Generate a text with the [keyword] subject in the [language] language with less than [length] words for a store product  SEO description.');

-- --------------------------------------------------------

--
-- Structure de la table `badges`
--

CREATE TABLE `badges` (
  `id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `type` enum('register_date','course_count','course_rate','sale_count','support_rate','product_sale_count','make_topic','send_post_in_topic','instructor_blog') NOT NULL,
  `condition` varchar(128) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `badges`
--

INSERT INTO `badges` (`id`, `image`, `type`, `condition`, `score`, `created_at`) VALUES
(21, '/store/1/default_images/badges/registration1.svg', 'register_date', '{\"from\":\"1\",\"to\":\"30\"}', 5, 1625553769),
(22, '/store/1/default_images/badges/registration2.svg', 'register_date', '{\"from\":\"31\",\"to\":\"365\"}', 10, 1625554171),
(23, '/store/1/default_images/badges/registration3.svg', 'register_date', '{\"from\":\"365\",\"to\":\"1000\"}', 15, 1625554495),
(24, '/store/1/default_images/badges/courses1.svg', 'course_count', '{\"from\":\"1\",\"to\":\"1\"}', 10, 1625554772),
(25, '/store/1/default_images/badges/courses2.svg', 'course_count', '{\"from\":\"2\",\"to\":\"2\"}', 20, 1625554960),
(26, '/store/1/default_images/badges/courses3.svg', 'course_count', '{\"from\":\"3\",\"to\":\"6\"}', 30, 1625555421),
(27, '/store/1/default_images/badges/rating1.svg', 'course_rate', '{\"from\":\"2\",\"to\":\"3\"}', NULL, 1625556048),
(28, '/store/1/default_images/badges/rating2.svg', 'course_rate', '{\"from\":\"3\",\"to\":\"4\"}', 10, 1625556159),
(29, '/store/1/default_images/badges/rating3.svg', 'course_rate', '{\"from\":\"4\",\"to\":\"5\"}', 50, 1625556284),
(30, '/store/1/default_images/badges/sales1.svg', 'sale_count', '{\"from\":\"1\",\"to\":\"2\"}', NULL, 1625557021),
(31, '/store/1/default_images/badges/sales2.svg', 'sale_count', '{\"from\":\"3\",\"to\":\"9\"}', 20, 1625557247),
(32, '/store/1/default_images/badges/sales3.svg', 'sale_count', '{\"from\":\"10\",\"to\":\"20\"}', 50, 1625558061),
(33, '/store/1/default_images/badges/support1.svg', 'support_rate', '{\"from\":\"2\",\"to\":\"3\"}', NULL, 1625558473),
(34, '/store/1/default_images/badges/support2.svg', 'support_rate', '{\"from\":\"3\",\"to\":\"4\"}', NULL, 1625558682),
(35, '/store/1/default_images/badges/support3.svg', 'support_rate', '{\"from\":\"4\",\"to\":\"5\"}', 20, 1625558892),
(36, '/store/1/default_images/badges/store1.svg', 'product_sale_count', '{\"from\":\"5\",\"to\":\"9\"}', 5, 1656145531),
(37, '/store/1/default_images/badges/store2.svg', 'product_sale_count', '{\"from\":\"10\",\"to\":\"15\"}', 10, 1656145677),
(38, '/store/1/default_images/badges/forum1.svg', 'make_topic', '{\"from\":\"1\",\"to\":\"5\"}', 10, 1656145989),
(39, '/store/1/default_images/badges/forum2.svg', 'make_topic', '{\"from\":\"6\",\"to\":\"10\"}', 15, 1656146136),
(40, '/store/1/default_images/badges/articles1.svg', 'instructor_blog', '{\"from\":\"5\",\"to\":\"10\"}', 20, 1656146397),
(41, '/store/1/default_images/badges/forum_replies_1.svg', 'send_post_in_topic', '{\"from\":\"20\",\"to\":\"30\"}', 10, 1656146689);

-- --------------------------------------------------------

--
-- Structure de la table `badge_translations`
--

CREATE TABLE `badge_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `badge_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `badge_translations`
--

INSERT INTO `badge_translations` (`id`, `badge_id`, `locale`, `title`, `description`) VALUES
(1, 21, 'en', 'New User', '1 Month of Membership'),
(2, 22, 'en', 'Loyal User', '1 year of Membership'),
(3, 23, 'en', 'Faithful User', 'Old Membership'),
(4, 24, 'en', 'Junior Vendor', 'Has 1 Class'),
(5, 25, 'en', 'Senior Vendor', 'Has 2 Classes'),
(6, 26, 'en', 'Expert Vendor', 'Has 3 to 6 Classes'),
(7, 27, 'en', 'Bronze Classes', 'Classes Rating from 2 to 3'),
(8, 28, 'en', 'Silver Classes', 'Classes Rating from 3 to 4'),
(9, 29, 'en', 'Golden Classes', 'Classes Rating from 4 to 5'),
(10, 30, 'en', 'Best Seller', 'Classes Sales from 1 to 2'),
(11, 31, 'en', 'Top Seller', 'Classes Sales from 3 to 9'),
(12, 32, 'en', 'King Seller', 'Classes Sales from 10 to 20'),
(13, 33, 'en', 'Good Support', 'Support Rating from 2 to 3'),
(14, 34, 'en', 'Amazing Support', 'Support Rating from 3 to 4'),
(15, 35, 'en', 'Fantastic Support', 'Support Rating from 4 to 5'),
(16, 36, 'en', 'Store Best Seller', 'Store Products Sales from 1 to 5'),
(17, 37, 'en', 'Store King Seller', 'Store Products Sales from 6 to 15'),
(18, 38, 'en', 'Forums Top User', 'Has 2 to 5 Topics'),
(19, 39, 'en', 'Forums Best User', 'Has 6 to 10 Topics'),
(20, 40, 'en', 'Loyal Writer', 'Has 5 to 10 Articles'),
(21, 41, 'en', 'Forum Loyal User', 'Has 20 to 30 Posts in Forums');

-- --------------------------------------------------------

--
-- Structure de la table `become_instructors`
--

CREATE TABLE `become_instructors` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role` enum('teacher','organization') NOT NULL,
  `package_id` int(10) UNSIGNED DEFAULT NULL,
  `certificate` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','accept','reject') NOT NULL DEFAULT 'pending',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `blog`
--

CREATE TABLE `blog` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `study_time` int(10) UNSIGNED DEFAULT NULL,
  `visit_count` int(10) UNSIGNED DEFAULT 0,
  `enable_comment` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('pending','publish') NOT NULL DEFAULT 'pending',
  `created_at` int(10) UNSIGNED NOT NULL,
  `updated_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `icon2` varchar(255) DEFAULT NULL,
  `icon2_box_color` varchar(255) DEFAULT NULL,
  `overlay_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `slug`, `cover_image`, `icon`, `icon2`, `icon2_box_color`, `overlay_image`) VALUES
(33, 'Vel-consequatur', NULL, NULL, NULL, NULL, NULL),
(34, 'Facilis-ea', NULL, NULL, NULL, NULL, NULL),
(36, 'Fugit-dignissimos-possimus', NULL, NULL, NULL, NULL, NULL),
(37, 'new', NULL, NULL, NULL, NULL, NULL),
(39, 'tips', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `blog_category_translations`
--

CREATE TABLE `blog_category_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `blog_category_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `blog_category_translations`
--

INSERT INTO `blog_category_translations` (`id`, `blog_category_id`, `locale`, `title`, `subtitle`) VALUES
(1, 33, 'en', 'Announcements', 'Stay updated with the latest platform updates and releases'),
(2, 34, 'en', 'Articles', 'Explore expert tips, insights, and in-depth learning guides'),
(3, 36, 'en', 'Events', 'Discover upcoming webinars, workshops, and special activities'),
(4, 37, 'en', 'News', 'Catch up on recent education trends and platform news'),
(5, 39, 'en', 'Tip and Tricks', 'Boost your learning with practical tips and smart techniques');

-- --------------------------------------------------------

--
-- Structure de la table `blog_featured_categories`
--

CREATE TABLE `blog_featured_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `thumbnail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `blog_featured_categories`
--

INSERT INTO `blog_featured_categories` (`id`, `category_id`, `thumbnail`) VALUES
(1, 33, '/store/1/default_images/store/featured_store_category_1.jpg'),
(2, 34, '/store/1/default_images/store/featured_store_category_2.jpg'),
(3, 36, '/store/1/default_images/store/featured_store_category_3.jpg'),
(4, 37, '/store/1/default_images/store/featured_store_category_4.jpg'),
(5, 39, '/store/1/default_images/store/featured_store_category_5.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `blog_translations`
--

CREATE TABLE `blog_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `description` text NOT NULL,
  `content` longtext NOT NULL,
  `meta_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bulk_imports`
--

CREATE TABLE `bulk_imports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `data_type` enum('courses','categories','users','products') NOT NULL,
  `valid_items` int(10) UNSIGNED NOT NULL,
  `invalid_items` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bundles`
--

CREATE TABLE `bundles` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `teacher_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `image_cover` varchar(255) DEFAULT NULL,
  `video_demo` varchar(255) DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link','google_drive','iframe','s3','secure_host') DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `subscribe` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `access_days` int(10) UNSIGNED DEFAULT NULL COMMENT 'Number of days to access the bundle',
  `message_for_reviewer` text DEFAULT NULL,
  `status` enum('active','pending','is_draft','inactive') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL,
  `updated_at` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bundle_filter_option`
--

CREATE TABLE `bundle_filter_option` (
  `id` int(10) UNSIGNED NOT NULL,
  `bundle_id` int(10) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bundle_translations`
--

CREATE TABLE `bundle_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bundle_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `seo_description` text DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bundle_webinars`
--

CREATE TABLE `bundle_webinars` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `bundle_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

CREATE TABLE `cart` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `product_order_id` int(10) UNSIGNED DEFAULT NULL,
  `reserve_meeting_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `promotion_id` int(10) UNSIGNED DEFAULT NULL,
  `gift_id` int(10) UNSIGNED DEFAULT NULL,
  `ticket_id` int(10) UNSIGNED DEFAULT NULL,
  `special_offer_id` int(10) UNSIGNED DEFAULT NULL,
  `product_discount_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_payment_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `cart_discounts`
--

CREATE TABLE `cart_discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `show_only_on_empty_cart` tinyint(1) NOT NULL DEFAULT 0,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cart_discounts`
--

INSERT INTO `cart_discounts` (`id`, `discount_id`, `show_only_on_empty_cart`, `enable`, `created_at`) VALUES
(2, 25, 0, 0, 1754345847);

-- --------------------------------------------------------

--
-- Structure de la table `cart_discount_translations`
--

CREATE TABLE `cart_discount_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `cart_discount_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cart_discount_translations`
--

INSERT INTO `cart_discount_translations` (`id`, `cart_discount_id`, `locale`, `title`, `subtitle`) VALUES
(2, 2, 'en', 'Finalize your purchase with a discount', 'Please take advantage of this limited special offer by using the coupon and completing your purchase.');

-- --------------------------------------------------------

--
-- Structure de la table `cashback_rules`
--

CREATE TABLE `cashback_rules` (
  `id` int(10) UNSIGNED NOT NULL,
  `target_type` enum('all','courses','store_products','bundles','meetings','registration_packages','subscription_packages','recharge_wallet') NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  `start_date` bigint(20) UNSIGNED DEFAULT NULL,
  `end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  `amount_type` enum('fixed_amount','percent') DEFAULT NULL,
  `apply_cashback_per_item` tinyint(1) NOT NULL DEFAULT 0,
  `max_amount` double(15,2) DEFAULT NULL,
  `min_amount` double(15,2) DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cashback_rules`
--

INSERT INTO `cashback_rules` (`id`, `target_type`, `target`, `start_date`, `end_date`, `amount`, `amount_type`, `apply_cashback_per_item`, `max_amount`, `min_amount`, `enable`, `created_at`) VALUES
(5, 'all', NULL, 1672610400, NULL, 10.00, 'percent', 0, NULL, NULL, 0, 1678921892);

-- --------------------------------------------------------

--
-- Structure de la table `cashback_rule_specification_items`
--

CREATE TABLE `cashback_rule_specification_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `cashback_rule_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cashback_rule_translations`
--

CREATE TABLE `cashback_rule_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `cashback_rule_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cashback_rule_translations`
--

INSERT INTO `cashback_rule_translations` (`id`, `cashback_rule_id`, `locale`, `title`) VALUES
(5, 5, 'en', 'Christmas Cashback');

-- --------------------------------------------------------

--
-- Structure de la table `cashback_rule_users_groups`
--

CREATE TABLE `cashback_rule_users_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `cashback_rule_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `icon2` varchar(255) DEFAULT NULL,
  `icon2_box_color` varchar(255) DEFAULT NULL,
  `overlay_image` varchar(255) DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `slug`, `parent_id`, `icon`, `order`, `cover_image`, `icon2`, `icon2_box_color`, `overlay_image`, `enable`) VALUES
(612, 'تعليم', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0),
(613, 'تطوير', NULL, NULL, 2, NULL, NULL, NULL, NULL, 0),
(614, 'التواصل', NULL, NULL, 3, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `category_translations`
--

CREATE TABLE `category_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `bottom_seo_title` text DEFAULT NULL,
  `bottom_seo_content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category_translations`
--

INSERT INTO `category_translations` (`id`, `category_id`, `locale`, `title`, `subtitle`, `bottom_seo_title`, `bottom_seo_content`) VALUES
(55, 612, 'ar', 'تعليم', NULL, NULL, NULL),
(56, 613, 'ar', 'تطوير', NULL, NULL, NULL),
(57, 614, 'ar', 'التواصل', 'التواصل الفعال', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(10) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED DEFAULT NULL,
  `quiz_result_id` int(10) UNSIGNED DEFAULT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `user_grade` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('quiz','course','bundle') NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `certificates_templates`
--

CREATE TABLE `certificates_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('quiz','course','bundle') NOT NULL,
  `position_x` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `position_y` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `font_size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `text_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('draft','publish') NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `certificates_templates`
--

INSERT INTO `certificates_templates` (`id`, `image`, `type`, `position_x`, `position_y`, `font_size`, `text_color`, `status`, `created_at`, `updated_at`) VALUES
(7, '/store/1/default_images/certificate_background.jpg', 'quiz', NULL, NULL, NULL, NULL, 'publish', 1709112544, NULL),
(8, '/store/1/default_images/certificate_background.jpg', 'course', NULL, NULL, NULL, NULL, 'publish', 1709713472, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `certificate_template_translations`
--

CREATE TABLE `certificate_template_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `certificate_template_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `rtl` tinyint(4) DEFAULT NULL,
  `elements` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `certificate_template_translations`
--

INSERT INTO `certificate_template_translations` (`id`, `certificate_template_id`, `locale`, `title`, `body`, `rtl`, `elements`) VALUES
(9, 7, 'en', 'Quiz-depended Certificate Template', '<div class=\"certificate-template-container\" style=\"background-image: url(&quot;https://lms.rocket-soft.org/store/1/default_images/certificate_background.jpg&quot;);\"><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"title\" style=\"top: 225.134px; left: 247.125px; font-size: 22px; color: rgb(0, 0, 0); text-align: inherit; font-weight: bold;\">This certificate awarded to [student_name]</div><div class=\"draggable-element ui-draggable ui-draggable-handle ui-draggable-dragging\" data-name=\"subtitle\" style=\"top: 271.982px; left: 320.964px; font-size: 18px; color: rgb(0, 0, 0); text-align: inherit; font-weight: inherit;\">regarding passing [course_name]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"body\" style=\"top: 318.571px; left: 337.563px; font-size: 16px; color: rgb(0, 0, 0); text-align: inherit; font-weight: inherit;\">with the [grade] grade with success</div><div class=\"draggable-element ui-draggable ui-draggable-handle ui-draggable-dragging\" data-name=\"date\" style=\"top: 80.4286px; left: 57.4286px; font-size: 14px; color: rgb(0, 0, 0); text-align: inherit; font-weight: bold;\">[date]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"qr_code\" style=\"top: 392.42px; left: 728.42px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\">[qr_code]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"hint\" style=\"top: 49.4286px; left: 760.429px; font-size: 14px; color: rgb(0, 0, 0); text-align: inherit; font-weight: bold;\">ID : [certificate_id]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"platform_name\" style=\"top: 47.7143px; left: 55.7143px; font-size: 16px; color: rgb(0, 0, 0); text-align: inherit; font-weight: bold;\">[platform_name]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"stamp\" style=\"display: flex; align-items: center; justify-content: center; top: 399.714px; left: 100.714px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\"><img src=\"https://lms.rocket-soft.org/store/1/default_images/stamp.png\" style=\"max-height: 100%; max-width: 100%;\"></div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"platform_signature\" style=\"display: flex; align-items: center; justify-content: center; top: 399.429px; left: 241.429px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\"><img src=\"https://lms.rocket-soft.org/store/1/default_images/signature.png\" style=\"max-height: 100%; max-width: 100%;\"></div></div>', NULL, '{\"title\":{\"content\":\"This certificate awarded to [student_name]\",\"font_size\":\"22\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"enable\":\"on\"},\"subtitle\":{\"content\":\"regarding passing [course_name]\",\"font_size\":\"18\",\"font_color\":\"#000000\",\"styles\":null,\"enable\":\"on\"},\"body\":{\"content\":\"with the [grade] grade with success\",\"font_size\":\"16\",\"font_color\":\"#000000\",\"styles\":null,\"enable\":\"on\"},\"date\":{\"display_date\":\"textual\",\"font_size\":\"14\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"enable\":\"on\",\"content\":\"[date]\"},\"qr_code\":{\"image_size\":\"128\",\"enable\":\"on\",\"content\":\"[qr_code]\"},\"hint\":{\"content\":\"ID : [certificate_id]\",\"font_size\":\"14\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"enable\":\"on\"},\"student_name\":{\"font_size\":\"22\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"content\":\"[student_name]\"},\"instructor_name\":{\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[instructor_name]\"},\"platform_name\":{\"font_size\":\"16\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"enable\":\"on\",\"content\":\"[platform_name]\"},\"course_name\":{\"font_size\":\"22\",\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[course_name]\"},\"instructor_signature\":{\"content\":\"[instructor_signature]\"},\"platform_signature\":{\"image\":\"\\/store\\/1\\/default_images\\/signature.png\",\"image_size\":\"128\",\"enable\":\"on\"},\"stamp\":{\"image\":\"\\/store\\/1\\/default_images\\/stamp.png\",\"image_size\":\"128\",\"enable\":\"on\"}}'),
(10, 8, 'en', 'Completion Certificate Template', '<div class=\"certificate-template-container\" style=\"background-image: url(&quot;https://lms.rocket-soft.org/store/1/default_images/certificate_background.jpg&quot;);\"><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"title\" style=\"top: 244.134px; left: 272.125px; font-size: 22px; color: rgb(0, 0, 0); text-align: inherit; font-weight: bold;\">This certificate awarded to [student]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"subtitle\" style=\"top: 301.134px; left: 338.125px; font-size: 18px; color: rgb(0, 0, 0); text-align: inherit; font-weight: inherit;\">regarding completing [course]</div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"platform_signature\" style=\"display: flex; align-items: center; justify-content: center; top: 408.42px; left: 702.42px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\"><img src=\"https://lms.rocket-soft.org/store/1/default_images/signature.png\" style=\"max-height: 100%; max-width: 100%;\"></div><div class=\"draggable-element ui-draggable ui-draggable-handle\" data-name=\"stamp\" style=\"display: flex; align-items: center; justify-content: center; top: 408.42px; left: 96.4286px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\"><img src=\"https://lms.rocket-soft.org/store/1/default_images/stamp.png\" style=\"max-height: 100%; max-width: 100%;\"></div><div class=\"draggable-element ui-draggable ui-draggable-handle ui-draggable-dragging\" data-name=\"qr_code\" style=\"top: 58.4286px; left: 736.42px; text-align: inherit; font-weight: inherit; width: 128px; height: 128px;\">[qr_code]</div></div>', NULL, '{\"title\":{\"content\":\"This certificate awarded to [student]\",\"font_size\":\"22\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"enable\":\"on\"},\"subtitle\":{\"content\":\"regarding completing [course]\",\"font_size\":\"18\",\"font_color\":\"#000000\",\"styles\":null,\"enable\":\"on\"},\"body\":{\"content\":null,\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null},\"date\":{\"display_date\":\"textual\",\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[date]\"},\"qr_code\":{\"image_size\":\"128\",\"enable\":\"on\",\"content\":\"[qr_code]\"},\"hint\":{\"content\":null,\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null},\"student_name\":{\"font_size\":\"22\",\"font_color\":\"#000000\",\"styles\":null,\"font_weight_bold\":\"on\",\"content\":\"[student_name]\"},\"instructor_name\":{\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[instructor_name]\"},\"platform_name\":{\"font_size\":null,\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[platform_name]\"},\"course_name\":{\"font_size\":\"18\",\"font_color\":\"#000000\",\"styles\":null,\"content\":\"[course_name]\"},\"instructor_signature\":{\"content\":\"[instructor_signature]\"},\"platform_signature\":{\"image\":\"\\/store\\/1\\/default_images\\/signature.png\",\"image_size\":\"128\",\"enable\":\"on\"},\"stamp\":{\"image\":\"\\/store\\/1\\/default_images\\/stamp.png\",\"image_size\":\"128\",\"enable\":\"on\"}}');

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `review_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `event_id` int(10) DEFAULT NULL,
  `upcoming_course_id` int(10) UNSIGNED DEFAULT NULL,
  `blog_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `product_review_id` int(10) UNSIGNED DEFAULT NULL,
  `reply_id` int(10) UNSIGNED DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `status` enum('pending','active') NOT NULL,
  `report` tinyint(1) NOT NULL DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  `viewed_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `comments_reports`
--

CREATE TABLE `comments_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `blog_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `comment_id` int(10) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `reply` text DEFAULT NULL,
  `status` enum('pending','replied') NOT NULL DEFAULT 'pending',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `content_delete_requests`
--

CREATE TABLE `content_delete_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_published_date` bigint(20) UNSIGNED DEFAULT NULL,
  `customers_count` int(10) UNSIGNED DEFAULT NULL,
  `sales` decimal(15,2) DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_forums`
--

CREATE TABLE `course_forums` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `attach` varchar(255) DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_forum_answers`
--

CREATE TABLE `course_forum_answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `forum_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `resolved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_learning`
--

CREATE TABLE `course_learning` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `text_lesson_id` int(10) UNSIGNED DEFAULT NULL,
  `file_id` int(10) UNSIGNED DEFAULT NULL,
  `session_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_learning_last_views`
--

CREATE TABLE `course_learning_last_views` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `item_type` enum('file','session','text_lesson','assignment','quiz') NOT NULL,
  `visited_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `course_learning_last_views`
--

INSERT INTO `course_learning_last_views` (`id`, `user_id`, `webinar_id`, `item_id`, `item_type`, `visited_at`) VALUES
(19, 1129, 2064, 43, 'quiz', 1775022364),
(21, 1137, 2069, 45, 'quiz', 1774859478),
(22, 1139, 2069, 45, 'quiz', 1775021409),
(23, 1137, 2072, 106, 'session', 1777826394);

-- --------------------------------------------------------

--
-- Structure de la table `course_noticeboards`
--

CREATE TABLE `course_noticeboards` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `color` enum('warning','danger','neutral','info','success') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_noticeboard_status`
--

CREATE TABLE `course_noticeboard_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `noticeboard_id` int(10) UNSIGNED NOT NULL,
  `seen_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course_personal_notes`
--

CREATE TABLE `course_personal_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `currency` varchar(255) NOT NULL,
  `currency_position` enum('left','right','left_with_space','right_with_space') NOT NULL,
  `currency_separator` enum('dot','comma') NOT NULL,
  `currency_decimal` int(10) UNSIGNED DEFAULT NULL,
  `exchange_rate` double(15,2) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `currencies`
--

INSERT INTO `currencies` (`id`, `currency`, `currency_position`, `currency_separator`, `currency_decimal`, `exchange_rate`, `order`, `created_at`) VALUES
(4, 'EUR', 'left', 'dot', 2, 0.93, 1, 1678868603),
(6, 'INR', 'left', 'dot', 2, 82.52, 2, 1678869222);

-- --------------------------------------------------------

--
-- Structure de la table `delete_account_requests`
--

CREATE TABLE `delete_account_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `discount_type` enum('percentage','fixed_amount') NOT NULL,
  `source` enum('all','course','category','meeting','product','bundle') NOT NULL,
  `code` varchar(64) NOT NULL,
  `percent` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(15,2) UNSIGNED DEFAULT NULL,
  `max_amount` decimal(15,2) UNSIGNED DEFAULT NULL,
  `minimum_order` decimal(15,2) UNSIGNED DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 1,
  `user_type` enum('all_users','special_users') NOT NULL,
  `product_type` enum('all','physical','virtual') DEFAULT NULL,
  `for_first_purchase` tinyint(1) NOT NULL DEFAULT 0,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','disable') NOT NULL DEFAULT 'active',
  `expired_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `discounts`
--

INSERT INTO `discounts` (`id`, `creator_id`, `title`, `subtitle`, `discount_type`, `source`, `code`, `percent`, `amount`, `max_amount`, `minimum_order`, `count`, `user_type`, `product_type`, `for_first_purchase`, `private`, `status`, `expired_at`, `created_at`) VALUES
(7, 1, 'Black Friday', NULL, 'percentage', 'course', 'BLK2021', 20, 10.00, NULL, NULL, 20, 'all_users', 'all', 0, 0, 'active', 1797193740, 1626132792),
(8, 1, 'Store Physical Products Coupon', NULL, 'percentage', 'product', 'SPGH22', 10, NULL, NULL, NULL, 5, 'all_users', 'physical', 0, 0, 'active', 1773185400, 1656320198),
(9, 1, 'Store Virtual Products Coupon', NULL, 'percentage', 'product', 'VKRYT22', 20, NULL, NULL, NULL, 10, 'all_users', 'virtual', 0, 0, 'active', 1775052000, 1656320568),
(10, 1, 'Categories Coupon', NULL, 'percentage', 'category', 'GJKTPW', 10, NULL, 10.00, NULL, 1, 'all_users', 'all', 0, 0, 'active', 1828915200, 1656320749),
(25, 1, '2024 Offer for All Users', NULL, 'percentage', 'all', 'All10', 10, NULL, NULL, NULL, 50, 'all_users', 'all', 0, 0, 'active', 1805515200, 1709728742);

-- --------------------------------------------------------

--
-- Structure de la table `discount_bundles`
--

CREATE TABLE `discount_bundles` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `bundle_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_categories`
--

CREATE TABLE `discount_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_courses`
--

CREATE TABLE `discount_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_events`
--

CREATE TABLE `discount_events` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_groups`
--

CREATE TABLE `discount_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_meeting_packages`
--

CREATE TABLE `discount_meeting_packages` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `meeting_package_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_users`
--

CREATE TABLE `discount_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('in_person','online') NOT NULL DEFAULT 'online',
  `slug` varchar(255) NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link','google_drive','iframe','s3','secure_host') DEFAULT NULL,
  `video_demo` longtext DEFAULT NULL,
  `sales_count_number` int(10) UNSIGNED DEFAULT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `purchase_limit_count` int(10) UNSIGNED DEFAULT NULL,
  `duration` int(10) UNSIGNED DEFAULT NULL,
  `start_date` bigint(20) UNSIGNED DEFAULT NULL,
  `end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `sales_end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `enable_countdown` tinyint(1) NOT NULL DEFAULT 0,
  `countdown_time_reference` enum('start_date','sales_end_date') DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `support` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `message_for_reviewer` text DEFAULT NULL,
  `status` enum('publish','draft','pending','unpublish','canceled','rejected') NOT NULL DEFAULT 'draft',
  `created_at` bigint(20) UNSIGNED NOT NULL,
  `updated_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_filter_options`
--

CREATE TABLE `event_filter_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_reports`
--

CREATE TABLE `event_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_speakers`
--

CREATE TABLE `event_speakers` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_speaker_translations`
--

CREATE TABLE `event_speaker_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_speaker_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(255) NOT NULL,
  `job` text DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_tickets`
--

CREATE TABLE `event_tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `point` int(10) UNSIGNED DEFAULT NULL,
  `discount` int(10) UNSIGNED DEFAULT NULL,
  `discount_start_at` bigint(20) UNSIGNED DEFAULT NULL,
  `discount_end_at` bigint(20) UNSIGNED DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_tickets_sold`
--

CREATE TABLE `event_tickets_sold` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `event_ticket_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `paid_amount` decimal(15,2) NOT NULL,
  `paid_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_ticket_translations`
--

CREATE TABLE `event_ticket_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_ticket_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `options` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `event_translations`
--

CREATE TABLE `event_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `seo_description` text DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `upcoming_course_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `faqs`
--

INSERT INTO `faqs` (`id`, `creator_id`, `webinar_id`, `bundle_id`, `upcoming_course_id`, `order`, `created_at`, `updated_at`) VALUES
(59, 1137, 2069, NULL, NULL, 1, 1774858909, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `faq_translations`
--

CREATE TABLE `faq_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `faq_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `faq_translations`
--

INSERT INTO `faq_translations` (`id`, `faq_id`, `locale`, `title`, `answer`) VALUES
(47, 59, 'ar', 'لماذا الاستشارات تكلفتها عالية', 'لانها عالية');

-- --------------------------------------------------------

--
-- Structure de la table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `upcoming_course_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `feature_webinars`
--

CREATE TABLE `feature_webinars` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `page` enum('categories','home','home_categories') NOT NULL,
  `status` enum('publish','pending') NOT NULL,
  `updated_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `feature_webinar_translations`
--

CREATE TABLE `feature_webinar_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feature_webinar_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE `files` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `chapter_id` int(10) UNSIGNED DEFAULT NULL,
  `accessibility` enum('free','paid') NOT NULL,
  `downloadable` tinyint(1) DEFAULT 0,
  `storage` enum('upload','youtube','vimeo','external_link','google_drive','dropbox','iframe','s3','upload_archive','secure_host') NOT NULL,
  `file` text NOT NULL,
  `volume` varchar(64) NOT NULL,
  `file_type` varchar(64) NOT NULL,
  `secure_host_upload_type` enum('direct','manual') DEFAULT NULL,
  `interactive_type` enum('adobe_captivate','i_spring','custom') DEFAULT NULL,
  `interactive_file_name` varchar(255) DEFAULT NULL,
  `interactive_file_path` varchar(255) DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int(10) UNSIGNED DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `files`
--

INSERT INTO `files` (`id`, `creator_id`, `webinar_id`, `chapter_id`, `accessibility`, `downloadable`, `storage`, `file`, `volume`, `file_type`, `secure_host_upload_type`, `interactive_type`, `interactive_file_name`, `interactive_file_path`, `check_previous_parts`, `access_after_day`, `online_viewer`, `order`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(96, 1137, 2069, 155, 'paid', 0, 'google_drive', 'https://drive.google.com/file/d/19_0JoR1GC_N6sgGXAAOqS_kF7fiBIbYe/view?usp=sharing', '1', 'video', 'direct', NULL, NULL, NULL, 0, NULL, 0, NULL, 'active', 1774858836, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `file_translations`
--

CREATE TABLE `file_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `file_translations`
--

INSERT INTO `file_translations` (`id`, `file_id`, `locale`, `title`, `description`) VALUES
(65, 96, 'ar', 'الاستشارات', 'استشارات');

-- --------------------------------------------------------

--
-- Structure de la table `filters`
--

CREATE TABLE `filters` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `filter_options`
--

CREATE TABLE `filter_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `filter_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `filter_option_translations`
--

CREATE TABLE `filter_option_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `filter_translations`
--

CREATE TABLE `filter_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `filter_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `floating_bars`
--

CREATE TABLE `floating_bars` (
  `id` int(10) UNSIGNED NOT NULL,
  `start_at` bigint(20) DEFAULT NULL,
  `end_at` bigint(20) DEFAULT NULL,
  `title_color` varchar(255) DEFAULT NULL,
  `description_color` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `background_color` varchar(255) DEFAULT NULL,
  `background_image` varchar(255) DEFAULT NULL,
  `btn_url` varchar(255) DEFAULT NULL,
  `btn_color` varchar(255) DEFAULT NULL,
  `btn_text_color` varchar(255) DEFAULT NULL,
  `bar_height` int(11) DEFAULT NULL,
  `position` enum('top','bottom') NOT NULL,
  `fixed` tinyint(1) NOT NULL DEFAULT 0,
  `enable` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `floating_bars`
--

INSERT INTO `floating_bars` (`id`, `start_at`, `end_at`, `title_color`, `description_color`, `icon`, `background_color`, `background_image`, `btn_url`, `btn_color`, `btn_text_color`, `bar_height`, `position`, `fixed`, `enable`) VALUES
(2, 1678456800, 1755727200, '#ffffff', '#b5c1d4', '/store/1/themes/general/bar_icon.svg', '#1f3b64', '/store/1/themes/general/bar_background.svg', '/classes?discount=on', '#0170ff', '#ffffff', 70, 'top', 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `floating_bar_translations`
--

CREATE TABLE `floating_bar_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `floating_bar_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `btn_text` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `floating_bar_translations`
--

INSERT INTO `floating_bar_translations` (`id`, `floating_bar_id`, `locale`, `title`, `description`, `btn_text`) VALUES
(3, 2, 'en', 'New Years Day Celebration', 'Get all courses with 50 to 70% off without any limitation', 'View Courses');

-- --------------------------------------------------------

--
-- Structure de la table `follows`
--

CREATE TABLE `follows` (
  `id` int(10) UNSIGNED NOT NULL,
  `follower` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` enum('requested','accepted','rejected') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `forms`
--

CREATE TABLE `forms` (
  `id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `header_icon` varchar(255) DEFAULT NULL,
  `header_overlay_image` varchar(255) DEFAULT NULL,
  `enable_login` tinyint(1) NOT NULL DEFAULT 0,
  `enable_resubmission` tinyint(1) NOT NULL DEFAULT 0,
  `enable_welcome_message` tinyint(1) NOT NULL DEFAULT 0,
  `enable_tank_you_message` tinyint(1) NOT NULL DEFAULT 0,
  `welcome_message_image` varchar(255) DEFAULT NULL,
  `tank_you_message_image` varchar(255) DEFAULT NULL,
  `start_date` bigint(20) UNSIGNED DEFAULT NULL,
  `end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forms`
--

INSERT INTO `forms` (`id`, `url`, `cover`, `image`, `header_icon`, `header_overlay_image`, `enable_login`, `enable_resubmission`, `enable_welcome_message`, `enable_tank_you_message`, `welcome_message_image`, `tank_you_message_image`, `start_date`, `end_date`, `enable`, `created_at`) VALUES
(2, 'teacher_form', '/store/1/default_images/16.jpg', '/store/1/default_images/about.png', NULL, NULL, 1, 1, 1, 1, '/store/1/default_images/welcome.jpg', '/store/1/default_images/thank_you.jpg', 1694894400, 1789592400, 1, 1694945521);

-- --------------------------------------------------------

--
-- Structure de la table `form_fields`
--

CREATE TABLE `form_fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL,
  `type` enum('input','number','upload','date_picker','toggle','textarea','dropdown','checkbox','radio') NOT NULL,
  `order` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_fields`
--

INSERT INTO `form_fields` (`id`, `form_id`, `type`, `order`, `required`) VALUES
(1, 2, 'input', 1, 1),
(2, 2, 'input', 2, 1),
(4, 2, 'date_picker', 5, 1),
(5, 2, 'input', 6, 1),
(6, 2, 'number', 7, 0),
(7, 2, 'radio', 3, 1),
(8, 2, 'textarea', 8, 0),
(9, 2, 'dropdown', 9, 1),
(10, 2, 'checkbox', 10, 0),
(11, 2, 'toggle', 12, 1),
(12, 2, 'upload', 11, 1);

-- --------------------------------------------------------

--
-- Structure de la table `form_field_options`
--

CREATE TABLE `form_field_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_field_id` int(10) UNSIGNED NOT NULL,
  `order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_field_options`
--

INSERT INTO `form_field_options` (`id`, `form_field_id`, `order`) VALUES
(1, 7, NULL),
(2, 7, NULL),
(3, 9, NULL),
(4, 9, NULL),
(5, 10, NULL),
(6, 10, NULL),
(7, 10, NULL),
(8, 10, NULL),
(9, 10, NULL),
(10, 10, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `form_field_option_translations`
--

CREATE TABLE `form_field_option_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_field_option_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_field_option_translations`
--

INSERT INTO `form_field_option_translations` (`id`, `form_field_option_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Male'),
(2, 2, 'en', 'Female'),
(3, 3, 'en', 'YES'),
(4, 4, 'en', 'NO'),
(5, 5, 'en', 'Benefits'),
(6, 6, 'en', 'Company reputation'),
(7, 7, 'en', 'Location'),
(8, 8, 'en', 'Salary'),
(9, 9, 'en', 'To gain experience'),
(10, 10, 'en', 'Other');

-- --------------------------------------------------------

--
-- Structure de la table `form_field_translations`
--

CREATE TABLE `form_field_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_field_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_field_translations`
--

INSERT INTO `form_field_translations` (`id`, `form_field_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'First Name'),
(2, 2, 'en', 'Last Name'),
(4, 4, 'en', 'Date of Birth'),
(5, 5, 'en', 'Address'),
(6, 6, 'en', 'Mobile Number'),
(7, 7, 'en', 'Gender'),
(8, 8, 'en', 'Educational Background'),
(9, 9, 'en', 'Have you had any previous experience with teaching?'),
(10, 10, 'en', 'What determined you to apply for this position?'),
(11, 11, 'en', 'I accept the terms and rules'),
(12, 12, 'en', 'ID Card Image'),
(13, 2, 'ar', 'اسم العائلة');

-- --------------------------------------------------------

--
-- Structure de la table `form_roles_users_groups`
--

CREATE TABLE `form_roles_users_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_roles_users_groups`
--

INSERT INTO `form_roles_users_groups` (`id`, `form_id`, `role_id`, `user_id`, `group_id`) VALUES
(20, 2, 2, NULL, NULL),
(21, 2, 3, NULL, NULL),
(22, 2, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `form_submissions`
--

CREATE TABLE `form_submissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `form_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `form_submission_items`
--

CREATE TABLE `form_submission_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `submission_id` int(10) UNSIGNED NOT NULL,
  `form_field_id` int(10) UNSIGNED NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `form_translations`
--

CREATE TABLE `form_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `heading_title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `welcome_message_title` varchar(255) DEFAULT NULL,
  `welcome_message_description` text DEFAULT NULL,
  `tank_you_message_title` varchar(255) DEFAULT NULL,
  `tank_you_message_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `form_translations`
--

INSERT INTO `form_translations` (`id`, `form_id`, `locale`, `title`, `subtitle`, `heading_title`, `description`, `welcome_message_title`, `welcome_message_description`, `tank_you_message_title`, `tank_you_message_description`) VALUES
(2, 2, 'en', 'Teacher Registration Form', NULL, 'Teacher Registration Form', '<div>We appreciate your interest in becoming a part of our dedicated team of educators. As a teacher, you play a crucial role in shaping the future and empowering the next generation with knowledge and skills.</div><div><br></div><div>This registration form is designed to collect essential information about your qualifications and background. Your input will help us assess your suitability for a teaching position within our institution. Please take your time to complete the form accurately, as it will serve as the foundation of our evaluation process.</div><div><br></div><div>If you encounter any questions or need assistance while filling out this form, our support team is readily available to provide guidance and address your queries.</div><div><br></div><div>Thank you for considering us as the platform for your teaching journey. We believe in the power of education to transform lives, and we look forward to the possibility of having you on board to make a positive impact on our students.</div><div><br></div><div>Let\'s begin the registration process, and we wish you the best of luck in your pursuit of a fulfilling teaching career with us!</div>', 'Welcome To Rocket LMS', 'We are delighted that you have chosen to join our esteemed educational institution. Your commitment to education is greatly appreciated, and we look forward to having you as part of our team.\r\n\r\nThis registration form is the first step in the process of becoming a valued member of our teaching staff. Your expertise and passion for teaching are integral to our mission of providing a high-quality education to our students.\r\n\r\nPlease complete this form with accuracy and detail, as it will help us better understand your qualifications and preferences. If you have any questions or require assistance during the registration process, our dedicated support team is here to help.\r\n\r\nThank you for choosing to embark on this journey with us. Together, we can make a positive impact on the lives of our students and inspire them to achieve their full potential.\r\n\r\nLet\'s get started with your registration, and once again, welcome aboard!', 'Thank you for your submission', 'Your interest in joining our educational institution as a teacher is greatly appreciated. We value your dedication to the field of education and your willingness to be a part of our team.\r\n\r\nYour registration is an important step in our selection process, and we will carefully review the information you\'ve provided. Should we require any further details or have additional questions, our team will reach out to you promptly.\r\n\r\nWe understand that becoming a teacher is a significant commitment, and we are excited about the potential you bring to our institution. Your passion and expertise will undoubtedly contribute to the growth and success of our students.\r\n\r\nOnce again, thank you for taking the time to register with us. We will be in touch soon with updates on your application status. We look forward to the possibility of working together to create a positive and inspiring educational experience for all.'),
(3, 2, 'ar', 'التسجيل', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `forums`
--

CREATE TABLE `forums` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `status` enum('disabled','active') DEFAULT NULL,
  `close` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forums`
--

INSERT INTO `forums` (`id`, `slug`, `role_id`, `group_id`, `parent_id`, `icon`, `cover`, `status`, `close`, `order`) VALUES
(1, 'Lifestyle', NULL, NULL, NULL, '/store/1/default_images/forums/icons/makeup.png', NULL, 'active', 0, NULL),
(2, 'Beauty-Makeup', NULL, NULL, 1, '/store/1/default_images/forums/icons/makeup.png', NULL, 'active', 0, 1),
(3, 'Food-Beverage', NULL, NULL, 1, '/store/1/default_images/forums/icons/donut.png', NULL, 'active', 0, 2),
(4, 'Travel', NULL, NULL, 1, '/store/1/default_images/forums/icons/airplane.png', NULL, 'active', 0, 3),
(5, 'Music', NULL, NULL, NULL, '/store/1/default_images/forums/icons/love-song.png', NULL, 'active', 0, NULL),
(6, 'Marketing', NULL, NULL, NULL, '/store/1/default_images/forums/icons/advertising.png', NULL, 'active', 0, NULL),
(7, 'Digital-Marketing', NULL, NULL, 6, '/store/1/default_images/forums/icons/digital-marketing.png', NULL, 'active', 0, 1),
(8, 'Public-Relations', NULL, NULL, 6, '/store/1/default_images/forums/icons/security.png', NULL, 'active', 0, 2),
(9, 'Advertising', NULL, NULL, 6, '/store/1/default_images/forums/icons/ads.png', NULL, 'active', 0, 3),
(10, 'Social-Media', NULL, NULL, 6, '/store/1/default_images/forums/icons/twitter.png', NULL, 'active', 0, 4);

-- --------------------------------------------------------

--
-- Structure de la table `forum_featured_topics`
--

CREATE TABLE `forum_featured_topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_recommended_topics`
--

CREATE TABLE `forum_recommended_topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_recommended_topics`
--

INSERT INTO `forum_recommended_topics` (`id`, `icon`, `created_at`) VALUES
(1, '/store/1/default_images/forums/icons/recommended_topic_4.png', 1655794486),
(2, '/store/1/default_images/forums/icons/recommended_topic_3.png', 1655796024),
(3, '/store/1/default_images/forums/icons/recommended_topic_2.png', 1655796482),
(4, '/store/1/default_images/forums/icons/recommended_topic_1.png', 1655796824);

-- --------------------------------------------------------

--
-- Structure de la table `forum_recommended_topic_items`
--

CREATE TABLE `forum_recommended_topic_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `recommended_topic_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_recommended_topic_translations`
--

CREATE TABLE `forum_recommended_topic_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `forum_recommended_topic_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `forum_recommended_topic_translations`
--

INSERT INTO `forum_recommended_topic_translations` (`id`, `forum_recommended_topic_id`, `locale`, `title`, `subtitle`) VALUES
(1, 4, 'en', 'Time Management', 'Learn to prioritize tasks, set goals, and boost productivity daily'),
(2, 3, 'en', 'Financial Management', 'Master budgeting, saving, and investing to manage money wisely'),
(3, 2, 'en', 'Marketing Strategy', 'Learn to plan, execute, and optimize campaigns for business growth'),
(4, 1, 'en', 'Task Management', 'Organize, prioritize, and track tasks to boost daily productivity efficiently');

-- --------------------------------------------------------

--
-- Structure de la table `forum_topics`
--

CREATE TABLE `forum_topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `forum_id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `close` tinyint(1) NOT NULL DEFAULT 0,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_attachments`
--

CREATE TABLE `forum_topic_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_bookmarks`
--

CREATE TABLE `forum_topic_bookmarks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_likes`
--

CREATE TABLE `forum_topic_likes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED DEFAULT NULL,
  `topic_post_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_posts`
--

CREATE TABLE `forum_topic_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `description` text NOT NULL,
  `attach` varchar(255) DEFAULT NULL,
  `pin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_reports`
--

CREATE TABLE `forum_topic_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `topic_id` int(10) UNSIGNED DEFAULT NULL,
  `topic_post_id` int(10) UNSIGNED DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_topic_visits`
--

CREATE TABLE `forum_topic_visits` (
  `id` int(10) UNSIGNED NOT NULL,
  `forum_id` int(10) UNSIGNED DEFAULT NULL,
  `topic_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `forum_translations`
--

CREATE TABLE `forum_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `forum_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `forum_translations`
--

INSERT INTO `forum_translations` (`id`, `forum_id`, `locale`, `title`, `description`) VALUES
(1, 1, 'en', 'Lifestyle', 'Lifestyle is the interests, opinions, behaviours, and behavioural orientations of an individual, group, or culture. The term was introduced by Austrian psychologist Alfred Adler in his 1929 book, The Case of Miss R., with the meaning of \"a person\'s basic character as established early in childhood\".'),
(2, 2, 'en', 'Beauty & Makeup', 'How to create your natural skincare perfect'),
(3, 3, 'en', 'Food & Beverage', 'A practical forum to take your cooking skills from dull to delicious'),
(4, 4, 'en', 'Travel', 'How You Can Afford a Life of Travel and Adventure!'),
(5, 5, 'en', 'Music', 'Discuss music with The World\'s Top instructors'),
(6, 6, 'en', 'Marketing', 'Marketing is the process of exploring.'),
(7, 7, 'en', 'Digital Marketing', 'Master Digital Marketing Strategy'),
(8, 8, 'en', 'Public Relations', 'Everything you need to know to be successful at PR'),
(9, 9, 'en', 'Advertising', 'Learn the inner workings of a massive digital industry'),
(10, 10, 'en', 'Social Media', 'MASTER online marketing on Twitter, Pinterest, Instagram');

-- --------------------------------------------------------

--
-- Structure de la table `gifts`
--

CREATE TABLE `gifts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `viewed` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'for show modal in recipient user panel',
  `status` enum('active','pending','cancel') DEFAULT 'pending',
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `groups`
--

INSERT INTO `groups` (`id`, `creator_id`, `name`, `discount`, `status`, `created_at`) VALUES
(2, 1, 'Vip Instructors', 20, 'active', 1613379096),
(3, 1, 'Special Students', 10, 'active', 1614530208);

-- --------------------------------------------------------

--
-- Structure de la table `groups_registration_packages`
--

CREATE TABLE `groups_registration_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `instructors_count` int(11) DEFAULT NULL,
  `students_count` int(11) DEFAULT NULL,
  `courses_capacity` int(11) DEFAULT NULL,
  `courses_count` int(11) DEFAULT NULL,
  `meeting_count` int(11) DEFAULT NULL,
  `status` enum('disabled','active') NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `group_users`
--

CREATE TABLE `group_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `group_users`
--

INSERT INTO `group_users` (`id`, `group_id`, `user_id`, `created_at`) VALUES
(68, 2, 1113, 1769898928);

-- --------------------------------------------------------

--
-- Structure de la table `home_page_statistics`
--

CREATE TABLE `home_page_statistics` (
  `id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `count` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `home_page_statistics`
--

INSERT INTO `home_page_statistics` (`id`, `icon`, `color`, `count`, `order`, `created_at`) VALUES
(2, '/store/1/default_images/trend_categories_icons/chess.png', '#c95d63', 20, 1, 1675870234),
(3, '/store/1/default_images/trend_categories_icons/palette.png', '#496ddb', 12, 4, 1675870276),
(4, '/store/1/default_images/trend_categories_icons/connection.png', '#717ec3', 16, 3, 1675870320),
(5, '/store/1/default_images/trend_categories_icons/family.png', '#ae8799', 78, 2, 1675870418);

-- --------------------------------------------------------

--
-- Structure de la table `home_page_statistic_translations`
--

CREATE TABLE `home_page_statistic_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `home_page_statistic_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `home_page_statistic_translations`
--

INSERT INTO `home_page_statistic_translations` (`id`, `home_page_statistic_id`, `locale`, `title`, `description`) VALUES
(2, 2, 'en', 'Skillful Instructors', 'Start learning from experienced instructors.'),
(3, 3, 'en', 'Video Courses', 'Learn without any geographical & time limitations.'),
(4, 4, 'en', 'Live Classes', 'Improve your skills using live knowledge flow.'),
(5, 5, 'en', 'Happy Students', 'are available to help you by their knowledge');

-- --------------------------------------------------------

--
-- Structure de la table `home_sections`
--

CREATE TABLE `home_sections` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` enum('featured_classes','latest_bundles','latest_classes','best_rates','trend_categories','full_advertising_banner','best_sellers','discount_classes','free_classes','store_products','testimonials','subscribes','find_instructors','reward_program','become_instructor','forum_section','video_or_image_section','instructors','half_advertising_banner','organizations','blog','upcoming_courses') NOT NULL,
  `order` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `home_sections`
--

INSERT INTO `home_sections` (`id`, `name`, `order`) VALUES
(1, 'latest_classes', 2),
(2, 'featured_classes', 1),
(3, 'latest_bundles', 3),
(4, 'best_rates', 5),
(5, 'best_sellers', 7),
(6, 'free_classes', 8),
(7, 'trend_categories', 6),
(8, 'full_advertising_banner', 9),
(9, 'discount_classes', 10),
(10, 'store_products', 11),
(11, 'subscribes', 12),
(12, 'become_instructor', 13),
(13, 'forum_section', 14),
(14, 'find_instructors', 15),
(15, 'reward_program', 17),
(16, 'instructors', 18),
(17, 'video_or_image_section', 16),
(18, 'testimonials', 20),
(19, 'half_advertising_banner', 19),
(20, 'organizations', 21),
(21, 'blog', 22),
(31, 'upcoming_courses', 4);

-- --------------------------------------------------------

--
-- Structure de la table `installments`
--

CREATE TABLE `installments` (
  `id` int(10) UNSIGNED NOT NULL,
  `target_type` enum('all','courses','store_products','bundles','meetings','registration_packages','subscription_packages') NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `start_date` bigint(20) UNSIGNED DEFAULT NULL,
  `end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `verification` tinyint(1) NOT NULL DEFAULT 0,
  `request_uploads` tinyint(1) NOT NULL DEFAULT 0,
  `bypass_verification_for_verified_users` tinyint(1) NOT NULL DEFAULT 0,
  `upfront` double(15,2) DEFAULT NULL,
  `upfront_type` enum('fixed_amount','percent') DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `installments`
--

INSERT INTO `installments` (`id`, `target_type`, `target`, `capacity`, `start_date`, `end_date`, `verification`, `request_uploads`, `bypass_verification_for_verified_users`, `upfront`, `upfront_type`, `enable`, `created_at`) VALUES
(1, 'courses', 'specific_courses', 10, 1672549200, NULL, 1, 1, 0, 30.00, 'percent', 0, 1678904056);

-- --------------------------------------------------------

--
-- Structure de la table `installment_orders`
--

CREATE TABLE `installment_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL,
  `product_order_id` int(10) UNSIGNED DEFAULT NULL,
  `item_price` double(15,2) NOT NULL DEFAULT 0.00,
  `status` enum('paying','open','rejected','pending_verification','canceled','refunded') NOT NULL DEFAULT 'paying',
  `created_at` bigint(20) UNSIGNED NOT NULL,
  `refund_at` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `installment_order_attachments`
--

CREATE TABLE `installment_order_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_order_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `file` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `installment_order_payments`
--

CREATE TABLE `installment_order_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_order_id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('upfront','step') NOT NULL,
  `selected_installment_step_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(15,2) NOT NULL,
  `status` enum('paying','paid','canceled','refunded') NOT NULL DEFAULT 'paying',
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `installment_reminders`
--

CREATE TABLE `installment_reminders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `installment_order_id` int(10) UNSIGNED NOT NULL,
  `installment_step_id` int(10) UNSIGNED NOT NULL,
  `type` enum('before_due','due','after_due') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `installment_specification_items`
--

CREATE TABLE `installment_specification_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `installment_steps`
--

CREATE TABLE `installment_steps` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `deadline` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  `amount_type` enum('fixed_amount','percent') DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `installment_steps`
--

INSERT INTO `installment_steps` (`id`, `installment_id`, `deadline`, `amount`, `amount_type`, `order`) VALUES
(1, 1, 90, 20.00, 'percent', 0),
(2, 1, 180, 30.00, 'percent', 1),
(3, 1, 270, 30.00, 'percent', 2);

-- --------------------------------------------------------

--
-- Structure de la table `installment_step_translations`
--

CREATE TABLE `installment_step_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_step_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `installment_step_translations`
--

INSERT INTO `installment_step_translations` (`id`, `installment_step_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'First Installment'),
(2, 2, 'en', 'Second Installment'),
(3, 3, 'en', 'Third Installment');

-- --------------------------------------------------------

--
-- Structure de la table `installment_translations`
--

CREATE TABLE `installment_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `main_title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `banner` varchar(255) DEFAULT NULL,
  `options` text DEFAULT NULL,
  `verification_description` text DEFAULT NULL,
  `verification_banner` varchar(255) DEFAULT NULL,
  `verification_video` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `installment_translations`
--

INSERT INTO `installment_translations` (`id`, `installment_id`, `locale`, `title`, `main_title`, `description`, `banner`, `options`, `verification_description`, `verification_banner`, `verification_video`) VALUES
(1, 1, 'en', 'Christmas installment plan', 'Installment payment On Christmas', 'Buy your courses in installments.', '/store/1/default_images/Installments/installment_banner.png', 'Instant access to course files88889 months payment duration8888No price difference with cash payments8888Get points after finalizing installments', '<p>To use this installment plan, you should attach a picture of your ID card and your 3-month bank account statement.</p><p>We will try to review your request as soon as possible.</p>', '/store/1/default_images/Installments/verification_image.png', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `installment_user_groups`
--

CREATE TABLE `installment_user_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ip_restrictions`
--

CREATE TABLE `ip_restrictions` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('full_ip','ip_range','country') NOT NULL,
  `value` varchar(255) NOT NULL COMMENT 'full ip or ip range or country name',
  `reason` text NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ip_restrictions`
--

INSERT INTO `ip_restrictions` (`id`, `type`, `value`, `reason`, `created_at`) VALUES
(1, 'full_ip', '139.10.13.206', 'Spammer', 1709534805),
(3, 'country', 'CK', 'Testing Country Restriction', 1709534952);

-- --------------------------------------------------------

--
-- Structure de la table `jazzcash_transactions`
--

CREATE TABLE `jazzcash_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txn_ref_no` varchar(255) NOT NULL,
  `order` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Order data fields and values',
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Jazzcash request data fields and values',
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Jazzcash response data fields and values',
  `status` enum('pending','error','completed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `landings`
--

CREATE TABLE `landings` (
  `id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `preview_img` varchar(255) DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `landings`
--

INSERT INTO `landings` (`id`, `url`, `preview_img`, `enable`, `created_at`) VALUES
(1, 'default', '/store/landing_builder/landing_1//preview_img.jpg', 1, 1748938121);

-- --------------------------------------------------------

--
-- Structure de la table `landing_builder_components`
--

CREATE TABLE `landing_builder_components` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` enum('hero','banners','courses','categories','upcoming_courses','logos','bundles','faq','store_products','video','blog_posts','features','subscription','cards','testimonials','information','call_to_action','statistics','meeting_booking','miscellaneous','instructors','text','organizations') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `landing_builder_components`
--

INSERT INTO `landing_builder_components` (`id`, `name`, `category`) VALUES
(1, 'two_columns_hero', 'hero'),
(4, 'statistics', 'statistics'),
(5, 'featured_courses', 'courses'),
(8, 'trending_categories', 'categories'),
(9, 'newest_courses', 'courses'),
(10, 'best_selling_courses', 'courses'),
(11, 'best_rated_courses', 'courses'),
(12, 'discounted_courses', 'courses'),
(13, 'free_courses', 'courses'),
(33, 'instructors', 'instructors'),
(34, 'blog', 'blog_posts'),
(55, 'vertical_spacer', 'miscellaneous'),
(56, 'full_width_hero', 'hero'),
(57, 'single_instructor_hero', 'hero'),
(58, 'links_and_titles_slider_2_rows', 'miscellaneous'),
(59, 'links_and_titles_slider_1_row', 'miscellaneous'),
(60, 'information_cards', 'cards'),
(61, 'upcoming_courses', 'upcoming_courses'),
(62, 'course_bundles', 'bundles'),
(63, 'store_products', 'store_products'),
(64, 'hybrid_information_section_2_images_check_items_text', 'information'),
(65, 'hybrid_information_section_2_images_text', 'information'),
(66, 'hybrid_information_section_2_images_text_2', 'information'),
(67, 'hybrid_information_section_3_images_text', 'information'),
(68, 'hybrid_information_section_4_images_text', 'information'),
(69, 'company_logos', 'logos'),
(70, 'full_width_bar_cta', 'call_to_action'),
(71, 'faq_6_col', 'faq'),
(72, 'features_4x', 'features'),
(73, 'banners_grid_3_in_different_sizes', 'banners'),
(74, 'meeting_booking_list', 'meeting_booking'),
(75, 'subscription_plans', 'subscription'),
(76, 'single_video_section', 'video'),
(77, 'sliding_testimonials_2_rows', 'testimonials'),
(78, 'cta_card_8_columns', 'call_to_action'),
(79, 'organizations', 'organizations'),
(80, 'cta_section_full_width', 'call_to_action'),
(81, 'banner_full_width', 'banners'),
(82, 'banner_3_items_per_row', 'banners'),
(83, 'banner_2_items_per_row', 'banners'),
(84, 'banner_4_items_per_row', 'banners'),
(85, 'boxed_cta_full_width', 'call_to_action'),
(86, 'cta_and_information_hybrid', 'information'),
(87, 'hybrid_information_section_full_width', 'information'),
(88, 'links_and_images_6_items_per_row', 'miscellaneous'),
(89, 'video_and_image_slider_full_width', 'video'),
(90, 'information_card_full_width', 'cards'),
(91, 'information_card_full_width_2', 'cards'),
(92, 'full_width_image_and_video_cta', 'information'),
(93, 'image_information_cards_3x', 'banners'),
(94, 'two_sided_information_images_and_cards', 'information'),
(95, 'linked_images_3x', 'banners'),
(96, 'big_call_to_action_cards_2x', 'call_to_action'),
(97, 'custom_courses_grid', 'courses'),
(98, 'center_text', 'text');

-- --------------------------------------------------------

--
-- Structure de la table `landing_components`
--

CREATE TABLE `landing_components` (
  `id` int(10) UNSIGNED NOT NULL,
  `landing_id` int(10) UNSIGNED NOT NULL,
  `component_id` int(10) UNSIGNED NOT NULL,
  `preview` varchar(255) DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `landing_components`
--

INSERT INTO `landing_components` (`id`, `landing_id`, `component_id`, `preview`, `enable`, `order`) VALUES
(3, 1, 5, NULL, 1, 2),
(4, 1, 8, NULL, 1, 4),
(5, 1, 10, NULL, 1, 6),
(6, 1, 55, NULL, 1, 1),
(7, 1, 55, NULL, 1, 3),
(8, 1, 55, NULL, 1, 5),
(9, 1, 11, NULL, 1, 12),
(10, 1, 55, NULL, 1, 11),
(11, 1, 55, NULL, 1, 13),
(12, 1, 33, NULL, 1, 14),
(13, 1, 34, NULL, 1, 15),
(419, 1, 55, NULL, 1, 16),
(423, 1, 12, NULL, 1, 8),
(424, 1, 13, NULL, 1, 10),
(425, 1, 55, NULL, 1, 7),
(426, 1, 55, NULL, 1, 9),
(437, 1, 1, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `landing_component_translations`
--

CREATE TABLE `landing_component_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `landing_component_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `landing_component_translations`
--

INSERT INTO `landing_component_translations` (`id`, `landing_component_id`, `locale`, `content`) VALUES
(3, 3, 'en', '{\"enable_slider\":\"on\",\"main_content\":{\"pre_title\":\"Featured\",\"title\":\"Featured Courses\",\"description\":\"Explore our top-rated courses, handpicked to boost your skills and accelerate your learning journey\"},\"featured_courses\":{\"Kblmv\":{\"course\":\"2002\",\"cover_image\":\"\\/store\\/landing_builder\\/landing_1\\/3\\/workout_G7j.jpg\",\"checked_items\":{\"nPSgK\":\"Personalized workout plans\",\"TANBG\":\"Nutrition and meal guidance\",\"KhFGP\":\"Daily fitness challenges\",\"WQFEG\":\"Expert wellness coaching\",\"dujOQ\":\"Progress tracking tools\"}},\"tmlrR\":{\"course\":\"1995\",\"cover_image\":\"\\/store\\/landing_builder\\/landing_1\\/3\\/product_aF5.jpg\",\"checked_items\":{\"syJFo\":\"Product lifecycle management essentials\",\"lKkYJ\":\"Building effective product roadmaps\",\"UjxDt\":\"Conducting user and market research\",\"pKvxh\":\"Leading cross-functional product teams\",\"CaNKi\":\"Defining and prioritizing product features\"}}}}'),
(4, 4, 'en', '{\"main_content\":{\"pre_title\":\"Trending\",\"title\":\"Trending Categories\"},\"trending_categories\":{\"rBvHd\":{\"category\":\"1\"},\"kGpzO\":{\"category\":\"2\"},\"KEfio\":{\"category\":\"3\"},\"jQlOz\":{\"category\":\"4\"},\"Plypb\":{\"category\":\"5\"},\"vZcWP\":{\"category\":\"6\"},\"qVbwr\":{\"category\":\"10\"},\"xBoLW\":{\"category\":\"11\"},\"record\":{\"category\":null}},\"floating_background\":\"\\/store\\/landing_builder\\/landing_1\\/4\\/trending_floating_M8H.svg\"}'),
(5, 5, 'en', '{\"main_content\":{\"title\":\"Bestsellers Chosen by Our Students\",\"subtitle\":\"Explore our top-selling courses, chosen by thousands of learners who\\u2019ve enrolled and benefited. These bestsellers reflect what\\u2019s most in-demand and valuable across our platform.\",\"icon\":\"\\/store\\/landing_builder\\/landing_1\\/5\\/topselling_overlay_Z8L.png\"},\"background\":\"\\/store\\/landing_builder\\/landing_1\\/5\\/topselling_background_pVh.png\"}'),
(6, 6, 'en', '{\"space_number\":\"80\"}'),
(7, 7, 'en', '{\"space_number\":\"80\"}'),
(8, 8, 'en', '{\"space_number\":\"100\"}'),
(9, 10, 'en', '{\"space_number\":\"100\"}'),
(10, 9, 'en', '{\"main_content\":{\"title\":\"Top Rated by Our Students\",\"subtitle\":\"Discover the most highly rated courses, trusted by learners for quality content, expert instruction, and outstanding learning experiences across a wide range of topics.\",\"icon\":\"\\/store\\/landing_builder\\/landing_1\\/9\\/bestrated_overlay_4Ss.png\"},\"background\":\"\\/store\\/landing_builder\\/landing_1\\/9\\/topselling_background_xZD.png\"}'),
(11, 11, 'en', '{\"space_number\":\"60\"}'),
(12, 12, 'en', '{\"main_content\":{\"pre_title\":\"Instructors\",\"title\":\"Expert Instructors\",\"description\":\"Learn from experienced instructors dedicated to delivering practical knowledge, guidance, and real-world expertise\",\"button\":{\"label\":\"All Instructors\",\"icon\":\"bul-teacher\",\"url\":\"\\/instructors\"}},\"cta_section\":{\"title_bold_text\":\"400+ skilled instructors\",\"title_regular_text\":\"available to assist you every step of the way\",\"description\":\"Quickly find your ideal instructor with our intuitive Instructor Finder feature\",\"icon\":\"bul-verify\"},\"specific_instructors\":{\"zVjfh\":{\"instructor_id\":\"3\"},\"lNgbZ\":{\"instructor_id\":\"870\"},\"rBoFe\":{\"instructor_id\":\"923\"},\"URpzu\":{\"instructor_id\":\"929\"},\"bDOON\":{\"instructor_id\":\"934\"},\"SXDzy\":{\"instructor_id\":\"1015\"},\"record\":{\"instructor_id\":null}},\"background\":\"\\/store\\/landing_builder\\/landing_1\\/12\\/instructors_background_Wuk.png\"}'),
(14, 13, 'en', '{\"main_content\":{\"pre_title\":\"Read More\",\"title\":\"Blog and Articles\",\"description\":\"Stay informed with expert-written articles, tips, and insights to support your learning journey daily\",\"button\":{\"label\":\"Blog Posts\",\"icon\":\"bul-note-2\",\"url\":\"\\/blog\"}},\"background\":\"\\/store\\/landing_builder\\/landing_1\\/13\\/blog_background_e5l.png\"}'),
(386, 423, 'en', '{\"main_content\":{\"title\":\"Discounted Courses\",\"subtitle\":\"Save more now with top courses at discounts\",\"icon\":\"\\/store\\/landing_builder\\/landing_13\\/391\\/discounted_overlay_aol.png\"},\"cta_section\":{\"title_bold_text\":\"Over $240K Saved\",\"title_regular_text\":\"With Exclusive Course Discounts\",\"icon\":\"bul-verify\",\"button\":{\"label\":\"View More\",\"icon\":\"bul-discount-circle\",\"url\":\"\\/classes?discount=on\"}},\"background\":\"\\/store\\/landing_builder\\/landing_13\\/391\\/discounted_bg_s3Z.svg\"}'),
(413, 419, 'en', '{\"space_number\":\"60\"}'),
(417, 424, 'en', '{\"main_content\":{\"title\":\"Free Courses\",\"subtitle\":\"Access top-quality free courses anytime, expand your skills, and learn without spending a single dollar\"},\"cta_section\":{\"title\":\"Need skills but budget constraints?\",\"description\":\"Explore top free courses now and keep advancing your career path with practical, valuable new skills\",\"link_title\":\"Explore Free Courses\",\"url\":\"\\/classes?free=on\",\"icon\":\"\\/store\\/landing_builder\\/landing_13\\/392\\/free_courses_overlay_79X.png\"},\"background\":\"\\/store\\/landing_builder\\/landing_13\\/392\\/free_courses_bg_4Mq.svg\"}'),
(418, 425, 'en', '{\"space_number\":\"100\"}'),
(419, 426, 'en', '{\"space_number\":\"100\"}'),
(421, 5, 'ar', '{\"main_content\":{\"title\":\"\\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a \\u0627\\u0644\\u0623\\u0643\\u062b\\u0631 \\u0645\\u0628\\u064a\\u0639\\u0627\",\"subtitle\":\"\\u0633\\u062c\\u0644 \\u0641\\u064a\\u0647\\u0627 \\u0627\\u0643\\u062b\\u0631 \\u0645\\u0646 5000 \\u0645\\u062a\\u062f\\u0631\\u0628\"}}'),
(422, 423, 'ar', '{\"main_content\":{\"title\":\"\\u062f\\u0648\\u0631\\u0627\\u062a \\u0639\\u0644\\u064a\\u0647\\u0627 \\u062a\\u062e\\u0641\\u064a\\u0636\\u0627\\u062a\",\"subtitle\":null},\"cta_section\":{\"title_bold_text\":null,\"title_regular_text\":null,\"icon\":null,\"button\":{\"label\":null,\"icon\":null,\"url\":null}}}'),
(423, 424, 'ar', '{\"background_color\":\"primary\",\"main_content\":{\"title\":\"\\u062f\\u0648\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u064a\\u0646\\u0629\",\"subtitle\":null},\"cta_section\":{\"title\":null,\"description\":null,\"link_title\":null,\"url\":null}}'),
(424, 3, 'ar', '{\"enable_slider\":\"on\",\"main_content\":{\"pre_title\":\"\\u0628\\u0631\\u0627\\u0645\\u062c\\u0646\\u0627 \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\\u0629\",\"title\":\"\\u064a\\u0642\\u062f\\u0645\\u0647\\u0627 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0645\\u0644\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0628\\u064a\\u0629 \\u0627\\u0644\\u0633\\u0639\\u0648\\u062f\\u064a\\u0629\",\"description\":null},\"featured_courses\":{\"VjVcY\":{\"course\":\"2062\",\"cover_image\":\"\\/store\\/landing_builder\\/landing_1\\/3\\/Screenshot_2024-07-20_204128_KEs.png\",\"overlay_image\":\"\\/store\\/landing_builder\\/landing_1\\/3\\/Screenshot_2024-08-10_220922_IlL.png\"},\"DBNqu\":{\"course\":\"2054\",\"cover_image\":\"\\/store\\/landing_builder\\/landing_1\\/3\\/Screenshot_2024-08-07_202503_sY3.png\"}}}'),
(425, 9, 'ar', '{\"main_content\":{\"title\":\"\\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a \\u0627\\u0644\\u0623\\u0643\\u062b\\u0631 \\u062a\\u0642\\u064a\\u064a\\u0645\\u0627\",\"subtitle\":\"\\u062f\\u0648\\u0631\\u0627\\u062a \\u0642\\u064a\\u0645\\u0647\\u0627 \\u0645\\u062a\\u062f\\u0631\\u0628\\u064a\\u0646\\u0627 \\u0643\\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0628\\u0631\\u0627\\u0645\\u062c \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628\\u064a\\u0629\"}}'),
(426, 12, 'ar', '{\"main_content\":{\"pre_title\":\"\\u0627\\u0645\\u064a\\u0632 \\u0645\\u062f\\u0631\\u0628\\u064a\\u0627\",\"title\":\"\\u0645\\u0646 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0641\\u064a \\u0627\\u0644\\u0645\\u0645\\u0644\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0628\\u064a\\u0629 \\u0627\\u0644\\u0633\\u0639\\u0648\\u062f\\u064a\\u0629 \\u0641\\u064a \\u0643\\u0644 \\u0627\\u0644\\u0645\\u062c\\u0627\\u0644\\u0627\\u062a\",\"description\":null,\"button\":{\"label\":null,\"icon\":null,\"url\":null}},\"cta_section\":{\"title_bold_text\":\"\\u0627\\u062e\\u062a\\u0631 \\u062f\\u0648\\u0631\\u062a\\u0643 \\u0627\\u0644\\u0645\\u0641\\u0636\\u0644\\u0629\",\"title_regular_text\":null,\"description\":null,\"icon\":null},\"specific_instructors\":{\"RyBfa\":{\"instructor_id\":\"3\"},\"xneeA\":{\"instructor_id\":\"870\"},\"BwsHn\":{\"instructor_id\":\"923\"},\"CtQgB\":{\"instructor_id\":\"1048\"},\"VhoFw\":{\"instructor_id\":\"934\"},\"iDydD\":{\"instructor_id\":\"1015\"},\"dmety\":{\"instructor_id\":\"1016\"},\"sQpbF\":{\"instructor_id\":\"1048\"},\"record\":{\"instructor_id\":null}}}'),
(427, 13, 'ar', '{\"main_content\":{\"pre_title\":\"\\u0645\\u0631\\u0643\\u0632 \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629\",\"title\":\"\\u062a\\u0639\\u0644\\u0645 \\u0648\\u062a\\u0639\\u0631\\u0641 \\u0639\\u0644\\u064a \\u0643\\u0627\\u0641\\u0629 \\u062e\\u0635\\u0627\\u0626\\u0635 \\u0645\\u0646\\u0635\\u0629 \\u0633\\u0645\\u0627\\u062a \\u0628\\u0644\\u0633\",\"description\":\"\\u0645\\u0642\\u0627\\u0644\\u0627\\u062a \\u0648\\u0627\\u062f\\u0644\\u0629 \\u0627\\u0631\\u0634\\u0627\\u062f\\u064a\\u0629 \\u0648\\u0641\\u064a\\u062f\\u064a\\u0648\\u0647\\u0627\\u062a \\u062a\\u0639\\u0631\\u064a\\u0641\\u064a\\u0629 \\u0628\\u0643\\u0644 \\u0645\\u0627\\u064a\\u0647\\u0645\\u0643\\u0645 \\u0641\\u064a \\u0633\\u0645\\u0627\\u062a \\u0628\\u0644\\u0633\",\"button\":{\"label\":null,\"icon\":null,\"url\":null}}}'),
(428, 4, 'ar', '{\"main_content\":{\"pre_title\":\"\\u0633\\u062c\\u0644 \\u0641\\u064a\\u0647\\u0627 \\u0627\\u0643\\u062b\\u0631 \\u0645\\u0646 10000 \\u0645\\u062a\\u062f\\u0631\\u0628\",\"title\":\"\\u062f\\u0648\\u0631\\u0627\\u062a\\u0646\\u0627 \\u0627\\u0644\\u0645\\u0645\\u064a\\u0632\\u0629 \\u0648\\u0627\\u0644\\u0623\\u0643\\u062b\\u0631 \\u062a\\u0633\\u062c\\u064a\\u0644\\u0627\"},\"trending_categories\":{\"trPlf\":{\"category\":\"11\"},\"NmNFb\":{\"category\":\"2\"},\"AwpIB\":{\"category\":\"4\"},\"lCDvA\":{\"category\":\"10\"},\"NQgkS\":{\"category\":\"4\"},\"WKMxy\":{\"category\":\"3\"},\"lbDad\":{\"category\":\"5\"},\"RbOfq\":{\"category\":\"6\"},\"record\":{\"category\":null}}}'),
(430, 437, 'ar', '{\"upper_cta\":{\"badge_text\":\"\\u0627\\u0644\\u062c\\u062f\\u064a\\u062f\",\"main_text\":\"\\u0625\\u0637\\u0644\\u0639 \\u0639\\u0644\\u0649 \\u0627\\u062d\\u062f\\u062a \\u0628\\u0631\\u0627\\u0645\\u062c\\u0646\\u0627 \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628\\u064a\\u0629\",\"icon\":\"bro-book\",\"url\":\"https:\\/\\/siematplus.com\"},\"main_content\":{\"title_line_1\":\"\\u0627\\u0644\\u0634\\u0631\\u064a\\u0643 \\u0627\\u0644\\u0623\\u0641\\u0636\\u0644 \\u0644\\u0645\\u0633\\u0627\\u0631\\u0643 \\u0627\\u0644\\u0645\\u0647\\u0646\\u064a\",\"title_line_2\":null,\"description\":null,\"primary_button\":{\"label\":\"\\u0633\\u062c\\u0644 \\u0627\\u0644\\u0623\\u0646\",\"icon\":\"bro-logout\",\"url\":\"https:\\/\\/siematplus.com\\/register\"},\"secondary_button\":{\"label\":\"\\u0625\\u0643\\u062a\\u0634\\u0641 \\u0628\\u0631\\u0627\\u0645\\u062c\\u0646\\u0627 \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628\\u064a\\u0629\",\"icon\":\"bol-menu-1\",\"url\":\"https:\\/\\/siematplus.com\\/classes?sort=newest\"}},\"students_widget\":{\"title\":\"\\u062a\\u0642\\u064a\\u0645\\u0627\\u062a\",\"url\":\"https:\\/\\/siematplus.com\"},\"image_content\":{\"type\":\"image\",\"image\":\"\\/store\\/landing_builder\\/landing_1\\/437\\/WhatsApp_Image_2025-11-25_at_10.56.36_AM_eLV.jpeg\",\"overlay_image\":{},\"spinning_image\":null},\"background\":null}');

-- --------------------------------------------------------

--
-- Structure de la table `landing_translations`
--

CREATE TABLE `landing_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `landing_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `landing_translations`
--

INSERT INTO `landing_translations` (`id`, `landing_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Lite (Included)'),
(14, 1, 'ar', 'home-page');

-- --------------------------------------------------------

--
-- Structure de la table `meetings`
--

CREATE TABLE `meetings` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `amount` double(15,2) UNSIGNED DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `in_person` tinyint(1) NOT NULL DEFAULT 0,
  `in_person_amount` double(15,2) DEFAULT NULL,
  `group_meeting` tinyint(1) NOT NULL DEFAULT 0,
  `online_group_min_student` int(11) DEFAULT NULL,
  `online_group_max_student` int(11) DEFAULT NULL,
  `online_group_amount` double(15,2) DEFAULT NULL,
  `in_person_group_min_student` int(11) DEFAULT NULL,
  `in_person_group_max_student` int(11) DEFAULT NULL,
  `in_person_group_amount` double(15,2) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `meetings`
--

INSERT INTO `meetings` (`id`, `creator_id`, `amount`, `discount`, `in_person`, `in_person_amount`, `group_meeting`, `online_group_min_student`, `online_group_max_student`, `online_group_amount`, `in_person_group_min_student`, `in_person_group_max_student`, `in_person_group_amount`, `disabled`, `created_at`) VALUES
(39, 1113, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1769899305),
(40, 1129, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1772559420),
(41, 1137, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1777150678);

-- --------------------------------------------------------

--
-- Structure de la table `meeting_packages`
--

CREATE TABLE `meeting_packages` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `duration` int(10) UNSIGNED NOT NULL,
  `duration_type` enum('day','week','month','year') NOT NULL DEFAULT 'day',
  `sessions` int(10) UNSIGNED NOT NULL,
  `session_duration` int(10) UNSIGNED NOT NULL COMMENT 'Each Session duration (Minutes)',
  `price` decimal(15,2) DEFAULT NULL,
  `discount` int(10) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `meeting_packages_sold`
--

CREATE TABLE `meeting_packages_sold` (
  `id` int(10) UNSIGNED NOT NULL,
  `meeting_package_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `session_duration` int(10) UNSIGNED NOT NULL COMMENT 'Each Session duration (Minutes)',
  `paid_amount` decimal(15,2) DEFAULT NULL,
  `paid_at` bigint(20) UNSIGNED NOT NULL,
  `expire_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `meeting_package_translations`
--

CREATE TABLE `meeting_package_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meeting_package_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `meeting_times`
--

CREATE TABLE `meeting_times` (
  `id` int(10) UNSIGNED NOT NULL,
  `meeting_id` int(10) UNSIGNED NOT NULL,
  `meeting_type` enum('all','in_person','online') NOT NULL DEFAULT 'all',
  `day_label` enum('saturday','sunday','monday','tuesday','wednesday','thursday','friday') NOT NULL,
  `time` varchar(64) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2020_08_09_145553_create_roles_table', 1),
(4, '2020_08_09_145834_create_sections_table', 1),
(5, '2020_08_09_145926_create_permissions_table', 1),
(6, '2020_08_24_163003_create_webinars_table', 1),
(7, '2020_08_24_164823_create_webinar_partner_teacher_table', 1),
(8, '2020_08_24_165658_create_tags_table', 1),
(9, '2020_08_24_165835_create_webinar_tag_table', 1),
(10, '2020_08_24_171611_create_categories_table', 1),
(11, '2020_08_29_052437_create_filters_table', 1),
(12, '2020_08_29_052900_create_filter_options_table', 1),
(13, '2020_08_29_054455_add_category_id_in_webinar_table', 1),
(14, '2020_09_01_174741_add_seo_description_and_start_end_time_in_webinar_table', 1),
(15, '2020_09_02_180508_create_webinar_filter_option_table', 1),
(16, '2020_09_02_193923_create_tickets_table', 1),
(17, '2020_09_02_210447_create_sessions_table', 1),
(18, '2020_09_02_212642_create_files_table', 1),
(19, '2020_09_03_175543_create_faqs_table', 1),
(20, '2020_09_08_175539_delete_webinar_tag_and_update_tag_table', 1),
(21, '2020_09_09_154522_create_quizzes_table', 1),
(22, '2020_09_09_174646_create_quizzes_questions_table', 1),
(23, '2020_09_09_182726_create_quizzes_questions_answers_table', 1),
(24, '2020_09_14_160028_create_prerequisites_table', 1),
(25, '2020_09_14_183235_nullable_item_id_in_quizzes_table', 1),
(26, '2020_09_14_190110_create_webinar_quizzes_table', 1),
(27, '2020_09_16_163835_create_quizzes_results_table', 1),
(28, '2020_09_24_102115_add_total_mark_in_quize_table', 1),
(29, '2020_09_24_132242_create_comment_table', 1),
(30, '2020_09_24_132639_create_favorites_table', 1),
(31, '2020_09_26_181200_create_certificate_table', 1),
(32, '2020_09_26_181444_create_certificates_templates_table', 1),
(33, '2020_09_30_170451_add_slug_in_webinars_table', 1),
(34, '2020_09_30_191202_create_purchases_table', 1),
(35, '2020_10_02_063828_create_rating_table', 1),
(36, '2020_10_02_094723_edit_table_and_add_foreign_key', 1),
(37, '2020_10_08_055408_add_reviwes_table', 1),
(38, '2020_10_08_084100_edit_status_comments_table', 1),
(39, '2020_10_08_121041_create_meetings_table', 2),
(40, '2020_10_08_121621_create_meeting_times_table', 2),
(41, '2020_10_08_121848_create_meeting_requests_table', 2),
(42, '2020_10_15_172913_add_about_and_head_line_in_users_table', 2),
(43, '2020_10_15_173645_create_follow_table', 2),
(46, '2020_10_17_100606_create_badges_table', 3),
(47, '2020_10_08_121848_create_reserve_meetings_table', 4),
(48, '2020_10_20_193013_update_users_table', 5),
(50, '2020_10_18_220323_convert_creatore_user_id_to_creator_id', 7),
(51, '2020_10_22_153502_create_cart_table', 7),
(52, '2020_10_22_154636_create_orders_table', 7),
(53, '2020_10_22_155930_create_order_items_table', 7),
(54, '2020_10_23_204203_create_sales_table', 7),
(55, '2020_10_23_211459_create_accounting_table', 7),
(56, '2020_10_23_213515_create_discounts_table', 7),
(57, '2020_10_23_213934_create_discount_users_table', 7),
(58, '2020_10_23_235444_create_ticket_users_table', 7),
(59, '2020_10_25_172331_create_groups_table', 7),
(60, '2020_10_25_172523_create_group_users_table', 7),
(62, '2020_11_02_202754_edit_email_in_users_table', 8),
(63, '2020_11_03_200314_edit_some_tables', 9),
(64, '2020_11_06_193300_create_settings_table', 10),
(67, '2020_11_09_202533_create_feature_webinars_table', 11),
(68, '2020_11_10_193459_edit_webinars_table', 12),
(69, '2020_11_11_203344_create_trend_categories_table', 13),
(72, '2020_11_11_222833_create_blog_categories_table', 14),
(75, '2020_11_11_231204_create_blog_table', 15),
(76, '2020_10_25_223247_add_sub_title_tickets_table', 16),
(77, '2020_10_28_001340_add_count_in_discount_users_table', 16),
(78, '2020_10_28_221509_create_payment_channels_table', 16),
(79, '2020_11_01_120909_change_class_name_enum_payment_channels_table', 16),
(80, '2020_11_07_233948_add_some_raw_in_order_items__table', 16),
(81, '2020_11_10_061350_add_discount_id_in_order_items_table', 16),
(82, '2020_11_10_071651_decimal_orders_order_items_sales_table', 16),
(83, '2020_11_11_193138_change_reference_id_type_in_orders_tabel', 16),
(84, '2020_11_11_222413_change_meeting_id_to_meeting_time_id_in_order_items_table', 16),
(85, '2020_11_11_225421_add_locked_at_and_reserved_at_and_change_request_time_to_day_in_reserve_meetings_table', 17),
(86, '2020_11_12_000116_add_type_in_orders_table', 17),
(87, '2020_11_12_001912_change_meeting_id_to_meeting_time_id_in_accounting_table', 17),
(88, '2020_11_12_133009_decimal_paid_amount_in_reserve_meetings_table', 17),
(91, '2020_11_12_170109_add_blog_id_to_comments_table', 18),
(98, '2020_11_14_201228_add_bio_and_ban_to_users_table', 20),
(99, '2020_11_14_224447_create_users_badges_table', 21),
(100, '2020_11_14_233319_create_payout_request_table', 22),
(101, '2020_11_15_010622_change_byer_id_and_add_seller_id_in_sales_table', 22),
(102, '2020_11_16_195009_create_supports_table', 22),
(103, '2020_11_16_201814_create_support_departments_table', 22),
(107, '2020_11_16_202254_create_supports_table', 23),
(109, '2020_11_17_192744_create_support_conversations_table', 24),
(110, '2020_11_17_072348_create_offline_payments_table', 25),
(111, '2020_11_19_191943_add_replied_status_to_comments_table', 25),
(114, '2020_11_20_215748_create_subscribes_table', 26),
(115, '2020_11_21_185519_create_notification_templates_table', 27),
(116, '2020_11_22_210832_create_promotions_table', 28),
(118, '2020_11_23_194153_add_status_column_to_discounts_table', 29),
(119, '2020_11_23_213532_create_users_occupations_table', 30),
(120, '2020_11_30_220855_change_amount_in_payouts_table', 31),
(121, '2020_11_30_231334_add_pay_date_in_offline_payments_table', 31),
(122, '2020_11_30_233018_add_charge_enum_in_type_in_orders_table', 31),
(123, '2020_12_01_193948_create_testimonials_table', 32),
(124, '2020_12_02_202043_edit_and_add_types_to_webinars_table', 33),
(128, '2020_12_04_204048_add_column_creator_id_to_some_tables', 34),
(129, '2020_12_05_205320_create_text_lessons_table', 35),
(130, '2020_12_05_210052_create_text_lessons_attachments_table', 36),
(131, '2020_12_06_215701_add_order_column_to_webinar_items_tables', 37),
(132, '2020_12_11_114844_add_column_storage_to_files_table', 38),
(133, '2020_12_07_211009_add_subscribe_id_in_order_items_table', 39),
(134, '2020_12_07_211657_nullable_payment_method_in_orders_table', 39),
(135, '2020_12_07_212306_add_subscribe_enum__type_in_orders_table', 39),
(136, '2020_12_07_223237_changes_in_sales_table', 39),
(137, '2020_12_07_224925_add_subscribe_id_in_accounting_table', 39),
(138, '2020_12_07_230200_create_subscribe_uses_table', 39),
(139, '2020_12_11_123209_add_subscribe_type_account_in_accounting_table', 39),
(140, '2020_12_11_132819_add_sale_id_in_subscribe_use_in_subscribe_uses_table', 39),
(141, '2020_12_11_135824_add_subscribe_payment_method_in_sales_table', 39),
(143, '2020_12_13_205751_create_advertising_banners_table', 41),
(145, '2020_12_14_204251_create_become_instructors_table', 42),
(146, '2020_11_12_232207_create_reports_table', 43),
(147, '2020_11_12_232207_create_comments_reports_table', 44),
(148, '2020_12_17_210822_create_webinar_reports_table', 45),
(150, '2020_12_18_181551_create_notifications_table', 46),
(151, '2020_12_18_195833_create_notifications_status_table', 47),
(152, '2020_12_19_195152_add_status_column_to_payment_channels_table', 48),
(154, '2020_12_20_231434_create_contacts_table', 49),
(155, '2020_12_21_210345_edit_quizzes_table', 50),
(156, '2020_12_24_221715_add_column_to_users_table', 50),
(157, '2020_12_24_084728_create_special_offers_table', 51),
(158, '2020_12_25_204545_add_promotion_enum_type_in_orders_table', 51),
(159, '2020_12_25_205139_add_promotion_id_in_order_items_table', 51),
(160, '2020_12_25_205811_add_promotion_id_in_accounting_table', 51),
(161, '2020_12_25_210341_add_promotion_id_in_sales_table', 51),
(162, '2020_12_25_212453_add_promotion_type_account_enum_in_accounting_table', 51),
(163, '2020_12_25_231005_add_promotion_type_enum_in_sales_table', 51),
(166, '2020_12_29_192943_add_column_reply_to_contacts_table', 53),
(167, '2020_12_30_225001_create_payu_transactions_table', 54),
(168, '2021_01_06_202649_edit_column_password_from_users_table', 55),
(169, '2021_01_08_134022_add_api_column_to_sessions_table', 56),
(170, '2021_01_10_215540_add_column_store_type_to_accounting', 57),
(173, '2021_01_13_214145_edit_carts_table', 58),
(174, '2021_01_13_230725_delete_column_type_from_orders_table', 59),
(175, '2021_01_20_214653_add_discount_column_to_reserve_meetings_table', 60),
(177, '2021_01_27_193915_add_foreign_key_to_support_conversations_table', 61),
(178, '2021_02_02_203821_add_viewed_at_column_to_comments_table', 62),
(180, '2021_02_12_134504_add_financial_approval_column_to_users_table', 64),
(181, '2021_02_12_131916_create_verifications_table', 65),
(182, '2021_02_15_221518_add_certificate_to_users_table', 66),
(183, '2021_02_16_194103_add_cloumn_private_to_webinars_table', 66),
(184, '2021_02_18_213601_edit_rates_column_webinar_reviews_table', 67),
(188, '2021_02_27_212131_create_noticeboards_table', 68),
(189, '2021_02_27_213940_create_noticeboards_status_table', 68),
(191, '2021_02_28_195025_edit_groups_table', 69),
(192, '2021_03_06_205221_create_newsletters_table', 70),
(193, '2021_03_12_105526_add_is_main_column_to_roles_table', 71),
(194, '2021_03_12_202441_add_description_column_to_feature_webinars_table', 72),
(195, '2021_03_18_130248_edit_status_column_from_supports_table', 73),
(196, '2021_03_19_113306_add_column_order_to_categories_table', 74),
(197, '2021_03_19_115939_add_column_order_to_filter_options_table', 75),
(199, '2021_03_24_100005_edit_discounts_table', 76),
(200, '2021_03_27_204551_create_sales_status_table', 77),
(202, '2021_03_28_182558_add_column_page_to_settings_table', 78),
(206, '2021_03_31_195835_add_new_status_in_reserve_meetings_table', 79),
(207, '2020_12_12_204705_create_course_learning_table', 80),
(208, '2021_04_19_195452_add_meta_description_column_to_blog_table', 81),
(209, '2021_04_21_200131_add_icon_column_to_categories_table', 82),
(210, '2021_04_21_203746_add_is_popular_column_to_subscribes_table', 83),
(211, '2021_04_25_203955_add_is_charge_account_column_to_order_items', 84),
(212, '2021_04_25_203955_add_is_charge_account_column_to_orders', 85),
(213, '2021_05_13_111720_add_moderator_secret_column_to_sessions_table', 86),
(214, '2021_05_13_123920_add_zoom_id_column_to_sessions_table', 87),
(215, '2021_05_14_182848_create_session_reminds_table', 88),
(217, '2021_05_25_193743_create_users_zoom_api_table', 89),
(218, '2021_05_25_205716_add_new_column_to_sessions_table', 90),
(219, '2021_05_27_095128_add_user_id_to_newsletters_table', 91),
(220, '2020_12_27_192459_create_pages_table', 92),
(221, '2021_07_03_222439_add_special_offer_id_to_cart_table', 93),
(222, '2021_09_02_101422_add_payment_data_to_orders_table', 94),
(223, '2021_09_02_110519_add_sender_id_to_notifications_table', 95),
(224, '2021_09_06_113524_create_webinar_chapters_table', 96),
(228, '2021_09_06_114459_add_chapter_id_to_files_table', 97),
(229, '2021_09_06_114532_add_chapter_id_to_text_lessons_table', 97),
(230, '2021_09_06_114547_add_chapter_id_to_sessions_table', 97),
(231, '2021_09_13_134659_add_chapter_id_to_quizzes_table', 98),
(234, '2021_09_14_122505_create_affiliates_table', 100),
(235, '2021_09_14_122117_create_affiliates_codes_table', 101),
(239, '2021_09_14_142927_add_affiliate_column_to_users_table', 105),
(241, '2021_09_14_142302_add_affiliate_column_to_accounting_table', 106),
(244, '2021_09_18_155914_create_blog_translations_table', 107),
(246, '2021_09_19_190400_create_page_translations_table', 108),
(248, '2021_09_19_203526_create_setting_translations_table', 109),
(250, '2021_09_20_140241_create_advertising_banners_translations_table', 110),
(252, '2021_09_20_175518_create_category_translations_table', 111),
(255, '2021_09_20_184724_create_filter_translations_table', 112),
(256, '2021_09_20_185132_create_filter_option_translations_table', 112),
(258, '2021_09_21_160650_create_subscribe_translations_table', 113),
(260, '2021_09_21_162922_create_promotion_translations_table', 114),
(262, '2021_09_21_164954_create_testimonial_translations_table', 115),
(264, '2021_09_21_182251_create_feature_webinar_translations_table', 116),
(266, '2021_09_21_184239_create_certificate_template_translations_table', 117),
(268, '2021_09_21_195731_create_support_department_translations_table', 118),
(270, '2021_09_21_201512_create_badge_translations_table', 119),
(272, '2021_09_22_120723_create_webinar_translations_table', 120),
(274, '2021_09_22_135518_create_ticket_translations_table', 121),
(276, '2021_09_22_144342_create_webinar_chapter_translations_table', 122),
(278, '2021_09_22_162502_create_session_translations_table', 123),
(280, '2021_09_22_172309_create_file_translations_table', 124),
(282, '2021_09_22_173500_create_faq_translations_table', 125),
(284, '2021_09_23_094903_create_text_lesson_translations_table', 126),
(286, '2021_09_27_194537_create_quiz_translations_table', 127),
(288, '2021_09_28_112529_create_quiz_question_translations_table', 128),
(290, '2021_09_28_122513_create_quizzes_questions_answer_translations_table', 129),
(291, '2021_12_03_103010_add_agora_session_api_to_sessions_table', 130),
(292, '2021_12_03_103558_add_agora_to_sessions_table', 131),
(293, '2021_12_03_114009_create_agora_history_table', 132),
(295, '2021_12_04_183524_create_regions_table', 133),
(298, '2021_12_25_151304_add_new_column_to_meetings_table', 135),
(299, '2021_12_26_142304_add_new_column_to_meeting_times_table', 136),
(302, '2022_01_01_162247_add_new_column_to_reserve_meetings_table', 137),
(305, '2022_01_02_142927_create_rewards_table', 138),
(307, '2022_01_03_153517_create_rewards_accounting_table', 139),
(308, '2022_01_04_161756_add_score_column_to_badges_table', 140),
(309, '2022_01_04_165147_add_points_column_to_webinars_table', 141),
(312, '2022_01_08_154504_edit_storage_column_and_add_new_value_to_files_table', 142),
(313, '2022_01_11_162839_add_timezone_column_to_users_table', 143),
(314, '2022_01_12_142238_add_timezone_column_to_webinars_table', 144),
(315, '2022_01_15_131828_create_registration_packages_table', 145),
(319, '2022_01_15_203133_edit_columns_in_accounting_table', 146),
(320, '2022_01_16_102825_edit_columns_in_order_items_table', 147),
(321, '2022_01_17_152605_add_registration_package_id_to_sales_table', 148),
(322, '2022_01_18_103414_create_users_registration_packages_table', 149),
(323, '2022_01_18_113331_create_groups_registration_packages_table', 150),
(325, '2022_01_20_110119_add_become_instructor_id_column_to_order_items_table', 152),
(326, '2022_01_18_160228_add_column_role_to_become_instructors_table', 153),
(327, '2022_01_26_080434_add_reserve_date_columns_to_reserve_meetings_table', 154),
(328, '2022_01_28_094259_edit_column_in_discounts_table', 155),
(329, '2022_01_28_094515_create_discount_courses_table', 155),
(330, '2022_01_28_094527_create_discount_groups_table', 155),
(331, '2022_01_31_093231_add_column_description_to_meeting_times_table', 156),
(332, '2022_01_31_093306_add_column_description_to_reserve_meetings_table', 156),
(334, '2022_02_01_092922_create_newsletters_history_table', 157),
(335, '2022_02_01_104529_create_discount_categories_table', 158),
(337, '2022_02_02_092820_add_attachment_column_to_offline_payments_table', 159),
(339, '2022_02_02_184235_add_column_video_demo_source_to_webinars_table', 160),
(340, '2021_12_05_193333_add_new_column_to_users_table', 161),
(341, '2022_02_27_072819_add_forign_key_for_region_to_users_table', 162),
(347, '2022_03_05_123830_create_product_categories_table', 163),
(348, '2022_03_05_125138_create_product_filters_table', 163),
(350, '2022_03_06_091528_create_product_filter_options_table', 163),
(351, '2022_03_07_081257_create_product_specifications_table', 164),
(353, '2022_03_07_081808_create_product_specification_categories_table', 165),
(357, '2022_03_05_125434_create_products_table', 166),
(358, '2022_03_07_093128_create_product_discounts_table', 166),
(362, '2022_03_08_101832_create_product_media_table', 167),
(363, '2022_03_09_054031_create_product_selected_filter_options_table', 168),
(364, '2022_03_09_083337_create_product_specification_meta_table', 169),
(369, '2022_03_09_084108_create_product_selected_specifications_table', 170),
(370, '2022_03_09_140558_create_product_faqs_table', 171),
(374, '2022_03_11_180436_create_product_reviews_table', 174),
(375, '2022_03_11_182715_add_product_id_to_comments_reports_table', 175),
(376, '2022_03_08_094452_create_product_files_table', 176),
(377, '2022_03_11_180746_add_product_id_to_comments_table', 177),
(378, '2022_03_12_102233_add_new_position_to_advertising_banners_table', 178),
(383, '2022_03_13_072108_add_product_id_to_sales_table', 179),
(385, '2022_03_13_081212_create_product_orders_table', 180),
(386, '2022_03_19_171559_create_product_selected_specification_translations_table', 181),
(387, '2022_03_21_161055_add_create_store_column_to_users_table', 182),
(388, '2022_03_26_065509_add_new_type_to_rewards_table', 183),
(389, '2022_03_28_051949_add_product_count_column_to_registration_packages_table', 184),
(391, '2022_03_28_054322_add_product_type_column_to_discounts_table', 185),
(392, '2022_03_28_062248_edit_type_column_of_rewards_accounting_table', 186),
(393, '2022_03_28_083906_edit_type_column_to_badges_table', 187),
(394, '2022_04_02_051515_create_webinar_chapter_items_table', 188),
(395, '2022_04_02_085059_remove_type_column_from_webinar_chapters_table', 189),
(396, '2022_04_02_131352_add_check_sequence_content_fields_to_contents_tables', 190),
(399, '2022_04_04_075541_add_assignment_type_to_webinar_chapter_items_table', 192),
(400, '2022_04_04_071203_create_webinar_assignments_table', 193),
(401, '2022_04_04_071303_create_webinar_assignment_attachments_table', 193),
(405, '2022_04_05_053308_create_webinar_assignment_history_table', 194),
(406, '2022_04_05_060030_create_webinar_assignment_history_messages_table', 194),
(407, '2022_04_06_121240_add_new_type_passed_assignment_to_rewards_table', 195),
(408, '2022_04_09_064609_add_access_content_column_to_users_table', 196),
(409, '2022_04_10_073822_create_bundles_table', 197),
(410, '2022_04_10_092348_create_bundle_filter_option_table', 198),
(413, '2022_04_10_130733_create_bundle_webinars_table', 200),
(421, '2022_04_10_093457_add_bundle_id_to_needle_tables', 201),
(422, '2022_04_12_153052_add_access_time_to_webinars_table', 202),
(423, '2022_04_13_053947_create_course_noticeboards_table', 203),
(424, '2022_04_13_054536_create_course_noticeboard_status_table', 203),
(425, '2022_04_13_130155_add_column_forum_to_webinars_table', 204),
(427, '2022_04_14_060606_create_course_forums_table', 205),
(428, '2022_04_14_063316_create_course_forum_answers_table', 206),
(447, '2022_04_21_133513_add_new_type_in_rewards_table', 216),
(448, '2022_04_21_135212_add_new_type_in_badges_table', 217),
(449, '2022_04_24_081637_add_new_type_instructor_blog_in_rewards_table', 218),
(450, '2022_04_24_082515_add_new_type_instructor_blog_in_badges_table', 219),
(452, '2022_04_25_043945_create_users_cookie_security_table', 220),
(453, '2022_04_25_143142_add_organization_price__column_to_webinars_table', 221),
(454, '2022_04_25_165256_add_image_and_video_to_quizzes_questions_table', 222),
(456, '2022_04_26_060018_edit_certificates_templates_table', 223),
(458, '2022_04_26_082017_edit_certificates_table', 224),
(459, '2022_04_26_155421_create_subscribe_reminds_table', 225),
(460, '2022_04_26_163428_add_instructor_id_to_noticeboards_table', 226),
(461, '2022_04_27_133655_add_unlimited_download_to_subscribes_table', 227),
(462, '2022_04_27_133655_add_infinite_use_to_subscribes_table', 228),
(463, '2022_04_27_140844_add_extra_time_to_join_to_sessions_table', 229),
(464, '2022_04_28_052318_create_webinar_extra_description_table', 230),
(466, '2022_05_09_125820_create_navbar_buttons_table', 232),
(467, '2021_06_07_000000_create_payku_transactions_table', 233),
(468, '2021_06_07_000001_create_payku_payments_table', 233),
(469, '2021_11_30_122831_create_jazzcash_transactions_table', 233),
(470, '2021_12_15_000000_add_new_columns_to_tables', 233),
(471, '2022_05_23_081324_create_product_specification_multi_values_table', 234),
(472, '2022_05_23_091527_create_product_selected_specification_multi_values_table', 235),
(475, '2022_05_23_151601_add_product_delivery_fee_column_to_sales_table', 236),
(476, '2022_04_18_103856_create_forums_table', 237),
(477, '2022_04_18_152201_create_forum_topics_table', 237),
(478, '2022_04_18_152845_create_forum_topic_attachments_table', 237),
(479, '2022_04_19_071911_create_forum_topic_posts_table', 237),
(480, '2022_04_19_123745_create_forum_topic_reports_table', 237),
(481, '2022_04_19_135314_create_forum_topic_bookmarks_table', 237),
(482, '2022_04_19_152929_create_forum_topic_likes_table', 237),
(483, '2022_04_20_152756_create_forum_featured_topics_table', 237),
(484, '2022_04_21_054043_create_forum_recommended_topics_table', 237),
(485, '2022_04_21_054815_create_forum_recommended_topic_items_table', 237),
(486, '2022_05_26_085212_change_some_column_varchar_to_text', 238),
(487, '2022_05_27_142612_add_avarat_settings_to_users_table', 239),
(489, '2022_05_01_151107_add_manual_added_column_to_sales_table', 240),
(490, '2022_05_29_162315_create_delete_account_requests_table', 241),
(491, '2020_10_20_211927_create_users_metas_table', 242),
(492, '2022_05_31_133347_add_certificate_column_to_webinars_table', 243),
(494, '2022_05_31_165839_add_online_viewer_column_to_files_table', 244),
(495, '2022_06_08_071712_create_home_sections_table', 245),
(496, '2022_10_14_074434_add_reserve_meeting_id_to_sessions_table', 246),
(497, '2022_12_25_082946_add_logged_count_column_to_users_table', 247),
(498, '2022_12_26_064214_add_new_column_to_quizzes_table', 247),
(499, '2022_12_27_064800_add_column_url_to_categories_table', 247),
(500, '2023_01_02_085731_create_upcoming_courses_table', 248),
(501, '2023_01_09_065436_create_installments_table', 249),
(502, '2023_01_14_144421_create_installment_orders_table', 250),
(503, '2023_01_18_064141_create_floating_bars_table', 251),
(504, '2023_01_18_145605_create_cashback_rules_table', 252),
(505, '2023_01_21_075422_add_column_to_accounting_table', 253),
(506, '2023_01_24_141128_create_currencies_table', 254),
(507, '2023_01_25_090622_add_currency_column_to_users', 254),
(508, '2023_01_25_104531_edit_price_column_tables', 254),
(509, '2023_01_25_145647_add_column_to_payment_channels_table', 254),
(510, '2023_01_29_074044_create_installment_reminders_table', 255),
(511, '2023_02_06_135446_add_new_columns_to_special_offers_table', 256),
(512, '2023_02_07_141617_create_discount_bundles_table', 257),
(513, '2023_02_07_152101_add_new_columns_to_users_zoom_api_table', 258),
(514, '2023_02_08_140023_create_home_page_statistics_table', 259),
(515, '2023_02_11_135759_add_enable_waitlist_column_to_webinars_table', 260),
(516, '2023_02_11_144743_create_waitlists_table', 261),
(518, '2023_02_13_134648_create_offline_banks_table', 262),
(520, '2023_02_14_144003_create_user_banks_table', 263),
(523, '2023_02_15_140227_create_test_table', 264),
(524, '2023_02_15_151458_add_new_storage_to_files_table', 265),
(528, '2023_02_20_141047_create_gifts_table', 266),
(529, '2023_02_27_065823_add_enable_registration_bonus_to_users_table', 267),
(530, '2023_03_05_075231_add_installment_order_id_to_accounting_table', 267),
(531, '2023_03_08_095345_edit_payouts_table', 268),
(532, '2023_03_10_143238_edit_column_in_quizzes_table', 269),
(533, '2023_03_12_110714_edit_column_in_order_items_table', 270),
(534, '2023_03_13_120634_edit_price_column_in_promotions_table', 271),
(535, '2023_03_13_135747_add_price_column_to_installment_orders_table', 271),
(536, '2023_05_02_150757_create_selected_installments_table', 272),
(537, '2023_06_09_072812_create_forms_table', 273),
(538, '2023_06_09_084907_create_form_fields_table', 273),
(539, '2023_06_11_123736_create_form_submissions_table', 273),
(540, '2023_06_13_115235_create_user_form_fields_table', 273),
(541, '2019_08_19_000000_create_failed_jobs_table', 274),
(542, '2019_12_14_000001_create_personal_access_tokens_table', 274),
(543, '2023_08_13_145531_create_ai_content_templates_table', 274),
(544, '2023_08_17_065609_create_ai_contents_table', 274),
(545, '2023_09_12_102852_add_ai_content_limitation_column_to_users_table', 275),
(546, '2023_09_12_103623_add_ai_content_access_column_to_registration_packages_table', 275),
(547, '2023_08_22_141556_add_sales_count_column_to_webinars_table', 276),
(548, '2023_08_27_144854_create_related_courses_table', 276),
(549, '2023_09_02_152318_create_purchase_notifications_table', 276),
(550, '2023_09_13_164842_create_course_personal_notes_table', 276),
(551, '2023_09_18_172303_create_content_delete_requests_table', 276),
(552, '2023_09_19_155014_create_user_logs_table', 276),
(553, '2023_09_23_141534_create_ip_restrictions_table', 276),
(554, '2023_09_25_142632_create_product_badges_table', 276),
(555, '2023_09_30_141640_create_cart_discounts_table', 276),
(556, '2023_10_01_144952_create_abandoned_cart_rules_table', 276),
(557, '2023_10_17_154000_edit_files_table', 276),
(558, '2023_10_18_160122_create_blog_category_translations_table', 276),
(559, '2023_10_19_151449_edit_sections_table', 276),
(560, '2023_11_21_135049_create_course_learning_last_view_table', 276),
(561, '2023_12_24_124451_edit_certificate_template_translations_table', 276),
(562, '2023_12_24_124532_edit_certificate_template_translations_table', 276),
(563, '2024_02_04_142556_create_abandoned_cart_rule_users_groups_table', 276),
(564, '2024_02_04_143742_create_abandoned_cart_rule_specification_items_table', 276),
(565, '2024_02_19_141912_create_abandoned_cart_rule_histories_table', 276),
(566, '2024_02_28_436872_add_credentials_column_to_payment_channels_table', 276),
(567, '2024_02_28_469813_remove_settings_column_from_payment_channels_table', 276),
(568, '2023_07_11_165937_create_user_firebase_sessions', 277),
(569, '2024_04_24_085747_add_new_column_to_course_learning_last_views_table', 277),
(570, '2024_05_06_141610_create_user_commissions_table', 277),
(571, '2024_05_06_142505_remove_commission_column_from_tables', 277),
(572, '2024_05_11_122847_add_new_source_for_video_demo', 277),
(573, '2024_05_19_131041_add_certificate_column_to_bundles_table', 277),
(574, '2024_05_19_133542_add_bundle_to_certificates_table', 277),
(575, '2024_12_18_142629_edit_demo_sources_column_in_all_tables', 278),
(576, '2024_12_18_155802_create_role_translations_table', 278),
(577, '2023_12_18_140755_edit_support_departments_table', 279),
(578, '2024_01_04_091010_add_new_columns_to_users_table', 279),
(579, '2024_01_07_144315_create_user_profile_attachments_table', 279),
(580, '2024_01_27_144143_add_icon_column_to_quizzes_table', 279),
(581, '2024_02_25_095914_edit_media_column_on_webinars_table', 279),
(582, '2024_04_06_082351_edit_thumbnail_column_in_contents_tables', 279),
(583, '2024_05_28_180218_add_description_to_quiz_translations_table', 279),
(584, '2024_06_17_182344_add_username_column_to_users_table', 279),
(585, '2024_06_21_140326_add_study_time_column_to_blog_table', 279),
(586, '2024_07_17_181235_add_new_page_to_settings_table', 279),
(587, '2024_08_08_134035_add_summary_column_to_webinar_translations_table', 279),
(588, '2024_08_11_155755_add_profile_secondary_image_column_to_users', 279),
(589, '2024_09_09_152944_edit_categories_table', 279),
(590, '2024_09_11_163555_add_column_to_upcoming_course_table', 279),
(591, '2024_09_15_172927_add_new_column_to_bundles_table', 279),
(592, '2024_09_17_162034_add_new_design_columns_to_blog_table', 279),
(593, '2024_09_17_165210_create_blog_featured_categories_table', 279),
(594, '2024_09_21_152945_create_related_posts_table', 279),
(595, '2024_09_23_153631_create_product_top_categories_table', 279),
(596, '2024_09_23_180136_create_product_featured_categories_table', 279),
(597, '2024_09_24_155440_edit_new_design_product_categories_table', 279),
(598, '2024_09_25_172201_create_related_products_table', 279),
(599, '2024_10_01_143915_add_new_design_to_forms_table', 279),
(600, '2024_10_19_154545_edit_forum_recommended_topics_table', 279),
(601, '2024_10_20_164749_edit_forum_topics_table', 279),
(602, '2024_10_20_174506_edit_forums_table', 279),
(603, '2024_10_21_152219_create_forum_topic_visits_table', 279),
(604, '2024_10_26_190009_edit_pages_table', 279),
(605, '2024_12_07_184626_create_time_spent_on_courses_table', 279),
(606, '2024_12_09_152127_edit_noticeboards_table', 279),
(607, '2024_12_15_133158_create_visits_logs_table', 279),
(608, '2025_01_19_151751_create_themes_table', 279),
(609, '2025_01_29_152618_create_landings_table', 279),
(610, '2025_02_03_162616_create_landing_builder_components_table', 279),
(611, '2025_02_03_164800_create_landing_components_table', 279),
(612, '2025_03_12_150728_edit_subscribe_translations_table', 279),
(613, '2025_04_17_165516_create_theme_colors_fonts_table', 279),
(614, '2025_04_20_144801_create_theme_headers_footers_table', 279),
(615, '2025_04_22_161440_create_themes_table', 279),
(616, '2025_04_28_163719_add_theme_color_mode_to_users_table', 279),
(617, '2025_05_05_163147_edit_amounts_in_discounts_table', 279),
(618, '2025_06_22_101457_add_new_column_to_blog_table', 280),
(619, '2025_06_23_163558_add_new_column_to_product_category_translations_table', 280),
(620, '2025_06_24_144119_add_new_position_to_advertising_banners_table_2', 280),
(621, '2025_06_25_164053_add_new_column_to_themes_table', 280),
(622, '2025_07_03_072243_add_icon_column_to_webinars_table', 281),
(623, '2025_07_26_143036_add_new_page_to_settings_table', 282),
(624, '2025_08_11_000001_add_negative_grade_to_quizzes_questions_table', 283),
(625, '2025_08_13_150446_add_foreign_key_author_to_blog_table', 283);

-- --------------------------------------------------------

--
-- Structure de la table `navbar_buttons`
--

CREATE TABLE `navbar_buttons` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `for_guest` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `navbar_buttons`
--

INSERT INTO `navbar_buttons` (`id`, `role_id`, `for_guest`) VALUES
(1, 1, 0),
(2, 2, 0),
(3, 4, 0),
(4, 3, 0),
(6, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `navbar_button_translations`
--

CREATE TABLE `navbar_button_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `navbar_button_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `navbar_button_translations`
--

INSERT INTO `navbar_button_translations` (`id`, `navbar_button_id`, `locale`, `title`, `url`) VALUES
(1, 1, 'en', 'Become instructor', '/become-instructor'),
(2, 1, 'ar', 'أصبح مدربا', '/become-instructor'),
(3, 1, 'es', 'Convertirse en instructora', '/become-instructor'),
(4, 2, 'en', 'Admin panel', '/admin'),
(5, 3, 'en', 'Create a new course', '/panel/webinars/new'),
(6, 3, 'es', 'Crear un nuevo curso', '/panel/webinars/new'),
(7, 3, 'ar', 'أنشئ دورة جديدة', '/panel/webinars/new'),
(8, 4, 'en', 'Create a new course', '/panel/webinars/new'),
(9, 4, 'es', 'Crear un nuevo curso', '/panel/webinars/new'),
(10, 4, 'ar', 'أنشئ دورة جديدة', '/panel/webinars/new'),
(11, 6, 'en', 'Start learning', '/login');

-- --------------------------------------------------------

--
-- Structure de la table `newsletters`
--

CREATE TABLE `newsletters` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `newsletters`
--

INSERT INTO `newsletters` (`id`, `user_id`, `email`, `created_at`) VALUES
(8, 995, 'cameronschofield@gmail.com', 1625090411),
(9, 1017, 'a.pmelaa@gmail.com', 1646389129),
(10, 996, 'robert2002@gmail.com', 1646414262),
(11, 995, 'student@demo.com', 1763764570),
(12, NULL, 'radwalhusiny@hotmail.com', 1764148183);

-- --------------------------------------------------------

--
-- Structure de la table `newsletters_history`
--

CREATE TABLE `newsletters_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `send_method` enum('send_to_all','send_to_bcc','send_to_excel') NOT NULL,
  `bcc_email` varchar(255) DEFAULT NULL,
  `email_count` int(11) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `noticeboards`
--

CREATE TABLE `noticeboards` (
  `id` int(10) UNSIGNED NOT NULL,
  `organ_id` int(10) UNSIGNED DEFAULT NULL,
  `instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('all','organizations','students','instructors','students_and_instructors') NOT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `sender_id` int(10) UNSIGNED DEFAULT NULL,
  `sender_type` enum('instructor','platform') NOT NULL DEFAULT 'instructor',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `noticeboards`
--

INSERT INTO `noticeboards` (`id`, `organ_id`, `instructor_id`, `webinar_id`, `user_id`, `type`, `sender`, `sender_id`, `sender_type`, `title`, `message`, `created_at`) VALUES
(10, NULL, NULL, NULL, NULL, 'all', 'Staff', NULL, 'instructor', 'Top summer classes', '<p>You can find top summer courses on the platform homepage and get all of them with 50% discount by using \"mysummer\" discount coupon.</p>', 1625921717),
(11, NULL, NULL, NULL, NULL, 'instructors', 'Staff', NULL, 'instructor', 'Instructor terms of services changed', '<p>Instructors terms of services changed on July 17. You can read terms on the terms page.</p>', 1625921872),
(12, NULL, NULL, NULL, NULL, 'all', 'Staff', NULL, 'instructor', 'New Year Sales Festival', '<p>Due to the New Year Festival, users who buy more than $ 200 will be given a 20% discount code.</p>', 1626132374),
(14, NULL, NULL, NULL, NULL, 'students_and_instructors', 'Staff', NULL, 'instructor', 'New Private Course Published', '<p>Dear students and instructors. Travel Management Course published privately for you. please enroll on this course<br></p>', 1765239188);

-- --------------------------------------------------------

--
-- Structure de la table `noticeboards_status`
--

CREATE TABLE `noticeboards_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `noticeboard_id` int(10) UNSIGNED NOT NULL,
  `seen_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `noticeboards_status`
--

INSERT INTO `noticeboards_status` (`id`, `user_id`, `noticeboard_id`, `seen_at`) VALUES
(7, 1015, 11, 1626204347),
(8, 995, 14, 1751705540),
(9, 1051, 12, 1763603638);

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `sender_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sender` enum('system','admin') DEFAULT 'system',
  `type` enum('single','all_users','students','instructors','organizations','group','course_students') NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `sender_id`, `group_id`, `webinar_id`, `title`, `message`, `sender`, `type`, `created_at`) VALUES
(13, 1, NULL, NULL, NULL, 'New badge awarded', '<p>You received Faithful User&nbsp;badge</p>', 'system', 'single', 1768325252),
(14, 1, NULL, NULL, NULL, 'New user registered', '<p>yuhuu registered on the platform on 20/01/2026 09:58&nbsp;as Student</p>', 'system', 'single', 1768892293),
(16, 1113, NULL, NULL, NULL, 'New user group', '<p>You added to Vip Instructors user group.</p>', 'system', 'single', 1769898928),
(17, 1113, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 3/02/2026 11:37</p>', 'system', 'single', 1770107858),
(18, 1113, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1770107858),
(19, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 4/02/2026 17:52&nbsp;as طالب</p>', 'system', 'single', 1770216754),
(20, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 4/02/2026 18:19&nbsp;as طالب</p>', 'system', 'single', 1770218382),
(22, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 4/02/2026 19:40&nbsp;as طالب</p>', 'system', 'single', 1770223211),
(24, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 4/02/2026 20:28&nbsp;as طالب</p>', 'system', 'single', 1770226140),
(25, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 4/02/2026 20:36&nbsp;as طالب</p>', 'system', 'single', 1770226567),
(26, 1, NULL, NULL, NULL, 'New item created', '<p>امجد البصيري created a new item with title الجلسة المباشرة</p>', 'system', 'single', 1770325493),
(30, 1, NULL, NULL, NULL, 'New user registered', '<p>imad eddine boushaba registered on the platform on 6/02/2026 18:43&nbsp;as مدرب</p>', 'system', 'single', 1770392613),
(32, 1, NULL, NULL, NULL, 'New user registered', '<p>BOUSHABA IMAD EDDINE registered on the platform on 6/02/2026 19:14&nbsp;as مدرب</p>', 'system', 'single', 1770394443),
(34, 1, NULL, NULL, NULL, 'New user registered', '<p>yuhuu registered on the platform on 7/02/2026 15:03&nbsp;as Student</p>', 'system', 'single', 1770465786),
(36, 1, NULL, NULL, NULL, 'New user registered', '<p>Starligt Princes registered on the platform on 11/02/2026 11:15&nbsp;as Student</p>', 'system', 'single', 1770797730),
(38, 1, NULL, NULL, NULL, 'New user registered', '<p>Starligt Princes registered on the platform on 13/02/2026 11:18&nbsp;as Student</p>', 'system', 'single', 1770970731),
(40, 1, NULL, NULL, NULL, 'New user registered', '<p>خديجه السربابكر registered on the platform on 17/02/2026 19:40&nbsp;as طالب</p>', 'system', 'single', 1771346450),
(46, 1, NULL, NULL, NULL, 'New user registered', '<p>منصة نحو القمة التعليمية registered on the platform on 2/03/2026 00:24&nbsp;as مدرب</p>', 'system', 'single', 1772400266),
(47, 1, NULL, NULL, NULL, 'New user registered', '<p>منصة نحو القمة التعليمية registered on the platform on 2/03/2026 00:36&nbsp;as مدرب</p>', 'system', 'single', 1772400999),
(48, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 2/03/2026 00:37</p>', 'system', 'single', 1772401047),
(49, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 3/03/2026 01:07</p>', 'system', 'single', 1772489223),
(50, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1772489223),
(51, 1, NULL, NULL, NULL, 'New item created', '<p>منصة نحو القمة التعليمية للخدمات الرقمية created a new item with title باقة متكاملة للتربوي العام</p>', 'system', 'single', 1772490706),
(52, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 3/03/2026 01:38</p>', 'system', 'single', 1772491082),
(53, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received Junior Vendor&nbsp;badge</p>', 'system', 'single', 1772491082),
(54, 1, NULL, NULL, NULL, 'New user registered', '<p>0553412320 registered on the platform on 3/03/2026 19:56&nbsp;as طالب</p>', 'system', 'single', 1772556972),
(56, 1, NULL, NULL, NULL, 'New course enrollment', '<p>0553412320 enrolled in باقة متكاملة للتربوي العام&nbsp;on 3/03/2026 20:00&nbsp;at مجانًا</p>', 'system', 'single', 1772557205),
(57, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received Best Seller&nbsp;badge</p>', 'system', 'single', 1772557295),
(58, 1113, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 4/03/2026 01:43</p>', 'system', 'single', 1772577837),
(59, 1113, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1772577838),
(60, 1, NULL, NULL, NULL, 'New user registered', '<p>imad eddine boushaba registered on the platform on 4/03/2026 03:50&nbsp;as طالب</p>', 'system', 'single', 1772585434),
(62, 1, NULL, NULL, NULL, 'New user registered', '<p>imad eddine boushaba registered on the platform on 4/03/2026 04:32&nbsp;as طالب</p>', 'system', 'single', 1772587932),
(64, 1, NULL, NULL, NULL, 'New user registered', '<p>imad eddine boushaba registered on the platform on 4/03/2026 04:36&nbsp;as طالب</p>', 'system', 'single', 1772588190),
(66, 1, NULL, NULL, NULL, 'New user registered', '<p>imad eddine boushaba registered on the platform on 4/03/2026 05:26&nbsp;as طالب</p>', 'system', 'single', 1772591164),
(67, 1134, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 4/03/2026 05:26</p>', 'system', 'single', 1772591182),
(68, 1, NULL, NULL, NULL, 'New user registered', '<p>Starligt Princes registered on the platform on 6/03/2026 12:34&nbsp;as طالب</p>', 'system', 'single', 1772789686),
(69, 1135, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 6/03/2026 12:35</p>', 'system', 'single', 1772789740),
(70, 1, NULL, NULL, NULL, 'New item created', '<p>منصة نحو القمة التعليمية للخدمات الرقمية created a new item with title دورة الإدارة الصفية</p>', 'system', 'single', 1772940544),
(71, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 20&nbsp;for شارة جديدة&nbsp;on 8/03/2026 06:29</p>', 'system', 'single', 1772940550),
(72, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received Senior Vendor&nbsp;badge</p>', 'system', 'single', 1772940551),
(73, 1, NULL, NULL, NULL, 'New item created', '<p>منصة نحو القمة التعليمية للخدمات الرقمية created a new item with title دورة الإدارة الصفية</p>', 'system', 'single', 1772940813),
(74, 1, NULL, NULL, NULL, 'New user registered', '<p>Ibrahim Asiry registered on the platform on 8/03/2026 14:04&nbsp;as مدرب</p>', 'system', 'single', 1772967867),
(75, 1136, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 8/03/2026 14:05</p>', 'system', 'single', 1772967925),
(76, 1, NULL, NULL, NULL, 'New item created', '<p>Ibrahim Asiry created a new item with title المدارس الداخلية</p>', 'system', 'single', 1772971111),
(77, 1136, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 8/03/2026 14:59</p>', 'system', 'single', 1772971140),
(78, 1136, NULL, NULL, NULL, 'New badge awarded', '<p>You received Junior Vendor&nbsp;badge</p>', 'system', 'single', 1772971141),
(79, 1136, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 9/03/2026 03:48</p>', 'system', 'single', 1773017337),
(80, 1136, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1773017338),
(81, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 30&nbsp;for شارة جديدة&nbsp;on 12/03/2026 18:11</p>', 'system', 'single', 1773328293),
(82, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received Expert Vendor&nbsp;badge</p>', 'system', 'single', 1773328293),
(83, 1, NULL, NULL, NULL, 'New user registered', '<p>Siemat Learning registered on the platform on 29/03/2026 14:10&nbsp;as مدرب</p>', 'system', 'single', 1774782647),
(84, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 29/03/2026 14:11</p>', 'system', 'single', 1774782685),
(85, 1051, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 29/03/2026 19:20</p>', 'system', 'single', 1774808404),
(86, 1051, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1774808405),
(87, 1, NULL, NULL, NULL, 'New user registered', '<p>Dema Asiri registered on the platform on 29/03/2026 21:20&nbsp;as مدرب</p>', 'system', 'single', 1774808406),
(88, 1138, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 29/03/2026 21:20</p>', 'system', 'single', 1774808438),
(89, 1070, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1774808475),
(90, 1138, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 30/03/2026 10:43</p>', 'system', 'single', 1774856612),
(91, 1138, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1774856613),
(92, 1, NULL, NULL, NULL, 'New item created', '<p>Dema Asiri created a new item with title الاستشارات</p>', 'system', 'single', 1774857669),
(93, 1, NULL, NULL, NULL, 'New item created', '<p>Siemat Learning created a new item with title استشارات</p>', 'system', 'single', 1774858394),
(94, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 30/03/2026 11:29</p>', 'system', 'single', 1774859343),
(95, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1774859343),
(96, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 30/03/2026 11:29</p>', 'system', 'single', 1774859343),
(97, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received Junior Vendor&nbsp;badge</p>', 'system', 'single', 1774859344),
(98, 1, NULL, NULL, NULL, 'New user registered', '<p>rema asiri registered on the platform on 30/03/2026 11:35&nbsp;as طالب</p>', 'system', 'single', 1774859760),
(99, 1139, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 30/03/2026 11:36</p>', 'system', 'single', 1774859795),
(100, 1, NULL, NULL, NULL, 'New course enrollment', '<p>rema asiri enrolled in استشارات&nbsp;on 30/03/2026 11:37&nbsp;at مجانًا</p>', 'system', 'single', 1774859830),
(101, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received Best Seller&nbsp;badge</p>', 'system', 'single', 1774859832),
(102, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 20&nbsp;for شارة جديدة&nbsp;on 30/03/2026 11:44</p>', 'system', 'single', 1774860247),
(103, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received Senior Vendor&nbsp;badge</p>', 'system', 'single', 1774860247),
(104, 1, NULL, NULL, NULL, 'New user registered', '<p>amged albasery registered on the platform on 1/04/2026 08:31&nbsp;as طالب</p>', 'system', 'single', 1775021515),
(105, 1140, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for التسجيل&nbsp;on 1/04/2026 08:32</p>', 'system', 'single', 1775021573),
(106, 1138, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 3/04/2026 01:22</p>', 'system', 'single', 1775168572),
(107, 1138, NULL, NULL, NULL, 'New badge awarded', '<p>You received Junior Vendor&nbsp;badge</p>', 'system', 'single', 1775168572),
(108, 1129, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 11/04/2026 14:17</p>', 'system', 'single', 1775906272),
(109, 1129, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1775906273),
(110, 1137, NULL, NULL, NULL, 'Course approve', '<p>Your course with title التواصل الفعال approved</p>', 'system', 'single', 1776097230),
(111, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 50&nbsp;for Course Published&nbsp;on 13/04/2026 12:20</p>', 'system', 'single', 1776097231),
(112, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 30&nbsp;for New Badge Earned&nbsp;on 13/04/2026 12:20</p>', 'system', 'single', 1776097258),
(113, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received Expert Vendor&nbsp;badge</p>', 'system', 'single', 1776097258),
(114, 1137, NULL, NULL, NULL, 'Course approve', '<p>Your course with title التواصل الفعال approved</p>', 'system', 'single', 1776097563),
(115, 1137, NULL, NULL, NULL, 'Course rejection', '<p>Your course with title التواصل الفعال rejected</p>', 'system', 'single', 1776097620),
(116, 1136, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 15/04/2026 19:57</p>', 'system', 'single', 1776272231),
(117, 1136, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1776272231),
(118, 1140, NULL, NULL, NULL, 'New reward point', '<p>You collected 5&nbsp;for شارة جديدة&nbsp;on 19/04/2026 13:11</p>', 'system', 'single', 1776618713),
(119, 1140, NULL, NULL, NULL, 'New badge awarded', '<p>You received New User&nbsp;badge</p>', 'system', 'single', 1776618714),
(120, 1137, NULL, NULL, NULL, 'Course approve', '<p>Your course with title التسويق الرقمي approved</p>', 'system', 'single', 1777144835),
(121, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 50&nbsp;for نشر دورة&nbsp;on 25/04/2026 15:20</p>', 'system', 'single', 1777144836),
(122, 1137, NULL, NULL, NULL, 'Course rejection', '<p>Your course with title التسويق الرقمي rejected</p>', 'system', 'single', 1777145047),
(123, 1137, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 29/04/2026 13:32</p>', 'system', 'single', 1777458776),
(124, 1137, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1777458777),
(125, 1138, NULL, NULL, NULL, 'New reward point', '<p>You collected 10&nbsp;for شارة جديدة&nbsp;on 29/04/2026 22:20</p>', 'system', 'single', 1777490429),
(126, 1138, NULL, NULL, NULL, 'New badge awarded', '<p>You received Loyal User&nbsp;badge</p>', 'system', 'single', 1777490430);

-- --------------------------------------------------------

--
-- Structure de la table `notifications_status`
--

CREATE TABLE `notifications_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `notification_id` int(10) UNSIGNED NOT NULL,
  `seen_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `notifications_status`
--

INSERT INTO `notifications_status` (`id`, `user_id`, `notification_id`, `seen_at`) VALUES
(1, 1, 34, 1771146958),
(2, 1, 38, 1771146968),
(3, 1, 36, 1771146963),
(4, 1, 25, 1771146791),
(5, 1, 24, 1771146821),
(6, 1, 22, 1771146824),
(7, 1, 20, 1771146828),
(8, 1, 26, 1771146931),
(9, 1, 30, 1771146938),
(10, 1, 32, 1771146945),
(11, 1129, 49, 1772489365),
(12, 1129, 50, 1772489369),
(13, 1129, 48, 1772489370),
(14, 1138, 88, 1774808997),
(15, 1129, 81, 1775022888);

-- --------------------------------------------------------

--
-- Structure de la table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `template` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `title`, `template`) VALUES
(2, 'New badge awarded', '<p>You received [u.b.title]&nbsp;badge</p>'),
(3, 'User group change', '<p>Your user group changed to [u.g.title]</p>'),
(4, 'Course created', '<p>You created a new course&nbsp;with title [c.title]</p>'),
(5, 'Course approve', '<p>Your course with title [c.title] approved</p>'),
(6, 'Course rejection', '<p>Your course with title [c.title] rejected</p>'),
(7, 'New comment', '<p>[u.name] left a new comment for [c.title] course</p>'),
(8, 'New support message', '<p>[u.name] sent a new support message for [c.title]&nbsp;course</p>'),
(9, 'Support message replied', '<p>New reply in [c.title] course support message&nbsp;</p>'),
(10, 'New support for admin', '<p>New support ticket received with title [s.t.title]</p>'),
(11, 'Support ticket replied for admin', '<p>New reply in support ticket with title&nbsp;[s.t.title]</p>'),
(12, 'New financial document', '<p>&nbsp;New financial document submitted for [c.title] with type [f.d.type] with amount [amount]</p>'),
(13, 'Payout request', '<p>New payout request submitted with amount [payout.amount]</p>'),
(14, 'Payout processed', 'Your payout request with amount [payout.amount]&nbsp;&nbsp;proceed to [payout.account]'),
(15, 'New sales', '<p>Congratulations! New sale for [c.title]</p>'),
(16, 'New purchase', '<p>Congratulations! New purchase for [c.title]</p>'),
(17, 'Rating (Feedback)', '<p>New [rate.count] star feedback submitted for [c.title] by [student.name]</p>'),
(18, 'Offline payment request', '<p>The offline payment request with the amount [amount] submitted. It is under review and you will get informed by email.</p>'),
(19, 'Offline payment approved', '<p>Offline payment request with amount [amount]&nbsp;approved</p>'),
(20, 'Offline payment rejected', '<p>Offline payment request with amount [amount]&nbsp;rejected</p>'),
(21, 'New subscription plan', '<p>[s.p.name] subscription plan activated by [u.name]</p>'),
(22, 'New meeting', '<p>New meeting booked by [u.name] for [time.date] at [amount]</p>'),
(23, 'New meeting link', '<p>[instructor.name] defined the meeting link and you can join the meeting on [time.date] using the following link: [link]</p>'),
(24, 'Meeting reminder', '<p>You have a meeting on [time.date] please remember to join it on time.</p>'),
(25, 'Meeting finished', '<p>Your meeting finished with the following information</p><p>Instructor: [instructor.name]</p><p>Student: [student.name]</p><p>Meeting time: [time.date]</p>'),
(26, 'New contact message', '<p>New contact message received from [u.name] with title [c.u.title]</p><p><br></p>'),
(27, 'Live class reminder', '<p>Your live class session of the [c.title] will be conducted on [time.date]&nbsp;</p>'),
(28, 'Promotion plan', '<p>[p.p.name] promotion plan activated for [c.title] course</p>'),
(29, 'Promotion plan for admin', '<p>[p.p.name] promotion plan request submitted for [c.title]</p>'),
(30, 'Certificate achieved', '<p>You achieved a certificate for [c.title] course</p>'),
(31, 'Waiting quiz (Instructor)', '<p>[student.name] is waiting for [q.title] quiz result of the [c.title] course. Please review the quiz and submit the grade.</p>'),
(32, 'Waiting quiz result', '<p>Your [q.title] quiz of the [c.title] course rated by the instructor, and your quiz status is [q.result]</p>'),
(33, 'Product new sale', '<p>New sale for [p.title] product</p>'),
(34, 'Product new purchase', '<p>New purchase for [p.title] product</p>'),
(35, 'Product new comment', '<p>[u.name] left a new comment for [p.title] product</p>'),
(36, 'Product tracking code', '<p>[u.name] submitted tracking code for [p.title]</p>'),
(37, 'Product rating (Feedback)', '<p>[u.name] submitted a new [rate.count] stars rating for [p.title] product</p>'),
(38, 'Product received', '<p>[u.name] received [p.title] product.</p>'),
(39, 'Product out of stock', '<p>Your product [p.title] is out of stock</p>'),
(40, 'Assignment submission (Instructor)', '<p>[student.name] submitted an assignment for [c.title] course</p>'),
(41, 'Instructor message in assignment', '<p>[instructor.name] sent a message for [c.title] assignment</p>'),
(42, 'Assignment grade', '<p>Your assignment of [c.title] rated by [instructor.name] . Your grade is [assignment_grade]</p>'),
(43, 'User access to content', '<p>Your access to content is enabled.</p>'),
(44, 'Send post in topic', '<p>[u.name] sent a post in your topic with title [topic_title]&nbsp;</p>'),
(45, 'Blog post published (Instructor)', '<p>Your blog post with title [blog_title] published.</p>'),
(46, 'New comment for blog post (Instructor)', '<p>[u.name] leaft a new comment for your blog with title [blog_title]</p>'),
(47, 'Meeting reminder', '<p>You have a meeting on [time.date] with [instructor.name]</p>'),
(48, 'Subscription expiry reminder', '<p>Your subscription expires on [time.date]&nbsp;</p>'),
(49, 'Course forum new question', '<p>[u.name] registered a question in the [c.title]&nbsp;course forum.</p>'),
(50, 'New answer in course forum', '<p>[u.name] submitted an answer in the [c.title]&nbsp;course forum.</p>'),
(52, 'You received a gift', '<p>[u.name]&nbsp;sent you [gift_title] which is a [gift_type]&nbsp;as a gift with the following message: [gift_message]</p>'),
(53, 'Gift submitted successfully', '<p>Your gift request for [u.name]&nbsp;submitted successfully on [time.date]&nbsp;and the [gift_title] which is a [gift_type]&nbsp;at [amount]&nbsp;will be sent to the recipient on [time.date.2]&nbsp;with the following message: [gift_message]</p>'),
(54, 'Gift sent to recipient', '<p>We sent the gift request that you submitted on [time.date]&nbsp;for [u.name]. We sent [gift_title]&nbsp;which is a [gift_type]&nbsp;to the recipient with the following message on [time.date] . [gift_message]</p>'),
(55, 'Gift request submitted (Admin)', '<p>[u.name.2] submitted a gift request for [gift_title]&nbsp;which is a [gift_type]&nbsp;for [u.name]&nbsp;on [time.date]&nbsp;at [amount]&nbsp;and it will be sent to the recipient on [time.date.2]</p>'),
(56, 'Gift sent to recipient (Admin)', '<p>The system sent a [gift_title]&nbsp;which is a [gift_type]&nbsp;to [u.name]&nbsp;on [time.date.2]&nbsp;successfully. [u.name.2]&nbsp;submitted this request on [time.date]&nbsp;at [amount].</p>'),
(57, 'You have an upcoming installment', '<p>You have an installment for [installment_title] at [amount]&nbsp;on due date [time.date]</p>'),
(58, 'You have an unpaid installment', '<p>You have an installment for [installment_title]&nbsp;at [amount]&nbsp;for today. Please pay it as soon as possible.</p>'),
(59, 'You have an overdue installment', '<p>You have an overdue installment for [installment_title]&nbsp;at [amount]&nbsp;on due date [time.date].</p>'),
(60, 'Installment verification request approved', '<p>Your verification request for [installment_title]&nbsp;approved.</p>'),
(61, 'Installment verification request rejected', '<p>Your verification request for [installment_title]&nbsp;rejected.</p>'),
(62, 'Installment paid successfully', '<p>You paid [amount]&nbsp;for [installment_title]&nbsp;with due date [time.date]&nbsp;successfully.</p>'),
(63, 'Installment paid successfully (Admin)', '<p>[u.name] paid [amount]&nbsp;for [installment_title]&nbsp;with the due date [time.date]&nbsp;successfully.</p>'),
(64, 'Installment upfront amount paid', '<p>You paid [amount] as upfront for&nbsp;[installment_title].</p>'),
(65, 'Installment verification request submitted', '<p>We received your verification request for [installment_title]&nbsp;on [time.date]&nbsp;and the result will be informed to you soon.</p>'),
(66, 'Installment verification request submitted (Admin)', '<p>[u.name] submitted a verification request for [installment_title]&nbsp;on [time.date].</p>'),
(67, 'Installment request submitted', '<p>Your installment for [installment_title]&nbsp;at [amount]&nbsp;submitted successfully.</p>'),
(68, 'Installment request submitted (Admin)', '<p>[u.name] submitted an installment request for [installment_title]&nbsp;at [amount].</p>'),
(69, 'New upcoming course submitted', '<p>Your upcoming course [item_title]&nbsp;submitted successfully.</p>'),
(70, 'New upcoming course submitted (Admin)', '<p>[u.name] submitted an upcoming course with title [item_title].</p>'),
(71, 'Upcoming course approved', '<p>Your upcoming course [item_title]&nbsp;approved.</p>'),
(72, 'Upcoming course rejected', '<p>Your upcoming course [item_title] rejected.</p>'),
(73, 'Your upcoming course published', '<p>Your upcoming course [item_title]&nbsp;published.</p>'),
(74, 'Your upcoming course followed', '<p>[u.name] followed your upcoming course [item_title]</p>'),
(75, 'Upcoming course published and is accessible', '<p>The upcoming course [item_title] published now and you can check it.</p>'),
(76, 'You got cashback!', '<p>You got [amount]&nbsp;as cashback and this amount added to your account.</p>'),
(77, 'User got cashback (Admin)', '<p>[u.name] got [amount] as cashback and this amount charged to their account.</p>'),
(78, 'Bundle submitted successfully', '<p>Your bundle with the title [item_title]&nbsp;submitted successfully.</p>'),
(79, 'Bundle submitted (Admin)', '<p>[u.name] submitted a bundle with the title [item_title].</p>'),
(80, 'Bundle published successfully', '<p>Your bundle with title [item_title]&nbsp;published successfully.</p>'),
(81, 'Bundle rejected', '<p>Your bundle with title [item_title]&nbsp;rejected.</p>'),
(82, 'New review for your bundle', '<p>[u.name] submitted a [rate.count] star rating for your bundle [item_title].</p>'),
(83, 'You got registration bonus', '<p>You got [amount]&nbsp;as registration bonus.</p>'),
(84, 'Registration bonus unlocked', '<p>Your registration bonus [amount]&nbsp;unlocked. Happy with spending...</p>'),
(85, 'Registration bonus unlocked (Admin)', '<p>The registration bonus [amount] unlocked for [u.name].</p>'),
(86, 'SaaS package activated successfully', '<p>[item_title] activated for you until [time.date].</p>'),
(87, 'SaaS package activated (Admin)', '<p>[u.name] activated [item_title]&nbsp;registration plan until [time.date].</p>'),
(88, 'Your contact message submitted', '<p>We received your contact message with the subject [c.u.title]&nbsp;on [time.date].</p>'),
(89, 'New contact message received', '<p>New contact message received from [u.name] with subject [c.u.title] with message [c.u.message]</p>'),
(90, 'You submitted to waitlist', '<p>You submitted to [c.title]&nbsp;waitlist.</p>'),
(91, 'User submitted in waitlist', '<p>[u.name] submitted to [c.title]&nbsp;waitlist.</p>'),
(92, 'New user registered with your affiliate code', '<p>[u.name] registered with your affiliate code on [time.date].</p>'),
(93, 'New quiz added to course', '<p>New quiz with the title [q.title]&nbsp;added to the course [c.title].</p>'),
(94, 'New reward point', '<p>You collected [points]&nbsp;for [item_title]&nbsp;on [time.date]</p>'),
(95, 'New notice', '<p>You got a new notice with title [c.title]&nbsp;on [time.date]</p>'),
(96, 'New course notice', '<p>You got a new course notice for [c.title]&nbsp;with title [item_title]</p>'),
(97, 'Your user role changed', '<p>Your user role changed to [u.role]</p>'),
(98, 'New user group', '<p>You added to [u.g.title] user group.</p>'),
(99, 'Become instructor/organization request approved', '<p>Your become instructor/organization request is approved.</p>'),
(100, 'Become instructor/organization request rejected', '<p>Your instructor/organization request rejected</p>'),
(101, 'New question in course forum', '<p>[u.name] posted a new question in [c.title] forum.</p>'),
(102, 'New answer in course forum', '<p>[u.name] posted a new answer in [c.title] forum.</p>'),
(103, 'Live meeting created', '<p>[instructor.name] started a new live meeting. Please login to your account and join it now...</p>'),
(104, 'New user registered', '<p>[u.name] registered on the platform on [time.date]&nbsp;as [u.role]</p>'),
(105, 'New instructor/organization request', '<p>[u.name] submitted a user role change request on [time.date]</p>'),
(106, 'New course enrollment', '<p>[u.name] enrolled in [c.title]&nbsp;on [time.date]&nbsp;at [amount]</p>'),
(107, 'New forum topic', '<p>[u.name] created a new topic with title [topic_title]&nbsp;in [forum_title]&nbsp;forum.</p>'),
(108, 'New report', '<p>[u.name] reported a content for revising.</p>'),
(109, 'New item created', '<p>[u.name] created a new item with title [item_title]</p>'),
(110, 'New store order', '<p>New store order received from [u.name]&nbsp;at [amount]</p>'),
(111, 'Subscription plan activated', '<p>[u.name] purchased [s.p.name]&nbsp;at [amount]</p>'),
(112, 'Content review request', '<p>[u.name] sent a review request for [item_title]</p>'),
(113, 'New user blog post', '<p>[u.name] submitted a blog article with title [blog_title]</p>'),
(114, 'New item review (Rating)', '<p>[u.name] submitted a new rate for [item_title]</p>'),
(115, 'New organization user', '<p>[organization.name] submitted [u.name]&nbsp;as new [u.role]</p>'),
(116, 'User wallet charge', '<p>[u.name] charged their wallet for [amount]</p>'),
(117, 'New payout request', '<p>[u.name] submitted a new payout request at [amount]</p>'),
(118, 'New offline payment request', '<p>[u.name] submitted a new offline payment request at [amount]</p>'),
(119, 'Content access approval', '<p>Your content access request approved. You can access all courses now...</p>'),
(120, 'Form submission by user', '<p>[u.name] submitted form [form_title]</p>'),
(121, 'Cart reminder', '<div>We\'re excited to invite you to complete your purchase with us! Enjoy exclusive benefits and offers by finalizing your order now.</div>'),
(122, 'Complete your purchase today with discount!', '<div>Here\'s an exclusive [discount_amount] discount coupon to encourage you to finalize your purchase with us. Discount Code : [discount_code]</div>');

-- --------------------------------------------------------

--
-- Structure de la table `offline_banks`
--

CREATE TABLE `offline_banks` (
  `id` int(10) UNSIGNED NOT NULL,
  `logo` varchar(255) NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offline_bank_specifications`
--

CREATE TABLE `offline_bank_specifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `offline_bank_id` int(10) UNSIGNED NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offline_bank_specification_translations`
--

CREATE TABLE `offline_bank_specification_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `offline_bank_specification_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offline_bank_translations`
--

CREATE TABLE `offline_bank_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `offline_bank_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offline_payments`
--

CREATE TABLE `offline_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `offline_bank_id` int(10) UNSIGNED DEFAULT NULL,
  `reference_number` varchar(64) NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` enum('waiting','approved','reject') NOT NULL,
  `pay_date` varchar(64) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','paying','paid','fail') NOT NULL,
  `payment_method` enum('credit','payment_channel') DEFAULT NULL,
  `is_charge_account` tinyint(1) NOT NULL DEFAULT 0,
  `amount` double(15,2) UNSIGNED NOT NULL,
  `tax` decimal(13,2) UNSIGNED DEFAULT NULL,
  `total_discount` decimal(13,2) UNSIGNED DEFAULT NULL,
  `total_amount` decimal(13,2) UNSIGNED DEFAULT NULL,
  `product_delivery_fee` decimal(13,2) UNSIGNED DEFAULT NULL,
  `reference_id` text DEFAULT NULL,
  `payment_data` text DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `payment_method`, `is_charge_account`, `amount`, `tax`, `total_discount`, `total_amount`, `product_delivery_fee`, `reference_id`, `payment_data`, `created_at`) VALUES
(34, 1140, 'fail', 'payment_channel', 0, 100.00, 10.00, NULL, 110.00, NULL, NULL, NULL, 1776618419),
(39, 1140, 'pending', 'payment_channel', 0, 1.00, 0.10, 0.00, 1.10, 0.00, NULL, NULL, 1776618833),
(40, 1138, 'pending', 'payment_channel', 0, 1.00, 0.10, 0.00, 1.10, 0.00, NULL, NULL, 1776664739);

-- --------------------------------------------------------

--
-- Structure de la table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `promotion_id` int(10) UNSIGNED DEFAULT NULL,
  `gift_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `product_order_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_payment_id` int(10) UNSIGNED DEFAULT NULL,
  `reserve_meeting_id` int(10) UNSIGNED DEFAULT NULL,
  `ticket_id` int(10) UNSIGNED DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `become_instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(15,2) UNSIGNED DEFAULT NULL,
  `tax` int(10) UNSIGNED DEFAULT NULL,
  `tax_price` double(15,2) UNSIGNED DEFAULT NULL,
  `commission` int(10) UNSIGNED DEFAULT NULL,
  `commission_price` double(15,2) UNSIGNED DEFAULT NULL,
  `discount` double(15,2) UNSIGNED DEFAULT NULL,
  `total_amount` double(15,2) UNSIGNED DEFAULT NULL,
  `product_delivery_fee` double(15,2) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `order_items`
--

INSERT INTO `order_items` (`id`, `user_id`, `order_id`, `webinar_id`, `bundle_id`, `subscribe_id`, `promotion_id`, `gift_id`, `registration_package_id`, `product_id`, `product_order_id`, `installment_payment_id`, `reserve_meeting_id`, `ticket_id`, `discount_id`, `become_instructor_id`, `amount`, `tax`, `tax_price`, `commission`, `commission_price`, `discount`, `total_amount`, `product_delivery_fee`, `created_at`) VALUES
(34, 1140, 34, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100.00, 10, 10.00, 0, 0.00, NULL, 110.00, NULL, 1776618419),
(39, 1140, 39, 2070, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1.00, 10, 0.10, 20, 0.20, 0.00, 1.10, 0.00, 1776618833),
(40, 1138, 40, 2069, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1.00, 10, 0.10, 20, 0.20, 0.00, 1.10, 0.00, 1776664739);

-- --------------------------------------------------------

--
-- Structure de la table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `link` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `header_icon` varchar(255) DEFAULT NULL,
  `robot` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('publish','draft') NOT NULL DEFAULT 'draft',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pages`
--

INSERT INTO `pages` (`id`, `link`, `name`, `icon`, `cover`, `header_icon`, `robot`, `status`, `created_at`) VALUES
(3, '/about', 'About', '/store/1/202511171925140000.png', '/store/1109/مدربي سمات.png', '/store/1109/6.jpeg', 1, 'publish', 1774780146),
(5, '/terms', 'Terms & rules', '/store/1/default_images/16.jpg', '/store/1/default_images/16.jpg', '/store/1/default_images/16.jpg', 1, 'publish', 1763488472),
(6, '/reward_points_system', 'Reward Points System', NULL, NULL, NULL, 1, 'publish', 1646398467);

-- --------------------------------------------------------

--
-- Structure de la table `page_translations`
--

CREATE TABLE `page_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `page_translations`
--

INSERT INTO `page_translations` (`id`, `page_id`, `locale`, `title`, `subtitle`, `seo_description`, `content`) VALUES
(1, 3, 'en', 'About SIMTPLUS', 'SIMTPLUS', 'Rocket LMS is an online course marketplace with a pile of features that helps you to run your online education business easily.', '<font face=\"main-font-family\"><b>All sectors and their affiliated facilities in the Kingdom are witnessing increasing growth and rapid developments to meet the needs and aspirations of service recipients. All sectors strive to raise performance levels within their facilities and improve the quality of services provided to meet these needs and ensure the achievement of the Kingdom\'s Vision 2030 goals. In light of these rapid developments and increasing needs, it is essential to study the current state of these services and activities, identify strengths and weaknesses, prioritize needs, and then plan these programs and activities in line with the priorities and challenges of the next phase. There is also a pressing need to ensure the highest levels of harmony and coordination among service providers and guarantee their availability and optimal distribution, thereby enhancing accessibility and increasing user satisfaction. For this purpose, it has become essential to study the training and educational needs of these facilities and ensure the availability of the necessary knowledge, skills, and capabilities to achieve the goals of the next phase and reach institutional excellence.</b></font>'),
(2, 5, 'en', 'Terms of Service', NULL, 'Our mission is to improve lives through learning. We enable anyone anywhere to create and share educational content (instructors) and to access that educational content to learn.', '<p><b>Note: This is just demo data.</b></p><p>Our mission is to improve lives through learning. We enable anyone anywhere to create and share educational content (instructors) and to access that educational content to learn (students). We consider our marketplace model the best way to offer valuable educational content to our users. We need rules to keep our platform and services safe for you, us, and our student and instructor community. These Terms apply to all your activities on the Udemy website, the Udemy mobile applications, our TV applications, our APIs, and other related services (“<b>Services</b>”).</p><p>If you publish content on our platform, you must also agree to the Instructor Terms. We also provide details regarding our processing of the personal data of our students and instructors in our Privacy Policy. If you are using our platform for Business as part of your organization’s Udemy for Business subscription, you should consult our Udemy for Business Privacy Statement.</p><p style=\"text-align: center; \"><img src=\"/store/1/default_images/blogs/home2.png\" style=\"width: 954px;\"><br></p><p>You need an account for most activities on our platform, including to <b>purchase</b> and access content or to <b>submit content for publication</b>. When setting up and maintaining your account, you must provide and continue to provide accurate and complete information, including a valid email address. You have complete responsibility for your account and everything that happens on your account, including for any harm or damage (to us or anyone else) caused by someone using your account without your permission. This means you need to be careful with your password. You may not transfer your account to someone else or use someone else’s account. If you contact us to request access to an account, we will not grant you such access unless you can provide us with the information that we need to prove you are the owner of that account. In the event of the death of a user, the account of that user will be closed.</p>'),
(3, 6, 'en', 'Reward Points System', NULL, 'Rocket LMS Reward Points System is a Complete Loyalty Reward Points System and the most comprehensive Points and Rewards Plugin.', '<p><img src=\"/store/1/default_images/Reward Points System.jpg\" style=\"width: 800px;\"><br></p><p><b>Rocket LMS&nbsp;Reward Points System is a Complete Loyalty Reward Points System and the most comprehensive Points and Rewards Plugin. Reward your Customers using Reward Points for Product Purchase, Writing Reviews, Sign up, Referrals, etc. The earned Reward Points can be redeemed for future purchases.&nbsp;</b></p>'),
(4, 5, 'es', 'Términos de servicio', NULL, 'Nuestra misión es mejorar vidas a través del aprendizaje. Permitimos que cualquier persona en cualquier lugar pueda crear y compartir contenido educativo (instructores) y acceder a ese contenido educativo para aprender.', '<p>Nota: Estos son solo datos de demostración.</p><p><br></p><p>Nuestra misión es mejorar vidas a través del aprendizaje. Permitimos que cualquier persona en cualquier lugar pueda crear y compartir contenido educativo (instructores) y acceder a ese contenido educativo para aprender (estudiantes). Consideramos nuestro modelo de mercado la mejor manera de ofrecer contenido educativo valioso a nuestros usuarios. Necesitamos reglas para mantener nuestra plataforma y servicios seguros para usted, nosotros y nuestra comunidad de estudiantes e instructores. Estos Términos se aplican a todas sus actividades en el sitio web de Udemy, las aplicaciones móviles de Udemy, nuestras aplicaciones de TV, nuestras API y otros servicios relacionados (\"Servicios\").</p><p><br></p><p>Si publica contenido en nuestra plataforma, también debe aceptar los Términos del instructor. También proporcionamos detalles sobre nuestro procesamiento de los datos personales de nuestros estudiantes e instructores en nuestra Política de privacidad. Si utiliza nuestra plataforma para empresas como parte de la suscripción a Udemy for Business de su organización, debe consultar nuestra Declaración de privacidad de Udemy for Business.</p><p><br></p><p><br></p><p><br></p><p>Necesita una cuenta para la mayoría de las actividades en nuestra plataforma, incluso para comprar y acceder a contenido o para enviar contenido para su publicación. Al configurar y mantener su cuenta, debe proporcionar y continuar proporcionando información precisa y completa, incluida una dirección de correo electrónico válida. Usted es completamente responsable de su cuenta y de todo lo que sucede en ella, incluido cualquier daño o perjuicio (a nosotros o a cualquier otra persona) causado por alguien que usa su cuenta sin su permiso. Esto significa que debe tener cuidado con su contraseña. No puede transferir su cuenta a otra persona ni usar la cuenta de otra persona. Si se comunica con nosotros para solicitar acceso a una cuenta, no le otorgaremos dicho acceso a menos que pueda proporcionarnos la información que necesitamos para demostrar que es el propietario de esa cuenta. En caso de fallecimiento de un usuario, la cuenta de ese usuario se cerrará.</p>'),
(5, 5, 'ar', 'شروط الخدمة', 'شروط الخدمة', 'مهمتنا هي تحسين الحياة من خلال التعلم. نحن نمكن أي شخص في أي مكان من إنشاء ومشاركة المحتوى التعليمي (المدربين) والوصول إلى هذا المحتوى التعليمي للتعلم.', '<p style=\"direction: rtl; text-align: right;\">ملاحظة: هذه مجرد بيانات تجريبية.</p><p style=\"direction: rtl; text-align: right;\">مهمتنا هي تحسين الحياة من خلال التعلم. نحن نمكن أي شخص في أي مكان من إنشاء ومشاركة المحتوى التعليمي (المدربين) والوصول إلى هذا المحتوى التعليمي للتعلم (الطلاب). نحن نعتبر نموذج السوق الخاص بنا هو أفضل طريقة لتقديم محتوى تعليمي قيم لمستخدمينا. نحن بحاجة إلى قواعد للحفاظ على نظامنا الأساسي وخدماتنا آمنة لك ولنا ومجتمع الطلاب والمدرسين لدينا. تنطبق هذه الشروط على جميع أنشطتك على موقع Udemy على الويب ، وتطبيقات Udemy للهاتف المحمول ، وتطبيقات التلفزيون لدينا ، وواجهات برمجة التطبيقات الخاصة بنا ، والخدمات الأخرى ذات الصلة (\"الخدمات\").</p><p style=\"direction: rtl; text-align: right;\">إذا قمت بنشر محتوى على نظامنا الأساسي ، فيجب عليك أيضًا الموافقة على شروط المدرب. نقدم أيضًا تفاصيل تتعلق بمعالجتنا للبيانات الشخصية لطلابنا ومعلمينا في سياسة الخصوصية الخاصة بنا. إذا كنت تستخدم منصتنا للأعمال كجزء من اشتراك Udemy for Business الخاص بمؤسستك ، فيجب عليك الرجوع إلى بيان خصوصية Udemy for Business.</p><p style=\"direction: rtl; text-align: right;\">أنت بحاجة إلى حساب لمعظم الأنشطة على نظامنا الأساسي ، بما في ذلك شراء المحتوى والوصول إليه أو إرسال المحتوى للنشر. عند إعداد حسابك وصيانته ، يجب عليك تقديم معلومات دقيقة وكاملة والاستمرار في تقديمها ، بما في ذلك عنوان بريد إلكتروني صالح. أنت تتحمل المسؤولية الكاملة عن حسابك وكل ما يحدث على حسابك ، بما في ذلك أي ضرر أو ضرر (لنا أو لأي شخص آخر) ناجم عن شخص يستخدم حسابك دون إذنك. هذا يعني أنك بحاجة إلى توخي الحذر بشأن كلمة المرور الخاصة بك. لا يجوز لك نقل حسابك إلى شخص آخر أو استخدام حساب شخص آخر. إذا اتصلت بنا لطلب الوصول إلى حساب ، فلن نمنحك هذا الوصول ما لم تتمكن من تزويدنا بالمعلومات التي نحتاجها لإثبات أنك مالك هذا الحساب. في حالة وفاة المستخدم ، سيتم إغلاق حساب هذا المستخدم.</p>'),
(6, 3, 'ar', 'منصة سمات بلس', 'الذراع التدريبي لشركة سمات التعلم', NULL, '<h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\">من نحن</h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\" style=\"text-align: justify; \"><span style=\"font-weight: normal;\">منصة سمات بلس هي منصة تدريب إلكترونية سعودية وطنية تهدف إلى تقديم برامج تعليمية وتدريبية عالية الجودة تواكب متطلبات سوق العمل المتسارعة. نعمل على تمكين الأفراد والمهنيين من تطوير مهاراتهم وبناء قدراتهم عبر محتوى تدريبي حديث، يقدمه خبراء ومتخصصون في مجالات متعددة.</span></h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\" style=\"text-align: justify; \"><span style=\"font-weight: normal;\">نسعى في سمات بلس إلى أن تكون المعرفة متاحة وسهلة الوصول، وأن نساهم في بناء مجتمع معرفي قادر على الابتكار والمنافسة محليًا وعالميًا.</span></h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\">رؤيتنا</h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\" style=\"text-align: justify; \"><span style=\"font-weight: normal;\">أن تكون سمات بلس منصة التدريب الإلكتروني الوطنية الرائدة في تطوير المهارات وبناء القدرات، والمساهمة في إعداد كفاءات مؤهلة تدعم التنمية الوطنية وتواكب تطلعات المستقبل.</span></h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\">رسالتنا</h3><h3 data-section-id=\"1l6qnd4\" data-start=\"86\" data-end=\"96\" style=\"text-align: justify; \"><span style=\"font-weight: normal;\">تقديم برامج تدريبية إلكترونية متميزة وموثوقة، تعتمد على أفضل الممارسات التعليمية والتقنيات الحديثة، بهدف تمكين الأفراد من اكتساب المهارات والمعارف التي تعزز فرصهم المهنية وتسهم في تطوير المجتمع والاقتصاد.</span></h3>');

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('av18981848@gmail.com', 'cYTtJLR86NoxZ0whf465XoQa98hhxAxx2Q7t3zeaeTJRYoUMQwqqzb4rgqP2', '2021-02-20 16:05:13');

-- --------------------------------------------------------

--
-- Structure de la table `payku_payments`
--

CREATE TABLE `payku_payments` (
  `transaction_id` varchar(255) NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `media` varchar(255) NOT NULL,
  `verification_key` varchar(255) NOT NULL,
  `authorization_code` varchar(255) NOT NULL,
  `last_4_digits` int(10) UNSIGNED DEFAULT NULL,
  `installments` varchar(255) DEFAULT NULL,
  `card_type` varchar(255) DEFAULT NULL,
  `additional_parameters` varchar(255) DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_key` varchar(255) DEFAULT NULL,
  `transaction_key` varchar(255) DEFAULT NULL,
  `deposit_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `payku_transactions`
--

CREATE TABLE `payku_transactions` (
  `id` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `order` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `amount` int(10) UNSIGNED DEFAULT NULL,
  `notified_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `payment_channels`
--

CREATE TABLE `payment_channels` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `credentials` text DEFAULT NULL,
  `currencies` text DEFAULT NULL,
  `created_at` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `payment_channels`
--

INSERT INTO `payment_channels` (`id`, `title`, `class_name`, `status`, `image`, `credentials`, `currencies`, `created_at`) VALUES
(19, 'Paypal', 'Paypal', 'active', '/store/1/default_images/payment gateways/paypal.png', NULL, '[\"USD\",\"EUR\"]', '1654755044'),
(48, 'MyFatoorah', 'MyFatoorah', 'active', '/store/1/my-fatoorah-paddedV2.png', '{\"api_key\":\"PFsrjeND6blbFtVsB98Mqu2HAWCvHSJkpNLUuVTRe27IwaD36JGFBTgaXAJgR8AWjSRPYm_ETyWvKyzKfYYKof0gZ-9ltB-rN2XOagvcjONAwlj9MHVNneZxjbP8h3LFu4JX2-EH-NWDS2hnA1Ljq7ZzrxJCDXQ4YfskxjR5F8GW5M5v-Nt_RRNccLLnIEH0He1h4DecIcbzbsC7Re5d8biPkMmpltSq0XkUpUn7Q3ewOw1tTq5eKzN3y4_43hYbMjCUtgM9hepJ3e4LG5ZakqXNA7prmAw_5USHAibO2uMHEVeibqP8HGauzCQN_N-Jad0-mT3YhBy2e7C1Ityl2Vz15Frya3v39rv9Pg88T2AJoaNK0MlrXSgBI7JK5OuiYCiFyrKwsoKThMsFfHQ5vaEPbYPF7Ze15S5swua7H1Slfm40R1vUb2T-kQViEz00O3uvVaos52hYe4hfTyUDUOQU8H5R7aDeWR4pLmeeMJxkxfLu0KxEFHJVuUfsaQmRuBAL-vbIzBWpdLixKRAmu1QNYl-jBlCliKfp5pxharpa4bYtJurw9zZyfQ6LjvEFdik4kiRLhdGHVyBHcARd8iPH2OmvbyE9EQrhAuBFBh8hdXhQdZ2agZucx2QCHiYNOmjisMvr0M9DffcUrcINRKWSdxxWnZ2hA3DKygvaLBKokWITCQsyD1Z099qSp6EsETfd8yNcp4WaCFaqbwFy7nZGho_XvBM_8JyMtPH1hMD_eQQk\",\"base_url\":\"https:\\/\\/api-sa.myfatoorah.com\\/\",\"test_mode\":\"on\"}', '[\"SAR\"]', ''),
(49, 'Tamara', 'Tamara', 'active', '/store/1/387896.png', '{\"base_url\":\"https:\\/\\/api.tamara.co\",\"api_token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiIzODI5OGVjYy0wMzFlLTQxMzQtOWZlOC1jZDkwZTc3YTJlNzYiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiNjY1MDVmMjYtZjAzNC00MmZmLWI2YTQtNTAyZTE4MmExYzE4Iiwicm9sZXMiOlsiUk9MRV9NRVJDSEFOVCJdLCJpc010bHMiOmZhbHNlLCJpYXQiOjE3NjgzMTQyNzMsImlzcyI6IlRhbWFyYSBQUCJ9.BAYmL4Q53XH8M1mi-9kGIGSfWPZ9hXjw2oA_U7q_GxoSQPpDVPKWX_n3547p-mphpNcC5DrkjuVGaGi8V9AD_fHqHN18sTWEUb_tFzKCH_Hh-wBwqywD0Fd8TkgutmI8dzoeD-hFW5fxjHes5xJNtUuxHkyzNus_JnaG1svIvY2z_2miXnEONAZoGk_hG4HAK3jAFeqe7_Agst4pPjq_ESASVw1T7y_XLXGaY7DRGJYLuRF34Bio_8-Ep4JNtrYWIEXTwO6x3jVogPm7epIbBPk_2ICO90zwCJ01aPRDRqhJWub1qyJkCBcTJIRJoxcBhtHkVt1_v7T4pkLpSv9c0w\",\"notification_token\":\"ad876aa6-39de-4599-a264-5a19bc38b502\",\"country_code\":\"+966\",\"test_mode\":null}', '[\"SAR\"]', ''),
(50, 'Tabby', 'Tabby', 'active', '/store/1/tabby-logo-1.png', '{\"secret_key\":\"123\",\"merchant_code\":\"123\",\"api_url\":\"123\",\"test_mode\":null}', '[\"SAR\"]', ''),
(51, 'Payu', 'Payu', 'inactive', NULL, NULL, NULL, '1768159778'),
(52, 'Razorpay', 'Razorpay', 'inactive', NULL, NULL, NULL, '1768159778'),
(79, 'Paymob', 'Paymob', 'active', NULL, NULL, NULL, '1767052932'),
(80, 'Alipay', 'Alipay', 'inactive', NULL, NULL, NULL, '1769982721'),
(81, 'Authorizenet', 'Authorizenet', 'inactive', NULL, NULL, NULL, '1769982721'),
(82, 'Bitpay', 'Bitpay', 'inactive', NULL, NULL, NULL, '1769982721'),
(83, 'Braintree', 'Braintree', 'inactive', NULL, NULL, NULL, '1769982721'),
(84, 'Cashu', 'Cashu', 'inactive', NULL, NULL, NULL, '1769982721'),
(85, 'Flutterwave', 'Flutterwave', 'inactive', NULL, '{\"publicKey\":null,\"secretKey\":null,\"secretHash\":null,\"test_mode\":null}', '[\"SAR\"]', '1769982721'),
(86, 'Instamojo', 'Instamojo', 'inactive', NULL, NULL, NULL, '1769982721'),
(87, 'Iyzipay', 'Iyzipay', 'inactive', NULL, NULL, NULL, '1769982721'),
(88, 'Izipay', 'Izipay', 'inactive', NULL, NULL, NULL, '1769982721'),
(89, 'KlarnaCheckout', 'KlarnaCheckout', 'inactive', NULL, NULL, NULL, '1769982721'),
(90, 'MercadoPago', 'MercadoPago', 'inactive', NULL, NULL, NULL, '1769982721'),
(91, 'Mollie', 'Mollie', 'inactive', NULL, NULL, NULL, '1769982721'),
(92, 'Ngenius', 'Ngenius', 'inactive', NULL, NULL, NULL, '1769982721'),
(93, 'Payfort', 'Payfort', 'inactive', NULL, NULL, NULL, '1769982721'),
(94, 'Payhere', 'Payhere', 'inactive', NULL, NULL, NULL, '1769982721'),
(95, 'Payku', 'Payku', 'inactive', NULL, NULL, NULL, '1769982721'),
(96, 'Paylink', 'Paylink', 'inactive', NULL, NULL, NULL, '1769982721'),
(97, 'Paysera', 'Paysera', 'inactive', NULL, NULL, NULL, '1769982721'),
(98, 'Paystack', 'Paystack', 'inactive', NULL, NULL, NULL, '1769982721'),
(99, 'Paytm', 'Paytm', 'inactive', NULL, NULL, NULL, '1769982721'),
(100, 'Robokassa', 'Robokassa', 'inactive', NULL, NULL, NULL, '1769982721'),
(101, 'Sslcommerz', 'Sslcommerz', 'inactive', NULL, NULL, NULL, '1769982721'),
(102, 'Stripe', 'Stripe', 'inactive', NULL, NULL, NULL, '1769982721'),
(103, 'Toyyibpay', 'Toyyibpay', 'inactive', NULL, NULL, NULL, '1769982721'),
(104, 'Voguepay', 'Voguepay', 'inactive', NULL, NULL, NULL, '1769982721'),
(105, 'Zarinpal', 'Zarinpal', 'inactive', NULL, NULL, NULL, '1769982721'),
(106, 'JazzCash', 'JazzCash', 'inactive', NULL, NULL, NULL, '1769982721'),
(107, 'IPay88', 'IPay88', 'inactive', NULL, NULL, NULL, '1769982721'),
(108, 'Redsys', 'Redsys', 'inactive', NULL, NULL, NULL, '1769982721'),
(109, 'Xendit', 'Xendit', 'inactive', NULL, NULL, NULL, '1769982721'),
(110, 'Paytabs', 'Paytabs', 'inactive', NULL, NULL, NULL, '1769982721'),
(111, 'Cintepay', 'Cintepay', 'inactive', NULL, NULL, NULL, '1769982721'),
(112, 'TapPayment', 'TapPayment', 'inactive', NULL, NULL, NULL, '1769982721'),
(113, 'Paytr', 'Paytr', 'inactive', NULL, NULL, NULL, '1769982721'),
(114, 'Telebirr', 'Telebirr', 'inactive', NULL, NULL, NULL, '1769982721'),
(115, 'Chapa', 'Chapa', 'inactive', NULL, NULL, NULL, '1769982721'),
(116, 'Clickpay', 'Clickpay', 'inactive', NULL, NULL, NULL, '1769982721'),
(117, 'Bkash', 'Bkash', 'inactive', NULL, NULL, NULL, '1769982721');

-- --------------------------------------------------------

--
-- Structure de la table `payouts`
--

CREATE TABLE `payouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_selected_bank_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(13,2) NOT NULL,
  `status` enum('waiting','done','reject') NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `payu_transactions`
--

CREATE TABLE `payu_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `paid_for_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_for_type` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `gateway` text NOT NULL,
  `body` text NOT NULL,
  `destination` varchar(255) NOT NULL,
  `hash` text NOT NULL,
  `response` text DEFAULT NULL,
  `status` enum('pending','failed','successful','invalid') NOT NULL DEFAULT 'pending',
  `verified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `section_id` int(10) UNSIGNED DEFAULT NULL,
  `allow` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `role_id`, `section_id`, `allow`) VALUES
(20779, 3, 100001, 1),
(20780, 3, 100002, 1),
(20781, 3, 100003, 1),
(20782, 3, 100004, 1),
(20783, 3, 100005, 1),
(20784, 3, 100010, 1),
(20785, 3, 100011, 1),
(20786, 3, 100012, 1),
(20787, 3, 100013, 1),
(20788, 3, 100014, 1),
(20789, 3, 100020, 1),
(20790, 3, 100021, 1),
(20791, 3, 100022, 1),
(20792, 3, 100023, 1),
(20793, 3, 100024, 1),
(20794, 3, 100025, 1),
(20795, 3, 100026, 1),
(20796, 3, 100027, 1),
(20797, 3, 100028, 1),
(20798, 3, 100029, 1),
(20799, 3, 100030, 1),
(20800, 3, 100031, 1),
(20801, 3, 100032, 1),
(20802, 3, 100033, 1),
(20803, 3, 100034, 1),
(20804, 3, 100035, 1),
(20805, 3, 100040, 1),
(20806, 3, 100041, 1),
(20807, 3, 100042, 1),
(20808, 3, 100043, 1),
(20809, 3, 100044, 1),
(20810, 3, 100045, 1),
(20811, 3, 100050, 1),
(20812, 3, 100051, 1),
(20813, 3, 100052, 1),
(20814, 3, 100053, 1),
(20815, 3, 100054, 1),
(20816, 3, 100055, 1),
(20817, 3, 100060, 1),
(20818, 3, 100061, 1),
(20819, 3, 100062, 1),
(20820, 3, 100063, 1),
(20821, 3, 100070, 1),
(20822, 3, 100071, 1),
(20823, 3, 100072, 1),
(20824, 3, 100073, 1),
(20825, 3, 100080, 1),
(20826, 3, 100081, 1),
(20827, 3, 100082, 1),
(20828, 3, 100083, 1),
(20829, 3, 100084, 1),
(20830, 3, 100085, 1),
(20831, 3, 100086, 1),
(20832, 3, 100090, 1),
(20833, 3, 100091, 1),
(20834, 3, 100092, 1),
(20835, 3, 100093, 1),
(20836, 3, 100100, 1),
(20837, 3, 100101, 1),
(20838, 3, 100102, 1),
(20839, 3, 100103, 1),
(20840, 3, 100104, 1),
(20841, 3, 100105, 1),
(20842, 3, 100106, 1),
(20843, 3, 100107, 1),
(20844, 3, 100120, 1),
(20845, 3, 100121, 1),
(20846, 3, 100122, 1),
(20847, 3, 100123, 1),
(20848, 3, 100124, 1),
(20849, 3, 100125, 1),
(20850, 3, 100126, 1),
(20851, 3, 100127, 1),
(20852, 3, 100140, 1),
(20853, 3, 100141, 1),
(20854, 3, 100142, 1),
(20855, 3, 100143, 1),
(20856, 3, 100160, 1),
(20857, 3, 100161, 1),
(20858, 3, 100162, 1),
(20859, 3, 100163, 1),
(20860, 3, 100164, 1),
(20861, 3, 100165, 1),
(20862, 3, 100166, 1),
(20863, 3, 100167, 1),
(20864, 3, 100180, 1),
(20865, 3, 100181, 1),
(20866, 3, 100182, 1),
(20867, 3, 100183, 1),
(20868, 3, 100184, 1),
(20869, 3, 100200, 1),
(20870, 3, 100201, 1),
(20871, 3, 100202, 1),
(20872, 3, 100203, 1),
(20873, 3, 100204, 1),
(20874, 3, 100220, 1),
(20875, 3, 100221, 1),
(20876, 3, 100222, 1),
(20877, 3, 100223, 1),
(20878, 3, 100224, 1),
(20879, 3, 100225, 1),
(20880, 3, 100240, 1),
(20881, 3, 100241, 1),
(20882, 3, 100260, 1),
(20883, 3, 100261, 1),
(20884, 3, 100280, 1),
(20885, 3, 100281, 1),
(20886, 3, 100300, 1),
(20887, 3, 100301, 1),
(20888, 3, 100302, 1),
(20889, 3, 100303, 1),
(21112, 4, 100001, 1),
(21113, 4, 100002, 1),
(21114, 4, 100003, 1),
(21115, 4, 100004, 1),
(21116, 4, 100005, 1),
(21117, 4, 100010, 1),
(21118, 4, 100011, 1),
(21119, 4, 100012, 1),
(21120, 4, 100013, 1),
(21121, 4, 100014, 1),
(21122, 4, 100020, 1),
(21123, 4, 100021, 1),
(21124, 4, 100022, 1),
(21125, 4, 100023, 1),
(21126, 4, 100024, 1),
(21127, 4, 100025, 1),
(21128, 4, 100026, 1),
(21129, 4, 100027, 1),
(21130, 4, 100028, 1),
(21131, 4, 100029, 1),
(21132, 4, 100030, 1),
(21133, 4, 100031, 1),
(21134, 4, 100032, 1),
(21135, 4, 100033, 1),
(21136, 4, 100034, 1),
(21137, 4, 100035, 1),
(21138, 4, 100040, 1),
(21139, 4, 100041, 1),
(21140, 4, 100042, 1),
(21141, 4, 100043, 1),
(21142, 4, 100044, 1),
(21143, 4, 100045, 1),
(21144, 4, 100050, 1),
(21145, 4, 100051, 1),
(21146, 4, 100052, 1),
(21147, 4, 100053, 1),
(21148, 4, 100054, 1),
(21149, 4, 100055, 1),
(21150, 4, 100060, 1),
(21151, 4, 100061, 1),
(21152, 4, 100062, 1),
(21153, 4, 100063, 1),
(21154, 4, 100070, 1),
(21155, 4, 100071, 1),
(21156, 4, 100072, 1),
(21157, 4, 100073, 1),
(21158, 4, 100080, 1),
(21159, 4, 100081, 1),
(21160, 4, 100082, 1),
(21161, 4, 100083, 1),
(21162, 4, 100084, 1),
(21163, 4, 100085, 1),
(21164, 4, 100086, 1),
(21165, 4, 100090, 1),
(21166, 4, 100091, 1),
(21167, 4, 100092, 1),
(21168, 4, 100093, 1),
(21169, 4, 100100, 1),
(21170, 4, 100101, 1),
(21171, 4, 100102, 1),
(21172, 4, 100103, 1),
(21173, 4, 100104, 1),
(21174, 4, 100105, 1),
(21175, 4, 100106, 1),
(21176, 4, 100107, 1),
(21177, 4, 100120, 1),
(21178, 4, 100121, 1),
(21179, 4, 100122, 1),
(21180, 4, 100123, 1),
(21181, 4, 100124, 1),
(21182, 4, 100125, 1),
(21183, 4, 100126, 1),
(21184, 4, 100127, 1),
(21185, 4, 100140, 1),
(21186, 4, 100141, 1),
(21187, 4, 100142, 1),
(21188, 4, 100143, 1),
(21189, 4, 100160, 1),
(21190, 4, 100161, 1),
(21191, 4, 100162, 1),
(21192, 4, 100163, 1),
(21193, 4, 100164, 1),
(21194, 4, 100165, 1),
(21195, 4, 100166, 1),
(21196, 4, 100167, 1),
(21197, 4, 100180, 1),
(21198, 4, 100181, 1),
(21199, 4, 100182, 1),
(21200, 4, 100183, 1),
(21201, 4, 100184, 1),
(21202, 4, 100200, 1),
(21203, 4, 100201, 1),
(21204, 4, 100202, 1),
(21205, 4, 100203, 1),
(21206, 4, 100204, 1),
(21207, 4, 100220, 1),
(21208, 4, 100221, 1),
(21209, 4, 100222, 1),
(21210, 4, 100223, 1),
(21211, 4, 100224, 1),
(21212, 4, 100225, 1),
(21213, 4, 100240, 1),
(21214, 4, 100241, 1),
(21215, 4, 100260, 1),
(21216, 4, 100261, 1),
(21217, 4, 100280, 1),
(21218, 4, 100281, 1),
(21219, 4, 100300, 1),
(21220, 4, 100301, 1),
(21221, 4, 100302, 1),
(21222, 4, 100303, 1),
(21777, 2, 1, 1),
(21778, 2, 2, 1),
(21779, 2, 3, 1),
(21780, 2, 4, 1),
(21781, 2, 5, 1),
(21782, 2, 6, 1),
(21783, 2, 7, 1),
(21784, 2, 8, 1),
(21785, 2, 9, 1),
(21786, 2, 10, 1),
(21787, 2, 11, 1),
(21788, 2, 12, 1),
(21789, 2, 13, 1),
(21790, 2, 14, 1),
(21791, 2, 15, 1),
(21792, 2, 16, 1),
(21793, 2, 17, 1),
(21794, 2, 25, 1),
(21795, 2, 26, 1),
(21796, 2, 50, 1),
(21797, 2, 51, 1),
(21798, 2, 52, 1),
(21799, 2, 53, 1),
(21800, 2, 54, 1),
(21801, 2, 100, 1),
(21802, 2, 101, 1),
(21803, 2, 102, 1),
(21804, 2, 103, 1),
(21805, 2, 104, 1),
(21806, 2, 105, 1),
(21807, 2, 106, 1),
(21808, 2, 107, 1),
(21809, 2, 108, 1),
(21810, 2, 109, 1),
(21811, 2, 110, 1),
(21812, 2, 111, 1),
(21813, 2, 112, 1),
(21814, 2, 113, 1),
(21815, 2, 114, 1),
(21816, 2, 115, 1),
(21817, 2, 116, 1),
(21818, 2, 117, 1),
(21819, 2, 118, 1),
(21820, 2, 150, 1),
(21821, 2, 151, 1),
(21822, 2, 152, 1),
(21823, 2, 153, 1),
(21824, 2, 154, 1),
(21825, 2, 155, 1),
(21826, 2, 156, 1),
(21827, 2, 157, 1),
(21828, 2, 158, 1),
(21829, 2, 159, 1),
(21830, 2, 160, 1),
(21831, 2, 161, 1),
(21832, 2, 162, 1),
(21833, 2, 163, 1),
(21834, 2, 164, 1),
(21835, 2, 165, 1),
(21836, 2, 166, 1),
(21837, 2, 167, 1),
(21838, 2, 200, 1),
(21839, 2, 201, 1),
(21840, 2, 202, 1),
(21841, 2, 203, 1),
(21842, 2, 204, 1),
(21843, 2, 205, 1),
(21844, 2, 206, 1),
(21845, 2, 207, 1),
(21846, 2, 208, 1),
(21847, 2, 250, 1),
(21848, 2, 251, 1),
(21849, 2, 252, 1),
(21850, 2, 253, 1),
(21851, 2, 254, 1),
(21852, 2, 300, 1),
(21853, 2, 301, 1),
(21854, 2, 302, 1),
(21855, 2, 303, 1),
(21856, 2, 304, 1),
(21857, 2, 350, 1),
(21858, 2, 351, 1),
(21859, 2, 352, 1),
(21860, 2, 353, 1),
(21861, 2, 354, 1),
(21862, 2, 355, 1),
(21863, 2, 356, 1),
(21864, 2, 357, 1),
(21865, 2, 400, 1),
(21866, 2, 401, 1),
(21867, 2, 402, 1),
(21868, 2, 403, 1),
(21869, 2, 404, 1),
(21870, 2, 405, 1),
(21871, 2, 406, 1),
(21872, 2, 450, 1),
(21873, 2, 451, 1),
(21874, 2, 452, 1),
(21875, 2, 453, 1),
(21876, 2, 454, 1),
(21877, 2, 455, 1),
(21878, 2, 456, 1),
(21879, 2, 457, 1),
(21880, 2, 458, 1),
(21881, 2, 459, 1),
(21882, 2, 460, 1),
(21883, 2, 461, 1),
(21884, 2, 500, 1),
(21885, 2, 501, 1),
(21886, 2, 502, 1),
(21887, 2, 503, 1),
(21888, 2, 504, 1),
(21889, 2, 505, 1),
(21890, 2, 550, 1),
(21891, 2, 551, 1),
(21892, 2, 552, 1),
(21893, 2, 553, 1),
(21894, 2, 554, 1),
(21895, 2, 555, 1),
(21896, 2, 600, 1),
(21897, 2, 601, 1),
(21898, 2, 602, 1),
(21899, 2, 603, 1),
(21900, 2, 650, 1),
(21901, 2, 651, 1),
(21902, 2, 652, 1),
(21903, 2, 653, 1),
(21904, 2, 654, 1),
(21905, 2, 655, 1),
(21906, 2, 656, 1),
(21907, 2, 657, 1),
(21908, 2, 658, 1),
(21909, 2, 700, 1),
(21910, 2, 701, 1),
(21911, 2, 702, 1),
(21912, 2, 703, 1),
(21913, 2, 704, 1),
(21914, 2, 705, 1),
(21915, 2, 706, 1),
(21916, 2, 707, 1),
(21917, 2, 708, 1),
(21918, 2, 709, 1),
(21919, 2, 710, 1),
(21920, 2, 750, 1),
(21921, 2, 751, 1),
(21922, 2, 752, 1),
(21923, 2, 753, 1),
(21924, 2, 754, 1),
(21925, 2, 800, 1),
(21926, 2, 801, 1),
(21927, 2, 802, 1),
(21928, 2, 803, 1),
(21929, 2, 850, 1),
(21930, 2, 851, 1),
(21931, 2, 852, 1),
(21932, 2, 853, 1),
(21933, 2, 854, 1),
(21934, 2, 900, 1),
(21935, 2, 901, 1),
(21936, 2, 902, 1),
(21937, 2, 903, 1),
(21938, 2, 904, 1),
(21939, 2, 950, 1),
(21940, 2, 951, 1),
(21941, 2, 952, 1),
(21942, 2, 953, 1),
(21943, 2, 954, 1),
(21944, 2, 955, 1),
(21945, 2, 956, 1),
(21946, 2, 957, 1),
(21947, 2, 958, 1),
(21948, 2, 959, 1),
(21949, 2, 1000, 1),
(21950, 2, 1001, 1),
(21951, 2, 1002, 1),
(21952, 2, 1003, 1),
(21953, 2, 1004, 1),
(21954, 2, 1050, 1),
(21955, 2, 1051, 1),
(21956, 2, 1052, 1),
(21957, 2, 1053, 1),
(21958, 2, 1054, 1),
(21959, 2, 1055, 1),
(21960, 2, 1056, 1),
(21961, 2, 1057, 1),
(21962, 2, 1058, 1),
(21963, 2, 1059, 1),
(21964, 2, 1060, 1),
(21965, 2, 1075, 1),
(21966, 2, 1076, 1),
(21967, 2, 1077, 1),
(21968, 2, 1078, 1),
(21969, 2, 1079, 1),
(21970, 2, 1080, 1),
(21971, 2, 1081, 1),
(21972, 2, 1082, 1),
(21973, 2, 1083, 1),
(21974, 2, 1100, 1),
(21975, 2, 1101, 1),
(21976, 2, 1102, 1),
(21977, 2, 1103, 1),
(21978, 2, 1104, 1),
(21979, 2, 1150, 1),
(21980, 2, 1151, 1),
(21981, 2, 1152, 1),
(21982, 2, 1153, 1),
(21983, 2, 1154, 1),
(21984, 2, 1200, 1),
(21985, 2, 1201, 1),
(21986, 2, 1202, 1),
(21987, 2, 1203, 1),
(21988, 2, 1204, 1),
(21989, 2, 1230, 1),
(21990, 2, 1231, 1),
(21991, 2, 1232, 1),
(21992, 2, 1233, 1),
(21993, 2, 1234, 1),
(21994, 2, 1235, 1),
(21995, 2, 1250, 1),
(21996, 2, 1251, 1),
(21997, 2, 1252, 1),
(21998, 2, 1253, 1),
(21999, 2, 1300, 1),
(22000, 2, 1301, 1),
(22001, 2, 1302, 1),
(22002, 2, 1303, 1),
(22003, 2, 1304, 1),
(22004, 2, 1305, 1),
(22005, 2, 1350, 1),
(22006, 2, 1351, 1),
(22007, 2, 1352, 1),
(22008, 2, 1353, 1),
(22009, 2, 1354, 1),
(22010, 2, 1355, 1),
(22011, 2, 1400, 1),
(22012, 2, 1401, 1),
(22013, 2, 1402, 1),
(22014, 2, 1403, 1),
(22015, 2, 1404, 1),
(22016, 2, 1405, 1),
(22017, 2, 1406, 1),
(22018, 2, 1407, 1),
(22019, 2, 1408, 1),
(22020, 2, 1409, 1),
(22021, 2, 1450, 1),
(22022, 2, 1451, 1),
(22023, 2, 1452, 1),
(22024, 2, 1453, 1),
(22025, 2, 1454, 1),
(22026, 2, 1455, 1),
(22027, 2, 1456, 1),
(22028, 2, 1457, 1),
(22029, 2, 1500, 1),
(22030, 2, 1501, 1),
(22031, 2, 1502, 1),
(22032, 2, 1503, 1),
(22033, 2, 1504, 1),
(22034, 2, 1550, 1),
(22035, 2, 1551, 1),
(22036, 2, 1552, 1),
(22037, 2, 1553, 1),
(22038, 2, 1554, 1),
(22039, 2, 1600, 1),
(22040, 2, 1601, 1),
(22041, 2, 1602, 1),
(22042, 2, 1603, 1),
(22043, 2, 1604, 1),
(22044, 2, 1605, 1),
(22045, 2, 1650, 1),
(22046, 2, 1651, 1),
(22047, 2, 1652, 1),
(22048, 2, 1675, 1),
(22049, 2, 1676, 1),
(22050, 2, 1677, 1),
(22051, 2, 1678, 1),
(22052, 2, 1725, 1),
(22053, 2, 1726, 1),
(22054, 2, 1727, 1),
(22055, 2, 1728, 1),
(22056, 2, 1729, 1),
(22057, 2, 1730, 1),
(22058, 2, 1731, 1),
(22059, 2, 1732, 1),
(22060, 2, 1750, 1),
(22061, 2, 1751, 1),
(22062, 2, 1752, 1),
(22063, 2, 1753, 1),
(22064, 2, 1754, 1),
(22065, 2, 1775, 1),
(22066, 2, 1776, 1),
(22067, 2, 1777, 1),
(22068, 2, 1778, 1),
(22069, 2, 1779, 1),
(22070, 2, 1780, 1),
(22071, 2, 1781, 1),
(22072, 2, 1800, 1),
(22073, 2, 1801, 1),
(22074, 2, 1802, 1),
(22075, 2, 1803, 1),
(22076, 2, 1804, 1),
(22077, 2, 1805, 1),
(22078, 2, 1806, 1),
(22079, 2, 1807, 1),
(22080, 2, 1808, 1),
(22081, 2, 1809, 1),
(22082, 2, 1810, 1),
(22083, 2, 1811, 1),
(22084, 2, 1812, 1),
(22085, 2, 1813, 1),
(22086, 2, 1814, 1),
(22087, 2, 1815, 1),
(22088, 2, 1816, 1),
(22089, 2, 1817, 1),
(22090, 2, 1818, 1),
(22091, 2, 1819, 1),
(22092, 2, 1820, 1),
(22093, 2, 1821, 1),
(22094, 2, 1822, 1),
(22095, 2, 1823, 1),
(22096, 2, 1824, 1),
(22097, 2, 1825, 1),
(22098, 2, 1826, 1),
(22099, 2, 1827, 1),
(22100, 2, 1828, 1),
(22101, 2, 1829, 1),
(22102, 2, 1830, 1),
(22103, 2, 1831, 1),
(22104, 2, 1832, 1),
(22105, 2, 1833, 1),
(22106, 2, 1834, 1),
(22107, 2, 1835, 1),
(22108, 2, 1836, 1),
(22109, 2, 1837, 1),
(22110, 2, 1838, 1),
(22111, 2, 1850, 1),
(22112, 2, 1851, 1),
(22113, 2, 1852, 1),
(22114, 2, 1853, 1),
(22115, 2, 1875, 1),
(22116, 2, 1876, 1),
(22117, 2, 1877, 1),
(22118, 2, 1900, 1),
(22119, 2, 1901, 1),
(22120, 2, 1902, 1),
(22121, 2, 1903, 1),
(22122, 2, 1904, 1),
(22123, 2, 1905, 1),
(22124, 2, 1925, 1),
(22125, 2, 1926, 1),
(22126, 2, 1927, 1),
(22127, 2, 1928, 1),
(22128, 2, 1929, 1),
(22129, 2, 1930, 1),
(22130, 2, 1931, 1),
(22131, 2, 1932, 1),
(22132, 2, 1933, 1),
(22133, 2, 1934, 1),
(22134, 2, 1935, 1),
(22135, 2, 1950, 1),
(22136, 2, 1951, 1),
(22137, 2, 1952, 1),
(22138, 2, 1953, 1),
(22139, 2, 1954, 1),
(22140, 2, 1975, 1),
(22141, 2, 1976, 1),
(22142, 2, 1977, 1),
(22143, 2, 1978, 1),
(22144, 2, 1979, 1),
(22145, 2, 2000, 1),
(22146, 2, 2001, 1),
(22147, 2, 2015, 1),
(22148, 2, 2016, 1),
(22149, 2, 2017, 1),
(22150, 2, 2018, 1),
(22151, 2, 2019, 1),
(22152, 2, 2020, 1),
(22153, 2, 2021, 1),
(22154, 2, 2030, 1),
(22155, 2, 2031, 1),
(22156, 2, 2032, 1),
(22157, 2, 2050, 1),
(22158, 2, 2051, 1),
(22159, 2, 2052, 1),
(22160, 2, 2053, 1),
(22161, 2, 2054, 1),
(22162, 2, 2055, 1),
(22163, 2, 2070, 1),
(22164, 2, 2071, 1),
(22165, 2, 2072, 1),
(22166, 2, 2073, 1),
(22167, 2, 2074, 1),
(22168, 2, 2075, 1),
(22169, 2, 2076, 1),
(22170, 2, 2077, 1),
(22171, 2, 2078, 1),
(22172, 2, 2079, 1),
(22173, 2, 2080, 1),
(22174, 2, 2081, 1),
(22175, 2, 2090, 1),
(22176, 2, 2091, 1),
(22177, 2, 2092, 1),
(22178, 2, 2093, 1),
(22179, 2, 3000, 1),
(22180, 2, 3001, 1),
(22181, 2, 3010, 1),
(22182, 2, 3011, 1),
(22183, 2, 3012, 1),
(22184, 2, 3013, 1),
(22185, 2, 3020, 1),
(22186, 2, 3021, 1),
(22187, 2, 3022, 1),
(22188, 2, 3023, 1),
(22189, 2, 3024, 1),
(22190, 2, 3025, 1),
(22191, 2, 3030, 1),
(22192, 2, 3031, 1),
(22193, 2, 3032, 1),
(22194, 2, 3033, 1),
(22195, 2, 3034, 1),
(22196, 2, 3035, 1),
(22197, 2, 3040, 1),
(22198, 2, 3041, 1),
(22199, 2, 3042, 1),
(22200, 2, 3043, 1),
(22201, 2, 3044, 1),
(22202, 2, 3045, 1),
(22203, 2, 3046, 1),
(22204, 2, 3050, 1),
(22205, 2, 3051, 1),
(22206, 2, 3052, 1),
(22207, 2, 3053, 1),
(22208, 2, 3054, 1),
(22209, 2, 3055, 1),
(22210, 2, 3056, 1),
(22211, 2, 3060, 1),
(22212, 2, 3061, 1),
(22213, 2, 3062, 1),
(22214, 2, 3063, 1),
(22215, 2, 3064, 1),
(22216, 2, 3070, 1),
(22217, 2, 3071, 1),
(22218, 2, 3072, 1),
(22219, 2, 3080, 1),
(22220, 2, 3081, 1),
(22221, 2, 3082, 1),
(22222, 2, 3083, 1),
(22223, 2, 3084, 1),
(22224, 2, 3090, 1),
(22225, 2, 3091, 1),
(22226, 2, 3092, 1),
(22227, 2, 3093, 1),
(22228, 2, 3100, 1),
(22229, 2, 3101, 1),
(22230, 2, 3102, 1),
(22231, 2, 3103, 1),
(22232, 2, 3104, 1),
(22233, 2, 3110, 1),
(22234, 2, 3111, 1),
(22235, 2, 3120, 1),
(22236, 2, 3121, 1),
(22237, 2, 3122, 1),
(22238, 2, 3123, 1),
(22239, 2, 3130, 1),
(22240, 2, 3131, 1),
(22241, 2, 3140, 1),
(22242, 2, 3141, 1),
(22243, 2, 3150, 1),
(22244, 2, 3151, 1),
(22245, 2, 3152, 1),
(22246, 2, 3153, 1),
(22247, 2, 3154, 1),
(22248, 2, 3155, 1),
(22249, 2, 3156, 1),
(22250, 2, 3170, 1),
(22251, 2, 3171, 1),
(22252, 2, 3172, 1),
(22253, 2, 3173, 1),
(22254, 2, 3174, 1),
(22255, 2, 3175, 1),
(22256, 2, 3176, 1),
(23251, 6, 1, 1),
(23252, 6, 2, 1),
(23253, 6, 3, 1),
(23254, 6, 4, 1),
(23255, 6, 5, 1),
(23256, 6, 6, 1),
(23257, 6, 7, 1),
(23258, 6, 8, 1),
(23259, 6, 9, 1),
(23260, 6, 10, 1),
(23261, 6, 11, 1),
(23262, 6, 12, 1),
(23263, 6, 13, 1),
(23264, 6, 14, 1),
(23265, 6, 15, 1),
(23266, 6, 16, 1),
(23267, 6, 150, 1),
(23268, 6, 151, 1),
(23269, 6, 152, 1),
(23270, 6, 153, 1),
(23271, 6, 154, 1),
(23272, 6, 155, 1),
(23273, 6, 157, 1),
(23274, 6, 159, 1),
(23275, 6, 160, 1),
(23276, 6, 161, 1),
(23277, 6, 162, 1),
(23278, 6, 163, 1),
(23279, 6, 164, 1),
(23280, 6, 165, 1),
(23281, 6, 166, 1),
(23282, 6, 167, 1),
(23283, 6, 700, 1),
(23284, 6, 701, 1),
(23285, 6, 702, 1),
(23286, 6, 703, 1),
(23287, 6, 704, 1),
(23288, 6, 705, 1),
(23289, 6, 706, 1),
(23290, 6, 707, 1),
(23291, 6, 708, 1),
(23292, 6, 709, 1),
(23293, 6, 710, 1),
(23294, 6, 750, 1),
(23295, 6, 751, 1),
(23296, 6, 752, 1),
(23297, 6, 753, 1),
(23298, 6, 754, 1),
(23299, 6, 950, 1),
(23300, 6, 951, 1),
(23301, 6, 952, 1),
(23302, 6, 953, 1),
(23303, 6, 954, 1),
(23304, 6, 955, 1),
(23305, 6, 956, 1),
(23306, 6, 957, 1),
(23307, 6, 958, 1),
(23308, 6, 959, 1),
(23309, 6, 1400, 1),
(23310, 6, 1401, 1),
(23311, 6, 1402, 1),
(23312, 6, 1403, 1),
(23313, 6, 1404, 1),
(23314, 6, 1405, 1),
(23315, 6, 1406, 1),
(23316, 6, 1407, 1),
(23317, 6, 1408, 1),
(23318, 6, 1409, 1),
(23319, 6, 1600, 1),
(23320, 6, 1601, 1),
(23321, 6, 1602, 1),
(23322, 6, 1603, 1),
(23323, 6, 1604, 1),
(23324, 6, 1605, 1),
(23325, 6, 1925, 1),
(23326, 6, 1926, 1),
(23327, 6, 1927, 1),
(23328, 6, 1928, 1),
(23329, 6, 1929, 1),
(23330, 6, 1930, 1),
(23331, 6, 1931, 1),
(23332, 6, 1932, 1),
(23333, 6, 1933, 1),
(23334, 6, 1934, 1),
(23335, 6, 1935, 1),
(23336, 6, 1950, 1),
(23337, 6, 1951, 1),
(23338, 6, 1952, 1),
(23339, 6, 1953, 1),
(23340, 6, 1954, 1),
(23341, 6, 1975, 1),
(23342, 6, 1976, 1),
(23343, 6, 1977, 1),
(23344, 6, 1978, 1),
(23345, 6, 1979, 1),
(23346, 1, 100001, 1),
(23347, 1, 100002, 1),
(23348, 1, 100003, 1),
(23349, 1, 100004, 1),
(23350, 1, 100005, 1),
(23351, 1, 100010, 1),
(23352, 1, 100011, 1),
(23353, 1, 100012, 1),
(23354, 1, 100013, 1),
(23355, 1, 100014, 1),
(23356, 1, 100020, 1),
(23357, 1, 100021, 1),
(23358, 1, 100022, 1),
(23359, 1, 100023, 1),
(23360, 1, 100024, 1),
(23361, 1, 100025, 1),
(23362, 1, 100026, 1),
(23363, 1, 100027, 1),
(23364, 1, 100028, 1),
(23365, 1, 100029, 1),
(23366, 1, 100030, 1),
(23367, 1, 100031, 1),
(23368, 1, 100032, 1),
(23369, 1, 100033, 1),
(23370, 1, 100034, 1),
(23371, 1, 100035, 1),
(23372, 1, 100040, 1),
(23373, 1, 100041, 1),
(23374, 1, 100042, 1),
(23375, 1, 100043, 1),
(23376, 1, 100044, 1),
(23377, 1, 100045, 1),
(23378, 1, 100050, 1),
(23379, 1, 100051, 1),
(23380, 1, 100052, 1),
(23381, 1, 100053, 1),
(23382, 1, 100054, 1),
(23383, 1, 100055, 1),
(23384, 1, 100060, 1),
(23385, 1, 100061, 1),
(23386, 1, 100062, 1),
(23387, 1, 100063, 1),
(23388, 1, 100070, 1),
(23389, 1, 100071, 1),
(23390, 1, 100072, 1),
(23391, 1, 100073, 1),
(23392, 1, 100080, 1),
(23393, 1, 100081, 1),
(23394, 1, 100082, 1),
(23395, 1, 100083, 1),
(23396, 1, 100084, 1),
(23397, 1, 100085, 1),
(23398, 1, 100086, 1),
(23399, 1, 100090, 1),
(23400, 1, 100091, 1),
(23401, 1, 100092, 1),
(23402, 1, 100093, 1),
(23403, 1, 100100, 1),
(23404, 1, 100101, 1),
(23405, 1, 100102, 1),
(23406, 1, 100103, 1),
(23407, 1, 100104, 1),
(23408, 1, 100105, 1),
(23409, 1, 100106, 1),
(23410, 1, 100107, 1),
(23411, 1, 100120, 1),
(23412, 1, 100121, 1),
(23413, 1, 100122, 1),
(23414, 1, 100123, 1),
(23415, 1, 100124, 1),
(23416, 1, 100125, 1),
(23417, 1, 100126, 1),
(23418, 1, 100127, 1),
(23419, 1, 100140, 1),
(23420, 1, 100141, 1),
(23421, 1, 100142, 1),
(23422, 1, 100143, 1),
(23423, 1, 100160, 1),
(23424, 1, 100161, 1),
(23425, 1, 100162, 1),
(23426, 1, 100163, 1),
(23427, 1, 100164, 1),
(23428, 1, 100180, 1),
(23429, 1, 100181, 1),
(23430, 1, 100182, 1),
(23431, 1, 100183, 1),
(23432, 1, 100184, 1),
(23433, 1, 100200, 1),
(23434, 1, 100201, 1),
(23435, 1, 100202, 1),
(23436, 1, 100203, 1),
(23437, 1, 100204, 1),
(23438, 1, 100220, 1),
(23439, 1, 100221, 1),
(23440, 1, 100222, 1),
(23441, 1, 100223, 1),
(23442, 1, 100224, 1),
(23443, 1, 100225, 1),
(23444, 1, 100240, 1),
(23445, 1, 100241, 1),
(23446, 1, 100260, 1),
(23447, 1, 100261, 1),
(23448, 1, 100280, 1),
(23449, 1, 100281, 1),
(23450, 1, 100300, 1),
(23451, 1, 100301, 1),
(23452, 1, 100302, 1),
(23453, 1, 100303, 1);

-- --------------------------------------------------------

--
-- Structure de la table `prerequisites`
--

CREATE TABLE `prerequisites` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `prerequisite_id` int(10) UNSIGNED NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `type` enum('virtual','physical') NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `price` double(15,2) UNSIGNED DEFAULT NULL,
  `point` bigint(20) UNSIGNED DEFAULT NULL,
  `unlimited_inventory` tinyint(1) NOT NULL DEFAULT 0,
  `ordering` tinyint(1) NOT NULL DEFAULT 0,
  `inventory` int(10) UNSIGNED DEFAULT NULL,
  `inventory_warning` int(10) UNSIGNED DEFAULT NULL,
  `inventory_updated_at` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_fee` double(15,2) UNSIGNED DEFAULT NULL,
  `delivery_estimated_time` int(10) UNSIGNED DEFAULT NULL,
  `message_for_reviewer` text DEFAULT NULL,
  `tax` int(10) UNSIGNED DEFAULT NULL,
  `commission_type` enum('percent','fixed_amount') NOT NULL,
  `commission` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','pending','draft','inactive') NOT NULL,
  `updated_at` bigint(20) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `creator_id`, `type`, `slug`, `category_id`, `price`, `point`, `unlimited_inventory`, `ordering`, `inventory`, `inventory_warning`, `inventory_updated_at`, `delivery_fee`, `delivery_estimated_time`, `message_for_reviewer`, `tax`, `commission_type`, `commission`, `status`, `updated_at`, `created_at`) VALUES
(6, 1, 'virtual', 'ui-ux-playbook', 3, 20.00, NULL, 1, 1, NULL, NULL, 1751189058, NULL, NULL, NULL, NULL, 'percent', NULL, 'active', 1751189058, 1656321480),
(9, 1, 'virtual', 'How-to-Do-a-Website-UX-audit-ebook', 3, 20.00, NULL, 1, 1, NULL, NULL, 1751189213, NULL, NULL, NULL, NULL, 'percent', NULL, 'active', 1751189213, 1656321480);

-- --------------------------------------------------------

--
-- Structure de la table `product_badges`
--

CREATE TABLE `product_badges` (
  `id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) NOT NULL,
  `background` varchar(255) NOT NULL,
  `start_at` bigint(20) UNSIGNED DEFAULT NULL,
  `end_at` bigint(20) UNSIGNED DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product_badges`
--

INSERT INTO `product_badges` (`id`, `icon`, `color`, `background`, `start_at`, `end_at`, `enable`, `created_at`) VALUES
(1, NULL, '#ffffff', 'rgb(28, 28, 28)', 1709316000, 1806451200, 1, 1709533982);

-- --------------------------------------------------------

--
-- Structure de la table `product_badge_contents`
--

CREATE TABLE `product_badge_contents` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_badge_id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_badge_translations`
--

CREATE TABLE `product_badge_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_badge_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product_badge_translations`
--

INSERT INTO `product_badge_translations` (`id`, `product_badge_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Bestseller'),
(2, 1, 'ar', 'جديد'),
(3, 1, 'es', 'Nueva');

-- --------------------------------------------------------

--
-- Structure de la table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_categories`
--

INSERT INTO `product_categories` (`id`, `parent_id`, `icon`, `order`) VALUES
(1, NULL, '/store/1/default_images/categories_icons/feather.png', NULL),
(2, NULL, '/store/1/default_images/categories_icons/pie-chart.png', NULL),
(3, NULL, '/store/1/default_images/categories_icons/umbrella.png', NULL),
(17, NULL, '/store/1/default_images/categories_icons/anchor.png', NULL),
(18, NULL, '/store/1/default_images/categories_icons/heart.png', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `product_category_translations`
--

CREATE TABLE `product_category_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` text DEFAULT NULL,
  `bottom_seo_title` varchar(255) DEFAULT NULL,
  `bottom_seo_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_category_translations`
--

INSERT INTO `product_category_translations` (`id`, `product_category_id`, `locale`, `title`, `subtitle`, `bottom_seo_title`, `bottom_seo_description`) VALUES
(1, 1, 'en', 'Design Tools', 'Create stunning visuals with powerful and user-friendly tools', NULL, NULL),
(2, 2, 'en', 'Science Tools', 'Explore experiments and concepts using practical science kits', NULL, NULL),
(3, 3, 'en', 'E-books', 'Access digital books for learning anytime and anywhere', NULL, NULL),
(23, 17, 'en', 'Projects', 'Hands-on projects to apply and showcase your skills perfectly', NULL, NULL),
(24, 18, 'en', 'Templates', 'Ready-to-use layouts to save valuable time and effort', NULL, NULL),
(26, 18, 'ar', 'القوالب', 'القوالب', NULL, NULL),
(27, 17, 'ar', 'المشاريع', 'المشاريع', NULL, NULL),
(28, 3, 'ar', 'الكتب الإلكترونية', 'الكتب الإلكترونية', NULL, NULL),
(29, 2, 'ar', 'أدوات العلمية', 'أدوات العلمية', NULL, NULL),
(30, 1, 'ar', 'أدوات التصميم', 'أدوات التصميم', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `product_discounts`
--

CREATE TABLE `product_discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `percent` int(10) UNSIGNED NOT NULL,
  `count` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL,
  `start_date` int(10) UNSIGNED NOT NULL,
  `end_date` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_faqs`
--

CREATE TABLE `product_faqs` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_faq_translations`
--

CREATE TABLE `product_faq_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_faq_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_featured_categories`
--

CREATE TABLE `product_featured_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product_featured_categories`
--

INSERT INTO `product_featured_categories` (`id`, `category_id`, `image`) VALUES
(1, 1, '/store/1/default_images/store/featured_store_category_1.jpg'),
(2, 2, '/store/1/default_images/store/featured_store_category_2.jpg'),
(3, 3, '/store/1/default_images/store/featured_store_category_3.jpg'),
(4, 17, '/store/1/default_images/store/featured_store_category_4.jpg'),
(5, 18, '/store/1/default_images/store/featured_store_category_5.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `product_files`
--

CREATE TABLE `product_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL,
  `online_viewer` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_files`
--

INSERT INTO `product_files` (`id`, `creator_id`, `product_id`, `path`, `file_type`, `volume`, `online_viewer`, `order`, `status`, `created_at`) VALUES
(5, 1, 6, '/store/1/Where-the-Crawdads-Sing.pdf', 'pdf', '3', 1, NULL, 'active', 1656322274);

-- --------------------------------------------------------

--
-- Structure de la table `product_file_translations`
--

CREATE TABLE `product_file_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_file_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_file_translations`
--

INSERT INTO `product_file_translations` (`id`, `product_file_id`, `locale`, `title`, `description`) VALUES
(5, 5, 'en', 'Where the Crawdads Sing e-book', 'Where the Crawdads Sing is at once an exquisite ode to the natural world, a heartbreaking coming-of-age story, and a surprising tale of possible murder. Owens reminds us that we are forever shaped by the children we once were, and that we are all subject to the beautiful and violent secrets that nature keeps.');

-- --------------------------------------------------------

--
-- Structure de la table `product_filters`
--

CREATE TABLE `product_filters` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_filters`
--

INSERT INTO `product_filters` (`id`, `category_id`) VALUES
(1, 1),
(2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `product_filter_options`
--

CREATE TABLE `product_filter_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `filter_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_filter_options`
--

INSERT INTO `product_filter_options` (`id`, `filter_id`, `order`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `product_filter_option_translations`
--

CREATE TABLE `product_filter_option_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_filter_option_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_filter_option_translations`
--

INSERT INTO `product_filter_option_translations` (`id`, `product_filter_option_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Brushes'),
(2, 2, 'en', 'Novel'),
(3, 3, 'en', 'Laguage learning'),
(4, 4, 'en', 'Scientific');

-- --------------------------------------------------------

--
-- Structure de la table `product_filter_translations`
--

CREATE TABLE `product_filter_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_filter_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_filter_translations`
--

INSERT INTO `product_filter_translations` (`id`, `product_filter_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Paint Tools'),
(2, 2, 'en', 'Type');

-- --------------------------------------------------------

--
-- Structure de la table `product_media`
--

CREATE TABLE `product_media` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `type` enum('thumbnail','image','video') NOT NULL,
  `path` varchar(255) NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_media`
--

INSERT INTO `product_media` (`id`, `creator_id`, `product_id`, `type`, `path`, `order`, `created_at`) VALUES
(77, 1, 6, 'thumbnail', '/store/1/default_images/store/products/book1.jpg', NULL, 1751189058),
(93, 1, 9, 'thumbnail', '/store/1/default_images/store/products/uxbook.jpg', NULL, 1751189213),
(102, 1, 6, 'image', '/store/1/default_images/Where the Crawdads Sing e-book_1.jpg', NULL, 1751189059),
(103, 1, 6, 'image', '/store/1/default_images/Where the Crawdads Sing e-book_2.jpg', NULL, 1751189059),
(105, 1, 9, 'image', '/store/1/dashboard.png', NULL, 1751189213),
(106, 1, 9, 'image', '/store/1/dashboard.png', NULL, 1751189213);

-- --------------------------------------------------------

--
-- Structure de la table `product_orders`
--

CREATE TABLE `product_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `seller_id` int(10) UNSIGNED NOT NULL,
  `buyer_id` int(10) UNSIGNED DEFAULT NULL,
  `sale_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_order_id` int(10) UNSIGNED DEFAULT NULL,
  `gift_id` int(10) UNSIGNED DEFAULT NULL,
  `specifications` text DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `discount_id` int(10) UNSIGNED DEFAULT NULL,
  `message_to_seller` text DEFAULT NULL,
  `tracking_code` varchar(255) DEFAULT NULL,
  `status` enum('pending','waiting_delivery','shipped','success','canceled') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_quality` int(10) UNSIGNED NOT NULL,
  `purchase_worth` int(10) UNSIGNED NOT NULL,
  `delivery_quality` int(10) UNSIGNED NOT NULL,
  `seller_quality` int(10) UNSIGNED NOT NULL,
  `rates` char(10) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','active') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product_selected_filter_options`
--

CREATE TABLE `product_selected_filter_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_selected_filter_options`
--

INSERT INTO `product_selected_filter_options` (`id`, `product_id`, `filter_option_id`) VALUES
(104, 6, 2),
(106, 9, 2);

-- --------------------------------------------------------

--
-- Structure de la table `product_selected_specifications`
--

CREATE TABLE `product_selected_specifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_specification_id` int(10) UNSIGNED NOT NULL,
  `type` enum('textarea','multi_value') NOT NULL,
  `allow_selection` tinyint(1) NOT NULL DEFAULT 0,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_selected_specifications`
--

INSERT INTO `product_selected_specifications` (`id`, `creator_id`, `product_id`, `product_specification_id`, `type`, `allow_selection`, `order`, `status`, `created_at`) VALUES
(6, 1, 6, 5, 'multi_value', 0, NULL, 'active', 1656322503),
(7, 1, 6, 4, 'textarea', 0, NULL, 'active', 1656322546);

-- --------------------------------------------------------

--
-- Structure de la table `product_selected_specification_multi_values`
--

CREATE TABLE `product_selected_specification_multi_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `selected_specification_id` int(10) UNSIGNED NOT NULL,
  `specification_multi_value_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_selected_specification_multi_values`
--

INSERT INTO `product_selected_specification_multi_values` (`id`, `selected_specification_id`, `specification_multi_value_id`) VALUES
(10, 6, 11);

-- --------------------------------------------------------

--
-- Structure de la table `product_selected_specification_translations`
--

CREATE TABLE `product_selected_specification_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_selected_specification_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_selected_specification_translations`
--

INSERT INTO `product_selected_specification_translations` (`id`, `product_selected_specification_id`, `locale`, `value`) VALUES
(2, 7, 'en', 'Publisher ‏ : ‎ Penguin Publishing Group (March 30, 2021)\r\nLanguage ‏ : ‎ English\r\nPaperback ‏ : ‎ 400 pages\r\nISBN-10 ‏ : ‎ 0735219109\r\nISBN-13 ‏ : ‎ 978-0735219106\r\nItem Weight ‏ : ‎ 11.2 ounces\r\nDimensions ‏ : ‎ 5.5 x 0.79 x 8.22 inches');

-- --------------------------------------------------------

--
-- Structure de la table `product_specifications`
--

CREATE TABLE `product_specifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `input_type` enum('textarea','multi_value') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_specifications`
--

INSERT INTO `product_specifications` (`id`, `input_type`) VALUES
(1, 'multi_value'),
(2, 'multi_value'),
(3, 'multi_value'),
(4, 'textarea'),
(5, 'multi_value');

-- --------------------------------------------------------

--
-- Structure de la table `product_specification_categories`
--

CREATE TABLE `product_specification_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `specification_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_specification_categories`
--

INSERT INTO `product_specification_categories` (`id`, `specification_id`, `category_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(5, 5, 3),
(6, 4, 1),
(7, 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `product_specification_multi_values`
--

CREATE TABLE `product_specification_multi_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `specification_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_specification_multi_values`
--

INSERT INTO `product_specification_multi_values` (`id`, `specification_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 5),
(12, 5),
(13, 5),
(14, 5);

-- --------------------------------------------------------

--
-- Structure de la table `product_specification_multi_value_translations`
--

CREATE TABLE `product_specification_multi_value_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_specification_multi_value_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_specification_multi_value_translations`
--

INSERT INTO `product_specification_multi_value_translations` (`id`, `product_specification_multi_value_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Small'),
(2, 2, 'en', 'Medium'),
(3, 3, 'en', 'Large'),
(4, 4, 'en', 'Basic'),
(5, 5, 'en', 'Advanced'),
(6, 6, 'en', '3-5'),
(7, 7, 'en', '5-8'),
(8, 8, 'en', '8-13'),
(9, 9, 'en', '13-18'),
(10, 10, 'en', '+18'),
(11, 11, 'en', 'Novel'),
(12, 12, 'en', 'Language learning'),
(13, 13, 'en', 'Scientific'),
(14, 14, 'en', 'literature');

-- --------------------------------------------------------

--
-- Structure de la table `product_specification_translations`
--

CREATE TABLE `product_specification_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_specification_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_specification_translations`
--

INSERT INTO `product_specification_translations` (`id`, `product_specification_id`, `locale`, `title`) VALUES
(1, 1, 'en', 'Size'),
(2, 2, 'en', 'Skill Level'),
(3, 3, 'en', 'Age Range'),
(4, 4, 'en', 'Main Features'),
(5, 5, 'en', 'E-book type');

-- --------------------------------------------------------

--
-- Structure de la table `product_top_categories`
--

CREATE TABLE `product_top_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `product_top_categories`
--

INSERT INTO `product_top_categories` (`id`, `category_id`, `image`) VALUES
(1, 1, '/store/1/default_images/store/store_top_category.svg'),
(2, 2, '/store/1/default_images/store/store_top_category_2.svg'),
(3, 3, '/store/1/default_images/store/store_top_category_3.svg'),
(4, 17, '/store/1/default_images/store/store_top_category_4.svg'),
(5, 18, '/store/1/default_images/store/store_top_category_5.svg');

-- --------------------------------------------------------

--
-- Structure de la table `product_translations`
--

CREATE TABLE `product_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `seo_description` text DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product_translations`
--

INSERT INTO `product_translations` (`id`, `product_id`, `locale`, `title`, `seo_description`, `summary`, `description`) VALUES
(6, 6, 'en', 'Practical UI/UX Playbook E-book', 'The #1 New York Times bestselling worldwide sensation with more than 12 million copies sold', 'SOON TO BE A MAJOR MOTION PICTURE—The #1 New York Times bestselling worldwide sensation with more than 12 million copies sold, hailed by The New York Times Book Review as “a painfully beautiful first novel that is at once a murder mystery, a coming-of-age narrative and a celebration of nature.”\r\n\r\nFor years, rumors of the “Marsh Girl” have haunted Barkley Cove, a quiet town on the North Carolina coast. So in late 1969, when handsome Chase Andrews is found dead, the locals immediately suspect Kya Clark, the so-called Marsh Girl. But Kya is not what they say. Sensitive and intelligent, she has survived for years alone in the marsh that she calls home, finding friends in the gulls and lessons in the sand. Then the time comes when she yearns to be touched and loved. When two young men from town become intrigued by her wild beauty, Kya opens herself to a new life—until the unthinkable happens.\r\n\r\nWhere the Crawdads Sing is at once an exquisite ode to the natural world, a heartbreaking coming-of-age story, and a surprising tale of possible murder. Owens reminds us that we are forever shaped by the children we once were and that we are all subject to the beautiful and violent secrets that nature keeps.', '<div>“A painfully beautiful first novel that is at once a murder mystery, a coming-of-age narrative and a celebration of nature....Owens here surveys the desolate marshlands of the North Carolina coast through the eyes of an abandoned child. And in her isolation that child makes us open our own eyes to the secret wonders—and dangers—of her private world.”—The New York Times Book Review</div><div><br></div><div>“Steeped in the rhythms and shadows of the coastal marshes of North Carolina’s Outer Banks, this fierce and hauntingly beautiful novel centers on...Kya’s heartbreaking story of learning to trust human connections, intertwine[d] with a gripping murder mystery, revealing savage truths. An astonishing debut.”—People</div><div><br></div><div>“This lush mystery is perfect for fans of Barbara Kingsolver.”—Bustle</div><div><br></div><div>“A lush debut novel, Owens delivers her mystery wrapped in gorgeous, lyrical prose. It’s clear she’s from this place—the land of the southern coasts, but also the emotional terrain—you can feel it in the pages.  A magnificent achievement, ambitious, credible and very timely.”—Alexandra Fuller, New York Times bestselling author of Don’t Let’s Go to the Dogs Tonight</div><div><br></div><div>“Heart-wrenching...A fresh exploration of isolation and nature from a female perspective along with a compelling love story.”—Entertainment Weekly</div><div><br></div><div>“This wonderful novel has a bit of everything—mystery, romance, and fascinating characters, all told in a story that takes place in North Carolina.”—Nicholas Sparks, New York Times bestselling author of Every Breath</div><div><br></div><div>“Delia Owen’s gorgeous novel is both a coming-of-age tale and an engrossing whodunit.”—Real Simple</div><div><br></div><div>“Evocative...Kya makes for an unforgettable heroine.”—Publishers Weekly</div><div><br></div><div>“The New Southern novel...A lyrical debut.”—Southern Living</div><div><br></div><div>“A nature-infused romance with a killer twist.”—Refinery29</div><div><br></div><div>“Anyone who liked The Great Alone will want to read Where the Crawdads Sing....This astonishing debut is a beautiful and haunting novel that packs a powerful punch. It’s the first novel in a long time that made me cry.”—Kristin Hannah, author ofThe Great AloneandThe Nightingale</div><div><br></div><div>“Both a coming-of-age story and a mysterious account of a murder investigation told from the perspective of a young girl...Through Kya’s story, Owens explores how isolation affects human behavior, and the deep effect that rejection can have on our lives.”—Vanity Fair</div><div><br></div><div>“Lyrical...Its appeal ris[es] from Kya’s deep connection to the place where makes her home, and to all of its creatures.”—Booklist</div><div><br></div><div>“This beautiful, evocative novel is likely to stay with you for many days afterward....absorbing.”—AARP </div><div><br></div><div>“This haunting tale captivates every bit as much for its crime drama elements as for the humanity at its core.” —Mystery & Suspense Magazine</div><div><br></div><div>“Compelling, original...A mystery, a courtroom drama, a romance and a coming-of-age story, Where the Crawdads Sing is a moving, beautiful tale. Readers will remember Kya for a long, long time.”—ShelfAwareness</div><div><br></div><div>“With prose luminous as a low-country moon, Owens weaves a compelling tale of a forgotten girl in the unforgiving coastal marshes of North Carolina. It is a murder mystery/love story/courtroom drama that readers will love, but the novel delves so much deeper into the bone and sinew of our very nature, asking often unanswerable questions, old and intractable as the marsh itself. A stunning debut!”—Christopher Scotton, author of The Secret Wisdom of the Earth</div><div><br></div><div>“A compelling mystery with prose so luminous it can cut through the murkiest of pluff mud.”—Augusta Chronicle</div><div><br></div><div>“Carries the rhythm of an old time ballad. It is clear Owens knows this land intimately, from the black mud sucking at footsteps to the taste of saltwater and the cry of seagulls.”—David Joy, author of The Line That Held Us</div>'),
(9, 9, 'en', 'How to Do a Website UX Audit E-book', 'Implement methods associated with objects as per the latest ECMAScript specification', 'You Will Learn: Implement methods associated with objects as per the latest ECMAScript specification, and use the latest features of ECMAScript', '<p>About This BookGrasp the latest features of ECMAScript and the best way to use it in production codeLearn newly added native APIs to JS Engine and perform tasks efficiently with a cleaner code baseUnderstand the more complex sides of JavaScript such as the inheritance model, low-level memory management, multithreaded environments, and web workersWho This Book Is ForThis book is for web developers who have some basic programming knowledge and want to learn to write cleaner code with the power of ECMAScript.</p>');

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

CREATE TABLE `promotions` (
  `id` int(10) UNSIGNED NOT NULL,
  `days` int(10) UNSIGNED NOT NULL,
  `price` double(15,2) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `promotions`
--

INSERT INTO `promotions` (`id`, `days`, `price`, `icon`, `is_popular`, `created_at`) VALUES
(2, 15, 150.00, '/store/1/default_images/subscribe_packages/subscribe_icon_3.svg', 1, 1749393151),
(3, 15, 50.00, '/store/1/default_images/subscribe_packages/subscribe_icon_1.svg', 0, 1749393126),
(4, 15, 90.00, '/store/1/default_images/subscribe_packages/subscribe_icon_2.svg', 0, 1749393138);

-- --------------------------------------------------------

--
-- Structure de la table `promotion_translations`
--

CREATE TABLE `promotion_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `promotion_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `promotion_translations`
--

INSERT INTO `promotion_translations` (`id`, `promotion_id`, `locale`, `title`, `description`) VALUES
(1, 2, 'en', 'Gold', 'One of your classes will be displayed at the top of the category list and homepage slider'),
(2, 3, 'en', 'Bronze', 'One of your classes will be displayed at the top of the category list'),
(3, 4, 'en', 'Silver', 'One of your classes will be displayed at the homepage slider'),
(4, 2, 'es', 'Oro', 'Una de sus clases se mostrará en la parte superior de la lista de categorías y el control deslizante de la página de inicio.'),
(5, 2, 'ar', 'ذهب', 'سيتم عرض أحد فصولك الدراسية في أعلى قائمة الفئات وشريط تمرير الصفحة الرئيسية'),
(6, 4, 'ar', 'فضة', 'سيتم عرض إحدى فصولك الدراسية في شريط تمرير الصفحة الرئيسية'),
(7, 4, 'es', 'Plata', 'Una de sus clases se mostrará en el control deslizante de la página de inicio.'),
(8, 3, 'ar', 'برونزية', 'سيتم عرض أحد فصولك في أعلى قائمة الفئات'),
(9, 3, 'es', 'Bronce', 'Una de sus clases se mostrará en la parte superior de la lista de categorías.');

-- --------------------------------------------------------

--
-- Structure de la table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `purchase_code`
--

CREATE TABLE `purchase_code` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `product_type` varchar(255) NOT NULL DEFAULT 'main',
  `license_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `purchase_code`
--

INSERT INTO `purchase_code` (`id`, `code`, `product_type`, `license_type`, `created_at`, `updated_at`) VALUES
(1, '361b1d94-473c-49cc-897c-e09896dceba9', 'main', 'Regular License', '2025-11-14 16:26:31', '2025-11-14 16:26:31'),
(2, 'd64a812b-c0bd-4063-84fc-d6128360a925', 'plugin_bundle', 'Regular License', '2025-11-14 16:36:46', '2025-11-14 16:36:46'),
(3, '761d9da5-9b7d-486e-99a7-2c20c37befbc', 'theme_builder', 'Regular License', '2025-11-16 06:46:35', '2025-11-16 06:46:35');

-- --------------------------------------------------------

--
-- Structure de la table `purchase_notifications`
--

CREATE TABLE `purchase_notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `start_at` bigint(20) DEFAULT NULL,
  `end_at` bigint(20) DEFAULT NULL,
  `popup_duration` int(10) UNSIGNED DEFAULT NULL,
  `popup_delay` int(10) UNSIGNED DEFAULT NULL,
  `maximum_purchase_amount` int(10) UNSIGNED DEFAULT NULL,
  `maximum_community_age` int(10) UNSIGNED DEFAULT NULL,
  `display_type` enum('overall','per_session') NOT NULL,
  `display_time` int(10) UNSIGNED DEFAULT NULL,
  `display_for_logged_out_users` tinyint(1) NOT NULL DEFAULT 0,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `purchase_notifications`
--

INSERT INTO `purchase_notifications` (`id`, `start_at`, `end_at`, `popup_duration`, `popup_delay`, `maximum_purchase_amount`, `maximum_community_age`, `display_type`, `display_time`, `display_for_logged_out_users`, `enable`, `created_at`) VALUES
(1, 1709269200, 1868673600, 10, 30, NULL, NULL, 'per_session', 1, 1, 0, 1709375811);

-- --------------------------------------------------------

--
-- Structure de la table `purchase_notification_histories`
--

CREATE TABLE `purchase_notification_histories` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `purchase_notification_id` int(10) UNSIGNED NOT NULL,
  `display_type` enum('overall','per_session') NOT NULL,
  `count_view` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `session_ended` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Get True After the user login, we update all the per_session records'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `purchase_notification_roles_groups_contents`
--

CREATE TABLE `purchase_notification_roles_groups_contents` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_notification_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `purchase_notification_roles_groups_contents`
--

INSERT INTO `purchase_notification_roles_groups_contents` (`id`, `purchase_notification_id`, `role_id`, `group_id`, `webinar_id`, `bundle_id`, `product_id`) VALUES
(127, 1, 1, NULL, NULL, NULL, NULL),
(128, 1, 3, NULL, NULL, NULL, NULL),
(129, 1, 4, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `purchase_notification_translations`
--

CREATE TABLE `purchase_notification_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_notification_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `popup_title` varchar(255) NOT NULL,
  `popup_subtitle` varchar(255) NOT NULL,
  `users` text NOT NULL,
  `times` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `purchase_notification_translations`
--

INSERT INTO `purchase_notification_translations` (`id`, `purchase_notification_id`, `locale`, `title`, `popup_title`, `popup_subtitle`, `users`, `times`) VALUES
(1, 1, 'en', 'Test Sales Pop-up', '[user] has Purchased', '[user] purchase [content] for [price]', 'Jack Anderson, Cameron Schofield,Jade Harrison,Jessica Wray,James Kong', '10 mins ago,25 mins ago,1 hrs ago,5 mins ago,30 mins ago,2 hrs ago,2 mins ago,45 mins ago');

-- --------------------------------------------------------

--
-- Structure de la table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `chapter_id` int(10) UNSIGNED DEFAULT NULL,
  `time` int(11) DEFAULT 0,
  `attempt` int(11) DEFAULT NULL,
  `pass_mark` int(11) NOT NULL,
  `certificate` tinyint(1) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `total_mark` int(10) UNSIGNED DEFAULT NULL,
  `display_limited_questions` tinyint(1) NOT NULL DEFAULT 0,
  `display_number_of_questions` int(10) UNSIGNED DEFAULT NULL,
  `display_questions_randomly` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_days` int(10) UNSIGNED DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `quizzes`
--

INSERT INTO `quizzes` (`id`, `webinar_id`, `creator_id`, `chapter_id`, `time`, `attempt`, `pass_mark`, `certificate`, `status`, `total_mark`, `display_limited_questions`, `display_number_of_questions`, `display_questions_randomly`, `expiry_days`, `icon`, `created_at`, `updated_at`) VALUES
(43, 2064, 1129, 151, NULL, NULL, 10, 1, 'active', NULL, 0, NULL, 1, 10, '/store/1129/quizzes/43/icon.jpg', 1772491061, NULL),
(45, 2069, 1137, 155, NULL, 2, 10, 1, 'active', 20, 0, NULL, 0, 5, '/store/1137/quizzes/45/icon.jpg', 1774859003, 1774860043);

-- --------------------------------------------------------

--
-- Structure de la table `quizzes_questions`
--

CREATE TABLE `quizzes_questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `grade` varchar(255) NOT NULL,
  `negative_grade` int(11) DEFAULT NULL,
  `type` enum('multiple','descriptive') NOT NULL,
  `image` text DEFAULT NULL,
  `video` text DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `quizzes_questions`
--

INSERT INTO `quizzes_questions` (`id`, `quiz_id`, `creator_id`, `grade`, `negative_grade`, `type`, `image`, `video`, `order`, `created_at`, `updated_at`) VALUES
(79, 45, 1137, '10', 10, 'multiple', '/store/1137/quizzes/questions/79/question-image-79.jpg', NULL, 1, 1774859057, 1774859330),
(80, 45, 1137, '10', 10, 'multiple', NULL, NULL, 2, 1774860030, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `quizzes_questions_answers`
--

CREATE TABLE `quizzes_questions_answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `image` text DEFAULT NULL,
  `correct` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `quizzes_questions_answers`
--

INSERT INTO `quizzes_questions_answers` (`id`, `creator_id`, `question_id`, `image`, `correct`, `created_at`, `updated_at`) VALUES
(215, 1137, 79, '/store/1137/quizzes/questions/79/answer-image-215.jpg', 1, 1774859330, NULL),
(216, 1137, 80, NULL, 0, 1774860030, NULL),
(217, 1137, 80, NULL, 1, 1774860030, NULL),
(218, 1137, 80, NULL, 0, 1774860030, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `quizzes_questions_answer_translations`
--

CREATE TABLE `quizzes_questions_answer_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quizzes_questions_answer_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `quizzes_questions_answer_translations`
--

INSERT INTO `quizzes_questions_answer_translations` (`id`, `quizzes_questions_answer_id`, `locale`, `title`) VALUES
(145, 215, 'ar', 'الاستشارات'),
(146, 216, 'ar', 'الاستشارات'),
(147, 217, 'ar', 'gftfb'),
(148, 218, 'ar', 'ttg');

-- --------------------------------------------------------

--
-- Structure de la table `quizzes_results`
--

CREATE TABLE `quizzes_results` (
  `id` int(10) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `results` text DEFAULT NULL,
  `user_grade` int(11) DEFAULT NULL,
  `status` enum('passed','failed','waiting') NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `quizzes_results`
--

INSERT INTO `quizzes_results` (`id`, `quiz_id`, `user_id`, `results`, `user_grade`, `status`, `created_at`) VALUES
(58, 45, 1139, '{\"attempt_number\":\"2\"}', 0, 'failed', 1774859897);

-- --------------------------------------------------------

--
-- Structure de la table `quiz_question_translations`
--

CREATE TABLE `quiz_question_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quizzes_question_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text NOT NULL,
  `correct` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `quiz_question_translations`
--

INSERT INTO `quiz_question_translations` (`id`, `quizzes_question_id`, `locale`, `title`, `correct`) VALUES
(58, 79, 'ar', 'استشارات', NULL),
(59, 80, 'ar', 'استشارات', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `quiz_translations`
--

CREATE TABLE `quiz_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quiz_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `quiz_translations`
--

INSERT INTO `quiz_translations` (`id`, `quiz_id`, `locale`, `title`, `description`) VALUES
(20, 43, 'ar', 'باقة متكاملة للتربوي العام', NULL),
(22, 45, 'ar', 'الاستشارات', 'الاستشارات');

-- --------------------------------------------------------

--
-- Structure de la table `rating`
--

CREATE TABLE `rating` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `rate` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `regions`
--

CREATE TABLE `regions` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  `province_id` int(10) UNSIGNED DEFAULT NULL,
  `city_id` int(10) UNSIGNED DEFAULT NULL,
  `geo_center` point DEFAULT NULL,
  `type` enum('country','province','city','district') NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `regions`
--

INSERT INTO `regions` (`id`, `country_id`, `province_id`, `city_id`, `geo_center`, `type`, `title`, `created_at`) VALUES
(16, NULL, NULL, NULL, 0x000000000101000000502c37a3fd2748400000000000910440, 'country', 'France', 1646175250),
(17, NULL, NULL, NULL, 0x000000000101000000cc4c51ad1a29374000000000509c5340, 'country', 'India', 1646045215),
(18, NULL, NULL, NULL, 0x000000000101000000fc87794512fd434000000000787e58c0, 'country', 'United States', 1646208799),
(19, NULL, NULL, NULL, 0x000000000101000000c399e9d9582130400000000040da3240, 'country', 'Chad', 1646045318),
(20, NULL, NULL, NULL, 0x000000000101000000c914e2b7f634384000000000e0634640, 'country', 'Saudi Arabia', 1646045651),
(21, 16, NULL, NULL, 0x000000000101000000b7417d8d9700484000000000c01709c0, 'province', 'Brittany', 1646175600),
(22, 16, NULL, NULL, 0x000000000101000000c28d5422c26d484000000000e0b20240, 'province', 'Île-de-France', 1646176998),
(23, 16, 22, NULL, 0x00000000010100000043242b8d136e4840f6ffffff3dcd0240, 'city', 'Paris', 1646177038),
(24, 16, 22, 23, 0x000000000101000000f4056521416f4840f7ffff7f315a0240, 'district', 'Chaillot', 1646177131),
(25, 16, 22, 23, 0x000000000101000000fecb2c1406684840f9ffff7f26fc0140, 'district', 'Le val', 1646177195),
(26, 16, 22, 23, 0x000000000101000000da05b69e8a6d484008000000cd2e0340, 'district', 'Charonne', 1646177249),
(27, 17, NULL, NULL, 0x00000000010100000032073e5acab03c4004000000934a5340, 'province', 'Delhi', 1646177430),
(28, 17, NULL, NULL, 0x000000000101000000e7331bb0e31333400200008025395240, 'province', 'Maharashtra', 1646177529),
(29, 17, 27, NULL, 0x0000000001010000004ea45133209e3c4002000050f54c5340, 'city', 'New Delhi', 1646177585),
(30, 17, 28, NULL, 0x0000000001010000000fd66a9d27f13240040000305b355240, 'city', 'Mumbai', 1646177660),
(31, 20, NULL, NULL, 0x0000000001010000005aa3dd6a75923840070000004acf4340, 'province', 'Medina', 1646207588),
(32, 20, 31, NULL, 0x0000000001010000007522ebce077938400500005028ce4340, 'city', 'Medina', 1646207641),
(33, 20, NULL, NULL, 0x000000000101000000f87d72b19dd33840000000007c5d4740, 'province', 'Riyadh', 1646207846),
(34, 20, 33, NULL, 0x0000000001010000003352eaadc2a23840050000207c5b4740, 'city', 'Riyadh', 1646207899),
(35, 17, 27, 29, 0x000000000101000000677eaddc83933c40000000f4e44f5340, 'district', 'Jal vihar', 1646208038),
(36, 17, 27, 29, 0x0000000001010000000c564b253b8f3c40030000f4f54d5340, 'district', 'Anand lok', 1646208100),
(37, 17, 28, 30, 0x000000000101000000744a1102cef732400000003c9b345240, 'district', 'Tardeo', 1646208151),
(38, 17, 28, 30, 0x000000000101000000e1347d6ea4ed32400000009235355240, 'district', 'Kala ghoda', 1646208227),
(39, 17, 28, 30, 0x0000000001010000007f59b3f397003340feffffa36f345240, 'district', 'Nehru nagar', 1646208287),
(40, 20, 31, 32, 0x0000000001010000009f9a107be67a3840fcfffff32bcc4340, 'district', 'Al fath', 1646208357),
(41, 20, 31, 32, 0x0000000001010000004a9335c11e7c384001000084fbd54340, 'district', 'Al mabuth', 1646208449),
(42, 20, 33, 34, 0x000000000101000000ecdbbe5e4ca438400400001821554740, 'district', 'Al rafiah', 1646208501),
(43, 20, 33, 34, 0x00000000010100000047a393f74fa83840fdffff8f195d4740, 'district', 'Al malaz', 1646208541),
(44, 20, 33, 34, 0x000000000101000000b3cc5d99029b384004000090d3574740, 'district', 'Sultanah', 1646208741),
(45, 18, NULL, NULL, 0x0000000001010000008a421c62479242402300000002ef5dc0, 'province', 'California', 1646208923),
(46, 18, NULL, NULL, 0x00000000010100000073bb0212f86a4540000000006add52c0, 'province', 'New York', 1646209125),
(47, 18, 45, NULL, 0x000000000101000000c0eb475b13e44240e2ffffafd29a5ec0, 'city', 'San Francisco', 1646209213),
(48, 18, 45, NULL, 0x000000000101000000996d3806e37c4240f8fffff7ee815ec0, 'city', 'Santa Cruz', 1646209310),
(49, 18, 46, NULL, 0x0000000001010000002ff3954dd15d4440020000504b7f52c0, 'city', 'New York', 1646209459),
(50, 18, 46, NULL, 0x00000000010100000035c4cc6279534540000000b85b7052c0, 'city', 'Albany', 1646209552),
(51, 18, 45, 47, 0x0000000001010000003aeafdd6abe04240faffffd7b49f5ec0, 'district', 'Sunset district', 1646209607),
(52, 18, 45, 47, 0x0000000001010000001d646d8c1bdf4240f1ffff57859a5ec0, 'district', 'Bernal heights', 1646209668),
(53, 18, 45, 48, 0x000000000101000000798fe4b88f7b4240220000d4f3825ec0, 'district', 'Westside', 1646209704),
(54, 18, 45, 48, 0x0000000001010000000ea4fdcb187c4240e4ffffdb84805ec0, 'district', 'Seabright', 1646209756),
(55, 18, 46, 49, 0x000000000101000000502d3717765b444003000064278052c0, 'district', 'Civic center', 1646209822),
(56, 18, 46, 49, 0x000000000101000000895ffa4836624440fffffff7687d52c0, 'district', 'Lenox hill', 1646209902),
(57, 18, 46, 50, 0x0000000001010000002a11fd866f5445400400000c7e7252c0, 'district', 'Pine hills', 1646209945),
(58, 18, 46, 50, 0x000000000101000000132a6a90cb5445400400000a557052c0, 'district', 'Arbor hill', 1646209990),
(59, 19, NULL, NULL, 0x000000000101000000e02f3b6e02472840f2ffffff83122e40, 'province', 'N\'Djaména', 1646210607),
(60, 19, 59, NULL, 0x0000000001010000000b5659aeba3d284018000040c4192e40, 'city', 'N\'Djaména', 1646210643),
(61, 19, NULL, NULL, 0x000000000101000000776860c6695021400e00000094103040, 'province', 'Logone Occidental', 1646210813),
(62, 19, 61, NULL, 0x000000000101000000d1cf427b71222140030000a0e2123040, 'city', 'Moundou', 1646210881),
(63, 19, 59, 60, 0x0000000001010000002e2f2cc30d312840e6ffffdf71262e40, 'district', 'Moursal', 1646210978),
(64, 19, 59, 60, 0x0000000001010000009f93ddbcdc392840f1ffff9feb192e40, 'district', 'Blabline', 1646211027),
(65, 19, 61, 62, 0x0000000001010000000b91007923232140f7ffff9732163040, 'district', 'Bornou', 1646211077),
(66, 19, 61, 62, 0x0000000001010000006b07cb49aa192140f6ffffa7650f3040, 'district', 'Dokapti', 1646211168),
(67, 16, 21, NULL, 0x00000000010100000018e23f51690e4840fffffffff1e3fabf, 'city', 'Rennes', 1646295560),
(68, 16, 21, 67, 0x0000000001010000001d2d3bd0140e4840060000009f54fbbf, 'district', 'Moulin du comte', 1646295696);

-- --------------------------------------------------------

--
-- Structure de la table `registration_packages`
--

CREATE TABLE `registration_packages` (
  `id` int(10) UNSIGNED NOT NULL,
  `days` int(10) UNSIGNED NOT NULL,
  `price` double(15,2) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `role` enum('instructors','organizations') NOT NULL,
  `instructors_count` int(11) DEFAULT NULL,
  `students_count` int(11) DEFAULT NULL,
  `courses_capacity` int(11) DEFAULT NULL,
  `courses_count` int(11) DEFAULT NULL,
  `meeting_count` int(11) DEFAULT NULL,
  `product_count` int(10) UNSIGNED DEFAULT NULL,
  `ai_content_access` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('disabled','active') NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `registration_packages`
--

INSERT INTO `registration_packages` (`id`, `days`, `price`, `icon`, `role`, `instructors_count`, `students_count`, `courses_capacity`, `courses_count`, `meeting_count`, `product_count`, `ai_content_access`, `status`, `created_at`) VALUES
(1, 30, 99.00, '/store/1/default_images/subscribe_packages/subscribe_icon_1.svg', 'instructors', NULL, NULL, 60, 50, 60, 30, 0, 'active', 1752178583),
(2, 90, 199.00, '/store/1/default_images/subscribe_packages/subscribe_icon_2.svg', 'instructors', NULL, NULL, 80, 60, 80, 40, 0, 'active', 1752178603),
(3, 180, 400.00, '/store/1/default_images/subscribe_packages/subscribe_icon_2.svg', 'instructors', NULL, NULL, 100, 80, 100, 60, 0, 'active', 1752178623),
(4, 30, 200.00, '/store/1/default_images/subscribe_packages/subscribe_icon_1.svg', 'organizations', 5, 50, 40, 10, 30, NULL, 0, 'active', 1749394134),
(5, 90, 400.00, '/store/1/default_images/subscribe_packages/subscribe_icon_2.svg', 'organizations', 10, 100, 70, 20, 50, NULL, 0, 'active', 1749394152),
(6, 180, 600.00, '/store/1/default_images/subscribe_packages/subscribe_icon_3.svg', 'organizations', 30, 300, 150, 50, 100, NULL, 0, 'active', 1749394185);

-- --------------------------------------------------------

--
-- Structure de la table `registration_packages_translations`
--

CREATE TABLE `registration_packages_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `registration_package_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `registration_packages_translations`
--

INSERT INTO `registration_packages_translations` (`id`, `registration_package_id`, `locale`, `title`, `description`) VALUES
(1, 1, 'en', 'Basic', 'Suggested for starter instructors.'),
(2, 2, 'en', 'Pro', 'Suggested for professional instructors.'),
(3, 3, 'en', 'Premium', 'Suggested for expert instructors.'),
(4, 4, 'en', 'Basic', 'Suggested for small organizations'),
(5, 5, 'en', 'Pro', 'Suggested for medium organizations'),
(6, 6, 'en', 'Premium', 'Suggested for big organizations');

-- --------------------------------------------------------

--
-- Structure de la table `related_courses`
--

CREATE TABLE `related_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED DEFAULT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `related_posts`
--

CREATE TABLE `related_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(11) NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `related_products`
--

CREATE TABLE `related_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reserve_meetings`
--

CREATE TABLE `reserve_meetings` (
  `id` int(10) UNSIGNED NOT NULL,
  `meeting_id` int(11) DEFAULT NULL,
  `sale_id` int(10) UNSIGNED DEFAULT NULL,
  `meeting_time_id` int(10) UNSIGNED NOT NULL,
  `day` varchar(10) NOT NULL,
  `date` int(10) UNSIGNED NOT NULL,
  `start_at` bigint(20) UNSIGNED NOT NULL,
  `end_at` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `paid_amount` decimal(13,2) NOT NULL,
  `meeting_type` enum('in_person','online') NOT NULL DEFAULT 'online',
  `student_count` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','open','finished','canceled') NOT NULL,
  `created_at` int(11) NOT NULL,
  `locked_at` int(11) DEFAULT NULL,
  `reserved_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `rewards`
--

CREATE TABLE `rewards` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') NOT NULL,
  `score` int(10) UNSIGNED DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `status` enum('active','disabled') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `rewards`
--

INSERT INTO `rewards` (`id`, `type`, `score`, `condition`, `status`, `created_at`) VALUES
(3, 'charge_wallet', 50, '150', 'active', 1641205067),
(4, 'account_charge', 50, '100', 'active', 1641369989),
(5, 'badge', NULL, NULL, 'active', 1641300755),
(6, 'create_classes', 50, NULL, 'active', 1641369921),
(7, 'buy', 50, '10', 'active', 1641369938),
(8, 'pass_the_quiz', 50, NULL, 'active', 1641369947),
(9, 'certificate', 30, NULL, 'active', 1641369955),
(11, 'register', 5, NULL, 'active', 1641370008),
(12, 'review_courses', 15, NULL, 'active', 1641370016),
(13, 'instructor_meeting_reserve', 30, NULL, 'active', 1641370026),
(14, 'student_meeting_reserve', 30, NULL, 'active', 1641370036),
(15, 'newsletters', 10, NULL, 'active', 1641370050),
(16, 'referral', 5, NULL, 'active', 1641370059),
(18, 'learning_progress_100', 20, NULL, 'active', 1641372957),
(19, 'buy_store_product', 50, '26', 'active', 1648277874),
(20, 'pass_assignment', 50, NULL, 'active', 1649247227),
(21, 'make_topic', 1, NULL, 'active', 1650548269),
(23, 'create_blog_by_instructor', 5, NULL, 'active', 1650788324);

-- --------------------------------------------------------

--
-- Structure de la table `rewards_accounting`
--

CREATE TABLE `rewards_accounting` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('account_charge','create_classes','buy','pass_the_quiz','certificate','comment','register','review_courses','instructor_meeting_reserve','student_meeting_reserve','newsletters','badge','referral','learning_progress_100','charge_wallet','withdraw','buy_store_product','pass_assignment','send_post_in_topic','make_topic','create_blog_by_instructor','comment_for_instructor_blog') NOT NULL,
  `score` int(10) UNSIGNED NOT NULL,
  `status` enum('addiction','deduction') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `rewards_accounting`
--

INSERT INTO `rewards_accounting` (`id`, `user_id`, `item_id`, `type`, `score`, `status`, `created_at`) VALUES
(77, 1, 23, 'badge', 15, 'addiction', 1655618081),
(263, 1070, 1070, 'register', 5, 'addiction', 1764148515),
(267, 1070, 21, 'badge', 5, 'addiction', 1764432574),
(269, 1074, 21, 'badge', 5, 'addiction', 1764668094),
(282, 1109, 1109, 'register', 5, 'addiction', 1766488440),
(283, 1074, 22, 'badge', 10, 'addiction', 1767150059),
(284, 1070, 22, 'badge', 10, 'addiction', 1767864214),
(288, 1113, 21, 'badge', 5, 'addiction', 1770107858),
(300, 1129, 1129, 'register', 5, 'addiction', 1772401047),
(301, 1129, 21, 'badge', 5, 'addiction', 1772489223),
(302, 1129, 24, 'badge', 10, 'addiction', 1772491082),
(304, 1113, 22, 'badge', 10, 'addiction', 1772577837),
(308, 1134, 1134, 'register', 5, 'addiction', 1772591181),
(309, 1135, 1135, 'register', 5, 'addiction', 1772789740),
(310, 1129, 25, 'badge', 20, 'addiction', 1772940550),
(311, 1136, 1136, 'register', 5, 'addiction', 1772967925),
(312, 1136, 24, 'badge', 10, 'addiction', 1772971140),
(313, 1136, 21, 'badge', 5, 'addiction', 1773017337),
(314, 1129, 26, 'badge', 30, 'addiction', 1773328293),
(315, 1137, 1137, 'register', 5, 'addiction', 1774782685),
(316, 1051, 22, 'badge', 10, 'addiction', 1774808404),
(317, 1138, 1138, 'register', 5, 'addiction', 1774808438),
(318, 1138, 21, 'badge', 5, 'addiction', 1774856612),
(319, 1137, 21, 'badge', 5, 'addiction', 1774859343),
(320, 1137, 24, 'badge', 10, 'addiction', 1774859343),
(321, 1139, 1139, 'register', 5, 'addiction', 1774859795),
(322, 1137, 25, 'badge', 20, 'addiction', 1774860247),
(323, 1140, 1140, 'register', 5, 'addiction', 1775021573),
(324, 1138, 24, 'badge', 10, 'addiction', 1775168572),
(325, 1129, 22, 'badge', 10, 'addiction', 1775906272),
(326, 1137, 2071, 'create_classes', 50, 'addiction', 1776097231),
(327, 1137, 26, 'badge', 30, 'addiction', 1776097258),
(328, 1136, 22, 'badge', 10, 'addiction', 1776272231),
(329, 1140, 21, 'badge', 5, 'addiction', 1776618713),
(330, 1137, 2072, 'create_classes', 50, 'addiction', 1777144836),
(331, 1137, 22, 'badge', 10, 'addiction', 1777458776),
(332, 1138, 22, 'badge', 10, 'addiction', 1777490429);

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `users_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `users_count`, `is_admin`, `created_at`) VALUES
(1, 'user', 0, 0, 1604418504),
(2, 'admin', 0, 1, 1604418504),
(3, 'organization', 0, 0, 1604418504),
(4, 'teacher', 0, 0, 1604418504),
(6, 'education', 0, 1, 1613370817);

-- --------------------------------------------------------

--
-- Structure de la table `role_translations`
--

CREATE TABLE `role_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `caption` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role_translations`
--

INSERT INTO `role_translations` (`id`, `role_id`, `locale`, `caption`) VALUES
(1, 1, 'en', 'Student'),
(2, 1, 'ar', 'طالب'),
(3, 1, 'es', 'Alumna'),
(4, 2, 'en', 'Admin'),
(5, 2, 'es', 'Administradora'),
(6, 2, 'ar', 'مسؤل'),
(7, 3, 'en', 'Organization'),
(8, 3, 'ar', 'منظمة'),
(9, 3, 'es', 'Organización'),
(10, 4, 'en', 'Instructor'),
(11, 4, 'es', 'Instructora'),
(12, 4, 'ar', 'مدرب'),
(13, 6, 'en', 'Staff'),
(14, 6, 'ar', 'طاقم عمل'),
(15, 6, 'es', 'Personal');

-- --------------------------------------------------------

--
-- Structure de la table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL,
  `buyer_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `meeting_id` int(10) UNSIGNED DEFAULT NULL,
  `meeting_time_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `ticket_id` int(10) UNSIGNED DEFAULT NULL,
  `promotion_id` int(10) UNSIGNED DEFAULT NULL,
  `product_order_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL,
  `installment_payment_id` int(10) UNSIGNED DEFAULT NULL,
  `gift_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_method` enum('credit','payment_channel','subscribe') DEFAULT NULL,
  `type` enum('webinar','meeting','subscribe','promotion','registration_package','product','bundle','installment_payment','gift') NOT NULL,
  `amount` decimal(13,2) UNSIGNED NOT NULL,
  `tax` decimal(13,2) UNSIGNED DEFAULT NULL,
  `commission` decimal(13,2) UNSIGNED DEFAULT NULL,
  `discount` decimal(13,2) UNSIGNED DEFAULT NULL,
  `total_amount` decimal(13,2) UNSIGNED DEFAULT NULL,
  `product_delivery_fee` decimal(13,2) UNSIGNED DEFAULT NULL,
  `manual_added` tinyint(1) NOT NULL DEFAULT 0,
  `access_to_purchased_item` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` int(10) UNSIGNED NOT NULL,
  `refund_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sales`
--

INSERT INTO `sales` (`id`, `seller_id`, `buyer_id`, `order_id`, `webinar_id`, `bundle_id`, `meeting_id`, `meeting_time_id`, `subscribe_id`, `ticket_id`, `promotion_id`, `product_order_id`, `registration_package_id`, `installment_payment_id`, `gift_id`, `payment_method`, `type`, `amount`, `tax`, `commission`, `discount`, `total_amount`, `product_delivery_fee`, `manual_added`, `access_to_purchased_item`, `created_at`, `refund_at`) VALUES
(1, 1129, 1130, NULL, 2064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'credit', 'webinar', 0.00, NULL, NULL, NULL, 0.00, NULL, 0, 1, 1772557205, NULL),
(2, 1137, 1139, NULL, 2069, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'credit', 'webinar', 0.00, NULL, NULL, NULL, 0.00, NULL, 0, 1, 1774859830, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sales_log`
--

CREATE TABLE `sales_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `viewed_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sales_log`
--

INSERT INTO `sales_log` (`id`, `sale_id`, `viewed_at`) VALUES
(1, 1, 1772967470);

-- --------------------------------------------------------

--
-- Structure de la table `sections`
--

CREATE TABLE `sections` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `section_group_id` int(10) UNSIGNED DEFAULT NULL,
  `caption` varchar(128) NOT NULL,
  `type` enum('admin','panel') NOT NULL DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sections`
--

INSERT INTO `sections` (`id`, `name`, `section_group_id`, `caption`, `type`) VALUES
(1, 'admin_general_dashboard', NULL, 'General Dashboard', 'admin'),
(2, 'admin_general_dashboard_show', 1, 'General Dashboard page', 'admin'),
(3, 'admin_general_dashboard_quick_access_links', 1, 'Quick access links in General Dashboard', 'admin'),
(4, 'admin_general_dashboard_daily_sales_statistics', 1, 'Daily Sales Type Statistics Section', 'admin'),
(5, 'admin_general_dashboard_income_statistics', 1, 'Income Statistics Section', 'admin'),
(6, 'admin_general_dashboard_total_sales_statistics', 1, 'Total Sales Statistics Section', 'admin'),
(7, 'admin_general_dashboard_new_sales', 1, 'New Sales Section', 'admin'),
(8, 'admin_general_dashboard_new_comments', 1, 'New Comments Section', 'admin'),
(9, 'admin_general_dashboard_new_tickets', 1, 'New Tickets Section', 'admin'),
(10, 'admin_general_dashboard_new_reviews', 1, 'New Reviews Section', 'admin'),
(11, 'admin_general_dashboard_sales_statistics_chart', 1, 'Sales Statistics Chart', 'admin'),
(12, 'admin_general_dashboard_recent_comments', 1, 'Recent comments Section', 'admin'),
(13, 'admin_general_dashboard_recent_tickets', 1, 'Recent tickets Section', 'admin'),
(14, 'admin_general_dashboard_recent_webinars', 1, 'Recent webinars Section', 'admin'),
(15, 'admin_general_dashboard_recent_courses', 1, 'Recent courses Section', 'admin'),
(16, 'admin_general_dashboard_users_statistics_chart', 1, 'Users Statistics Chart', 'admin'),
(17, 'admin_clear_cache', 1, 'Clear cache', 'admin'),
(25, 'admin_marketing_dashboard', NULL, 'Marketing Dashboard', 'admin'),
(26, 'admin_marketing_dashboard_show', 25, 'Marketing Dashboard page', 'admin'),
(50, 'admin_roles', NULL, 'الادوار', 'admin'),
(51, 'admin_roles_list', 50, 'قائمة الادوار', 'admin'),
(52, 'admin_roles_create', 50, 'انشاء ادوار', 'admin'),
(53, 'admin_roles_edit', 50, 'تعديل ادوار', 'admin'),
(54, 'admin_roles_delete', 50, 'حذف ادوار', 'admin'),
(100, 'admin_users', NULL, 'المستخدمون', 'admin'),
(101, 'admin_staffs_list', 100, 'Staffs list', 'admin'),
(102, 'admin_users_list', 100, 'Students list', 'admin'),
(103, 'admin_instructors_list', 100, 'Instructors list', 'admin'),
(104, 'admin_organizations_list', 100, 'Organizations list', 'admin'),
(105, 'admin_users_create', 100, 'انشاء مستخدمين', 'admin'),
(106, 'admin_users_edit', 100, 'تعديل المستخدمين', 'admin'),
(107, 'admin_users_delete', 100, 'حذف المستخدمين', 'admin'),
(108, 'admin_users_export_excel', 100, 'List Export excel', 'admin'),
(109, 'admin_users_badges', 100, 'شارات المستخدمين', 'admin'),
(110, 'admin_users_badges_edit', 100, 'Badges edit', 'admin'),
(111, 'admin_users_badges_delete', 100, 'Badges delete', 'admin'),
(112, 'admin_users_impersonate', 100, 'users impersonate (login by users)', 'admin'),
(113, 'admin_become_instructors_list', 100, 'Lists of requests for become instructors', 'admin'),
(114, 'admin_become_instructors_reject', 100, 'Reject requests for become instructors', 'admin'),
(115, 'admin_become_instructors_delete', 100, 'Delete requests for become instructors', 'admin'),
(116, 'admin_update_user_registration_package', 100, 'Edit user registration package', 'admin'),
(117, 'admin_update_user_meeting_settings', 100, 'Edit user meeting settings', 'admin'),
(118, 'admin_update_user_role_in_edit_page', 100, 'Update User role in edit page', 'admin'),
(150, 'admin_webinars', NULL, 'المناقشات', 'admin'),
(151, 'admin_webinars_list', 150, 'قائمة المناقشات', 'admin'),
(152, 'admin_webinars_create', 150, 'انشاء مناقشة', 'admin'),
(153, 'admin_webinars_edit', 150, 'تعديل المناقشات', 'admin'),
(154, 'admin_webinars_delete', 150, 'حذف المناقشات', 'admin'),
(155, 'admin_webinars_export_excel', 150, 'Export excel webinars list', 'admin'),
(156, 'admin_feature_webinars', 150, 'Feature webinars list', 'admin'),
(157, 'admin_feature_webinars_create', 150, 'create feature webinar', 'admin'),
(158, 'admin_feature_webinars_export_excel', 150, 'Feature webinar export excel', 'admin'),
(159, 'admin_webinar_students_lists', 150, 'Webinar students Lists', 'admin'),
(160, 'admin_webinar_students_delete', 150, 'Webinar students delete', 'admin'),
(161, 'admin_webinar_notification_to_students', 150, 'Send notification to course students', 'admin'),
(162, 'admin_webinar_statistics', 150, 'Course statistics', 'admin'),
(163, 'admin_agora_history_list', 150, 'Agora history lists', 'admin'),
(164, 'admin_agora_history_export', 150, 'Agora history export', 'admin'),
(165, 'admin_course_question_forum_list', 150, 'Forum Question Lists', 'admin'),
(166, 'admin_course_question_forum_answers', 150, 'Forum Answers Lists', 'admin'),
(167, 'admin_course_personal_notes', 150, 'Course Personal Notes', 'admin'),
(200, 'admin_categories', NULL, 'الفئات', 'admin'),
(201, 'admin_categories_list', 200, 'قائمة الفئات', 'admin'),
(202, 'admin_categories_create', 200, 'انشاء فئات', 'admin'),
(203, 'admin_categories_edit', 200, 'تعديل الفئات', 'admin'),
(204, 'admin_categories_delete', 200, 'حذف الفئات', 'admin'),
(205, 'admin_trending_categories', 200, 'Trends Categories List', 'admin'),
(206, 'admin_create_trending_categories', 200, 'Create Trend Categories', 'admin'),
(207, 'admin_edit_trending_categories', 200, 'Edit Trend Categories', 'admin'),
(208, 'admin_delete_trending_categories', 200, 'Delete Trend Categories', 'admin'),
(250, 'admin_tags', NULL, 'العلامات', 'admin'),
(251, 'admin_tags_list', 250, 'قائمة العلامات', 'admin'),
(252, 'admin_tags_create', 250, 'انشاء علامات', 'admin'),
(253, 'admin_tags_edit', 250, 'تعديل العلامات', 'admin'),
(254, 'admin_tags_delete', 250, 'حذف العلامات', 'admin'),
(300, 'admin_filters', NULL, 'المرشحات', 'admin'),
(301, 'admin_filters_list', 300, 'قائمة المرشحات', 'admin'),
(302, 'admin_filters_create', 300, 'المرشحات إنشاء', 'admin'),
(303, 'admin_filters_edit', 300, 'المرشحات تحرير', 'admin'),
(304, 'admin_filters_delete', 300, 'المرشحات حذف', 'admin'),
(350, 'admin_quizzes', NULL, 'الاختبارات', 'admin'),
(351, 'admin_quizzes_list', 350, 'قائمة الاختبارات', 'admin'),
(352, 'admin_quizzes_create', 350, 'Create Quiz', 'admin'),
(353, 'admin_quizzes_edit', 350, 'Edit Quiz', 'admin'),
(354, 'admin_quizzes_delete', 350, 'Delete Quiz', 'admin'),
(355, 'admin_quizzes_results', 350, 'Quizzes results', 'admin'),
(356, 'admin_quizzes_results_delete', 350, 'Quizzes results delete', 'admin'),
(357, 'admin_quizzes_lists_excel', 350, 'Quizzes export excel', 'admin'),
(400, 'admin_quiz_result', NULL, 'نتيجة الاختبار', 'admin'),
(401, 'admin_quiz_result_list', 400, 'قائمة نتيجة الاختبار', 'admin'),
(402, 'admin_quiz_result_create', 400, 'انشاء نتيجة اختبار', 'admin'),
(403, 'admin_quiz_result_edit', 400, 'تعديل نتيجة اختبار', 'admin'),
(404, 'admin_quiz_result_delete', 400, 'حذف نتيجة اختبار', 'admin'),
(405, 'admin_quiz_result_review', 400, 'Review Result', 'admin'),
(406, 'admin_quiz_result_export_excel', 400, 'quiz result export excel', 'admin'),
(450, 'admin_certificate', NULL, 'شهادة', 'admin'),
(451, 'admin_certificate_list', 450, 'قائمة الشهادات', 'admin'),
(452, 'admin_certificate_create', 450, 'انشاء شهادة', 'admin'),
(453, 'admin_certificate_edit', 450, 'تعديل شهادة', 'admin'),
(454, 'admin_certificate_delete', 450, 'حذف شهادة', 'admin'),
(455, 'admin_certificate_template_list', 450, 'Certificate template lists', 'admin'),
(456, 'admin_certificate_template_create', 450, 'Certificate template create', 'admin'),
(457, 'admin_certificate_template_edit', 450, 'Certificate template edit', 'admin'),
(458, 'admin_certificate_template_delete', 450, 'Certificate template delete', 'admin'),
(459, 'admin_certificate_export_excel', 450, 'Certificates export excel', 'admin'),
(460, 'admin_course_certificate_list', 450, 'Course Competition Certificates', 'admin'),
(461, 'admin_certificate_settings', 450, 'Settings', 'admin'),
(500, 'admin_discount_codes', NULL, 'Discount codes', 'admin'),
(501, 'admin_discount_codes_list', 500, 'Discount codes list', 'admin'),
(502, 'admin_discount_codes_create', 500, 'Discount codes create', 'admin'),
(503, 'admin_discount_codes_edit', 500, 'Discount codes edit', 'admin'),
(504, 'admin_discount_codes_delete', 500, 'Discount codes delete', 'admin'),
(505, 'admin_discount_codes_export', 500, 'Discount codes export excel', 'admin'),
(550, 'admin_group', NULL, 'المجموعات', 'admin'),
(551, 'admin_group_list', 550, 'قائمة المجموعات', 'admin'),
(552, 'admin_group_create', 550, 'انشاء مجموعات', 'admin'),
(553, 'admin_group_edit', 550, 'تعديل المجموعات', 'admin'),
(554, 'admin_group_delete', 550, 'حذف المجموعات', 'admin'),
(555, 'admin_update_group_registration_package', 550, 'Update group registration package', 'admin'),
(600, 'admin_payment_channel', NULL, 'قنوات الدفع', 'admin'),
(601, 'admin_payment_channel_list', 600, 'قائمة قنوات الدفع', 'admin'),
(602, 'admin_payment_channel_toggle_status', 600, 'active or inactive channel', 'admin'),
(603, 'admin_payment_channel_edit', 600, 'تعديل قنوات الدفع', 'admin'),
(650, 'admin_settings', NULL, 'settings', 'admin'),
(651, 'admin_settings_general', 650, 'General settings', 'admin'),
(652, 'admin_settings_financial', 650, 'Financial settings', 'admin'),
(653, 'admin_settings_personalization', 650, 'Personalization settings', 'admin'),
(654, 'admin_settings_notifications', 650, 'Notifications settings', 'admin'),
(655, 'admin_settings_seo', 650, 'Seo settings', 'admin'),
(656, 'admin_settings_update_app', 650, 'Update App settings', 'admin'),
(657, 'admin_settings_mobile_app', 650, 'Mobile App settings', 'admin'),
(658, 'admin_settings_home_sections', 650, 'Home sections settings', 'admin'),
(700, 'admin_blog', NULL, 'Blog', 'admin'),
(701, 'admin_blog_lists', 700, 'Blog lists', 'admin'),
(702, 'admin_blog_create', 700, 'Blog create', 'admin'),
(703, 'admin_blog_edit', 700, 'Blog edit', 'admin'),
(704, 'admin_blog_delete', 700, 'Blog delete', 'admin'),
(705, 'admin_blog_categories', 700, 'Blog categories list', 'admin'),
(706, 'admin_blog_categories_create', 700, 'Blog categories create', 'admin'),
(707, 'admin_blog_categories_edit', 700, 'Blog categories edit', 'admin'),
(708, 'admin_blog_categories_delete', 700, 'Blog categories delete', 'admin'),
(709, 'admin_blog_featured_categories', 700, 'Blog Featured Categories (List/Create/Delete)', 'admin'),
(710, 'admin_blog_featured_contents', 700, 'Blog Featured Contents (List/Create/Delete)', 'admin'),
(750, 'admin_sales', NULL, 'Sales', 'admin'),
(751, 'admin_sales_list', 750, 'Sales List', 'admin'),
(752, 'admin_sales_refund', 750, 'Sales Refund', 'admin'),
(753, 'admin_sales_invoice', 750, 'Sales invoice', 'admin'),
(754, 'admin_sales_export', 750, 'Sales Export Excel', 'admin'),
(800, 'admin_documents', NULL, 'Balances', 'admin'),
(801, 'admin_documents_list', 800, 'Balances List', 'admin'),
(802, 'admin_documents_create', 800, 'Balances Create', 'admin'),
(803, 'admin_documents_print', 800, 'Balances print', 'admin'),
(850, 'admin_payouts', NULL, 'Payout', 'admin'),
(851, 'admin_payouts_list', 850, 'Payout List', 'admin'),
(852, 'admin_payouts_reject', 850, 'Payout Reject', 'admin'),
(853, 'admin_payouts_payout', 850, 'Payout accept', 'admin'),
(854, 'admin_payouts_export_excel', 850, 'Payout export excel', 'admin'),
(900, 'admin_offline_payments', NULL, 'Offline Payments', 'admin'),
(901, 'admin_offline_payments_list', 900, 'Offline Payments List', 'admin'),
(902, 'admin_offline_payments_reject', 900, 'Offline Payments Reject', 'admin'),
(903, 'admin_offline_payments_approved', 900, 'Offline Payments Approved', 'admin'),
(904, 'admin_offline_payments_export_excel', 900, 'Offline Payments export excel', 'admin'),
(950, 'admin_supports', NULL, 'Supports', 'admin'),
(951, 'admin_supports_list', 950, 'Supports List', 'admin'),
(952, 'admin_support_send', 950, 'Send Support', 'admin'),
(953, 'admin_supports_reply', 950, 'Supports reply', 'admin'),
(954, 'admin_supports_delete', 950, 'Supports delete', 'admin'),
(955, 'admin_support_departments', 950, 'Support departments lists', 'admin'),
(956, 'admin_support_department_create', 950, 'Create support department', 'admin'),
(957, 'admin_support_departments_edit', 950, 'Edit support departments', 'admin'),
(958, 'admin_support_departments_delete', 950, 'Delete support department', 'admin'),
(959, 'admin_support_course_conversations', 950, 'Course conversations', 'admin'),
(1000, 'admin_subscribe', NULL, 'Subscribes', 'admin'),
(1001, 'admin_subscribe_list', 1000, 'Subscribes list', 'admin'),
(1002, 'admin_subscribe_create', 1000, 'Subscribes create', 'admin'),
(1003, 'admin_subscribe_edit', 1000, 'Subscribes edit', 'admin'),
(1004, 'admin_subscribe_delete', 1000, 'Subscribes delete', 'admin'),
(1050, 'admin_notifications', NULL, 'Notifications', 'admin'),
(1051, 'admin_notifications_list', 1050, 'Notifications list', 'admin'),
(1052, 'admin_notifications_send', 1050, 'Send Notifications', 'admin'),
(1053, 'admin_notifications_edit', 1050, 'Edit and details Notifications', 'admin'),
(1054, 'admin_notifications_delete', 1050, 'Delete Notifications', 'admin'),
(1055, 'admin_notifications_markAllRead', 1050, 'Mark All Read Notifications', 'admin'),
(1056, 'admin_notifications_templates', 1050, 'Notifications templates', 'admin'),
(1057, 'admin_notifications_template_create', 1050, 'Create notification template', 'admin'),
(1058, 'admin_notifications_template_edit', 1050, 'Edit notification template', 'admin'),
(1059, 'admin_notifications_template_delete', 1050, 'Delete notification template', 'admin'),
(1060, 'admin_notifications_posted_list', 1050, 'Notifications Posted list', 'admin'),
(1075, 'admin_noticeboards', NULL, 'Noticeboards', 'admin'),
(1076, 'admin_noticeboards_list', 1075, 'Noticeboards list', 'admin'),
(1077, 'admin_noticeboards_send', 1075, 'Send Noticeboards', 'admin'),
(1078, 'admin_noticeboards_edit', 1075, 'Edit Noticeboards', 'admin'),
(1079, 'admin_noticeboards_delete', 1075, 'Delete Noticeboards', 'admin'),
(1080, 'admin_course_noticeboards_list', 1075, 'Course Noticeboards list', 'admin'),
(1081, 'admin_course_noticeboards_send', 1075, 'Send Course Noticeboards', 'admin'),
(1082, 'admin_course_noticeboards_edit', 1075, 'Edit Course Noticeboards', 'admin'),
(1083, 'admin_course_noticeboards_delete', 1075, 'Delete Course Noticeboards', 'admin'),
(1100, 'admin_promotion', NULL, 'Promotions', 'admin'),
(1101, 'admin_promotion_list', 1100, 'Promotions list', 'admin'),
(1102, 'admin_promotion_create', 1100, 'Promotion create', 'admin'),
(1103, 'admin_promotion_edit', 1100, 'Promotion edit', 'admin'),
(1104, 'admin_promotion_delete', 1100, 'Promotion delete', 'admin'),
(1150, 'admin_testimonials', NULL, 'testimonials', 'admin'),
(1151, 'admin_testimonials_list', 1150, 'testimonials list', 'admin'),
(1152, 'admin_testimonials_create', 1150, 'testimonials create', 'admin'),
(1153, 'admin_testimonials_edit', 1150, 'testimonials edit', 'admin'),
(1154, 'admin_testimonials_delete', 1150, 'testimonials delete', 'admin'),
(1200, 'admin_advertising', NULL, 'advertising', 'admin'),
(1201, 'admin_advertising_banners', 1200, 'advertising banners list', 'admin'),
(1202, 'admin_advertising_banners_create', 1200, 'create advertising banner', 'admin'),
(1203, 'admin_advertising_banners_edit', 1200, 'edit advertising banner', 'admin'),
(1204, 'admin_advertising_banners_delete', 1200, 'delete advertising banner', 'admin'),
(1230, 'admin_newsletters', NULL, 'Newsletters', 'admin'),
(1231, 'admin_newsletters_lists', 1230, 'Newsletters lists', 'admin'),
(1232, 'admin_newsletters_send', 1230, 'Send Newsletters', 'admin'),
(1233, 'admin_newsletters_history', 1230, 'Newsletters histories', 'admin'),
(1234, 'admin_newsletters_delete', 1230, 'Delete newsletters item', 'admin'),
(1235, 'admin_newsletters_export_excel', 1230, 'Export excel newsletters item', 'admin'),
(1250, 'admin_contacts', NULL, 'Contacts', 'admin'),
(1251, 'admin_contacts_lists', 1250, 'Contacts lists', 'admin'),
(1252, 'admin_contacts_reply', 1250, 'Contacts reply', 'admin'),
(1253, 'admin_contacts_delete', 1250, 'Contacts delete', 'admin'),
(1300, 'admin_product_discount', NULL, 'product discount', 'admin'),
(1301, 'admin_product_discount_list', 1300, 'product discount list', 'admin'),
(1302, 'admin_product_discount_create', 1300, 'create product discount', 'admin'),
(1303, 'admin_product_discount_edit', 1300, 'edit product discount', 'admin'),
(1304, 'admin_product_discount_delete', 1300, 'delete product discount', 'admin'),
(1305, 'admin_product_discount_export', 1300, 'delete product export excel', 'admin'),
(1350, 'admin_pages', NULL, 'pages', 'admin'),
(1351, 'admin_pages_list', 1350, 'pages list', 'admin'),
(1352, 'admin_pages_create', 1350, 'pages create', 'admin'),
(1353, 'admin_pages_edit', 1350, 'pages edit', 'admin'),
(1354, 'admin_pages_toggle', 1350, 'pages toggle publish/draft', 'admin'),
(1355, 'admin_pages_delete', 1350, 'pages delete', 'admin'),
(1400, 'admin_comments', NULL, 'Comments', 'admin'),
(1401, 'admin_comments_edit', 1400, 'Comments edit', 'admin'),
(1402, 'admin_comments_reply', 1400, 'Comments reply', 'admin'),
(1403, 'admin_comments_delete', 1400, 'Comments delete', 'admin'),
(1404, 'admin_comments_status', 1400, 'Comments status (active or pending)', 'admin'),
(1405, 'admin_comments_reports', 1400, 'Reports', 'admin'),
(1406, 'admin_webinar_comments', 1400, 'Classes comments', 'admin'),
(1407, 'admin_blog_comments', 1400, 'Blog comments', 'admin'),
(1408, 'admin_product_comments', 1400, 'Product comments', 'admin'),
(1409, 'admin_bundle_comments', 1400, 'Bundle comments', 'admin'),
(1450, 'admin_reports', NULL, 'Reports', 'admin'),
(1451, 'admin_webinar_reports', 1450, 'Classes reports', 'admin'),
(1452, 'admin_webinar_comments_reports', 1450, 'Classes Comments reports', 'admin'),
(1453, 'admin_webinar_reports_delete', 1450, 'Classes reports delete', 'admin'),
(1454, 'admin_blog_comments_reports', 1450, 'Blog Comments reports', 'admin'),
(1455, 'admin_report_reasons', 1450, 'Reports reasons', 'admin'),
(1456, 'admin_product_comments_reports', 1450, 'Products Comments reports', 'admin'),
(1457, 'admin_forum_topic_post_reports', 1450, 'Forum Topic Posts Reports', 'admin'),
(1500, 'admin_additional_pages', NULL, 'Additional Pages', 'admin'),
(1501, 'admin_additional_pages_errors', 1500, 'Errors page settings (404, 419, 403, 500)', 'admin'),
(1502, 'admin_additional_pages_contact_us', 1500, 'Contact page settings', 'admin'),
(1503, 'admin_additional_pages_footer', 1500, 'Footer settings', 'admin'),
(1504, 'admin_additional_pages_navbar_links', 1500, 'Top Navbar links settings', 'admin'),
(1550, 'admin_appointments', NULL, 'Appointments', 'admin'),
(1551, 'admin_appointments_lists', 1550, 'Appointments lists', 'admin'),
(1552, 'admin_appointments_join', 1550, 'Appointments join', 'admin'),
(1553, 'admin_appointments_send_reminder', 1550, 'Appointments send reminder', 'admin'),
(1554, 'admin_appointments_cancel', 1550, 'Appointments cancel', 'admin'),
(1600, 'admin_reviews', NULL, 'Reviews', 'admin'),
(1601, 'admin_reviews_lists', 1600, 'Reviews lists', 'admin'),
(1602, 'admin_reviews_status_toggle', 1600, 'Reviews status toggle (publish or hidden)', 'admin'),
(1603, 'admin_reviews_detail_show', 1600, 'Review details page', 'admin'),
(1604, 'admin_reviews_reply', 1600, 'Review reply', 'admin'),
(1605, 'admin_reviews_delete', 1600, 'Review delete', 'admin'),
(1650, 'admin_consultants', NULL, 'Consultants', 'admin'),
(1651, 'admin_consultants_lists', 1650, 'Consultants lists', 'admin'),
(1652, 'admin_consultants_export_excel', 1650, 'Consultants export excel', 'admin'),
(1675, 'admin_referrals', NULL, 'Referrals', 'admin'),
(1676, 'admin_referrals_history', 1675, 'Referrals History', 'admin'),
(1677, 'admin_referrals_users', 1675, 'Referrals users', 'admin'),
(1678, 'admin_referrals_export', 1675, 'Export Referrals', 'admin'),
(1725, 'admin_regions', NULL, 'Regions', 'admin'),
(1726, 'admin_regions_countries', 1725, 'countries lists', 'admin'),
(1727, 'admin_regions_provinces', 1725, 'provinces lists', 'admin'),
(1728, 'admin_regions_cities', 1725, 'cities lists', 'admin'),
(1729, 'admin_regions_districts', 1725, 'districts lists', 'admin'),
(1730, 'admin_regions_create', 1725, 'create item', 'admin'),
(1731, 'admin_regions_edit', 1725, 'edit item', 'admin'),
(1732, 'admin_regions_delete', 1725, 'delete item', 'admin'),
(1750, 'admin_rewards', NULL, 'Rewards', 'admin'),
(1751, 'admin_rewards_history', 1750, 'Rewards history', 'admin'),
(1752, 'admin_rewards_settings', 1750, 'Rewards settings', 'admin'),
(1753, 'admin_rewards_items', 1750, 'Rewards items', 'admin'),
(1754, 'admin_rewards_item_delete', 1750, 'Reward item delete', 'admin'),
(1775, 'admin_registration_packages', NULL, 'Registration packages', 'admin'),
(1776, 'admin_registration_packages_lists', 1775, 'packages lists', 'admin'),
(1777, 'admin_registration_packages_new', 1775, 'New package', 'admin'),
(1778, 'admin_registration_packages_edit', 1775, 'Edit package', 'admin'),
(1779, 'admin_registration_packages_delete', 1775, 'Delete package', 'admin'),
(1780, 'admin_registration_packages_reports', 1775, 'Reports', 'admin'),
(1781, 'admin_registration_packages_settings', 1775, 'Settings', 'admin'),
(1800, 'admin_store', NULL, 'Store', 'admin'),
(1801, 'admin_store_products', 1800, 'Products lists', 'admin'),
(1802, 'admin_store_new_product', 1800, 'Create New Product', 'admin'),
(1803, 'admin_store_edit_product', 1800, 'Edit Product', 'admin'),
(1804, 'admin_store_delete_product', 1800, 'Delete Product', 'admin'),
(1805, 'admin_store_export_products', 1800, 'Export excel Products', 'admin'),
(1806, 'admin_store_categories_list', 1800, 'Store Categories Lists', 'admin'),
(1807, 'admin_store_categories_create', 1800, 'Create Store Category', 'admin'),
(1808, 'admin_store_categories_edit', 1800, 'Edit Store Category', 'admin'),
(1809, 'admin_store_categories_delete', 1800, 'Delete Store Category', 'admin'),
(1810, 'admin_store_filters_list', 1800, 'Store Filters Lists', 'admin'),
(1811, 'admin_store_filters_create', 1800, 'Create Store Filter', 'admin'),
(1812, 'admin_store_filters_edit', 1800, 'Edit Store Filter', 'admin'),
(1813, 'admin_store_filters_delete', 1800, 'Delete Store Filter', 'admin'),
(1814, 'admin_store_specifications', 1800, 'Store Specifications', 'admin'),
(1815, 'admin_store_specifications_create', 1800, 'Create New Store Specification', 'admin'),
(1816, 'admin_store_specifications_edit', 1800, 'Edit Store Specification', 'admin'),
(1817, 'admin_store_specifications_delete', 1800, 'Delete Store Specification', 'admin'),
(1818, 'admin_store_discounts', 1800, 'Store Discounts Lists', 'admin'),
(1819, 'admin_store_discounts_create', 1800, 'Create New Store discount', 'admin'),
(1820, 'admin_store_discounts_edit', 1800, 'Edit Store discount', 'admin'),
(1821, 'admin_store_discounts_delete', 1800, 'Delete Store discount', 'admin'),
(1822, 'admin_store_products_orders', 1800, 'Products Orders', 'admin'),
(1823, 'admin_store_products_orders_refund', 1800, 'Products Orders Refund', 'admin'),
(1824, 'admin_store_products_orders_invoice', 1800, 'Products Orders View Invoice', 'admin'),
(1825, 'admin_store_products_orders_export', 1800, 'Products Orders Export Excel', 'admin'),
(1826, 'admin_store_products_orders_tracking_code', 1800, 'Products Orders Tracking code', 'admin'),
(1827, 'admin_store_products_reviews', 1800, 'Reviews lists', 'admin'),
(1828, 'admin_store_products_reviews_status_toggle', 1800, 'Reviews status toggle (publish or hidden)', 'admin'),
(1829, 'admin_store_products_reviews_detail_show', 1800, 'Review details page', 'admin'),
(1830, 'admin_store_products_reviews_delete', 1800, 'Review delete', 'admin'),
(1831, 'admin_store_settings', 1800, 'Store settings', 'admin'),
(1832, 'admin_store_in_house_products', 1800, 'In-house products', 'admin'),
(1833, 'admin_store_in_house_orders', 1800, 'In-house Products Orders', 'admin'),
(1834, 'admin_store_products_sellers', 1800, 'Products Sellers', 'admin'),
(1835, 'admin_store_top_categories', 1800, 'Store Top Categories (List/Create/Delete)', 'admin'),
(1836, 'admin_store_featured_products', 1800, 'Store Featured Products (List/Create/Delete)', 'admin'),
(1837, 'admin_store_featured_categories', 1800, 'Store Featured Categories (List/Create/Delete)', 'admin'),
(1838, 'admin_store_products_sellers', 1800, 'Products Sellers', 'admin'),
(1850, 'admin_webinar_assignments', NULL, 'Webinar assignments', 'admin'),
(1851, 'admin_webinar_assignments_lists', 1850, 'Assignments lists', 'admin'),
(1852, 'admin_webinar_assignments_students', 1850, 'Assignment students', 'admin'),
(1853, 'admin_webinar_assignments_conversations', 1850, 'Assignment students conversations', 'admin'),
(1875, 'admin_users_not_access_content', NULL, 'Users do not have access to the content', 'admin'),
(1876, 'admin_users_not_access_content_lists', 1875, 'Users lists', 'admin'),
(1877, 'admin_users_not_access_content_toggle', 1875, 'Toggle active/inactive users to view content', 'admin'),
(1900, 'admin_bundles', NULL, 'Bundles', 'admin'),
(1901, 'admin_bundles_list', 1900, 'Bundles Lists', 'admin'),
(1902, 'admin_bundles_create', 1900, 'Create new Bundle', 'admin'),
(1903, 'admin_bundles_edit', 1900, 'Edit bundle', 'admin'),
(1904, 'admin_bundles_delete', 1900, 'Delete bundle', 'admin'),
(1905, 'admin_bundles_export_excel', 1900, 'Export excel', 'admin'),
(1925, 'admin_forum', NULL, 'Forums', 'admin'),
(1926, 'admin_forum_list', 1925, 'Forums Lists', 'admin'),
(1927, 'admin_forum_create', 1925, 'Forums create', 'admin'),
(1928, 'admin_forum_edit', 1925, 'Forums edit', 'admin'),
(1929, 'admin_forum_delete', 1925, 'Forums delete', 'admin'),
(1930, 'admin_forum_topics_lists', 1925, 'Forums topics lists', 'admin'),
(1931, 'admin_forum_topics_create', 1925, 'Forums topics create', 'admin'),
(1932, 'admin_forum_topics_delete', 1925, 'Forums topics delete', 'admin'),
(1933, 'admin_forum_topics_posts', 1925, 'Forums topic posts', 'admin'),
(1934, 'admin_forum_topics_create_posts', 1925, 'Forums topic store posts', 'admin'),
(1935, 'admin_forum_settings', 1925, 'Forums Settings', 'admin'),
(1950, 'admin_featured_topics', NULL, 'Featured topics', 'admin'),
(1951, 'admin_featured_topics_list', 1950, 'Featured topics Lists', 'admin'),
(1952, 'admin_featured_topics_create', 1950, 'Featured topics create', 'admin'),
(1953, 'admin_featured_topics_edit', 1950, 'Featured topics edit', 'admin'),
(1954, 'admin_featured_topics_delete', 1950, 'Featured topics delete', 'admin'),
(1975, 'admin_recommended_topics', NULL, 'Recommended topics', 'admin'),
(1976, 'admin_recommended_topics_list', 1975, 'Recommended topics Lists', 'admin'),
(1977, 'admin_recommended_topics_create', 1975, 'Recommended topics create', 'admin'),
(1978, 'admin_recommended_topics_edit', 1975, 'Recommended topics edit', 'admin'),
(1979, 'admin_recommended_topics_delete', 1975, 'Recommended topics delete', 'admin'),
(2000, 'admin_advertising_modal', NULL, 'Advertising modal', 'admin'),
(2001, 'admin_advertising_modal_config', 2000, 'Set Advertising modal', 'admin'),
(2015, 'admin_enrollment', NULL, 'Enrollment', 'admin'),
(2016, 'admin_enrollment_history', 2015, 'Enrollment History', 'admin'),
(2017, 'admin_enrollment_add_student_to_items', 2015, 'Enrollment Add Student To Items', 'admin'),
(2018, 'admin_enrollment_block_access', 2015, 'Enrollment Block Access', 'admin'),
(2019, 'admin_enrollment_enable_access', 2015, 'Enrollment Enable Access', 'admin'),
(2020, 'admin_enrollment_export', 2015, 'Enrollment Export History', 'admin'),
(2021, 'admin_enrollment_export', 2015, 'Enrollment Export History', 'admin'),
(2030, 'admin_delete_account_requests', NULL, 'Delete Account Requests', 'admin'),
(2031, 'admin_delete_account_requests_lists', 2030, 'Delete Account Requests Lists', 'admin'),
(2032, 'admin_delete_account_requests_confirm', 2030, 'Delete Account Requests Confirm', 'admin'),
(2050, 'admin_upcoming_courses', NULL, 'Upcoming Course', 'admin'),
(2051, 'admin_upcoming_courses_list', 2050, 'Lists', 'admin'),
(2052, 'admin_upcoming_courses_create', 2050, 'Create', 'admin'),
(2053, 'admin_upcoming_courses_edit', 2050, 'Edit and Update', 'admin'),
(2054, 'admin_upcoming_courses_delete', 2050, 'Delete', 'admin'),
(2055, 'admin_upcoming_courses_followers', 2050, 'Followers', 'admin'),
(2070, 'admin_installments', NULL, 'Installments', 'admin'),
(2071, 'admin_installments_list', 2070, 'Lists', 'admin'),
(2072, 'admin_installments_create', 2070, 'Create', 'admin'),
(2073, 'admin_installments_edit', 2070, 'Edit and Update', 'admin'),
(2074, 'admin_installments_delete', 2070, 'Delete', 'admin'),
(2075, 'admin_installments_settings', 2070, 'Settings', 'admin'),
(2076, 'admin_installments_purchases', 2070, 'Purchases', 'admin'),
(2077, 'admin_installments_overdue_lists', 2070, 'Overdue Installments', 'admin'),
(2078, 'admin_installments_overdue_history', 2070, 'Overdue History', 'admin'),
(2079, 'admin_installments_verification_requests', 2070, 'Verification Requests', 'admin'),
(2080, 'admin_installments_verified_users', 2070, 'Verified Users', 'admin'),
(2081, 'admin_installments_orders', 2070, 'Approve/Reject/Refund Requests', 'admin'),
(2090, 'admin_registration_bonus', NULL, 'Registration Bonus', 'admin'),
(2091, 'admin_registration_bonus_history', 2090, 'History', 'admin'),
(2092, 'admin_registration_bonus_settings', 2090, 'Settings', 'admin'),
(2093, 'admin_registration_bonus_export_excel', 2090, 'Export Excel', 'admin'),
(3000, 'admin_floating_bar', NULL, 'Top/Bottom Floating Bar', 'admin'),
(3001, 'admin_floating_bar_create', 3000, 'Create/Edit', 'admin'),
(3010, 'admin_cashback', NULL, 'Cashback', 'admin'),
(3011, 'admin_cashback_rules', 3010, 'Rules', 'admin'),
(3012, 'admin_cashback_transactions', 3010, 'Transactions', 'admin'),
(3013, 'admin_cashback_history', 3010, 'History', 'admin'),
(3020, 'admin_waitlists', NULL, 'Waitlists', 'admin'),
(3021, 'admin_waitlists_lists', 3020, 'Lists', 'admin'),
(3022, 'admin_waitlists_users', 3020, 'Joined Users', 'admin'),
(3023, 'admin_waitlists_exports', 3020, 'Export excel lists', 'admin'),
(3024, 'admin_waitlists_clear_list', 3020, 'Clear lists', 'admin'),
(3025, 'admin_waitlists_disable', 3020, 'Disable', 'admin'),
(3030, 'admin_gift', NULL, 'Gifts', 'admin'),
(3031, 'admin_gift_history', 3030, 'History', 'admin'),
(3032, 'admin_gift_send_reminder', 3030, 'Send Reminder', 'admin'),
(3033, 'admin_gift_cancel', 3030, 'Cancel', 'admin'),
(3034, 'admin_gift_settings', 3030, 'Settings', 'admin'),
(3035, 'admin_gift_export', 3030, 'Export Excel', 'admin'),
(3040, 'admin_forms', NULL, 'Forms', 'admin'),
(3041, 'admin_forms_lists', 3040, 'Lists', 'admin'),
(3042, 'admin_forms_create', 3040, 'Create', 'admin'),
(3043, 'admin_forms_edit', 3040, 'Edit', 'admin'),
(3044, 'admin_forms_delete', 3040, 'Delete', 'admin'),
(3045, 'admin_forms_export', 3040, 'Export', 'admin'),
(3046, 'admin_forms_submissions', 3040, 'Submissions', 'admin'),
(3050, 'admin_ai_contents', NULL, 'AI Contents', 'admin'),
(3051, 'admin_ai_contents_lists', 3050, 'Generated Contents Lists', 'admin'),
(3052, 'admin_ai_contents_templates_lists', 3050, 'Template Lists', 'admin'),
(3053, 'admin_ai_contents_templates_create', 3050, 'Template Create', 'admin'),
(3054, 'admin_ai_contents_templates_edit', 3050, 'Template Edit', 'admin'),
(3055, 'admin_ai_contents_templates_delete', 3050, 'Template Delete', 'admin'),
(3056, 'admin_ai_contents_settings', 3050, 'Settings', 'admin'),
(3060, 'admin_purchase_notifications', NULL, 'Purchase Notifications', 'admin'),
(3061, 'admin_purchase_notifications_lists', 3060, 'Lists', 'admin'),
(3062, 'admin_purchase_notifications_create', 3060, 'Create', 'admin'),
(3063, 'admin_purchase_notifications_edit', 3060, 'Edit', 'admin'),
(3064, 'admin_purchase_notifications_delete', 3060, 'Delete', 'admin'),
(3070, 'admin_content_delete_requests', NULL, 'Content Delete Requests', 'admin'),
(3071, 'admin_content_delete_requests_lists', 3070, 'Lists', 'admin'),
(3072, 'admin_content_delete_requests_actions', 3070, 'Approve/Reject', 'admin'),
(3080, 'admin_user_login_history', NULL, 'User Login History', 'admin'),
(3081, 'admin_user_login_history_lists', 3080, 'Lists', 'admin'),
(3082, 'admin_user_login_history_delete', 3080, 'Delete', 'admin'),
(3083, 'admin_user_login_history_end_session', 3080, 'End Session', 'admin'),
(3084, 'admin_user_login_history_export', 3080, 'Export Excel', 'admin'),
(3090, 'admin_user_ip_restriction', NULL, 'User IP Restriction', 'admin'),
(3091, 'admin_user_ip_restriction_lists', 3090, 'Lists', 'admin'),
(3092, 'admin_user_ip_restriction_create', 3090, 'Create/Edit Restriction', 'admin'),
(3093, 'admin_user_ip_restriction_delete', 3090, 'Delete', 'admin'),
(3100, 'admin_product_badges', NULL, 'Product Badges', 'admin'),
(3101, 'admin_product_badges_lists', 3100, 'Lists', 'admin'),
(3102, 'admin_product_badges_create', 3100, 'Create', 'admin'),
(3103, 'admin_product_badges_edit', 3100, 'Edit', 'admin'),
(3104, 'admin_product_badges_delete', 3100, 'Delete', 'admin'),
(3110, 'admin_cart_discount', NULL, 'Cart Discount', 'admin'),
(3111, 'admin_cart_discount_controls', 3110, 'Controls', 'admin'),
(3120, 'admin_abandoned_cart', NULL, 'Abandoned Cart', 'admin'),
(3121, 'admin_abandoned_cart_rules', 3120, 'Rules (Create/Edit/Delete)', 'admin'),
(3122, 'admin_abandoned_cart_users', 3120, 'Users Cart', 'admin'),
(3123, 'admin_abandoned_cart_settings', 3120, 'Settings', 'admin'),
(3130, 'admin_translator', NULL, 'Translator', 'admin'),
(3131, 'admin_translator_actions', 3130, 'Actions (Create/Edit/Delete)', 'admin'),
(3140, 'admin_instructor_finder', NULL, 'Instructor Finder', 'admin'),
(3141, 'admin_instructor_finder_settings', 3140, 'Settings', 'admin'),
(3150, 'admin_themes', NULL, 'Themes And Theme Settings', 'admin'),
(3151, 'admin_themes_create', 3150, 'Create/Edit', 'admin'),
(3152, 'admin_themes_delete', 3150, 'Delete', 'admin'),
(3153, 'admin_themes_colors', 3150, 'Colors (Create/Edit/Delete)', 'admin'),
(3154, 'admin_themes_fonts', 3150, 'Fonts (Create/Edit/Delete)', 'admin'),
(3155, 'admin_themes_headers', 3150, 'Headers (Edit)', 'admin'),
(3156, 'admin_themes_footers', 3150, 'Footers (Edit)', 'admin'),
(3170, 'admin_landing_builder', NULL, 'Landing Builder', 'admin'),
(3171, 'admin_landing_builder_create', 3170, 'Create/Edit', 'admin'),
(3172, 'admin_landing_builder_preview', 3170, 'Preview', 'admin'),
(3173, 'admin_landing_builder_duplicate', 3170, 'Duplicate', 'admin'),
(3174, 'admin_landing_builder_delete', 3170, 'Delete', 'admin'),
(3175, 'admin_landing_builder_all_pages', 3170, 'All Pages', 'admin'),
(3176, 'admin_landing_builder_settings', 3170, 'Settings', 'admin'),
(100001, 'panel_organization_instructors', NULL, 'Organization Instructors', 'panel'),
(100002, 'panel_organization_instructors_lists', 100001, 'Lists', 'panel'),
(100003, 'panel_organization_instructors_create', 100001, 'Create', 'panel'),
(100004, 'panel_organization_instructors_edit', 100001, 'Edit', 'panel'),
(100005, 'panel_organization_instructors_delete', 100001, 'Delete', 'panel'),
(100010, 'panel_organization_students', NULL, 'Organization Students', 'panel'),
(100011, 'panel_organization_students_lists', 100010, 'Lists', 'panel'),
(100012, 'panel_organization_students_create', 100010, 'Create', 'panel'),
(100013, 'panel_organization_students_edit', 100010, 'Edit', 'panel'),
(100014, 'panel_organization_students_delete', 100010, 'Delete', 'panel'),
(100020, 'panel_webinars', NULL, 'Webinars (Courses)', 'panel'),
(100021, 'panel_webinars_lists', 100020, 'Lists', 'panel'),
(100022, 'panel_webinars_create', 100020, 'Create/Edit', 'panel'),
(100023, 'panel_webinars_delete', 100020, 'Delete', 'panel'),
(100024, 'panel_webinars_learning_page', 100020, 'Learning Page', 'panel'),
(100025, 'panel_webinars_invited_lists', 100020, 'Invited Class Lists', 'panel'),
(100026, 'panel_webinars_organization_classes', 100020, 'My Organization classes', 'panel'),
(100027, 'panel_webinars_my_purchases', 100020, 'My Purchases', 'panel'),
(100028, 'panel_webinars_my_class_comments', 100020, 'My Class Comments', 'panel'),
(100029, 'panel_webinars_comments', 100020, 'My Comments', 'panel'),
(100030, 'panel_webinars_favorites', 100020, 'Favorites', 'panel'),
(100031, 'panel_webinars_personal_course_notes', 100020, 'Personal Course Notes', 'panel'),
(100032, 'panel_webinars_duplicate', 100020, 'Duplicate', 'panel'),
(100033, 'panel_webinars_export_students_list', 100020, 'Export Students List', 'panel'),
(100034, 'panel_webinars_invoice', 100020, 'Invoice', 'panel'),
(100035, 'panel_webinars_statistics', 100020, 'Statistics', 'panel'),
(100040, 'panel_upcoming_courses', NULL, 'Upcoming Courses', 'panel'),
(100041, 'panel_upcoming_courses_lists', 100040, 'Lists', 'panel'),
(100042, 'panel_upcoming_courses_create', 100040, 'Create/Edit', 'panel'),
(100043, 'panel_upcoming_courses_delete', 100040, 'Delete', 'panel'),
(100044, 'panel_upcoming_courses_followings', 100040, 'Followings', 'panel'),
(100045, 'panel_upcoming_courses_followers', 100040, 'Followers', 'panel'),
(100050, 'panel_bundles', NULL, 'Bundles', 'panel'),
(100051, 'panel_bundles_lists', 100050, 'Lists', 'panel'),
(100052, 'panel_bundles_create', 100050, 'Create/Edit', 'panel'),
(100053, 'panel_bundles_delete', 100050, 'Delete', 'panel'),
(100054, 'panel_bundles_export_students_list', 100050, 'Export Students List', 'panel'),
(100055, 'panel_bundles_courses', 100050, 'Courses', 'panel'),
(100060, 'panel_assignments', NULL, 'Assignments', 'panel'),
(100061, 'panel_assignments_lists', 100060, 'My Assignments Lists', 'panel'),
(100062, 'panel_assignments_my_courses_assignments', 100060, 'My Courses Assignments', 'panel'),
(100063, 'panel_assignments_students', 100060, 'Students Assignments', 'panel'),
(100070, 'panel_meetings', NULL, 'Meetings', 'panel'),
(100071, 'panel_meetings_my_reservation', 100070, 'My Reservation', 'panel'),
(100072, 'panel_meetings_requests', 100070, 'Requests', 'panel'),
(100073, 'panel_meetings_settings', 100070, 'Settings', 'panel'),
(100080, 'panel_quizzes', NULL, 'Quizzes', 'panel'),
(100081, 'panel_quizzes_lists', 100080, 'Lists', 'panel'),
(100082, 'panel_quizzes_create', 100080, 'Create/Edit', 'panel'),
(100083, 'panel_quizzes_delete', 100080, 'Delete', 'panel'),
(100084, 'panel_quizzes_results', 100080, 'Results', 'panel'),
(100085, 'panel_quizzes_my_results', 100080, 'My Results', 'panel'),
(100086, 'panel_quizzes_not_participated', 100080, 'Not Participated Lists', 'panel'),
(100090, 'panel_certificates', NULL, 'Certificates', 'panel'),
(100091, 'panel_certificates_lists', 100090, 'Lists', 'panel'),
(100092, 'panel_certificates_achievements', 100090, 'Achievements', 'panel'),
(100093, 'panel_certificates_course_certificates', 100090, 'Course Certificates', 'panel'),
(100100, 'panel_products', NULL, 'Products (Store)', 'panel'),
(100101, 'panel_products_lists', 100100, 'Lists', 'panel'),
(100102, 'panel_products_create', 100100, 'Create/Edit', 'panel'),
(100103, 'panel_products_delete', 100100, 'Delete', 'panel'),
(100104, 'panel_products_sales', 100100, 'Sales', 'panel'),
(100105, 'panel_products_purchases', 100100, 'Purchases', 'panel'),
(100106, 'panel_products_comments', 100100, 'Comments', 'panel'),
(100107, 'panel_products_my_comments', 100100, 'My Comments', 'panel'),
(100120, 'panel_financial', NULL, 'Financial', 'panel'),
(100121, 'panel_financial_sales_reports', 100120, 'Sales Reports', 'panel'),
(100122, 'panel_financial_summary', 100120, 'Summary', 'panel'),
(100123, 'panel_financial_payout', 100120, 'Payout', 'panel'),
(100124, 'panel_financial_charge_account', 100120, 'Charge Account', 'panel'),
(100125, 'panel_financial_subscribes', 100120, 'Subscribes', 'panel'),
(100126, 'panel_financial_registration_packages', 100120, 'Registration Packages', 'panel'),
(100127, 'panel_financial_installments', 100120, 'Installments', 'panel'),
(100140, 'panel_support', NULL, 'Support', 'panel'),
(100141, 'panel_support_lists', 100140, 'Lists', 'panel'),
(100142, 'panel_support_create', 100140, 'Create', 'panel'),
(100143, 'panel_support_tickets', 100140, 'Tickets', 'panel'),
(100160, 'panel_marketing', NULL, 'Marketing', 'panel'),
(100161, 'panel_marketing_special_offers', 100160, 'Special Offers', 'panel'),
(100162, 'panel_marketing_promotions', 100160, 'Promotions', 'panel'),
(100163, 'panel_marketing_affiliates', 100160, 'Affiliates', 'panel'),
(100164, 'panel_marketing_registration_bonus', 100160, 'Registration Bonus', 'panel'),
(100165, 'panel_marketing_coupons', 100160, 'Coupons', 'panel'),
(100166, 'panel_marketing_new_coupon', 100160, 'Create Coupons', 'panel'),
(100167, 'panel_marketing_delete_coupon', 100160, 'Delete Coupons', 'panel'),
(100180, 'panel_forums', NULL, 'Forums', 'panel'),
(100181, 'panel_forums_new_topic', 100180, 'New Topic', 'panel'),
(100182, 'panel_forums_my_topics', 100180, 'My Topics', 'panel'),
(100183, 'panel_forums_my_posts', 100180, 'My Posts', 'panel'),
(100184, 'panel_forums_bookmarks', 100180, 'Bookmarks', 'panel'),
(100200, 'panel_blog', NULL, 'Blog', 'panel'),
(100201, 'panel_blog_new_article', 100200, 'New/Edit Article', 'panel'),
(100202, 'panel_blog_my_articles', 100200, 'My Article', 'panel'),
(100203, 'panel_blog_delete_article', 100200, 'Delete Article', 'panel'),
(100204, 'panel_blog_comments', 100200, 'Comments', 'panel'),
(100220, 'panel_noticeboard', NULL, 'Noticeboard', 'panel'),
(100221, 'panel_noticeboard_history', 100220, 'Noticeboard History', 'panel'),
(100222, 'panel_noticeboard_create', 100220, 'Create/Edit Noticeboard', 'panel'),
(100223, 'panel_noticeboard_delete', 100220, 'Delete Noticeboard', 'panel'),
(100224, 'panel_noticeboard_course_notices', 100220, 'Course Notices', 'panel'),
(100225, 'panel_noticeboard_course_notices_create', 100220, 'Create/Edit Course Notices', 'panel'),
(100240, 'panel_rewards', NULL, 'Rewards', 'panel'),
(100241, 'panel_rewards_lists', 100240, 'Lists', 'panel'),
(100260, 'panel_ai_contents', NULL, 'AI Contents', 'panel'),
(100261, 'panel_ai_contents_lists', 100260, 'Lists', 'panel'),
(100280, 'panel_notifications', NULL, 'Notifications', 'panel'),
(100281, 'panel_notifications_lists', 100280, 'Lists', 'panel'),
(100300, 'panel_others', NULL, 'Others', 'panel'),
(100301, 'panel_others_profile_setting', 100300, 'Profile Settings', 'panel'),
(100302, 'panel_others_profile_url', 100300, 'Profile Url', 'panel'),
(100303, 'panel_others_logout', 100300, 'Logout', 'panel');

-- --------------------------------------------------------

--
-- Structure de la table `selected_installments`
--

CREATE TABLE `selected_installments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `installment_id` int(10) UNSIGNED NOT NULL,
  `installment_order_id` int(10) UNSIGNED NOT NULL,
  `start_date` bigint(20) UNSIGNED DEFAULT NULL,
  `end_date` bigint(20) UNSIGNED DEFAULT NULL,
  `upfront` double(15,2) DEFAULT NULL,
  `upfront_type` enum('fixed_amount','percent') DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `selected_installment_steps`
--

CREATE TABLE `selected_installment_steps` (
  `id` int(10) UNSIGNED NOT NULL,
  `selected_installment_id` int(10) UNSIGNED NOT NULL,
  `installment_step_id` int(10) UNSIGNED NOT NULL,
  `deadline` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(15,2) DEFAULT NULL,
  `amount_type` enum('fixed_amount','percent') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `chapter_id` int(10) UNSIGNED DEFAULT NULL,
  `reserve_meeting_id` int(10) UNSIGNED DEFAULT NULL,
  `event_id` int(10) UNSIGNED DEFAULT NULL,
  `meeting_package_sold_id` int(10) UNSIGNED DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `extra_time_to_join` int(10) UNSIGNED DEFAULT NULL COMMENT 'Specifies that the user can see the join button up to a few minutes after the start time of the webinar.',
  `zoom_start_link` text DEFAULT NULL,
  `zoom_id` varchar(255) DEFAULT NULL,
  `session_api` enum('local','big_blue_button','zoom','agora','jitsi','google_meet') NOT NULL DEFAULT 'local',
  `api_secret` varchar(255) DEFAULT NULL,
  `moderator_secret` varchar(255) DEFAULT NULL,
  `agora_settings` text DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `enable_attendance` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int(10) UNSIGNED DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive','draft','finished') NOT NULL DEFAULT 'active',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `creator_id`, `webinar_id`, `chapter_id`, `reserve_meeting_id`, `event_id`, `meeting_package_sold_id`, `date`, `duration`, `link`, `extra_time_to_join`, `zoom_start_link`, `zoom_id`, `session_api`, `api_secret`, `moderator_secret`, `agora_settings`, `check_previous_parts`, `enable_attendance`, `access_after_day`, `order`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(62, 867, 2000, 19, NULL, NULL, NULL, 1690867800, 30, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '12345', '', NULL, 0, 0, NULL, NULL, 'active', 1625045297, 1635417342, NULL),
(63, 867, 2000, 19, NULL, NULL, NULL, 1691130600, 30, 'https://meet.google.com/', NULL, NULL, NULL, 'local', 'ABC547397', '', NULL, 0, 0, NULL, NULL, 'active', 1625045392, 1635417351, NULL),
(64, 867, 2000, 19, NULL, NULL, NULL, 1691501400, 30, 'https://meet.google.com/', NULL, NULL, NULL, 'local', 'LM756114', '', NULL, 0, 0, NULL, NULL, 'active', 1625045465, 1635417380, NULL),
(65, 3, 2001, 16, NULL, NULL, NULL, 1702362600, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '12345', '', NULL, 0, 0, NULL, NULL, 'active', 1625078642, 1635417181, NULL),
(66, 3, 2001, 17, NULL, NULL, NULL, 1702650600, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '46546', '', NULL, 0, 0, NULL, NULL, 'active', 1625078804, 1635417191, NULL),
(67, 3, 2001, 17, NULL, NULL, NULL, 1702895400, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', 'D548755', '', NULL, 0, 0, NULL, NULL, 'active', 1625079005, 1635417199, NULL),
(68, 863, 2002, 15, NULL, NULL, NULL, 1625200200, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '46546', '', NULL, 0, 0, NULL, NULL, 'active', 1625122908, 1635417036, NULL),
(69, 863, 2002, 15, NULL, NULL, NULL, 1625211600, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '12345', '', NULL, 0, 0, NULL, NULL, 'active', 1625122957, 1635417042, NULL),
(70, 863, 2002, 15, NULL, NULL, NULL, 1625220000, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', 'A547397', '', NULL, 0, 0, NULL, NULL, 'active', 1625123036, 1635417051, NULL),
(71, 864, 2003, 13, NULL, NULL, NULL, 1696505400, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '368967886', '', NULL, 0, 0, NULL, NULL, 'active', 1625299964, 1635416803, NULL),
(72, 864, 2003, 13, NULL, NULL, NULL, 1696915800, 20, 'https://meet.google.com/', NULL, NULL, NULL, 'local', '55475666', '', NULL, 0, 0, NULL, NULL, 'active', 1625300053, 1635416824, NULL),
(73, 864, 2003, 13, NULL, NULL, NULL, 1697319000, 35, 'https://meet.google.com/', NULL, NULL, NULL, 'local', 'RW346@654', '', NULL, 0, 0, NULL, NULL, 'active', 1625300165, 1635416835, NULL),
(105, 1137, 2072, 156, NULL, NULL, NULL, 1777194420, 60, NULL, 20, NULL, NULL, 'agora', NULL, NULL, '{\"chat\":true,\"record\":false,\"users_join\":true}', 0, 0, NULL, NULL, 'active', 1777151102, NULL, NULL),
(106, 1137, 2072, 156, NULL, NULL, NULL, 1777896000, 30, 'https://meet.google.com/kzi-aobw-zpe?pli=1&authuser=1&hs=49', 20, NULL, NULL, 'local', '123456789', NULL, NULL, 0, 0, NULL, NULL, 'active', 1777826151, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `session_attendance`
--

CREATE TABLE `session_attendance` (
  `id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL,
  `status` enum('present','absent','late') NOT NULL DEFAULT 'present',
  `joined_at` bigint(20) UNSIGNED NOT NULL,
  `edited_at` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `session_attendance_notifications`
--

CREATE TABLE `session_attendance_notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL COMMENT 'Notifications will be sent to sessions where the attendance feature is enabled after the session ends.',
  `notify_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `session_reminds`
--

CREATE TABLE `session_reminds` (
  `id` int(10) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `session_translations`
--

CREATE TABLE `session_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `session_translations`
--

INSERT INTO `session_translations` (`id`, `session_id`, `locale`, `title`, `description`) VALUES
(63, 108, 'ar', 'دورة جديدة في الاتصال الرقمي', 'دورة رقمية جديدة'),
(64, 105, 'ar', 'دورة جديدة في الاتصال الرقمي', NULL),
(65, 106, 'ar', 'دورة جديدة في الاتصال الرقمي', 'الدليل الكامل للأسئلة الشائعة (FAQ) - منحة \"ادرس في السعودية\"\r\nأولاً: أسئلة عامة عن المنحة\r\n•	ما هي المنحة التعليمية السعودية؟ هي برنامج وطني تقوده وزارة التعليم لجذب الطلاب المتميزين من العالم للدراسة في الجامعات الحكومية والخاصة في المملكة.\r\n•	ما الجهات التي تقدم المنحة؟ وزارة التعليم السعودية بالتنسيق مع أكثر من 27 جامعة حكومية وعشرت الجامعات الخاصة.\r\n•	ما الهدف من المنحة؟ نشر الثقافة والعلوم، وتعزيز التبادل الثقافي الدولي، وتحقيق رؤية المملكة 2030 في تصدير التعليم السعودي للعالم.');

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `page` enum('general','financial','personalization','notifications','seo','customization','other','forum','mobile_app') NOT NULL DEFAULT 'other',
  `name` varchar(255) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `settings`
--

INSERT INTO `settings` (`id`, `page`, `name`, `updated_at`) VALUES
(1, 'seo', 'seo_metas', 1709806236),
(2, 'general', 'socials', 1763577600),
(4, 'other', 'footer', 1632071275),
(5, 'general', 'general', 1772929234),
(6, 'financial', 'financial', 1775020578),
(8, 'personalization', 'home_hero', 1652016269),
(12, 'customization', 'custom_css_js', 1636119881),
(14, 'personalization', 'page_background', 1709889935),
(15, 'personalization', 'home_hero2', 1632223631),
(20, 'other', 'report_reasons', 1632235945),
(22, 'notifications', 'notifications', 1694993271),
(23, 'financial', 'site_bank_accounts', 1617002426),
(24, 'other', 'contact_us', 1763298090),
(25, 'personalization', 'home_sections', 1653226117),
(26, 'other', 'navbar_links', 1750058920),
(27, 'personalization', 'home_video_or_image_box', 1632226618),
(28, 'other', '404', 1763283354),
(29, 'personalization', 'panel_sidebar', 1751187899),
(30, 'financial', 'referral', 1754346481),
(31, 'general', 'features', 1763999391),
(32, 'personalization', 'find_instructors', 1642530710),
(33, 'personalization', 'reward_program', 1645628594),
(34, 'general', 'rewards_settings', 1764058961),
(37, 'financial', 'registration_packages_general', 1754345735),
(38, 'financial', 'registration_packages_instructors', 1754345741),
(39, 'financial', 'registration_packages_organizations', 1754345747),
(40, 'personalization', 'become_instructor_section', 1645345116),
(41, 'general', 'store_settings', 1754345665),
(42, 'personalization', 'theme_colors', 1678865210),
(43, 'personalization', 'forums_section', 1650546951),
(44, 'personalization', 'cookie_settings', 1763283460),
(45, 'personalization', 'mobile_app', 1653489015),
(46, 'personalization', 'theme_fonts', 1677180546),
(47, 'general', 'reminders', 1650982581),
(48, 'other', 'advertising_modal', 1652000772),
(52, 'personalization', 'others_personalization', 1763478541),
(53, 'general', 'security', 1768335037),
(54, 'general', 'installments_settings', 1754345819),
(55, 'general', 'installments_terms_settings', 1679089417),
(56, 'financial', 'currency_settings', 1763149174),
(57, 'personalization', 'statistics', 1678151460),
(58, 'personalization', 'maintenance_settings', 1749403729),
(59, 'general', 'general_options', 1763760121),
(60, 'financial', 'offline_banks_credits', 1676303092),
(61, 'financial', 'offline_banks', 1754346398),
(62, 'general', 'gifts_general_settings', 1764077625),
(63, 'general', 'registration_bonus_settings', 1754345926),
(64, 'general', 'registration_bonus_terms_settings', 1749395309),
(65, 'general', 'ai_contents_settings', 1754345692),
(66, 'general', 'certificate_settings', 1776355453),
(67, 'general', 'abandoned_cart_settings', 1754345857),
(68, 'personalization', 'restriction_settings', 1749402597),
(69, 'financial', 'commission_settings', 1719771535),
(70, 'forum', 'forum_general_settings', 1754345564),
(71, 'forum', 'forum_homepage_settings', 1749364648),
(72, 'forum', 'forum_homepage_revolver_settings', 1749365217),
(73, 'forum', 'forum_cta_section_settings', 1749369024),
(74, 'forum', 'forum_images_settings', 1749372578),
(75, 'other', '500', 1763487562),
(76, 'other', '419', 1763487577),
(77, 'other', '403', 1763487594),
(78, 'general', 'store_featured_products_settings', 1749379429),
(79, 'general', 'instructor_finder_settings', 1749390983),
(80, 'financial', 'referral_how_work', 1749396264),
(81, 'personalization', 'user_dashboard_data', 1749403064),
(82, 'personalization', 'content_review_information', 1751190964),
(83, 'mobile_app', 'mobile_app_general_settings', 1754300386);

-- --------------------------------------------------------

--
-- Structure de la table `setting_translations`
--

CREATE TABLE `setting_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `setting_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `setting_translations`
--

INSERT INTO `setting_translations` (`id`, `setting_id`, `locale`, `value`) VALUES
(1, 1, 'en', '{\"home\":{\"title\":\"Home\",\"description\":\"Home Page Description\",\"robot\":\"index\"},\"search\":{\"title\":\"Search\",\"description\":\"Search Page Description\",\"robot\":\"index\"},\"categories\":{\"title\":\"Category\",\"description\":\"Categories Page Description\",\"robot\":\"index\"},\"login\":{\"title\":\"Login\",\"description\":\"Login Page Description\",\"robot\":\"index\"},\"register\":{\"title\":\"Register\",\"description\":\"Register Page Description\",\"robot\":\"index\"},\"about\":{\"title\":\"about page title\",\"description\":\"about page Description\"},\"contact\":{\"title\":\"Contact\",\"description\":\"Contact Page Description\",\"robot\":\"index\"},\"certificate_validation\":{\"title\":\"Certificate validation\",\"description\":\"Certificate Validation Description\",\"robot\":\"index\"},\"classes\":{\"title\":\"Courses\",\"description\":\"Courses page Description\",\"robot\":\"index\"},\"blog\":{\"title\":\"Blog\",\"description\":\"Blog Page Description\",\"robot\":\"index\"},\"instructors\":{\"title\":\"Instructors\",\"description\":\"Instructors Page Description\",\"robot\":\"index\"},\"organizations\":{\"title\":\"Organizations\",\"description\":\"Organizations Page Description\",\"robot\":\"index\"},\"instructor_finder_wizard\":{\"title\":\"Instructor finder wizard\",\"description\":\"Tutor Finder Wizard Description\",\"robot\":\"noindex\"},\"instructor_finder\":{\"title\":\"Instructor finder\",\"description\":\"Tutor Finder Description\",\"robot\":\"index\"},\"reward_courses\":{\"title\":\"Reward courses\",\"description\":\"Reward Courses Description\",\"robot\":\"index\"},\"products_lists\":{\"title\":\"Store Products\",\"description\":\"Store Products Description\",\"robot\":\"noindex\"},\"reward_products\":{\"title\":\"Reward Products\",\"description\":\"Reward Products Description\",\"robot\":\"noindex\"},\"forum\":{\"title\":\"Forums\",\"description\":\"Forums Description\",\"robot\":\"noindex\"},\"upcoming_courses_lists\":{\"title\":\"Upcoming Course\",\"description\":\"Upcoming Courses Description\",\"robot\":\"noindex\"},\"tags\":{\"title\":\"Tags\",\"description\":\"Tags Page Description\",\"robot\":\"noindex\"}}'),
(2, 2, 'en', '{\"Facebook\":{\"title\":\"Facebook\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/icons8-facebook-30.png\",\"link\":\"https:\\/\\/www.facebook.com\\/siematplus\",\"order\":\"4\"},\"X\":{\"title\":\"X\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/icons8-x-30.png\",\"link\":\"https:\\/\\/x.com\\/Siematplus\",\"order\":\"4\"},\"youtube\":{\"title\":\"youtube\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/icons8-youtube-30.png\",\"link\":\"https:\\/\\/www.youtube.com\\/@Siematplus\",\"order\":\"4\"},\"linkedin\":{\"title\":\"linkedin\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/icons8-linkedin-30.png\",\"link\":\"https:\\/\\/www.linkedin.com\\/company\\/siematplus\",\"order\":\"2\"},\"tiktok\":{\"title\":\"tiktok\",\"image\":\"\\/store\\/1\\/default_images\\/social\\/icons8-tiktok-30.png\",\"link\":\"https:\\/\\/www.tiktok.com\\/@siematplus\",\"order\":\"2\"}}'),
(4, 5, 'en', '{\"site_name\":\"\\u0634\\u0631\\u0643\\u0629 \\u0633\\u0645\\u0627\\u062a \\u0644\\u0644\\u062a\\u0637\\u0648\\u064a\\u0631 \\u0648 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a\",\"site_email\":\"no-reply@siematplus.com\",\"site_phone\":null,\"register_method\":\"email\",\"default_time_zone\":\"Asia\\/Riyadh\",\"date_format\":\"numerical\",\"time_format\":\"24_hours\",\"site_language\":\"AR\",\"visitors_default_language\":\"default\",\"user_languages\":[\"AR\",\"EN\"],\"rtl_languages\":[\"AR\"],\"fav_icon\":\"\\/store\\/1\\/Siemat.svg\",\"logo\":\"\\/store\\/1\\/Siemat.svg\",\"dark_mode_logo\":\"\\/store\\/1\\/Siemat.svg\",\"rtl_layout\":\"1\",\"preloading\":\"0\",\"content_translate\":\"1\",\"app_debugbar\":\"0\"}'),
(5, 6, 'en', '{\"tax\":\"10\",\"minimum_payout\":\"50\",\"price_display\":\"total_price\",\"hide_disabled_payment_gateways\":\"0\"}'),
(6, 8, 'en', '{\"title\":\"Joy of learning & teaching...\",\"description\":\"Rocket LMS is a fully-featured educational platform that helps instructors to create and publish video courses, live classes, and text courses and earn money, and helps students to learn in the easiest way.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}'),
(7, 12, 'en', '{\"css\":null,\"js\":null}'),
(8, 14, 'en', '{\"admin_login\":\"\\/store\\/1\\/default_images\\/admin_login.jpg\",\"admin_dashboard\":\"\\/store\\/1\\/default_images\\/admin_dashboard.jpg\",\"login\":\"\\/store\\/1\\/default_images\\/front_login.jpg\",\"register\":\"\\/store\\/1\\/default_images\\/front_register.jpg\",\"remember_pass\":\"\\/store\\/1\\/default_images\\/password_recovery.jpg\",\"verification\":\"\\/store\\/1\\/default_images\\/verification.jpg\",\"search\":\"\\/store\\/1\\/default_images\\/search_cover.png\",\"tags\":\"\\/store\\/1\\/default_images\\/search_cover.png\",\"categories\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"become_instructor\":\"\\/store\\/1\\/default_images\\/become_instructor.jpg\",\"certificate_validation\":\"\\/store\\/1\\/default_images\\/certificate_validation.jpg\",\"blog\":\"\\/store\\/1\\/default_images\\/blogs_cover.png\",\"instructors\":\"\\/store\\/1\\/default_images\\/instructors_cover.png\",\"organizations\":\"\\/store\\/1\\/default_images\\/organizations_cover.png\",\"dashboard\":\"\\/store\\/1\\/dashboard.png\",\"user_cover\":\"\\/store\\/1\\/default_images\\/default_cover.jpg\",\"instructor_finder_wizard\":\"\\/store\\/1\\/default_images\\/instructor_finder_wizard.jpg\",\"products_lists\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"upcoming_courses_lists\":\"\\/store\\/1\\/default_images\\/category_cover.png\",\"user_default_signature\":\"\\/store\\/1\\/default_images\\/default_signature.jpg\"}'),
(9, 15, 'en', '{\"title\":\"Joy of learning & teaching...\",\"description\":\"Rocket LMS is a fully-featured educational platform that helps instructors to create and publish video courses, live classes, and text courses and earn money, and helps students to learn in the easiest way.\",\"hero_background\":\"\\/assets\\/default\\/img\\/home\\/world.png\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}'),
(10, 20, 'en', '[\"Inappropriate Course Content\",\"Inappropriate Behavior\",\"Policy Violation\",\"Spammy Content\",\"Other\"]'),
(11, 22, 'en', '{\"new_comment_admin\":\"7\",\"support_message_admin\":\"10\",\"support_message_replied_admin\":\"11\",\"promotion_plan_admin\":\"29\",\"new_contact_message\":\"26\",\"new_badge\":\"2\",\"change_user_group\":\"3\",\"course_created\":\"4\",\"course_approve\":\"5\",\"course_reject\":\"6\",\"new_comment\":\"7\",\"support_message\":\"8\",\"support_message_replied\":\"9\",\"new_rating\":\"17\",\"webinar_reminder\":\"27\",\"new_financial_document\":\"12\",\"payout_request\":\"13\",\"payout_proceed\":\"14\",\"offline_payment_request\":\"18\",\"offline_payment_approved\":\"19\",\"offline_payment_rejected\":\"20\",\"new_sales\":\"15\",\"new_purchase\":\"16\",\"new_subscribe_plan\":\"21\",\"promotion_plan\":\"28\",\"new_appointment\":\"22\",\"new_appointment_link\":\"23\",\"appointment_reminder\":\"24\",\"meeting_finished\":\"25\",\"new_certificate\":\"30\",\"waiting_quiz\":\"31\",\"waiting_quiz_result\":\"32\",\"payout_request_admin\":\"13\",\"product_new_sale\":\"33\",\"product_new_purchase\":\"34\",\"product_new_comment\":\"35\",\"product_tracking_code\":\"36\",\"product_new_rating\":\"37\",\"product_receive_shipment\":\"38\",\"product_out_of_stock\":\"39\",\"student_send_message\":\"40\",\"instructor_send_message\":\"41\",\"instructor_set_grade\":\"42\",\"send_post_in_topic\":\"44\",\"publish_instructor_blog_post\":\"45\",\"new_comment_for_instructor_blog_post\":\"46\",\"meeting_reserve_reminder\":\"47\",\"subscribe_reminder\":\"48\",\"reminder_gift_to_receipt\":\"52\",\"gift_sender_confirmation\":\"53\",\"gift_sender_notification\":\"54\",\"admin_gift_submission\":\"55\",\"admin_gift_sending_confirmation\":\"56\",\"reminder_installments_before_overdue\":\"57\",\"installment_due_reminder\":\"58\",\"reminder_installments_after_overdue\":\"59\",\"approve_installment_verification_request\":\"60\",\"reject_installment_verification_request\":\"61\",\"paid_installment_step\":\"62\",\"paid_installment_step_for_admin\":\"63\",\"paid_installment_upfront\":\"64\",\"installment_verification_request_sent\":\"65\",\"admin_installment_verification_request_sent\":\"66\",\"instalment_request_submitted\":\"67\",\"instalment_request_submitted_for_admin\":\"68\",\"upcoming_course_submission\":\"69\",\"upcoming_course_submission_for_admin\":\"70\",\"upcoming_course_approved\":\"71\",\"upcoming_course_rejected\":\"72\",\"upcoming_course_published\":\"73\",\"upcoming_course_followed\":\"74\",\"upcoming_course_published_for_followers\":\"75\",\"user_get_cashback\":\"76\",\"user_get_cashback_notification_for_admin\":\"77\",\"bundle_submission\":\"78\",\"bundle_submission_for_admin\":\"79\",\"bundle_approved\":\"80\",\"bundle_rejected\":\"81\",\"new_review_for_bundle\":\"82\",\"registration_bonus_achieved\":\"83\",\"registration_bonus_unlocked\":\"84\",\"registration_bonus_unlocked_for_admin\":\"85\",\"registration_package_activated\":\"86\",\"registration_package_activated_for_admin\":\"87\",\"registration_package_expired\":\"87\",\"contact_message_submission\":\"88\",\"contact_message_submission_for_admin\":\"89\",\"waitlist_submission\":\"90\",\"waitlist_submission_for_admin\":\"91\",\"new_referral_user\":\"92\",\"user_role_change\":\"97\",\"add_to_user_group\":\"98\",\"become_instructor_request_approved\":\"99\",\"become_instructor_request_rejected\":\"100\",\"new_question_in_forum\":\"101\",\"new_answer_in_forum\":\"102\",\"new_appointment_session\":\"103\",\"new_quiz\":\"93\",\"user_get_new_point\":\"94\",\"new_course_notice\":\"96\",\"new_registration\":\"104\",\"new_become_instructor_request\":\"105\",\"new_course_enrollment\":\"106\",\"new_forum_topic\":\"107\",\"new_report_item_for_admin\":\"108\",\"new_item_created\":\"109\",\"new_store_order\":\"110\",\"subscription_plan_activated\":\"111\",\"content_review_request\":\"112\",\"new_user_blog_post\":\"113\",\"new_user_item_rating\":\"114\",\"new_organization_user\":\"115\",\"user_wallet_charge\":\"116\",\"new_user_payout_request\":\"117\",\"new_offline_payment_request\":\"118\",\"user_access_to_content\":\"119\",\"submit_form_by_users\":\"120\"}'),
(12, 23, 'en', '{\"540\":{\"title\":\"Qatar National Bank\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/Qatar National Bank.png\",\"card_id\":\"2578-4910-3682-6288\",\"account_id\":\"38152294372\",\"iban\":\"QA66QUWW934528129454345775226\"},\"334\":{\"title\":\"State Bank of India\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/State Bank of India.png\",\"card_id\":\"6282-4518-1237-7641\",\"account_id\":\"56238341127\",\"iban\":\"IN37ABNA2422193788\"},\"jhgDW\":{\"title\":\"JPMorgan\",\"image\":\"\\/store\\/1\\/default_images\\/offline_payments\\/jpmorgan.png\",\"card_id\":\"5012-4518-1772-8911\",\"account_id\":\"46237751125\",\"iban\":\"NL37ABNA2423554788\"}}'),
(13, 24, 'en', '{\"phones\":\"0505529393 , 0575653106\",\"emails\":\"info@siematplus.com\",\"address\":\"\\u0634\\u0631\\u0643\\u0629 \\u0633\\u0645\\u0627\\u062a \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0644\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628 \\u0648\\u0627\\u0644\\u062a\\u0637\\u0648\\u064a\\u0631 \\r\\n\\u0627\\u0644\\u0645\\u0645\\u0644\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0628\\u064a\\u0629 \\u0627\\u0644\\u0633\\u0639\\u0648\\u062f\\u064a\\u0629 - \\u0627\\u0644\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0627\\u0644\\u0634\\u0631\\u0642\\u064a\\u0629 \\u0627\\u0644\\u062f\\u0645\\u0627\\u0645\",\"latitude\":\"26.435894422685013\",\"longitude\":\"50.10257373932183\",\"map_zoom\":\"16\",\"additional_information_title\":\"\\u0623\\u0648\\u0642\\u0627\\u062a \\u0627\\u0644\\u062a\\u0648\\u0627\\u0635\\u0644\",\"additional_information_subtitle\":\"\\u0627\\u0644\\u0633\\u0628\\u062a \\u0625\\u0644\\u0649 \\u0627\\u0644\\u062e\\u0645\\u064a\\u0633 \\u0645\\u0646 \\u0627\\u0644\\u0633\\u0627\\u0639\\u0629 8 \\u0635\\u0628\\u0627\\u062d\\u0627\\u064b \\u062d\\u062a\\u0649 7 \\u0645\\u0633\\u0627\\u0621\\u064b\\r\\n\\u0633\\u0646\\u062d\\u0627\\u0648\\u0644 \\u0627\\u0644\\u0631\\u062f \\u0639\\u0644\\u0649 \\u0627\\u0644\\u0631\\u0633\\u0627\\u0626\\u0644 \\u062e\\u0644\\u0627\\u0644 \\u0645\\u062f\\u0629 \\u0623\\u0642\\u0635\\u0627\\u0647\\u0627 72 \\u0633\\u0627\\u0639\\u0629.\",\"additional_information_image\":\"\\/store\\/1\\/themes\\/general\\/contact_icon.png\"}'),
(14, 25, 'en', '{\"latest_classes\":\"1\",\"best_sellers\":\"1\",\"free_classes\":\"1\",\"discount_classes\":\"1\",\"best_rates\":\"1\",\"trend_categories\":\"1\",\"testimonials\":\"1\",\"subscribes\":\"1\",\"blog\":\"1\",\"organizations\":\"1\",\"instructors\":\"1\",\"video_or_image_section\":\"1\",\"find_instructors\":\"1\",\"reward_program\":\"1\"}'),
(15, 26, 'en', '{\"02nh9a\":{\"title\":\"Home\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"Courses\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"Instructors\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"},\"Uo5b2v\":{\"title\":\"Store\",\"link\":\"\\/products\",\"order\":\"4\"},\"Wnq5Qb\":{\"title\":\"Forums\",\"link\":\"\\/forums\",\"order\":\"5\"}}'),
(16, 27, 'en', '{\"link\":\"\\/classes\",\"title\":\"Start learning anywhere, anytime...\",\"description\":\"Use Rocket LMS to access high-quality education materials without any limitations in the easiest way.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}'),
(17, 28, 'en', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/404_error.svg\",\"title\":\"Page Not Found\",\"description\":\"The page you\'re looking for doesn\'t exist or was removed...\",\"button\":{\"title\":\"Back to Home\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(18, 29, 'en', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/themes\\/general\\/sidebar_banner.png\"}'),
(19, 30, 'en', '{\"status\":\"0\",\"users_affiliate_status\":\"0\",\"affiliate_user_commission\":\"5\",\"store_affiliate_user_commission\":\"5\",\"affiliate_user_amount\":\"20\",\"referred_user_amount\":\"10\",\"referral_description\":\"You can share your affiliate URL you will get the above rewards when a user uses the platform.\"}'),
(20, 4, 'en', '{\"first_column\":{\"title\":\"About US\",\"value\":\"<p><font color=\\\"#ffffff\\\">Rocket LMS is a fully-featured learning management system that helps you to run your education business in several hours. This platform helps instructors to create professional education materials and helps students to learn from the best instructors.<\\/font><\\/p>\"},\"second_column\":{\"title\":\"Additional Links\",\"value\":\"<p><a href=\\\"\\/login\\\"><font color=\\\"#ffffff\\\">- Login<\\/font><\\/a><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/register\\\"><font color=\\\"#ffffff\\\">- Register<\\/font><\\/a><br><\\/font><\\/p><p><a href=\\\"\\/blog\\\"><font color=\\\"#ffffff\\\">- Blog<\\/font><\\/a><\\/p><p><a href=\\\"\\/contact\\\"><font color=\\\"#ffffff\\\">- Contact us<\\/font><\\/a><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/certificate_validation\\\"><font color=\\\"#ffffff\\\">- Certificate validation<\\/font><\\/a><br><\\/font><\\/p><p><font color=\\\"#ffffff\\\"><a href=\\\"\\/become-instructor\\\"><font color=\\\"#ffffff\\\">- Become instructor<\\/font><\\/a><br><\\/font><\\/p><p><a href=\\\"\\/pages\\/terms\\\"><font color=\\\"#ffffff\\\">- Terms &amp; rules<\\/font><\\/a><\\/p><p><a href=\\\"\\/pages\\/about\\\"><font color=\\\"#ffffff\\\">- About us<\\/font><\\/a><br><\\/p>\"},\"third_column\":{\"title\":\"Similar Businesses\",\"value\":\"<p><a href=\\\"https:\\/\\/www.udemy.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udemy<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillshare.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillshare<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.coursera.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Coursera<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/learning\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Lynda<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillsoft.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillsoft<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.udacity.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udacity<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.edx.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- edX<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.masterclass.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Masterclass<\\/font><\\/a><br><\\/p>\"},\"forth_column\":{\"title\":\"Purchase Rocket LMS\",\"value\":\"<p><a title=\\\"Notnt\\\" href=\\\"https:\\/\\/codecanyon.net\\\"><img style=\\\"width: 200px;\\\" src=\\\"\\/store\\/1\\/default_images\\/envato.png\\\"><\\/a><\\/p>\"}}'),
(31, 4, 'ar', '{\"first_column\":{\"title\":\"\\u0645\\u0639\\u0644\\u0648\\u0645\\u0627\\u062a \\u0639\\u0646\\u0627\",\"value\":\"<p><font color=\\\"#ffffff\\\">Rocket LMS \\u0647\\u0648 \\u0646\\u0638\\u0627\\u0645 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u062a\\u0639\\u0644\\u0645 \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f\\u0643 \\u0639\\u0644\\u0649 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u0623\\u0639\\u0645\\u0627\\u0644\\u0643 \\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0641\\u064a \\u0639\\u062f\\u0629 \\u0633\\u0627\\u0639\\u0627\\u062a. \\u062a\\u0633\\u0627\\u0639\\u062f \\u0647\\u0630\\u0647 \\u0627\\u0644\\u0645\\u0646\\u0635\\u0629 \\u0627\\u0644\\u0645\\u0639\\u0644\\u0645\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0645\\u0648\\u0627\\u062f \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0627\\u062d\\u062a\\u0631\\u0627\\u0641\\u064a\\u0629 \\u0648\\u062a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0645\\u0646 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646.<\\/font><\\/p>\"},\"second_column\":{\"title\":\"\\u0631\\u0648\\u0627\\u0628\\u0637 \\u0625\\u0636\\u0627\\u0641\\u064a\\u0629\",\"value\":\"<p><a href=\\\"\\/login\\\"><span style=\\\"color: #ffffff;\\\">- \\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062f\\u062e\\u0648\\u0644<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/register\\\"><span style=\\\"color: #ffffff;\\\">- \\u062a\\u0633\\u062c\\u064a\\u0644<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/blog\\\"><span style=\\\"color: #ffffff;\\\">- \\u0645\\u0642\\u0627\\u0644\\u0627\\u062a<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/contact\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u062a\\u0635\\u0644 \\u0628\\u0646\\u0627<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/certificate_validation\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u0644\\u062a\\u062d\\u0642\\u0642 \\u0645\\u0646 \\u0635\\u062d\\u0629 \\u0627\\u0644\\u0634\\u0647\\u0627\\u062f\\u0629<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/become-instructor\\\"><span style=\\\"color: #ffffff;\\\">- \\u0623\\u0635\\u0628\\u062d \\u0645\\u062f\\u0631\\u0628\\u0627<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/terms\\\"><span style=\\\"color: #ffffff;\\\">- \\u0627\\u0644\\u0634\\u0631\\u0648\\u0637 \\u0648\\u0627\\u0644\\u0642\\u0648\\u0627\\u0639\\u062f<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/about\\\"><span style=\\\"color: #ffffff;\\\">- \\u0645\\u0639\\u0644\\u0648\\u0645\\u0627\\u062a \\u0639\\u0646\\u0627<\\/span><\\/a><\\/p>\"},\"third_column\":{\"title\":\"\\u0623\\u0639\\u0645\\u0627\\u0644 \\u0645\\u0645\\u0627\\u062b\\u0644\\u0629\",\"value\":\"<p><a href=\\\"https:\\/\\/www.udemy.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u064a\\u0648\\u062f\\u0645\\u064a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillshare.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0633\\u06a9\\u06cc\\u0644 \\u0634\\u06cc\\u0631<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.coursera.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0643\\u0631\\u0633 \\u0627\\u064a\\u0631\\u0627<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/learning\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0644\\u06cc\\u0646\\u062f\\u0627<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillsoft.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0633\\u0643\\u064a\\u0644 \\u0633\\u0641\\u062a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.udacity.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0627\\u0648\\u062f\\u0627\\u0633\\u064a\\u062a\\u064a<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.edx.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">\\u0627\\u062f\\u0643\\u0633<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.masterclass.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- \\u0645\\u0633\\u062a\\u0631 \\u0643\\u0644\\u0633<\\/font><\\/a><br><\\/p>\"},\"forth_column\":{\"title\":\"\\u0642\\u0645 \\u0628\\u0634\\u0631\\u0627\\u0621 Rocket LMS\",\"value\":\"<p><a title=\\\"Notnt\\\" href=\\\"https:\\/\\/codecanyon.net\\\"><img style=\\\"width: 200px;\\\" src=\\\"\\/store\\/1\\/default_images\\/envato.png\\\"><\\/a><\\/p>\"}}'),
(32, 31, 'en', '{\"agora_resolution\":\"960_720\",\"agora_max_bitrate\":\"2260\",\"agora_min_bitrate\":\"1130\",\"agora_frame_rate\":\"10\",\"agora_live_streaming\":\"1\",\"agora_chat\":\"1\",\"agora_in_free_courses\":\"1\",\"agora_for_meeting\":\"1\",\"meeting_live_stream_type\":\"multiple\",\"course_live_stream_type\":\"multiple\",\"agora_app_id\":\"dd8492f6bf2b49a18a874e5984f110fe\",\"agora_app_certificate\":\"7ee47ea17e434fdd8775b35afcbb38f0\",\"new_interactive_file\":\"0\",\"timezone_in_register\":\"1\",\"timezone_in_create_webinar\":\"1\",\"sequence_content_status\":\"0\",\"webinar_assignment_status\":\"0\",\"webinar_private_content_status\":\"0\",\"disable_view_content_after_user_register\":\"0\",\"course_forum_status\":\"0\",\"direct_classes_payment_button_status\":\"1\",\"direct_bundles_payment_button_status\":\"1\",\"direct_products_payment_button_status\":\"1\",\"cookie_settings_status\":\"0\",\"mobile_app_status\":\"0\",\"maintenance_status\":\"0\",\"maintenance_access_key\":\"key\",\"extra_time_to_join_status\":\"1\",\"extra_time_to_join_default_value\":\"20\",\"show_other_register_method\":\"1\",\"show_certificate_additional_in_register\":\"0\",\"show_google_login_button\":\"0\",\"show_facebook_login_button\":\"0\",\"google_client_id\":null,\"google_client_secret\":null,\"facebook_client_id\":null,\"facebook_client_secret\":null,\"show_live_chat_widget\":\"1\",\"cashback_active\":\"1\",\"display_cashback_notice_in_the_product_page\":\"1\",\"display_minimum_amount_cashback_notices\":\"1\",\"available_session_apis\":[\"local\",\"big_blue_button\",\"zoom\",\"agora\",\"jitsi\"],\"available_sources\":[\"upload\",\"youtube\",\"vimeo\",\"external_link\",\"google_drive\",\"iframe\",\"s3\",\"secure_host\"],\"bunny_configs\":[],\"select_the_role_during_registration\":[\"teacher\",\"organization\"],\"waitlist_status\":\"0\",\"upcoming_courses_status\":\"0\",\"user_register_form\":null,\"instructor_register_form\":null,\"organization_register_form\":null,\"become_instructor_form\":null,\"become_organization_form\":null,\"frontend_coupons_status\":\"1\",\"frontend_coupons_display_type\":\"before_content\",\"course_notes_status\":\"1\",\"course_notes_attachment\":\"1\",\"course_recent_reviews_status\":\"1\",\"zoom_client_id\":null,\"zoom_client_secret\":null,\"zoom_account_id\":null,\"bigbluebutton_server_base_url\":null,\"bigbluebutton_security_salt\":null,\"jitsi_live_url\":null}'),
(33, 32, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"Find the best instructor\",\"description\":\"Looking for an instructor? Find the best instructors according to different parameters like gender, skill level, price, meeting type, rating, etc.\\r\\nFind instructors on the map.\",\"button1\":{\"title\":\"Tutor Finder\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"Tutors on Map\",\"link\":\"\\/instructor-finder\"}}'),
(34, 33, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"Win Club Points\",\"description\":\"Use Rocket LMS and win club points according to different activities.\\r\\nYou will be able to use your club points to get free prizes and courses. Start using the system now and collect points!\",\"button1\":{\"title\":\"Rewards\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"Points Club\",\"link\":\"\\/panel\\/rewards\"}}'),
(35, 34, 'en', '{\"status\":\"1\",\"exchangeable\":\"1\",\"exchangeable_unit\":\"100\",\"want_more_points_link\":\"\\/pages\\/reward_points_system\"}'),
(38, 37, 'en', '{\"status\":\"0\",\"show_packages_during_registration\":\"0\",\"force_user_to_select_a_package\":\"0\",\"enable_home_section\":\"0\",\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/saas_overlay.png\"}'),
(39, 38, 'en', '{\"status\":\"0\",\"courses_capacity\":\"50\",\"courses_count\":\"15\",\"meeting_count\":\"30\",\"product_count\":\"10\",\"icon\":null}'),
(40, 39, 'en', '{\"status\":\"0\",\"instructors_count\":\"5\",\"students_count\":\"30\",\"courses_capacity\":\"60\",\"courses_count\":\"20\",\"meeting_count\":\"50\",\"product_count\":\"10\",\"icon\":null}'),
(41, 40, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"Become an instructor\",\"description\":\"Are you interested to be a part of our community?\\r\\nYou can be a part of our community by signing up as an instructor or organization.\",\"button1\":{\"title\":\"Become an Instructor\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"Registration Packages\",\"link\":\"become-instructor\\/packages\\/\"}}'),
(42, 8, 'ar', '{\"title\":\"\\u0645\\u062a\\u0639\\u0629 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 ...\",\"description\":\"Rocket LMS \\u0639\\u0628\\u0627\\u0631\\u0629 \\u0639\\u0646 \\u0646\\u0638\\u0627\\u0645 \\u0623\\u0633\\u0627\\u0633\\u064a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0648\\u0646\\u0634\\u0631 \\u062f\\u0648\\u0631\\u0627\\u062a \\u0641\\u064a\\u062f\\u064a\\u0648 \\u0648\\u0641\\u0635\\u0648\\u0644 \\u0645\\u0628\\u0627\\u0634\\u0631\\u0629 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0646\\u0635\\u064a\\u0629 \\u0648\\u0643\\u0633\\u0628 \\u0627\\u0644\\u0645\\u0627\\u0644 \\u060c \\u0648\\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}'),
(43, 8, 'es', '{\"title\":\"Alegr\\u00eda de aprender y ense\\u00f1ar ...\",\"description\":\"Rocket LMS es una plataforma educativa con todas las funciones que ayuda a los instructores a crear y publicar cursos de video, clases en vivo y cursos de texto y ganar dinero, y ayuda a los estudiantes a aprender de la manera m\\u00e1s f\\u00e1cil.\",\"hero_background\":\"\\/store\\/1\\/default_images\\/hero_1.jpg\"}'),
(44, 15, 'ar', '{\"title\":\"\\u0645\\u062a\\u0639\\u0629 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0648\\u0627\\u0644\\u062a\\u0639\\u0644\\u064a\\u0645 ...\",\"description\":\"Rocket LMS \\u0639\\u0628\\u0627\\u0631\\u0629 \\u0639\\u0646 \\u0646\\u0638\\u0627\\u0645 \\u0623\\u0633\\u0627\\u0633\\u064a \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a \\u0643\\u0627\\u0645\\u0644 \\u0627\\u0644\\u0645\\u064a\\u0632\\u0627\\u062a \\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0625\\u0646\\u0634\\u0627\\u0621 \\u0648\\u0646\\u0634\\u0631 \\u062f\\u0648\\u0631\\u0627\\u062a \\u0641\\u064a\\u062f\\u064a\\u0648 \\u0648\\u0641\\u0635\\u0648\\u0644 \\u0645\\u0628\\u0627\\u0634\\u0631\\u0629 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0646\\u0635\\u064a\\u0629 \\u0648\\u0643\\u0633\\u0628 \\u0627\\u0644\\u0645\\u0627\\u0644 \\u060c \\u0648\\u064a\\u0633\\u0627\\u0639\\u062f \\u0627\\u0644\\u0637\\u0644\\u0627\\u0628 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"hero_background\":\"\\/assets\\/default\\/img\\/home\\/world.png\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}'),
(45, 15, 'es', '{\"title\":\"Alegr\\u00eda de aprender y ense\\u00f1ar ...\",\"description\":\"Rocket LMS es una plataforma educativa con todas las funciones que ayuda a los instructores a crear y publicar cursos de video, clases en vivo y cursos de texto y ganar dinero, y ayuda a los estudiantes a aprender de la manera m\\u00e1s f\\u00e1cil.\",\"hero_background\":\"\\/assets\\/default\\/img\\/home\\/world.png\",\"hero_vector\":\"\\/store\\/1\\/animated-header.json\",\"has_lottie\":\"1\"}'),
(46, 27, 'ar', '{\"link\":\"\\/classes\",\"title\":\"\\u0627\\u0628\\u062f\\u0623 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0641\\u064a \\u0623\\u064a \\u0645\\u0643\\u0627\\u0646 \\u0648\\u0641\\u064a \\u0623\\u064a \\u0648\\u0642\\u062a ...\",\"description\":\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0645 Rocket LMS \\u0644\\u0644\\u0648\\u0635\\u0648\\u0644 \\u0625\\u0644\\u0649 \\u0645\\u0648\\u0627\\u062f \\u062a\\u0639\\u0644\\u064a\\u0645\\u064a\\u0629 \\u0639\\u0627\\u0644\\u064a\\u0629 \\u0627\\u0644\\u062c\\u0648\\u062f\\u0629 \\u062f\\u0648\\u0646 \\u0623\\u064a \\u0642\\u064a\\u0648\\u062f \\u0648\\u0628\\u0623\\u0633\\u0647\\u0644 \\u0637\\u0631\\u064a\\u0642\\u0629.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}'),
(47, 27, 'es', '{\"link\":\"\\/classes\",\"title\":\"Empiece a aprender en cualquier lugar, en cualquier momento ...\",\"description\":\"Utilice Rocket LMS para acceder a materiales educativos de alta calidad sin limitaciones de la forma m\\u00e1s sencilla.\",\"background\":\"\\/store\\/1\\/default_images\\/home_video_section.png\"}'),
(48, 29, 'ar', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/sidebar-user-ar.png\"}'),
(49, 29, 'es', '{\"link\":\"\\/classes?sort=newest\",\"background\":\"\\/store\\/1\\/sidebar-user-sp.png\"}'),
(50, 4, 'es', '{\"first_column\":{\"title\":\"Sobre Nosotras\",\"value\":\"<p><font color=\\\"#ffffff\\\">Rocket LMS es un sistema de gesti\\u00f3n de aprendizaje con todas las funciones que le ayuda a gestionar su negocio educativo en varias horas. Esta plataforma ayuda a los instructores a crear materiales educativos profesionales y ayuda a los estudiantes a aprender de los mejores instructores.<\\/font><\\/p>\"},\"second_column\":{\"title\":\"Enlaces Adicionales\",\"value\":\"<p><a href=\\\"\\/login\\\"><span style=\\\"color: #ffffff;\\\">- Acceso<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/register\\\"><span style=\\\"color: #ffffff;\\\">- Registrarse<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/blog\\\"><span style=\\\"color: #ffffff;\\\">- Blog<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/contact\\\"><span style=\\\"color: #ffffff;\\\">- Contacta con nosotras<\\/span><\\/a><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/certificate_validation\\\"><span style=\\\"color: #ffffff;\\\">- Validaci\\u00f3n de certificado<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><span style=\\\"color: #ffffff;\\\"><a href=\\\"\\/become-instructor\\\"><span style=\\\"color: #ffffff;\\\">- Convi\\u00e9rtete en instructor<\\/span><\\/a><br><\\/span><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/terms\\\"><span style=\\\"color: #ffffff;\\\">- T\\u00e9rminos y reglas<\\/span><\\/a><\\/p>\\r\\n<p><a href=\\\"\\/pages\\/about\\\"><span style=\\\"color: #ffffff;\\\">- Sobre nosotras<\\/span><\\/a><\\/p>\"},\"third_column\":{\"title\":\"Negocios Similares\",\"value\":\"<p><a href=\\\"https:\\/\\/www.udemy.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udemy<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillshare.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillshare<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.coursera.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Coursera<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.linkedin.com\\/learning\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Lynda<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.skillsoft.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Skillsoft<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.udacity.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Udacity<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.edx.org\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- edX<\\/font><\\/a><\\/p><p><a href=\\\"https:\\/\\/www.masterclass.com\\/\\\" target=\\\"_blank\\\"><font color=\\\"#ffffff\\\">- Masterclass<\\/font><\\/a><br><\\/p>\"},\"forth_column\":{\"title\":\"Compra Rocket LMS\",\"value\":\"<p><a title=\\\"Notnt\\\" href=\\\"https:\\/\\/codecanyon.net\\\"><img style=\\\"width: 200px;\\\" src=\\\"\\/store\\/1\\/default_images\\/envato.png\\\"><\\/a><\\/p>\"}}'),
(51, 26, 'es', '{\"02nh9a\":{\"title\":\"hogar\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"Cursos\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"Instructoras\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"},\"VBxDrB\":{\"title\":\"Blog\",\"link\":\"\\/blog\",\"order\":\"4\"},\"Uo5b2v\":{\"title\":\"Tienda\",\"link\":\"\\/products\",\"order\":\"4\"},\"Wnq5Qb\":{\"title\":\"Foros\",\"link\":\"\\/forums\",\"order\":\"5\"}}'),
(52, 26, 'ar', '{\"02nh9a\":{\"title\":\"\\u0627\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\",\"order\":\"1\"},\"1cH2kF\":{\"title\":\"\\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a\",\"link\":\"\\/classes?sort=newest\",\"order\":\"2\"},\"gGf8Lv\":{\"title\":\"\\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646\",\"link\":\"\\/instructor-finder\",\"order\":\"3\"},\"Uo5b2v\":{\"title\":\"\\u0645\\u062a\\u062c\\u0631\",\"link\":\"\\/products\",\"order\":\"4\"},\"Wnq5Qb\":{\"title\":\"\\u0627\\u0644\\u0645\\u0646\\u062a\\u062f\\u064a\\u0627\\u062a\",\"link\":\"\\/forums\",\"order\":\"5\"}}'),
(53, 32, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"\\u0627\\u0639\\u062b\\u0631 \\u0639\\u0644\\u0649 \\u0623\\u0641\\u0636\\u0644 \\u0645\\u062f\\u0631\\u0628\",\"description\":\"\\u062a\\u0628\\u062d\\u062b \\u0639\\u0646 \\u0645\\u062f\\u0631\\u0628\\u061f \\u0627\\u0639\\u062b\\u0631 \\u0639\\u0644\\u0649 \\u0623\\u0641\\u0636\\u0644 \\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0648\\u0641\\u0642\\u064b\\u0627 \\u0644\\u0645\\u0639\\u0627\\u064a\\u064a\\u0631 \\u0645\\u062e\\u062a\\u0644\\u0641\\u0629 \\u0645\\u062b\\u0644 \\u0627\\u0644\\u062c\\u0646\\u0633 \\u0648\\u0645\\u0633\\u062a\\u0648\\u0649 \\u0627\\u0644\\u0645\\u0647\\u0627\\u0631\\u0629 \\u0648\\u0627\\u0644\\u0633\\u0639\\u0631 \\u0648\\u0646\\u0648\\u0639 \\u0627\\u0644\\u0627\\u062c\\u062a\\u0645\\u0627\\u0639 \\u0648\\u0627\\u0644\\u062a\\u0642\\u064a\\u064a\\u0645 \\u0648\\u0645\\u0627 \\u0625\\u0644\\u0649 \\u0630\\u0644\\u0643.\\r\\n\\u0627\\u0628\\u062d\\u062b \\u0639\\u0646 \\u0645\\u062f\\u0631\\u0628\\u064a\\u0646 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062e\\u0631\\u064a\\u0637\\u0629.\",\"button1\":{\"title\":\"\\u0627\\u0644\\u0628\\u0627\\u062d\\u062b \\u0639\\u0646 \\u0627\\u0644\\u0645\\u0639\\u0644\\u0645\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"\\u0645\\u062f\\u0631\\u0633\\u0648\\u0646 \\u0639\\u0644\\u0649 \\u0627\\u0644\\u062e\\u0631\\u064a\\u0637\\u0629\",\"link\":\"\\/instructor-finder\"}}'),
(54, 32, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/instructor_finder_banner.jpg\",\"title\":\"Encuentra la mejor instructora\",\"description\":\"\\u00bfBuscas un instructor? Encuentre los mejores instructores seg\\u00fan diferentes par\\u00e1metros como g\\u00e9nero, nivel de habilidad, precio, tipo de reuni\\u00f3n, calificaci\\u00f3n, etc.\\r\\nEncuentra instructores en el mapa.\",\"button1\":{\"title\":\"Buscadora de tutores\",\"link\":\"\\/instructor-finder\\/wizard\"},\"button2\":{\"title\":\"Tutores en el mapa\",\"link\":\"\\/instructor-finder\"}}'),
(55, 33, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"\\u0627\\u0631\\u0628\\u062d \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a\",\"description\":\"\\u0627\\u0633\\u062a\\u062e\\u062f\\u0645 Rocket LMS \\u0648\\u0627\\u0631\\u0628\\u062d \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a \\u0648\\u0641\\u0642\\u064b\\u0627 \\u0644\\u0644\\u0623\\u0646\\u0634\\u0637\\u0629 \\u0627\\u0644\\u0645\\u062e\\u062a\\u0644\\u0641\\u0629.\\r\\n\\u0633\\u062a\\u062a\\u0645\\u0643\\u0646 \\u0645\\u0646 \\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0646\\u0642\\u0627\\u0637 \\u0627\\u0644\\u0646\\u0627\\u062f\\u064a \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629 \\u0628\\u0643 \\u0644\\u0644\\u062d\\u0635\\u0648\\u0644 \\u0639\\u0644\\u0649 \\u062c\\u0648\\u0627\\u0626\\u0632 \\u0648\\u062f\\u0648\\u0631\\u0627\\u062a \\u0645\\u062c\\u0627\\u0646\\u064a\\u0629. \\u0627\\u0628\\u062f\\u0623 \\u0641\\u064a \\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0627\\u0644\\u0646\\u0638\\u0627\\u0645 \\u0627\\u0644\\u0622\\u0646 \\u0648\\u0627\\u062c\\u0645\\u0639 \\u0627\\u0644\\u0646\\u0642\\u0627\\u0637!\",\"button1\":{\"title\":\"\\u0627\\u0644\\u0645\\u0643\\u0627\\u0641\\u0622\\u062a\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"\\u0646\\u0627\\u062f\\u064a \\u0627\\u0644\\u0646\\u0642\\u0627\\u0637\",\"link\":\"\\/panel\\/rewards\"}}'),
(56, 33, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/club_points_banner.png\",\"title\":\"Gana puntos del club\",\"description\":\"Utilice Rocket LMS y gane puntos del club seg\\u00fan diferentes actividades.\\r\\nPodr\\u00e1s utilizar tus puntos del club para conseguir premios y cursos gratuitos. \\u00a1Comience a usar el sistema ahora y acumule puntos!\",\"button1\":{\"title\":\"Recompensas\",\"link\":\"\\/reward-courses\"},\"button2\":{\"title\":\"club de puntos\",\"link\":\"\\/panel\\/rewards\"}}'),
(57, 40, 'ar', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"\\u0643\\u0646 \\u0645\\u062f\\u0631\\u0628\\u064b\\u0627\",\"description\":\"\\u0647\\u0644 \\u0623\\u0646\\u062a \\u0645\\u0647\\u062a\\u0645 \\u0628\\u0623\\u0646 \\u062a\\u0643\\u0648\\u0646 \\u062c\\u0632\\u0621\\u064b\\u0627 \\u0645\\u0646 \\u0645\\u062c\\u062a\\u0645\\u0639\\u0646\\u0627\\u061f\\r\\n\\u064a\\u0645\\u0643\\u0646\\u0643 \\u0623\\u0646 \\u062a\\u0643\\u0648\\u0646 \\u062c\\u0632\\u0621\\u064b\\u0627 \\u0645\\u0646 \\u0645\\u062c\\u062a\\u0645\\u0639\\u0646\\u0627 \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u062a\\u0633\\u062c\\u064a\\u0644 \\u0643\\u0645\\u062f\\u0631\\u0628 \\u0623\\u0648 \\u0645\\u0646\\u0638\\u0645\\u0629.\",\"button1\":{\"title\":\"\\u0643\\u0646 \\u0645\\u062f\\u0631\\u0633\\u064b\\u0627\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"\\u062d\\u0632\\u0645 \\u0627\\u0644\\u062a\\u0633\\u062c\\u064a\\u0644\",\"link\":\"become-instructor\\/packages\\/\"}}'),
(58, 40, 'es', '{\"image\":\"\\/store\\/1\\/default_images\\/home_sections_banners\\/become_instructor_banner.jpg\",\"title\":\"Convi\\u00e9rtete en instructora\",\"description\":\"\\u00bfEst\\u00e1s interesado en ser parte de nuestra comunidad?\\r\\nPuedes ser parte de nuestra comunidad registr\\u00e1ndote como instructor u organizaci\\u00f3n.\",\"button1\":{\"title\":\"Convi\\u00e9rtete en instructora\",\"link\":\"\\/become-instructor\"},\"button2\":{\"title\":\"Paquetes de registro\",\"link\":\"become-instructor\\/packages\\/\"}}'),
(59, 42, 'en', '{\"primary\":null,\"primary-border\":null,\"primary-hover\":null,\"primary-border-hover\":null,\"primary-btn-shadow\":null,\"primary-btn-shadow-hover\":null,\"primary-btn-color\":null,\"primary-btn-color-hover\":null,\"secondary\":null,\"secondary-border\":null,\"secondary-hover\":null,\"secondary-border-hover\":null,\"secondary-btn-shadow\":null,\"secondary-btn-shadow-hover\":null,\"secondary-btn-color\":null,\"secondary-btn-color-hover\":null,\"admin_primary\":\"#6777ef\"}'),
(60, 44, 'en', '{\"dialog_title\":\"Cookie Privacy Policies\",\"dialog_description\":\"Our website uses cookies, mainly from 3rd party services. Define your preferences or agree to our use of cookies.\",\"cookie_settings_modal_message\":\"<p>When you visit any of our websites, it may store or retrieve information on your browser, mostly in the form of cookies. This information might be about you, your preferences or your device and is mostly used to make the site work as you expect it to. The information does not usually directly identify you, but it can give you a more personalized web experience. Because we respect your right to privacy, you can choose not to allow some types of cookies. Click on the different category headings to find out more and manage your preferences. Please note, that blocking some types of cookies may impact your experience of the site and the services we are able to offer.<\\/p>\",\"cookie_settings_modal_items\":{\"dDRjfkGvQfFzQJpa\":{\"title\":\"Strictly Necessary\",\"subtitle\":null,\"description\":\"These cookies are necessary for our website to function properly and cannot be switched off in our systems. They are usually only set in response to actions made by you that amount to a request for services, such as setting your privacy preferences, logging in or filling in forms, or where they\\u2019re essential to providing you with a service you have requested. You cannot opt out of these cookies. You can set your browser to block or alert you about these cookies, but if you do, some parts of the site will not then work. These cookies do not store any personally identifiable information.\",\"required\":\"1\"},\"mOzJowgvTnWFlRzz\":{\"title\":\"Performance Cookies\",\"subtitle\":null,\"description\":\"These cookies allow us to count visits and traffic sources so we can measure and improve the performance of our site. They help us to know which pages are the most and least popular and see how visitors move around the site, which helps us optimize your experience. All information these cookies collect is aggregated and therefore anonymous. If you do not allow these cookies we will not be able to use your data in this way.\",\"required\":\"0\"},\"XBMtdYaeSrqMicTH\":{\"title\":\"Functional Cookies\",\"subtitle\":null,\"description\":\"These cookies enable the website to provide enhanced functionality and personalization. They may be set by us or by third-party providers whose services we have added to our pages. If you do not allow these cookies then some or all of these services may not function properly.\",\"required\":\"0\"},\"XlLqzsvNpRqdcNWP\":{\"title\":\"Targeting Cookies\",\"subtitle\":null,\"description\":\"These cookies may be set through our site by our advertising partners. They may be used by those companies to build a profile of your interests and show you relevant adverts on other sites. They do not store directly personal information but are based on uniquely identifying your browser and internet device. If you do not allow these cookies, you will experience less targeted advertising.\",\"required\":\"0\"}}}'),
(61, 41, 'en', '{\"status\":\"0\",\"virtual_product_commission\":\"20\",\"physical_product_commission\":\"10\",\"store_tax\":\"10\",\"possibility_create_virtual_product\":\"0\",\"possibility_create_physical_product\":\"0\",\"shipping_tracking_url\":\"https:\\/\\/www.tracking.my\\/\",\"activate_comments\":\"0\",\"show_address_selection_in_cart\":\"0\",\"take_address_selection_optional\":\"0\"}'),
(62, 46, 'en', '{\"main\":{\"regular\":\"\\/store\\/1\\/fonts\\/montserrat-regular.woff2\",\"bold\":\"\\/store\\/1\\/fonts\\/montserrat-bold.woff2\",\"medium\":\"\\/store\\/1\\/fonts\\/montserrat-medium.woff2\"},\"rtl\":{\"regular\":\"\\/store\\/1\\/fonts\\/Vazir-Regular.woff2\",\"bold\":\"\\/store\\/1\\/fonts\\/Vazir-Bold.woff2\",\"medium\":\"\\/store\\/1\\/fonts\\/Vazir-Medium.woff2\"}}'),
(63, 43, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_section.jpg\",\"title\":\"Have a Question? Ask it in forum and get answer\",\"description\":\"Our forums helps you to create your questions on different subjects and communicate with other forum users. Our users will help you to get the best answer!\",\"button1\":{\"title\":\"Create a new topic\",\"link\":\"\\/forums\\/create-topic\"},\"button2\":{\"title\":\"Browse forums\",\"link\":\"\\/forums\"}}'),
(64, 45, 'en', '{\"mobile_app_hero_image\":\"\\/store\\/1\\/default_images\\/app_only.png\",\"mobile_app_description\":\"<div>Is an amazing, modern, and clean landing page for showcasing your app or anything else.<\\/div><div><br><\\/div><div>A mobile application or app is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Mobile applications often stand in contrast to desktop applications which are designed to run on desktop computers, and web applications which run in mobile web browsers rather than directly on the mobile device.<\\/div>\",\"mobile_app_buttons\":{\"htQgcSjzjLJlGRyY\":{\"title\":\"Download from Play Store\",\"link\":\"https:\\/\\/play.google.com\\/store\\/games\",\"icon\":\"\\/store\\/1\\/default_images\\/google-play.png\",\"color\":\"primary\"}}}'),
(65, 48, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/ads_modal.png\",\"title\":\"Sales Campaign\",\"description\":\"We have a sales campaign on our promoted courses and products. You can purchase 150 products at a discounted price up to 50% discount.\",\"button1\":{\"title\":\"View Courses\",\"link\":\"\\/classes\"},\"button2\":{\"title\":\"View Products\",\"link\":\"\\/products\"}}'),
(66, 52, 'en', '{\"show_guarantee_text\":\"1\",\"show_secure_payment_text\":\"1\",\"secure_payment_image\":\"\\/store\\/1\\/themes\\/general\\/secure_payments.svg\",\"user_avatar_style\":\"ui_avatar\",\"default_user_avatar\":\"\\/store\\/1\\/default_images\\/default_profile.jpg\",\"default_user_profile_secondary_image\":\"\\/store\\/1\\/themes\\/general\\/default_instructor_placeholder.png\",\"platform_phone_and_email_position\":\"footer\"}'),
(67, 47, 'en', '{\"webinar_reminder_schedule\":\"1\",\"meeting_reminder_schedule\":\"1\",\"subscribe_reminder_schedule\":\"48\"}'),
(68, 61, 'en', '{\"offline_banks_status\":\"0\"}'),
(69, 62, 'en', '{\"status\":\"1\",\"allow_sending_gift_for_courses\":\"1\",\"allow_sending_gift_for_bundles\":\"1\",\"allow_sending_gift_for_products\":\"1\",\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/gift_overlay.png\"}'),
(70, 63, 'en', '{\"status\":\"0\",\"unlock_registration_bonus_instantly\":\"0\",\"unlock_registration_bonus_with_referral\":\"0\",\"number_of_referred_users\":null,\"enable_referred_users_purchase\":\"0\",\"purchase_amount_for_unlocking_bonus\":null,\"registration_bonus_amount\":\"50\",\"bonus_wallet\":\"balance_wallet\"}'),
(71, 57, 'en', '{\"enable_statistics\":\"1\",\"display_default_statistics\":\"1\"}'),
(72, 56, 'en', '{\"currency\":\"SAR\",\"currency_position\":\"left\",\"currency_separator\":\"dot\",\"currency_decimal\":\"2\",\"multi_currency\":\"0\"}'),
(73, 53, 'en', '{\"login_device_limit\":\"0\",\"number_of_allowed_devices\":\"10\",\"captcha_for_admin_login\":\"0\",\"captcha_for_admin_forgot_pass\":\"1\",\"captcha_for_login\":\"0\",\"captcha_for_register\":\"0\",\"captcha_for_forgot_pass\":\"1\",\"admin_panel_url\":\"admin\"}'),
(74, 54, 'en', '{\"status\":\"0\",\"disable_course_access_when_user_have_an_overdue_installment\":\"0\",\"disable_all_courses_access_when_user_have_an_overdue_installment\":\"0\",\"disable_instalments_when_the_user_have_an_overdue_installment\":\"0\",\"allow_cancel_verification\":\"0\",\"display_installment_button\":\"0\",\"overdue_interval_days\":\"3\",\"installment_plans_position\":\"top_of_page\",\"reminder_before_overdue_days\":\"3\",\"reminder_after_overdue_days\":\"2\"}'),
(75, 58, 'en', '{\"title\":\"We are under maintenance!\",\"image\":\"\\/store\\/1\\/themes\\/general\\/maintenance.svg\",\"description\":\"We are working on the platform; It won\'t take a long time. We will try to back as soon as possible.\",\"maintenance_button\":{\"title\":\"Contact Support\",\"link\":\"\\/\"},\"end_date\":1771630200,\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/maintenance_overlay.png\"}');
INSERT INTO `setting_translations` (`id`, `setting_id`, `locale`, `value`) VALUES
(76, 64, 'en', '{\"term_image\":\"\\/store\\/1\\/themes\\/general\\/registration_bonus.png\",\"items\":{\"DnrPr\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step1.svg\",\"title\":\"Sign up\",\"description\":\"Create an account on platform and get $50\"},\"eNMTB\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step2.svg\",\"title\":\"Refer your friends\",\"description\":\"Refer at least 5 users to the system using your affiliate URL\"},\"fdIUc\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step3.svg\",\"title\":\"Reach purchase target\",\"description\":\"Each referred user should purchase $100 on the platform\"},\"oeMZr\":{\"icon\":\"\\/store\\/1\\/default_images\\/registration bonus\\/step4.svg\",\"title\":\"Unlock your bonus\",\"description\":\"Your bonus will be unlocked! Enjoy spending...\"}}}'),
(77, 55, 'en', '{\"terms_description\":\"<p>Welcome to our website! To ensure the best possible experience for all users, please review and agree to the following terms and rules before using our installment feature:<\\/p><p>Installment Payment Plan: Our website offers an installment payment plan for select courses. By selecting the installment payment option, you agree to pay the full course fee in multiple installments. Each installment payment will be automatically deducted from the payment method you provided on the scheduled dates until the full payment is completed.<\\/p><p>Payment Plan Fees: Our installment payment plan may include a small processing fee for each installment payment. The total processing fee will be disclosed to you before you select the installment payment option.<\\/p><p>Late Payment: If a payment is not received on the scheduled date, a late payment fee may be added to the next scheduled payment.<\\/p><p>Refunds: Once an installment payment is made, it is non-refundable. However, if you wish to cancel your enrollment in the course, you may be eligible for a partial refund according to our Refund Policy.<\\/p><p>Default: If you default on a payment or fail to complete the full payment plan, your access to the course will be revoked, and you may be subject to additional fees and collection efforts.<\\/p><p>Privacy: Your personal and payment information will be kept secure and confidential. We use industry-standard security measures to protect your information.<\\/p><p>Changes to Terms and Rules: We reserve the right to modify these terms and rules at any time. Any changes will be posted on our website and will become effective immediately upon posting.<\\/p><p>By using our installment payment plan, you agree to these terms and rules. If you have any questions or concerns, please contact our support team.<\\/p>\"}'),
(78, 65, 'en', '{\"status\":\"0\",\"active_for_admin_panel\":\"0\",\"active_for_organization_panel\":\"0\",\"active_for_instructor_panel\":\"0\",\"secret_key\":null,\"activate_text_service_type\":\"0\",\"text_service_type\":\"gpt-3.5-turbo\",\"number_of_text_generated_per_request\":\"1\",\"max_tokens\":\"500\",\"activate_image_service_type\":\"0\",\"number_of_images_generated_per_request\":\"1\"}'),
(79, 66, 'en', '{\"_token\":\"JLQg499REU6a7m07ampMiSi4smuU0omJcl29HIek\",\"page\":\"general\",\"name\":\"certificate_settings\",\"locale\":\"en\",\"status\":\"0\",\"certificate_id\":\"CR\",\"ltr_font\":\"\\/store\\/1\\/fonts\\/montserrat-medium.woff2\",\"rtl_font\":\"\\/store\\/1\\/fonts\\/Vazir-Medium.woff2\",\"certificate_api_user_id\":\"01KP6EPS7KRW2K9FMS0TJVPFQS\",\"certificate_api_key\":\"019d8ceb-64f3-7ea7-b1f8-13e7de468a3c\"}'),
(80, 67, 'en', '{\"status\":\"0\",\"reset_cart_items\":\"0\",\"reset_hours\":null,\"default_cart_reminder\":\"121\",\"default_cart_coupon_template\":\"122\"}'),
(81, 68, 'en', '{\"title\":\"Access Limited\",\"image\":\"\\/store\\/1\\/themes\\/general\\/access_denied_state.svg\",\"description\":\"Your IP is not allowed to access the website.\"}'),
(82, 59, 'en', '{\"direct_publication_of_courses\":\"1\",\"direct_publication_of_bundles\":\"0\",\"direct_publication_of_comments\":\"0\",\"direct_publication_of_reviews\":\"0\",\"direct_publication_of_blog\":\"0\",\"allow_instructor_delete_content\":\"1\",\"content_delete_method\":\"delete_with_admin_approval\",\"disable_registration_verification_process\":null,\"duration_of_resend_verification_code\":\"2\"}'),
(83, 69, 'en', '{\"courses\":{\"type\":\"percent\",\"value\":\"20\"},\"bundles\":{\"type\":\"percent\",\"value\":\"20\"},\"virtual_products\":{\"type\":\"percent\",\"value\":\"30\"},\"physical_products\":{\"type\":\"percent\",\"value\":\"10\"},\"meetings\":{\"type\":\"percent\",\"value\":\"30\"}}'),
(84, 70, 'en', '{\"forums_status\":\"0\"}'),
(85, 71, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_hero.png\",\"title\":\"Your Learning Community Starts Here\",\"description\":\"Access a dedicated space for questions, answers, and peer support. Stay connected, solve doubts, and enrich your learning journey collaboratively\",\"badge\":{\"title\":\"Forum\",\"color\":\"#3fcd82\"},\"show_search\":\"1\"}'),
(86, 72, 'en', '{\"separator_image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_separator.svg\",\"revolver_items\":{\"Zknua\":{\"title\":\"Beauty and Makeup\",\"link\":\"\\/forums\\/Beauty-Makeup\\/topics\"},\"Adgnd\":{\"title\":\"Food and Beverage\",\"link\":\"\\/forums\\/Food-Beverage\\/topics\"},\"nWqZS\":{\"title\":\"Travel\",\"link\":\"\\/forums\\/Travel\\/topics\"},\"VQDJm\":{\"title\":\"Music\",\"link\":\"\\/forums\\/Music\\/topics\"},\"vkzzq\":{\"title\":\"Digital Marketing\",\"link\":\"\\/forums\\/Digital-Marketing\\/topics\"},\"mTQqI\":{\"title\":\"Public Relations\",\"link\":\"\\/forums\\/Public-Relations\\/topics\"},\"iYAHS\":{\"title\":\"Advertising\",\"link\":\"\\/forums\\/Advertising\\/topics\"},\"qaslt\":{\"title\":\"Social Media\",\"link\":\"\\/forums\\/Social-Media\\/topics\"}}}'),
(87, 73, 'en', '{\"image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_cta_image.png\",\"title\":\"Share What You Know!\",\"description\":\"Be part of a thriving learning community. Ask questions, share ideas, and connect with fellow learners to expand your knowledge beyond the classroom experience.\",\"badge\":{\"title\":\"Communicate Now!\",\"color\":\"#3fcd82\"},\"button1\":{\"title\":\"Create a Topic\",\"link\":\"\\/forums\\/create-topic\"},\"button2\":{\"title\":\"Explore Forums\",\"link\":\"\\/forums\"}}'),
(88, 74, 'en', '{\"create_topic_cover_image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_new_cover.jpg\",\"forum_search_topics_cover_image\":\"\\/store\\/1\\/default_images\\/forums\\/forum_search_cover.jpg\",\"featured_topics_left_float_image\":\"\\/store\\/1\\/default_images\\/forums\\/icons\\/forum_floating_1.png\",\"featured_topics_right_float_image\":\"\\/store\\/1\\/default_images\\/forums\\/icons\\/forum_floating_2.png\"}'),
(89, 75, 'en', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/500_error.svg\",\"title\":\"Something Went Wrong\",\"description\":\"An unexpected server error occurred. Please try again later...\",\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(90, 76, 'en', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/419_error.svg\",\"title\":\"Session Expired\",\"description\":\"Your session has timed out. Please refresh and try again...\",\"button\":{\"title\":\"Back to Home\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(91, 77, 'en', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/403_error.svg\",\"title\":\"Access Not Allowed\",\"description\":\"You don\\u2019t have permission to view this page or resource...\",\"button\":{\"title\":\"Back to Home\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(92, 78, 'en', '{\"featured_products\":[\"1\",\"2\",\"5\"],\"background_image\":\"\\/store\\/1\\/default_images\\/store\\/store_featured_categories_bg.svg\",\"overlay_image\":\"\\/store\\/1\\/default_images\\/store\\/store_featured_categories_overlay.png\"}'),
(93, 79, 'en', '{\"featured_instructors_ids\":[\"923\",\"929\",\"934\",\"1015\",\"1016\"],\"top_mentors_ids\":[\"934\",\"1015\"],\"main_image_step_1\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step1_background.jpg\",\"overlay_image_step_1\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step1_overlay.png\",\"main_image_step_2\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step2_background.jpg\",\"overlay_image_step_2\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step2_overlay.png\",\"main_image_step_3\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step3_background.jpg\",\"overlay_image_step_3\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step3_overlay.png\",\"main_image_step_4\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step4_background.jpg\",\"overlay_image_step_4\":\"\\/store\\/1\\/default_images\\/tutor_finder\\/tutorfinder_step4_overlay.png\"}'),
(94, 80, 'en', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/affiliate_guide.svg\",\"description\":\"Once the affiliate feature is activated, you\\u2019ll receive a unique referral link to share with others. When someone registers using your link and activates their account, you can earn a fixed bonus\\u2014automatically credited to your wallet.\\r\\n\\r\\nBut that\\u2019s not all. Each time your referred user makes a purchase on the platform, you\\u2019ll also earn a commission from their transaction. It\\u2019s a simple way to grow the community while earning rewards for every successful referral.\\r\\n\\r\\nTrack your referrals and earnings easily from your dashboard, and keep growing your rewards by sharing your link with more friends.\"}'),
(95, 81, 'en', '{\"student_enroll_on_courses\":[\"2022\",\"2010\"],\"student_overview_courses\":[\"2005\",\"2009\"],\"student_when_dont_upcoming_live_session\":[\"2007\",\"2006\"]}'),
(96, 82, 'en', '{\"description\":\"Make your title clear so users understand immediately.\\r\\n\\r\\nUse a high-quality cover image for professionalism.\\r\\n\\r\\nCheck pricing and discounts carefully before publishing.\\r\\n\\r\\nWrite clear, compelling descriptions highlighting key points.\\r\\n\\r\\nAdd relevant keywords and categories for easy discovery.\\r\\n\\r\\nUpload only original content you own or licensed.\\r\\n\\r\\nClarify refund terms, access rules, and conditions upfront.\\r\\n\\r\\nList all files, resources, and bonuses accurately.\\r\\n\\r\\nRespond quickly to questions and feedback from buyers.\",\"image\":\"\\/store\\/1\\/default_images\\/wizard_image.svg\"}'),
(98, 28, 'ar', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/404_error.svg\",\"title\":\"\\u0627\\u0644\\u0635\\u0641\\u062d\\u0629 \\u063a\\u064a\\u0631 \\u0645\\u0648\\u062c\\u0648\\u062f\\u0629\",\"description\":\"\\u064a\\u0628\\u062f\\u0648 \\u0623\\u0646 \\u0627\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u062a\\u064a \\u062a\\u0628\\u062d\\u062b \\u0639\\u0646\\u0647\\u0627 \\u063a\\u064a\\u0631 \\u0645\\u062a\\u0648\\u0641\\u0631\\u0629 \\u0641\\u064a \\u0627\\u0644\\u0648\\u0642\\u062a \\u0627\\u0644\\u062d\\u0627\\u0644\\u064a. \\u0642\\u062f \\u062a\\u0643\\u0648\\u0646 \\u062a\\u0645\\u062a \\u0625\\u0632\\u0627\\u0644\\u062a\\u0647\\u0627\\u060c \\u0623\\u0648 \\u062a\\u0645 \\u062a\\u063a\\u064a\\u064a\\u0631 \\u0631\\u0627\\u0628\\u0637\\u0647\\u0627\\u060c \\u0623\\u0648 \\u0631\\u0628\\u0645\\u0627 \\u062a\\u0645 \\u0625\\u062f\\u062e\\u0627\\u0644 \\u0627\\u0644\\u0639\\u0646\\u0648\\u0627\\u0646 \\u0628\\u0634\\u0643\\u0644 \\u063a\\u064a\\u0631 \\u0635\\u062d\\u064a\\u062d.\",\"button\":{\"title\":\"\\u0639\\u0648\\u062f\\u0629 \\u0644\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(99, 44, 'ar', '{\"dialog_title\":\"\\u062a\\u0646\\u0648\\u064a\\u0647 \\u0627\\u0644\\u062e\\u0635\\u0648\\u0635\\u064a\\u0629 \\u0648\\u062d\\u0645\\u0627\\u064a\\u0629 \\u0627\\u0644\\u0628\\u064a\\u0627\\u0646\\u0627\\u062a\",\"dialog_description\":\"\\u0646\\u0633\\u062a\\u062e\\u062f\\u0645 \\u0645\\u0644\\u0641\\u0627\\u062a \\u062a\\u0639\\u0631\\u064a\\u0641 \\u0627\\u0644\\u0627\\u0631\\u062a\\u0628\\u0627\\u0637 \\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u062a\\u062c\\u0631\\u0628\\u062a\\u0643. \\u0628\\u0627\\u0644\\u0645\\u062a\\u0627\\u0628\\u0639\\u0629\\u060c \\u0623\\u0646\\u062a \\u062a\\u0648\\u0627\\u0641\\u0642 \\u0639\\u0644\\u0649 \\u0633\\u064a\\u0627\\u0633\\u0629 \\u0627\\u0644\\u062e\\u0635\\u0648\\u0635\\u064a\\u0629.\",\"cookie_settings_modal_message\":\"<p>\\u0646\\u062d\\u0646 \\u0646\\u0633\\u062a\\u062e\\u062f\\u0645 \\u0645\\u0644\\u0641\\u0627\\u062a \\u062a\\u0639\\u0631\\u064a\\u0641 \\u0627\\u0644\\u0627\\u0631\\u062a\\u0628\\u0627\\u0637 \\u0648\\u062a\\u0642\\u0646\\u064a\\u0627\\u062a \\u0645\\u0634\\u0627\\u0628\\u0647\\u0629 \\u0644\\u062a\\u062d\\u0633\\u064a\\u0646 \\u062a\\u062c\\u0631\\u0628\\u062a\\u0643\\u060c \\u0648\\u062a\\u062d\\u0644\\u064a\\u0644 \\u0627\\u0633\\u062a\\u062e\\u062f\\u0627\\u0645 \\u0627\\u0644\\u0645\\u0648\\u0642\\u0639\\u060c \\u0648\\u062a\\u0642\\u062f\\u064a\\u0645 \\u0645\\u062d\\u062a\\u0648\\u0649 \\u0645\\u062e\\u0635\\u0635. \\u0645\\u0646 \\u062e\\u0644\\u0627\\u0644 \\u0627\\u0644\\u0645\\u062a\\u0627\\u0628\\u0639\\u0629\\u060c \\u0641\\u0625\\u0646\\u0643 \\u062a\\u0648\\u0627\\u0641\\u0642 \\u0639\\u0644\\u0649 \\u0645\\u0639\\u0627\\u0644\\u062c\\u0629 \\u0628\\u064a\\u0627\\u0646\\u0627\\u062a\\u0643 \\u0648\\u0641\\u0642\\u0627\\u064b \\u0644\\u0633\\u064a\\u0627\\u0633\\u0629 \\u0627\\u0644\\u062e\\u0635\\u0648\\u0635\\u064a\\u0629 \\u0627\\u0644\\u062e\\u0627\\u0635\\u0629 \\u0628\\u0646\\u0627. \\u064a\\u0645\\u0643\\u0646\\u0643 \\u0625\\u062f\\u0627\\u0631\\u0629 \\u062a\\u0641\\u0636\\u064a\\u0644\\u0627\\u062a\\u0643 \\u0641\\u064a \\u0623\\u064a \\u0648\\u0642\\u062a.<\\/p>\"}'),
(100, 77, 'ar', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/403_error.svg\",\"title\":\"\\u0627\\u0644\\u0648\\u0635\\u0648\\u0644 \\u063a\\u064a\\u0631 \\u0645\\u0633\\u0645\\u0648\\u062d \\u0628\\u0647\",\"description\":\"\\u0644\\u064a\\u0633 \\u0644\\u062f\\u064a\\u0643 \\u0627\\u0644\\u0625\\u0630\\u0646 \\u0644\\u0639\\u0631\\u0636 \\u0647\\u0630\\u0647 \\u0627\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0623\\u0648 \\u0627\\u0644\\u0645\\u0648\\u0631\\u062f...\",\"button\":{\"title\":\"\\u0639\\u0648\\u062f\\u0629 \\u0644\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(101, 76, 'ar', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/419_error.svg\",\"title\":\"\\u0627\\u0646\\u062a\\u0647\\u062a \\u0627\\u0644\\u062c\\u0644\\u0633\\u0629\",\"description\":\"\\u0627\\u0646\\u062a\\u0647\\u062a \\u062c\\u0644\\u0633\\u062a\\u0643. \\u064a\\u064f\\u0631\\u062c\\u0649 \\u0627\\u0644\\u062a\\u062d\\u062f\\u064a\\u062b \\u0648\\u0627\\u0644\\u0645\\u062d\\u0627\\u0648\\u0644\\u0629 \\u0645\\u0631\\u0629 \\u0623\\u062e\\u0631\\u0649...\",\"button\":{\"title\":\"\\u0639\\u0648\\u062f\\u0629 \\u0644\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}'),
(102, 75, 'ar', '{\"image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/500_error.svg\",\"title\":\"\\u0644\\u0642\\u062f \\u062d\\u062f\\u062b \\u062e\\u0637\\u0623 \\u0645\\u0627\",\"description\":\"\\u062d\\u062f\\u062b \\u062e\\u0637\\u0623 \\u063a\\u064a\\u0631 \\u0645\\u062a\\u0648\\u0642\\u0639 \\u0641\\u064a \\u0627\\u0644\\u062e\\u0627\\u062f\\u0645. \\u064a\\u064f\\u0631\\u062c\\u0649 \\u0627\\u0644\\u0645\\u062d\\u0627\\u0648\\u0644\\u0629 \\u0644\\u0627\\u062d\\u0642\\u064b\\u0627...\",\"button\":{\"title\":\"\\u0639\\u0648\\u062f\\u0629 \\u0644\\u0644\\u0635\\u0641\\u062d\\u0629 \\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"link\":\"\\/\"},\"right_float_image\":\"\\/store\\/1\\/themes\\/general\\/error_pages\\/warning_floating.png\"}');

-- --------------------------------------------------------

--
-- Structure de la table `special_offers`
--

CREATE TABLE `special_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `subscribe_id` int(10) UNSIGNED DEFAULT NULL,
  `registration_package_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `percent` int(10) UNSIGNED NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  `from_date` int(10) UNSIGNED NOT NULL,
  `to_date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `specific_locations`
--

CREATE TABLE `specific_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  `province_id` int(10) UNSIGNED DEFAULT NULL,
  `city_id` int(10) UNSIGNED DEFAULT NULL,
  `district_id` int(10) UNSIGNED DEFAULT NULL,
  `geo_center` point DEFAULT NULL,
  `address` text DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subscribes`
--

CREATE TABLE `subscribes` (
  `id` int(10) UNSIGNED NOT NULL,
  `usable_count` int(10) UNSIGNED NOT NULL,
  `days` int(10) UNSIGNED NOT NULL,
  `price` double(15,2) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `infinite_use` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `subscribes`
--

INSERT INTO `subscribes` (`id`, `usable_count`, `days`, `price`, `icon`, `is_popular`, `infinite_use`, `created_at`) VALUES
(3, 100, 15, 20.00, '/store/1/default_images/subscribe_packages/subscribe_icon_1.svg', 0, 0, 1751707952),
(4, 1000, 30, 100.00, '/store/1/default_images/subscribe_packages/subscribe_icon_2.svg', 1, 0, 1751708114),
(5, 400, 30, 50.00, '/store/1/default_images/subscribe_packages/subscribe_icon_3.svg', 0, 0, 1751708005);

-- --------------------------------------------------------

--
-- Structure de la table `subscribe_reminds`
--

CREATE TABLE `subscribe_reminds` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `subscribe_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subscribe_specification_items`
--

CREATE TABLE `subscribe_specification_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `subscribe_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `course_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `subscribe_translations`
--

CREATE TABLE `subscribe_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscribe_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `subscribe_translations`
--

INSERT INTO `subscribe_translations` (`id`, `subscribe_id`, `locale`, `title`, `subtitle`, `description`) VALUES
(1, 3, 'en', 'Starter Access', 'Ideal for beginners to start learning', 'Perfect for beginners, offering essential tools and resources to kickstart your learning journey effectively'),
(2, 4, 'en', 'Pro Plus', 'Advanced tools for serious learners', 'Designed for serious learners, providing advanced features, in-depth content, and exclusive resources'),
(3, 5, 'en', 'Elite Mastery', 'Exclusive access for expert users', 'Exclusive access for experts, offering premium content, personalized support, and top-tier resources for mastery'),
(4, 3, 'ar', 'برونزية', 'اقترح للاستخدام الشخصي', NULL),
(5, 3, 'es', 'Bronce', 'Sugerido para uso personal', NULL),
(6, 4, 'es', 'Oro', 'Sugerido para grandes empresas', NULL),
(7, 4, 'ar', 'ذهب', 'مقترح للشركات الكبيرة', NULL),
(8, 5, 'ar', 'فضة', 'اقترح للشركات الصغيرة', NULL),
(9, 5, 'es', 'Plata', 'Sugerido para pequeñas empresas', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `subscribe_uses`
--

CREATE TABLE `subscribe_uses` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `subscribe_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `installment_order_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `supports`
--

CREATE TABLE `supports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `status` enum('open','close','replied','supporter_replied') NOT NULL DEFAULT 'open',
  `created_at` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `support_conversations`
--

CREATE TABLE `support_conversations` (
  `id` int(10) UNSIGNED NOT NULL,
  `support_id` int(10) UNSIGNED NOT NULL,
  `supporter_id` int(10) UNSIGNED DEFAULT NULL,
  `sender_id` int(10) UNSIGNED DEFAULT NULL,
  `attach` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `support_departments`
--

CREATE TABLE `support_departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `support_department_translations`
--

CREATE TABLE `support_department_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_department_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(64) NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `upcoming_course_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_avatar` varchar(255) NOT NULL,
  `rate` varchar(5) NOT NULL DEFAULT '0',
  `status` enum('active','disable') NOT NULL DEFAULT 'disable',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `testimonials`
--

INSERT INTO `testimonials` (`id`, `user_avatar`, `rate`, `status`, `created_at`) VALUES
(2, '/store/1/default_images/testimonials/Group 2043.png', '5', 'active', 1606841889),
(3, '/store/1/default_images/testimonials/Group 2038.png', '5', 'active', 1606841910),
(4, '/store/1/default_images/testimonials/Group 2044.png', '5', 'active', 1606841929),
(5, '/store/1/default_images/testimonials/Group 2040.png', '5', 'active', 1606841946),
(6, '/store/1/default_images/testimonials/Group 2049.png', '5', 'active', 1606842000),
(7, '/store/1/default_images/testimonials/Group 2045.png', '5', 'active', 1750180065),
(8, '/store/1/default_images/testimonials/Group 2051.png', '5', 'active', 1750180153),
(9, '/store/1/default_images/testimonials/Group 2046.png', '5', 'active', 1750180264),
(10, '/store/1/default_images/testimonials/Group 2052.png', '5', 'active', 1750180350),
(11, '/store/1/default_images/testimonials/Group 2053.png', '5', 'active', 1750180442);

-- --------------------------------------------------------

--
-- Structure de la table `testimonial_translations`
--

CREATE TABLE `testimonial_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `testimonial_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_bio` varchar(255) NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `testimonial_translations`
--

INSERT INTO `testimonial_translations` (`id`, `testimonial_id`, `locale`, `user_name`, `user_bio`, `comment`) VALUES
(1, 2, 'en', 'Sarah Mitchell', 'Graphic Designer', 'I signed up for this platform last year, and it’s been an amazing journey of learning and growth. The instructors are very knowledgeable, the course material is up to date, and the quizzes and assignments really help reinforce what you learn. I love how flexible it is; I can study whenever I want. I’ve already completed four courses and can’t wait to enroll in more. Highly recommend this site for anyone serious about gaining new skills.'),
(2, 3, 'en', 'James Carter', 'Freelance Videographer', 'Before joining, I was hesitant about online learning. But this platform completely changed my perspective. The video lectures are clear, engaging, and easy to follow. I really appreciate the discussion forums too, where I can ask questions and get help quickly. The certificates have helped me boost my resume, and my confidence has grown a lot. I feel more prepared for new job opportunities now. If you’re considering taking a course, don’t hesitate. It’s worth it!'),
(3, 4, 'en', 'Emily Ross', 'Social Media Manager', 'As someone with a busy schedule, I needed a flexible learning solution. This platform was exactly what I was looking for. The instructors break down complex topics into manageable lessons, and I can track my progress easily. I especially love the mobile app that lets me learn on the go. I’ve already recommended this site to my friends and colleagues. It’s a smart investment for anyone who wants to keep up with industry trends and advance professionally.'),
(4, 5, 'en', 'Daniel Kim', 'Architecture Student', 'Taking courses here has been one of my best decisions. The wide variety of subjects means I always find something that fits my interests and career goals. The quizzes and assignments challenge me to apply what I’ve learned, which makes a huge difference. I’ve also interacted with some amazing instructors who genuinely care about their students’ success. If you want to stay ahead in today’s competitive world, I highly recommend giving this learning platform a try.'),
(5, 6, 'en', 'Olivia Bennett', 'Event Planner', 'I’ve always believed in continuous learning, and this site makes it incredibly easy and accessible. The course bundles offer great value for money, and the discounts during promotions are unbeatable. I enjoy the practical projects included in many courses because they help build a solid portfolio. Plus, earning certificates feels rewarding and keeps me motivated. The customer support is responsive and helpful whenever I have questions. Overall, I’ve gained valuable knowledge that I can immediately apply at work.'),
(6, 2, 'ar', 'Abdul Jabbaar el-Kaleel', 'محلل بيانات في مايكروسوفت', '\"لقد استخدمنا Rocket LMS خلال العامين الماضيين. شكرًا على الخدمة الرائعة.\"'),
(7, 2, 'es', 'Ryan Newman', 'Analista de datos en Microsoft', '\"Hemos utilizado Rocket LMS durante los últimos 2 años. Gracias por el gran servicio\"'),
(8, 3, 'es', 'Megan Hayward', 'Administradora de sistemas en Amazon', '\"Nos encanta. Rocket LMS es perfecto y muy adaptable\".'),
(9, 3, 'ar', 'Khaleela el-Alam', 'مسؤول النظام في أمازون', '\"نحن نحبها. Rocket LMS مثالي وقابل للتكيف بشكل كبير.\"'),
(10, 4, 'es', 'Natasha Hope', 'Técnico de TI en IBM', '\"Estoy realmente satisfecho con mi Rocket LMS. Es la solución perfecta para nuestro negocio\"'),
(11, 4, 'ar', 'Sakeena el-Shad', 'فني تكنولوجيا المعلومات في شركة آی بی ام', '\"أنا راضٍ حقًا عن Rocket LMS. إنه الحل الأمثل لأعمالنا.\"'),
(12, 5, 'es', 'Charles Dale', 'Ingeniera informatica en oracle', '\"Estoy muy satisfecho con este producto. No podría haber pedido más que esto\"'),
(13, 5, 'ar', 'Rifat el-Younis', 'مهندس كمبيوتر', '\"أنا مسرور جدًا بهذا المنتج. لم أستطع طلب أكثر من هذا.\"'),
(14, 6, 'es', 'David Patterson', 'Técnico de redes en Cisco', '\"Rocket LMS me impresionó en varios niveles\"'),
(15, 6, 'ar', 'Ahmed al-Mansouri', 'فني شبكات في سيسكو', '\"لقد أبهرني صاروخ Rocket LMS على مستويات متعددة.\"'),
(16, 7, 'en', 'Michael Alvarez', 'Industrial Engineer', 'Learning new skills felt intimidating before, but the supportive community here made a big difference for me. The instructors are approachable and explain concepts in an easy-to-understand way. I appreciate the interactive quizzes, assignments, and real-world projects that push me to practice. The flexible deadlines make it stress-free to learn at my own pace. I’ve even found mentors through the platform who’ve guided me on career choices. It’s a fantastic place to grow professionally and personally.'),
(17, 8, 'en', 'Chloe Martin', 'Blogger & Content Creator', 'This course marketplace has completely changed my professional life. I wanted to switch careers and needed practical skills fast. The UI/UX design path was exactly what I needed. The step-by-step lessons, downloadable resources, and active discussion boards kept me engaged. Within months, I felt confident enough to take on freelance projects. The certificates I earned really added value to my profile. If you’re serious about gaining skills employers actually want, this is the best place to start.'),
(18, 9, 'en', 'Rohan Kumar', 'Marketing Executive', 'Enrolling in courses here has been an eye-opening experience. I love that I can access thousands of high-quality lessons from experts around the world. The variety of topics is impressive — from programming to marketing, it’s all here. I also appreciate the lifetime access, so I can revisit content anytime I need a refresher. It’s a great investment for anyone wanting to grow their career, explore new fields, or simply keep their knowledge updated and relevant.'),
(19, 10, 'en', 'Jessica Patel', 'Travel Influencer', 'I discovered this platform when I needed help advancing my tech skills. What surprised me most was how interactive and engaging the lessons are. The quizzes and hands-on projects really help solidify what you learn. I also appreciate the clear structure and easy navigation. It feels like having a personal coach guiding me step by step. I’ve already landed a better job because of what I learned here. I’ll definitely keep coming back for more courses in the future.'),
(20, 11, 'en', 'Ahmed Al-Maktoum', 'Product Photographer', 'This online learning marketplace has everything I need to keep growing my knowledge. The instructors are industry experts who share valuable insights and practical tips. I especially love the certificates, which I’ve added to my LinkedIn profile and resume. They really stand out to employers. The course bundles make it affordable to learn multiple topics at once. I feel more confident tackling new challenges at work thanks to these lessons. If you’re thinking of enrolling, do it today!');

-- --------------------------------------------------------

--
-- Structure de la table `text_lessons`
--

CREATE TABLE `text_lessons` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `chapter_id` int(10) UNSIGNED DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `study_time` int(10) UNSIGNED DEFAULT NULL,
  `accessibility` enum('free','paid') NOT NULL DEFAULT 'free',
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int(10) UNSIGNED DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` int(10) UNSIGNED NOT NULL,
  `updated_at` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `text_lessons_attachments`
--

CREATE TABLE `text_lessons_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `text_lesson_id` int(10) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `text_lesson_translations`
--

CREATE TABLE `text_lesson_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `text_lesson_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `themes`
--

CREATE TABLE `themes` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `preview_image` varchar(255) DEFAULT NULL,
  `default_color_mode` enum('light','dark') NOT NULL DEFAULT 'light',
  `color_id` int(10) UNSIGNED DEFAULT NULL,
  `font_id` int(10) UNSIGNED DEFAULT NULL,
  `header_id` int(10) UNSIGNED DEFAULT NULL,
  `footer_id` int(10) UNSIGNED DEFAULT NULL,
  `home_landing_id` int(10) UNSIGNED DEFAULT NULL,
  `contents` longtext DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `enable` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `themes`
--

INSERT INTO `themes` (`id`, `title`, `preview_image`, `default_color_mode`, `color_id`, `font_id`, `header_id`, `footer_id`, `home_landing_id`, `contents`, `is_default`, `enable`, `created_at`) VALUES
(1, 'Lite (Included)', '/store/1/default_images/themes/lite-preview.jpg', 'light', 1, 11, 1, 2, 1, '{\"card_styles\":{\"course\":\"grid_card_1\",\"product\":\"grid_card_1\",\"bundle\":\"grid_card_1\",\"upcoming_course\":\"grid_card_1\",\"blog_post\":\"grid_card_1\",\"instructor\":\"grid_card_1\",\"organization\":\"grid_card_1\"},\"images\":{\"admin_login\":\"\\/store\\/1\\/themes\\/general\\/admin_login.jpg\",\"admin_dashboard\":\"\\/store\\/1\\/themes\\/general\\/admin_dashboard.png\",\"search\":\"\\/store\\/1\\/themes\\/general\\/search_background.jpg\",\"tags\":\"\\/store\\/1\\/themes\\/general\\/tags_background.jpg\",\"categories\":\"\\/store\\/1\\/themes\\/general\\/categories_background.jpg\",\"become_instructor\":\"\\/store\\/1\\/themes\\/general\\/become_instructor_background.jpg\",\"certificate_validation\":\"\\/store\\/1\\/themes\\/general\\/certificate_validation.jpg\",\"certificate_validation_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/certificate_validation_overlay.png\",\"instructors_lists\":\"\\/store\\/1\\/themes\\/general\\/instructors_background.jpg\",\"instructors_header_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/instructors_overlay.png\",\"organizations_lists\":\"\\/store\\/1\\/themes\\/general\\/organizations_background.jpg\",\"organizations_header_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/organizations_overlay.png\",\"user_cover\":\"\\/store\\/1\\/themes\\/general\\/user_profile_background.jpg\",\"products_lists\":\"\\/store\\/1\\/themes\\/general\\/products_list_background.jpg\",\"products_lists_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/products_overlay.png\",\"upcoming_courses_lists\":\"\\/store\\/1\\/themes\\/general\\/upcoming_courses_background.jpg\",\"upcoming_courses_lists_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/upcoming_courses_overlay.png\",\"categories_courses_lists_featured_courses_background\":\"\\/store\\/1\\/themes\\/general\\/featured_courses_background.svg\",\"categories_courses_lists_featured_courses_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/featured_courses_overlay.png\",\"bundles_lists\":\"\\/store\\/1\\/themes\\/general\\/bundles_background.jpg\",\"bundles_lists_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/bundles_overlay.png\",\"blog_lists\":\"\\/store\\/1\\/themes\\/general\\/blog_background.jpg\",\"blog_lists_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/blog_overlay.png\",\"form_default_cover\":\"\\/store\\/1\\/themes\\/general\\/form_background.jpg\",\"form_default_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/form_overlay.png\",\"form_default_header_icon\":\"\\/store\\/1\\/themes\\/general\\/form_default_icon.svg\",\"meeting_booking_step_1_image\":\"\\/store\\/1\\/themes\\/general\\/meeting_booking_step1_overlay.png\",\"meeting_booking_step_2_image\":\"\\/store\\/1\\/themes\\/general\\/meeting_booking_step2_overlay.png\",\"classes_lists\":\"\\/store\\/1\\/themes\\/general\\/classes_background.jpg\",\"classes_lists_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/courses_overlay.png\",\"reward_courses\":\"\\/store\\/1\\/themes\\/general\\/reward_courses_background.jpg\",\"reward_courses_overlay_image\":\"\\/store\\/1\\/themes\\/general\\/rewards_overlay.png\"},\"authentication_pages\":{\"style\":\"theme_1\",\"slider_background_image\":\"\\/store\\/1\\/themes\\/general\\/authentication_background.svg\",\"slider_contents\":{\"uHuuS\":{\"title\":\"Instant Certificate Access\",\"subtitle\":\"Download certificates right after completion\",\"image\":\"\\/store\\/1\\/themes\\/general\\/authentication_slide1.png\"},\"axuTg\":{\"title\":\"Affordable Quality Education\",\"subtitle\":\"High-value courses at accessible prices\",\"image\":\"\\/store\\/1\\/themes\\/general\\/authentication_slide2.png\"},\"RuDfz\":{\"title\":\"Advance Your Career\",\"subtitle\":\"Build your resume with proven expertise\",\"image\":\"\\/store\\/1\\/themes\\/general\\/authentication_slide3.png\"}}},\"custom_css\":null,\"custom_js\":null}', 1, 1, 1763296901);

-- --------------------------------------------------------

--
-- Structure de la table `theme_colors_fonts`
--

CREATE TABLE `theme_colors_fonts` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('color','font') NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `theme_colors_fonts`
--

INSERT INTO `theme_colors_fonts` (`id`, `type`, `title`, `content`, `created_at`) VALUES
(1, 'color', 'Blue (Default)', '{\"light\":{\"primary\":\"#b9a685\",\"primary_saturated\":\"#b9a685\",\"secondary\":\"#3d455d\",\"accent\":\"#fe6257\",\"success\":\"#3fcd82\",\"info\":\"#3d455d\",\"warning\":\"#ffa200\",\"danger\":\"#f63c3c\",\"dark\":\"#121f3e\",\"black\":\"#000000\",\"white\":\"#ffffff\",\"gray_100\":\"#fafcff\",\"gray_200\":\"#f0f4f9\",\"gray_300\":\"#e9edf3\",\"gray_400\":\"#cdd5e2\",\"gray_500\":\"#97a7bf\",\"gray\":\"#f5f8f9\",\"section_bg\":\"#eaf0f3\"},\"dark\":{\"primary\":\"#b9a685\",\"primary_saturated\":\"#b9a685\",\"secondary\":\"#3d455d\",\"accent\":\"#ff8077\",\"success\":\"#5ade98\",\"info\":\"#3d455d\",\"warning\":\"#ffb32d\",\"danger\":\"#fe6363\",\"dark\":\"#aab8c5\",\"black\":\"#e1eaf6\",\"white\":\"#1e1f26\",\"gray_100\":\"#272832\",\"gray_200\":\"#30313e\",\"gray_300\":\"#3e404e\",\"gray_400\":\"#5d5f72\",\"gray_500\":\"#8391a2\",\"gray\":\"#17181e\",\"section_bg\":\"#2d323a\"}}', 1748879802),
(2, 'font', 'Default', '{\"main\":{\"regular\":\"\\/store\\/1\\/fonts\\/Tajawal-Regular.woff2\",\"bold\":\"\\/store\\/1\\/fonts\\/Tajawal-Bold.woff2\",\"medium\":\"\\/store\\/1\\/fonts\\/Tajawal-Medium.woff2\"},\"rtl\":{\"regular\":\"\\/store\\/1\\/fonts\\/alfont_com_IBMPlexSansArabic-Regular.ttf\",\"bold\":\"\\/store\\/1\\/fonts\\/IBMPlexSansArabic-Bold.ttf\",\"medium\":\"\\/store\\/1\\/fonts\\/IBMPlexArabic-Medium.ttf\"}}', 1748880740),
(11, 'font', 'Ibm Sans', '{\"main\":{\"regular\":\"\\/store\\/1\\/fonts\\/alfont_com_IBMPlexSansArabic-Regular.ttf\",\"bold\":\"\\/store\\/1\\/fonts\\/IBMPlexSansArabic-Bold.ttf\",\"medium\":\"\\/store\\/1\\/fonts\\/IBMPlexArabic-Medium.ttf\"},\"rtl\":{\"regular\":\"\\/store\\/1\\/fonts\\/alfont_com_IBMPlexSansArabic-Regular.ttf\",\"bold\":\"\\/store\\/1\\/fonts\\/IBMPlexSansArabic-Bold.ttf\",\"medium\":\"\\/store\\/1\\/fonts\\/IBMPlexArabic-Medium.ttf\"}}', 1763287459);

-- --------------------------------------------------------

--
-- Structure de la table `theme_headers_footers`
--

CREATE TABLE `theme_headers_footers` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('header','footer') NOT NULL,
  `component_name` varchar(255) NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `theme_headers_footers`
--

INSERT INTO `theme_headers_footers` (`id`, `type`, `component_name`, `created_at`) VALUES
(1, 'header', 'header_1', 1748875817),
(2, 'footer', 'footer_1', 1748875817),
(4, 'header', 'header_2', 1768159778);

-- --------------------------------------------------------

--
-- Structure de la table `theme_header_footer_translations`
--

CREATE TABLE `theme_header_footer_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `theme_header_footer_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `theme_header_footer_translations`
--

INSERT INTO `theme_header_footer_translations` (`id`, `theme_header_footer_id`, `locale`, `title`, `content`) VALUES
(1, 1, 'en', 'Header 1 (Default)', '{\"top_navbar\":{\"phone\":\"+1 (323) 555-9876\",\"email\":\"mail@rocket-soft.org\",\"link_1\":{\"title\":\"Login\",\"url\":\"\\/login\"},\"link_2\":{\"title\":\"Register\",\"url\":\"\\/register\"},\"show_color_mode\":\"on\"},\"specific_links\":{\"RUYtv\":{\"title\":\"Home\",\"url\":\"\\/\"},\"tZblv\":{\"title\":\"About\",\"url\":\"\\/pages\\/about\"},\"rOvAj\":{\"title\":\"Courses\",\"url\":\"\\/classes\"},\"qeAzK\":{\"title\":\"Coaches\",\"url\":\"\\/instructor-finder\"},\"GZDCs\":{\"title\":\"Blogs\",\"url\":\"\\/blog\"},\"CIjxJ\":{\"title\":\"Contact\",\"url\":\"\\/contact\"},\"record\":{\"title\":null,\"url\":null}},\"specific_buttons\":{\"BFKTm\":{\"user_role\":\"for_guest\",\"title\":\"Start Learning\",\"url\":\"\\/login\",\"icon\":\"bul-teacher\"},\"UsxeP\":{\"user_role\":\"1\",\"title\":\"Become Instructor\",\"url\":\"\\/become-instructor\",\"icon\":\"bul-teacher\"},\"MYTBW\":{\"user_role\":\"2\",\"title\":\"Admin Panel\",\"url\":\"\\/admin\",\"icon\":\"bul-setting-2\"},\"yVQQV\":{\"user_role\":\"3\",\"title\":\"Create a Course\",\"url\":\"\\/panel\\/webinars\\/new\",\"icon\":\"bul-video-add\"},\"fQclX\":{\"user_role\":\"4\",\"title\":\"Create a Course\",\"url\":\"\\/panel\\/webinars\\/new\",\"icon\":\"bul-video-add\"},\"record\":{\"user_role\":null,\"title\":null,\"url\":null,\"icon\":null}}}'),
(2, 2, 'en', 'Footer 1 (Default)', '{\"newsletter\":{\"enable\":\"on\",\"title\":\"Subscribe to Our Newsletter\",\"subtitle\":\"Receive expert insights, course updates, and learning resources directly in your inbox and get notified\",\"button_text\":\"Join\",\"emoji\":\"\\/store\\/themes\\/footers\\/2\\/happy_emoji_zoa.svg\"},\"cta\":{\"pre_title\":\"Let\\u2019s get started now!\",\"title\":\"Take the First Step Towards Mastery!\",\"button\":{\"label\":\"Enroll on Courses\",\"icon\":\"bul-teacher\",\"url\":\"\\/classes\"},\"emoji\":\"\\/store\\/themes\\/footers\\/2\\/power_emoji_42t.svg\"},\"contact\":{\"section_title\":\"Contact US\",\"address\":\"1234 Sunset Blvd, Suite 567 Los Angeles, CA 90026 United States\",\"phone\":\"+1 (323) 555-9876\",\"email\":\"mail@lms.rocket-soft.org\",\"mobile\":\"+1 (213) 555-4321\"},\"links_1_section_title\":\"Additional Links\",\"links_2_section_title\":\"Popular Categories\",\"copyright_text\":\"\\u00a9 2025 Rocket Soft. All Rights Reserved. Empowering Learning Worldwide.\",\"specific_links\":{\"LITim\":{\"title\":\"Login\",\"url\":\"\\/login\"},\"qJFNp\":{\"title\":\"Register\",\"url\":\"\\/register\"},\"izISj\":{\"title\":\"Contact\",\"url\":\"\\/contact\"},\"cdkPb\":{\"title\":\"Certificate Validation\",\"url\":\"\\/certificate_validation\"},\"OKAqQ\":{\"title\":\"Become Instructor\",\"url\":\"\\/become-instructor\"},\"DebJE\":{\"title\":\"About\",\"url\":\"\\/pages\\/about\"},\"aMQau\":{\"title\":\"Terms and Policies\",\"url\":\"\\/pages\\/terms\"},\"record\":{\"title\":null,\"url\":null}},\"specific_links_2\":{\"dzQOe\":{\"title\":\"Development\",\"url\":\"\\/categories\\/Development\"},\"pgxMd\":{\"title\":\"Business\",\"url\":\"\\/categories\\/Business\"},\"ZveCn\":{\"title\":\"Marketing\",\"url\":\"\\/categories\\/Marketing\"},\"QXKsq\":{\"title\":\"Lifestyle\",\"url\":\"\\/categories\\/Lifestyles\"},\"FCJal\":{\"title\":\"Health\",\"url\":\"\\/categories\\/Health-and-Fitness\"},\"SVtaA\":{\"title\":\"Academics\",\"url\":\"\\/categories\\/Academics\"},\"PivsB\":{\"title\":\"Design\",\"url\":\"\\/categories\\/Design\"},\"record\":{\"title\":null,\"url\":null}},\"social_media\":[\"Instagram\",\"Whatsapp\",\"Twitter\",\"Facebook\"],\"background\":\"\\/store\\/themes\\/footers\\/2\\/footer_background_7gn.png\",\"dark_mode_background\":\"\\/store\\/themes\\/footers\\/2\\/footer_background_7gn.png\",\"background_color\":\"secondary\"}'),
(4, 2, 'ar', 'اتخذ الخطوة الأولى نحو الإتقان!', '{\"background_color\":\"secondary\",\"newsletter\":{\"enable\":\"on\",\"title\":\"\\u0627\\u0634\\u062a\\u0631\\u0643 \\u0641\\u064a \\u0646\\u0634\\u0631\\u062a\\u0646\\u0627 \\u0627\\u0644\\u0625\\u062e\\u0628\\u0627\\u0631\\u064a\\u0629\",\"subtitle\":\"\\u0627\\u062d\\u0635\\u0644 \\u0639\\u0644\\u0649 \\u0631\\u0624\\u0649 \\u0627\\u0644\\u062e\\u0628\\u0631\\u0627\\u0621\\u060c \\u0648\\u062a\\u062d\\u062f\\u064a\\u062b\\u0627\\u062a \\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a \\u0627\\u0644\\u062a\\u062f\\u0631\\u064a\\u0628\\u064a\\u0629\\u060c \\u0648\\u0645\\u0648\\u0627\\u0631\\u062f \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0645\\u0628\\u0627\\u0634\\u0631\\u0629\\u064b \\u0641\\u064a \\u0628\\u0631\\u064a\\u062f\\u0643 \\u0627\\u0644\\u0625\\u0644\\u0643\\u062a\\u0631\\u0648\\u0646\\u064a\\u060c \\u0648\\u062a\\u0644\\u0642\\u064e\\u0651 \\u0627\\u0644\\u0625\\u0634\\u0639\\u0627\\u0631\\u0627\\u062a.\",\"button_text\":\"\\u0623\\u062f\\u062e\\u0644 \\u0639\\u0646\\u0648\\u0627\\u0646 \\u0628\\u0631\\u064a\\u062f\\u0643 \\u0627\\u0644\\u0625\\u0644\\u0643\\u062a\\u0631\\u0648\\u0646\\u064a \\u0647\\u0646\\u0627\"},\"cta\":{\"pre_title\":\"\\u0647\\u064a\\u0627 \\u0646\\u0628\\u062f\\u0623 \\u0627\\u0644\\u0622\\u0646!\",\"title\":\"\\u0625\\u0628\\u062f \\u0631\\u062d\\u0644\\u0629 \\u0627\\u0644\\u062a\\u0639\\u0644\\u0645 \\u0648 \\u0627\\u0644\\u0645\\u0639\\u0631\\u0641\\u0629 \\u0641\\u064a \\u0645\\u0646\\u0635\\u0629 \\u0645\\u0647\\u0646\\u064a\\u0629\",\"button\":{\"label\":\"\\u0642\\u0645 \\u0628\\u0627\\u0644\\u062a\\u0633\\u062c\\u064a\\u0644 \\u0644\\u0623\\u0646\",\"icon\":\"bul-login\",\"url\":\"https:\\/\\/siematplus.com\\/register\"}},\"contact\":{\"section_title\":\"\\u0634\\u0631\\u0643\\u0629 \\u0633\\u0645\\u0627\\u062a \\u0644\\u0644\\u062a\\u0637\\u0648\\u064a\\u0631 \\u0648 \\u0627\\u0644\\u0627\\u0633\\u062a\\u0634\\u0627\\u0631\\u0627\\u062a\",\"address\":\"\\u0627\\u0644\\u0645\\u0645\\u0644\\u0643\\u0629 \\u0627\\u0644\\u0639\\u0631\\u0628\\u064a\\u0629 \\u0627\\u0644\\u0633\\u0639\\u0648\\u062f\\u064a\\u0629 - \\u0627\\u0644\\u0645\\u0646\\u0637\\u0642\\u0629 \\u0627\\u0644\\u0634\\u0631\\u0642\\u064a\\u0629 \\u0627\\u0644\\u062f\\u0645\\u0627\\u0645\",\"phone\":null,\"email\":\"info@siematplus.com\",\"mobile\":null},\"links_1_section_title\":\"\\u0627\\u0644\\u0627\\u0642\\u0633\\u0627\\u0645\",\"links_2_section_title\":\"\\u0627\\u0644\\u0635\\u0641\\u062d\\u0627\\u062a\",\"copyright_text\":\"\\u0643\\u0644 \\u0627\\u0644\\u062d\\u0642\\u0648\\u0642 \\u0645\\u062d\\u0641\\u0648\\u0637\\u0629 \\u0644\\u062f\\u064a @ SIEMATPLUS\",\"specific_links\":{\"tKbQX\":{\"title\":\"\\u062a\\u0633\\u0648\\u064a\\u0642\",\"url\":\"categories\\/Marketing\"},\"BAAVd\":{\"title\":\"\\u0627\\u0633\\u062a\\u0631\\u0627\\u062a\\u064a\\u062c\\u064a\\u0629 \\u0627\\u0644\\u0639\\u0645\\u0644\",\"url\":\"categories\\/Business\\/Business-Strategy\"},\"SCbKF\":{\"title\":\"\\u0627\\u0644\\u0635\\u062d\\u0629 \\u0648\\u0627\\u0644\\u0644\\u064a\\u0627\\u0642\\u0629 \\u0627\\u0644\\u0628\\u062f\\u0646\\u064a\\u0629\",\"url\":\"categories\\/Health-and-Fitness\"},\"BKDRJ\":{\"title\":\"\\u062a\\u0637\\u0648\\u064a\\u0631 \\u0627\\u0644\\u0634\\u0628\\u0643\\u0629\",\"url\":\"categories\\/Development\\/Web-Development\"},\"record\":{\"title\":null,\"url\":null}},\"specific_links_2\":{\"LQpRW\":{\"title\":\"\\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062f\\u062e\\u0648\\u0644\",\"url\":\"\\/login\"},\"PJGrL\":{\"title\":\"\\u062a\\u0633\\u062c\\u064a\\u0644\",\"url\":\"\\/register\"},\"CcKuT\":{\"title\":\"\\u0645\\u0646 \\u0646\\u062d\\u0646\",\"url\":\"\\/pages\\/about\"},\"fwKNZ\":{\"title\":\"\\u0627\\u0644\\u0645\\u0642\\u0627\\u0644\\u0627\\u062a\",\"url\":\"\\/blog\"},\"record\":{\"title\":null,\"url\":null}},\"social_media\":[\"linkedin\",\"tiktok\",\"Facebook\",\"X\",\"youtube\"]}'),
(5, 1, 'ar', 'Header', '{\"top_navbar\":{\"show_color_mode\":\"on\",\"phone\":null,\"email\":\"info@siematplus.com\",\"link_1\":{\"title\":\"\\u062a\\u0633\\u062c\\u064a\\u0644 \\u0627\\u0644\\u062f\\u062e\\u0648\\u0644\",\"url\":\"https:\\/\\/siematplus.com\\/login\"},\"link_2\":{\"title\":\"\\u062a\\u0633\\u062c\\u064a\\u0644\",\"url\":\"https:\\/\\/siematplus.com\\/register\"}},\"specific_links\":{\"HeMAC\":{\"title\":\"\\u0627\\u0644\\u0631\\u0626\\u064a\\u0633\\u064a\\u0629\",\"url\":\"\\/\"},\"Ttxun\":{\"title\":\"\\u0645\\u0646 \\u0646\\u062d\\u0646\",\"url\":\"\\/pages\\/about\"},\"KIcuA\":{\"title\":\"\\u0627\\u0644\\u062f\\u0648\\u0631\\u0627\\u062a\",\"url\":\"\\/classes\"},\"AYQGu\":{\"title\":\"\\u0627\\u0644\\u0645\\u062f\\u0631\\u0628\\u064a\\u0646\",\"url\":\"\\/instructor-finder\"},\"joTUq\":{\"title\":\"\\u0627\\u0644\\u0645\\u0642\\u0627\\u0644\\u0627\\u062a\",\"url\":\"\\/blog\"},\"FKURe\":{\"title\":\"\\u062a\\u0648\\u0627\\u0635\\u0644 \\u0645\\u0639\\u0646\\u0627\",\"url\":\"\\/contact\"},\"record\":{\"title\":null,\"url\":null}},\"specific_buttons\":{\"record\":{\"user_role\":null,\"title\":null,\"url\":null,\"icon\":null}}}'),
(6, 4, 'ar', 'header 2', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `start_date` int(10) UNSIGNED DEFAULT NULL,
  `end_date` int(10) UNSIGNED DEFAULT NULL,
  `discount` int(11) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `tickets`
--

INSERT INTO `tickets` (`id`, `creator_id`, `webinar_id`, `bundle_id`, `start_date`, `end_date`, `discount`, `capacity`, `order`, `created_at`, `updated_at`, `deleted_at`) VALUES
(41, 1129, 2064, NULL, 1772485200, 1773262800, 1, NULL, NULL, 1772490872, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `ticket_translations`
--

CREATE TABLE `ticket_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ticket_translations`
--

INSERT INTO `ticket_translations` (`id`, `ticket_id`, `locale`, `title`) VALUES
(28, 41, 'ar', 'باقة متكاملة للتربوي العام');

-- --------------------------------------------------------

--
-- Structure de la table `ticket_users`
--

CREATE TABLE `ticket_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `time_spent_on_courses`
--

CREATE TABLE `time_spent_on_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `page` enum('learning_page','show') NOT NULL DEFAULT 'learning_page',
  `entry_time` bigint(20) UNSIGNED DEFAULT NULL,
  `exit_time` bigint(20) UNSIGNED DEFAULT NULL,
  `seconds_spent` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `time_spent_on_courses`
--

INSERT INTO `time_spent_on_courses` (`id`, `user_id`, `course_id`, `page`, `entry_time`, `exit_time`, `seconds_spent`) VALUES
(60, 1129, 2064, 'learning_page', 1772491907, 1772495141, 3234),
(61, 1130, 2064, 'learning_page', 1772557303, 1772557375, 72),
(62, 1129, 2064, 'learning_page', 1772558024, 1772558095, 71),
(63, 1129, 2064, 'learning_page', 1772558112, 1772558564, 452),
(64, 1129, 2064, 'learning_page', 1772558559, 1772558584, 25),
(65, 1129, 2064, 'learning_page', 1772939694, 1772939865, 171),
(66, 1129, 2064, 'learning_page', 1772939864, 1772940116, 252),
(67, 1129, 2065, 'learning_page', 1772940574, 1772940584, 10),
(68, 1129, 2065, 'learning_page', 1772940608, 1772940618, 10),
(69, 1137, 2069, 'learning_page', 1774859424, 1774859456, 32),
(70, 1137, 2069, 'learning_page', 1774859452, 1774859466, 14),
(71, 1137, 2069, 'learning_page', 1774859476, 1774859486, 10),
(72, 1139, 2069, 'learning_page', 1774859846, 1774859957, 111),
(73, 1139, 2069, 'learning_page', 1774860105, 1774860156, 51),
(74, 1139, 2069, 'learning_page', 1775021391, 1775022298, 907),
(75, 1129, 2065, 'learning_page', 1775022330, 1775022340, 10),
(76, 1129, 2064, 'learning_page', 1775022363, 1775022889, 526),
(77, 1, 2071, 'learning_page', 1776097424, 1776097536, 112),
(78, 1, 2071, 'learning_page', 1776097532, 1776097595, 63),
(79, 1, 2071, 'learning_page', 1776097588, 1776097660, 72),
(80, 1, 2072, 'learning_page', 1777144905, 1777145106, 201),
(81, 1137, 2072, 'learning_page', 1777145107, 1777145167, 60),
(82, 1137, 2072, 'learning_page', 1777145250, 1777145302, 52),
(83, 1137, 2072, 'learning_page', 1777145294, 1777145312, 18),
(84, 1137, 2072, 'learning_page', 1777145308, 1777150722, 5414),
(85, 1137, 2072, 'learning_page', 1777151007, 1777151163, 156),
(86, 1137, 2072, 'learning_page', 1777151187, 1777151403, 216),
(87, 1137, 2072, 'learning_page', 1777174407, 1777180980, 6573),
(88, 1137, 2072, 'learning_page', 1777825961, 1777826232, 271),
(89, 1137, 2072, 'learning_page', 1777826250, 1777826332, 82),
(90, 1137, 2072, 'learning_page', 1777826393, 1777826592, 199);

-- --------------------------------------------------------

--
-- Structure de la table `trend_categories`
--

CREATE TABLE `trend_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) NOT NULL,
  `color` varchar(32) NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `upcoming_courses`
--

CREATE TABLE `upcoming_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `teacher_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'when assigned a course',
  `type` enum('webinar','course','text_lesson') NOT NULL,
  `slug` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `image_cover` varchar(255) DEFAULT NULL,
  `video_demo` varchar(255) DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link','google_drive','iframe','s3','secure_host') DEFAULT NULL,
  `publish_date` bigint(20) UNSIGNED DEFAULT NULL,
  `timezone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `points` int(10) UNSIGNED DEFAULT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `price` double(15,2) DEFAULT NULL,
  `duration` int(10) UNSIGNED DEFAULT NULL,
  `sections` int(10) UNSIGNED DEFAULT NULL,
  `parts` int(10) UNSIGNED DEFAULT NULL,
  `course_progress` int(10) UNSIGNED DEFAULT NULL,
  `support` tinyint(1) NOT NULL DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `include_quizzes` tinyint(1) NOT NULL DEFAULT 0,
  `downloadable` tinyint(1) NOT NULL DEFAULT 0,
  `forum` tinyint(1) NOT NULL DEFAULT 0,
  `assignments` tinyint(1) NOT NULL DEFAULT 0,
  `message_for_reviewer` text DEFAULT NULL,
  `status` enum('active','pending','is_draft','inactive') NOT NULL DEFAULT 'is_draft',
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `upcoming_course_filter_option`
--

CREATE TABLE `upcoming_course_filter_option` (
  `id` int(10) UNSIGNED NOT NULL,
  `upcoming_course_id` int(10) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `upcoming_course_followers`
--

CREATE TABLE `upcoming_course_followers` (
  `id` int(10) UNSIGNED NOT NULL,
  `upcoming_course_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `upcoming_course_reports`
--

CREATE TABLE `upcoming_course_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `upcoming_course_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `upcoming_course_translations`
--

CREATE TABLE `upcoming_course_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `upcoming_course_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `seo_description` text DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `full_name` varchar(128) DEFAULT NULL,
  `role_name` varchar(64) NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `organ_id` int(11) DEFAULT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `bio` varchar(128) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `facebook_id` varchar(255) DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `logged_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `financial_approval` tinyint(1) NOT NULL DEFAULT 0,
  `installment_approval` tinyint(1) DEFAULT 0,
  `enable_installments` tinyint(1) DEFAULT 1,
  `disable_cashback` tinyint(1) DEFAULT 0,
  `enable_registration_bonus` tinyint(1) NOT NULL DEFAULT 0,
  `registration_bonus_amount` double(15,2) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `avatar_settings` varchar(255) DEFAULT NULL,
  `cover_img` varchar(255) DEFAULT NULL,
  `profile_video` varchar(255) DEFAULT NULL,
  `profile_secondary_image` varchar(255) DEFAULT NULL,
  `headline` varchar(255) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  `province_id` int(10) UNSIGNED DEFAULT NULL,
  `city_id` int(10) UNSIGNED DEFAULT NULL,
  `district_id` int(10) UNSIGNED DEFAULT NULL,
  `location` point DEFAULT NULL,
  `level_of_training` bit(3) DEFAULT NULL,
  `meeting_type` enum('all','in_person','online') NOT NULL DEFAULT 'all',
  `status` enum('active','pending','inactive') NOT NULL DEFAULT 'active',
  `access_content` tinyint(1) NOT NULL DEFAULT 1,
  `enable_ai_content` tinyint(1) NOT NULL DEFAULT 0,
  `language` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `theme_color_mode` enum('dark','light') DEFAULT NULL,
  `newsletter` tinyint(1) NOT NULL DEFAULT 0,
  `public_message` tinyint(1) NOT NULL DEFAULT 0,
  `enable_profile_statistics` tinyint(1) NOT NULL DEFAULT 0,
  `identity_scan` varchar(128) DEFAULT NULL,
  `certificate` varchar(128) DEFAULT NULL,
  `affiliate` tinyint(1) NOT NULL DEFAULT 1,
  `can_create_store` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Despite disabling the store feature in the settings, we can enable this feature for that user through the edit page of a user and turning on the store toggle.',
  `ban` tinyint(1) NOT NULL DEFAULT 0,
  `ban_start_at` int(10) UNSIGNED DEFAULT NULL,
  `ban_end_at` int(10) UNSIGNED DEFAULT NULL,
  `offline` tinyint(1) NOT NULL DEFAULT 0,
  `offline_message` text DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `role_name`, `role_id`, `organ_id`, `mobile`, `email`, `bio`, `password`, `google_id`, `facebook_id`, `remember_token`, `logged_count`, `verified`, `financial_approval`, `installment_approval`, `enable_installments`, `disable_cashback`, `enable_registration_bonus`, `registration_bonus_amount`, `avatar`, `avatar_settings`, `cover_img`, `profile_video`, `profile_secondary_image`, `headline`, `about`, `address`, `country_id`, `province_id`, `city_id`, `district_id`, `location`, `level_of_training`, `meeting_type`, `status`, `access_content`, `enable_ai_content`, `language`, `currency`, `timezone`, `theme_color_mode`, `newsletter`, `public_message`, `enable_profile_statistics`, `identity_scan`, `certificate`, `affiliate`, `can_create_store`, `ban`, `ban_start_at`, `ban_end_at`, `offline`, `offline_message`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', 'Admin', 'admin', 2, NULL, '00000000', 'admin@demo.com', 'Senior software developer', '$2y$10$We7v6xiSH8y9NsabdEPYneLmEt/Qe768uWXTd4kqxMfxcqTwFfgiy', NULL, NULL, 'DY1JSFa442dJtedVPxiYzzjnpJb90x7JcVYyMJ5dRdkP8wkGopJqhky14hHf', 0, 1, 0, 0, 1, 0, 0, NULL, '/store/1/default_images/admin-avatar.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, 'EN', 'USD', 'America/New_York', 'light', 0, 0, 0, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, 1597826952, 1597826952, NULL),
(1051, 'mohamed-elnashar-t1t04', 'MOhamed Elnashar', 'admin', 2, NULL, NULL, 'Mohamedelnashar349@gmail.com', NULL, '$2y$10$BGwTOn0kyO8vS/uem/hdcusvimc8L5x.aeLieH3N1bnqyZTm641J2', NULL, NULL, 'dfG8dd0KUU4Olae1CyxK26Pp1jo8WlY0pwOs8dsDWlqn1PB8ccJ7xvJDtVFq', 0, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"FFFFFF\",\"background\":\"880E4F\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, 'EN', 'USD', 'Asia/Riyadh', 'light', 0, 0, 0, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, 1763559060, NULL, NULL),
(1070, 'radwa-test-for-emails-gujju', 'Radwa test-for-emails', 'admin', 2, NULL, NULL, 'radwalhusiny@gmail.com', NULL, '$2y$10$A1o..0fsiCoQZj81PjzgeOEYaw1BkHr7UzO7hIPHqe4xKBDpLeEPS', NULL, NULL, 'lq1S0pvC1R61GLzZZk0NnqedIP2HIQxhY9EBZgH2Rhk8fJqXL4b17NHObKlz', 7, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffe082\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 0, 1, NULL, NULL, 'Africa/Cairo', NULL, 0, 0, 0, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, 1764147971, NULL, NULL),
(1073, 'aldaam-alfny-iywoy', 'الدعم الفني', 'admin', 2, NULL, NULL, 'charafbendj@gmail.com', NULL, '$2y$10$M0zJVifETpYuh98TIib/W.TwsrdHArmDiC7PZXFT.pNH2QZ69loFG', NULL, NULL, 'e8k0CzF0vIWL0hogNHzcWj2ueqQi7w5TTGK2jkLyfvrJBFJmKwGOjSc9dc3h', 2, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"FFFFFF\",\"background\":\"512da8\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1764287096, NULL, NULL),
(1074, 'person-q6ieo', 'person', 'admin', 2, NULL, NULL, 'maha2abaa@gmail.com', NULL, '$2y$10$GsyWsecQMfmXzzn1ZVfdVeqHn6uw/C9L0H4LNaPzbT6gU5H6LDeB.', NULL, NULL, 'lyekXH7wfe23yXaeUp7vwDLDsPGLhTvOf454opfURBjuEDOA9rfKpUqONC0S', 2, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"FFFFFF\",\"background\":\"ffb300\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, 1764410257, NULL, NULL),
(1109, 'ibrahim-almeshafi-rn6mr', 'Ibrahim almeshafi', 'admin', 2, NULL, NULL, 'Almeshafi@siematsa.com', NULL, '$2y$10$qDx7SP8eM.kcCnjEvDY17uSYDujl/WfQCvE4/mpnAug.To8z/0Qyi', NULL, NULL, 'mZ9g104IfFCc3PWBnGjwdvmrXJbPzM0FACMdSjTjQ7qC0cAFFFS21nzmC223', 5, 1, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"eeeeee\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Africa/Casablanca', 'light', 0, 0, 0, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, 1766488345, NULL, NULL),
(1113, 'albyt-alkbyr-68rmu', 'البيت الكبير', 'organization', 3, NULL, NULL, 'albasery@gmail.com', NULL, '$2y$10$u2Tga1VhIgV4BOMhPbAiGOu7.fMQAI/Ehf5Q7e81V9SkFpvjfWGjO', NULL, NULL, 'A9xynWlneCwjqPyvOGRpqhrQ7hBzw9MlGjSz1dbm3HBsdPy2rXDJFf67nMRL', 1, 1, 0, 0, 1, 0, 0, NULL, '/store/1113/setting/avatar.jpg', '{\"color\":\"000000\",\"background\":\"ffeb3b\"}', '/store/1113/setting/cover_img.png', NULL, NULL, NULL, NULL, NULL, 20, 33, 34, 43, 0x00000000010100000047a393f74fa83840fdffff8f195d4740, b'111', 'online', 'active', 1, 0, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1769898928, NULL, NULL),
(1128, 'mns-nho-alkm-altaalymy-umd2s', 'منصة نحو القمة التعليمية', 'teacher', 4, NULL, '966553412320', 'mhmd.1414m@gamil.com', NULL, '$2y$10$wWD1.20uHUYZOSTOU5l0zepyYW9WHVrDvxTDmiF02Ja5o/VxCv/X6', NULL, NULL, 'Yyh5uY2AMVJmfrr29v9asUiVv5dliK5Z3k4uFCBjqsdX3xcLrXtkVqEoNg2i', 0, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"FF5252\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'pending', 1, 0, NULL, NULL, 'Asia/Qatar', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1772400263, NULL, NULL),
(1129, 'mns-nho-alkm-altaalymy-xvcql', 'منصة نحو القمة التعليمية للخدمات الرقمية', 'teacher', 4, NULL, '966538483068', 'mhmd.1414m@gmail.com', NULL, '$2y$10$7GCHX1GQvcoP6/DHck8Kful6BVKw7b0AHZDDxXt9o8OsD.1athemu', NULL, NULL, 'ikv5THMtvoI28nShiOouCKZGJTfVJY8L6LBQ0TyiLMqv6LLjxEeRQAyfCQQd', 9, 0, 0, 0, 1, 0, 0, NULL, '/store/1129/setting/avatar.jpg', '{\"color\":\"000000\",\"background\":\"e8eaf6\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, 'AR', NULL, 'Asia/Riyadh', 'light', 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1772400997, NULL, NULL),
(1134, 'imad-eddine-boushaba-fs3iz', 'imad eddine boushaba', 'user', 1, NULL, '966611642989', 'morocconaturel@gmail.com', NULL, '$2y$10$9ZaXdd9OE4mhRf7c21gvz.a0AV2p1F30d.1msgy5t.FdL9mjiYef.', NULL, NULL, NULL, 0, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"82b1ff\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1772591162, NULL, NULL),
(1135, 'starligt-princes-38irl', 'Starligt Princes', 'user', 1, NULL, '9663335353333', 'sprinces407+951@gmail.com', NULL, '$2y$10$SauHUwOJFO6f1NlFaVoH8.1Moc2fvxyqIvQLUVQgLUIdIShSvqyDa', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffc400\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1772789684, NULL, NULL),
(1136, 'ibrahim-asiry-ibla8', 'Ibrahim Asiry', 'teacher', 4, NULL, '966505755122', 'almeshafi@gmail.com', NULL, '$2y$10$VT9inkRnDRYg.0Y92.hdX.GA.fI9bs9UhN0I8C3yioCh/xb0yfrQi', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"FCE4EC\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1772967865, NULL, NULL),
(1137, 'siemat-learning-7bidl', 'Siemat Learning', 'teacher', 4, NULL, '966562730122', 'info@siematsa.com', NULL, '$2y$10$hiM9Qs9gwoRWPZAHnp9p0e9GfJTn.Hd0FHY/vjo1QpMXAD7GNGMtK', NULL, NULL, 'IcJeDGfc8xt3jmQBqP3lxXJruKPkXjJEYJfrTyFrqsgkcrq8BcLtoKC2iR5x', 2, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ffecb3\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, 'EN', NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1774782644, NULL, NULL),
(1138, 'dema-asiri-plf7b', 'Dema Asiri', 'teacher', 4, NULL, '966552755122', 'dema@siematsa.com', NULL, '$2y$10$CS4CUkh3scnENq0EMZj0EOoAmEfu3k8Yh9cbNn6ddaHq/ZCh2.NJi', NULL, NULL, 'SSoUoToyyowyFmBbRRYTibQdMwDSObu4Q1MngqlJ8SMLs2OBmPPT99csnSIn', 2, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"D50000\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1774808404, NULL, NULL),
(1139, 'rema-asiri-4zftx', 'rema asiri', 'user', 1, NULL, '966552055122', 'rema072233@gmail.com', NULL, '$2y$10$CjvTkpngxRz4jQHLAqpQBuoel8ZxU7y96oThEI2L8FYeF2rlPWZn2', NULL, NULL, 'FkA6dEmcWV7md6BaTQr7gyuTW8H2IM9da27Wv08k0iErOau0VJzxjPT1Vo8U', 2, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"009688\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1774859758, NULL, NULL),
(1140, 'amged-albasery-dkpim', 'amged albasery', 'user', 1, NULL, '966575653106', 'albaseryunistep@gmail.com', NULL, '$2y$10$z.mCob/NgMKM5UqDKYP3IOLAkiDj8hJwJCLj3BtHnD7NU77HJ57aa', NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, NULL, NULL, '{\"color\":\"000000\",\"background\":\"ff9100\"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'all', 'active', 1, 0, NULL, NULL, 'Asia/Riyadh', NULL, 0, 0, 0, NULL, NULL, 0, 0, 0, NULL, NULL, 0, NULL, 1775021514, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users_badges`
--

CREATE TABLE `users_badges` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `badge_id` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `users_cookie_security`
--

CREATE TABLE `users_cookie_security` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `type` enum('all','customize') NOT NULL,
  `settings` text DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users_cookie_security`
--

INSERT INTO `users_cookie_security` (`id`, `user_id`, `type`, `settings`, `created_at`) VALUES
(2, 1, 'all', NULL, 1655624844);

-- --------------------------------------------------------

--
-- Structure de la table `users_manual_purchase`
--

CREATE TABLE `users_manual_purchase` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `access` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users_metas`
--

CREATE TABLE `users_metas` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users_metas`
--

INSERT INTO `users_metas` (`id`, `user_id`, `name`, `value`) VALUES
(80, 1113, 'gender', 'man'),
(81, 1113, 'age', '45');

-- --------------------------------------------------------

--
-- Structure de la table `users_occupations`
--

CREATE TABLE `users_occupations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `users_registration_packages`
--

CREATE TABLE `users_registration_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `instructors_count` int(11) DEFAULT NULL,
  `students_count` int(11) DEFAULT NULL,
  `courses_capacity` int(11) DEFAULT NULL,
  `courses_count` int(11) DEFAULT NULL,
  `meeting_count` int(11) DEFAULT NULL,
  `status` enum('disabled','active') NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users_zoom_api`
--

CREATE TABLE `users_zoom_api` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `jwt_token` text DEFAULT NULL,
  `api_key` text DEFAULT NULL,
  `api_secret` text DEFAULT NULL,
  `account_id` text DEFAULT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_banks`
--

CREATE TABLE `user_banks` (
  `id` int(10) UNSIGNED NOT NULL,
  `logo` varchar(255) NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_banks`
--

INSERT INTO `user_banks` (`id`, `logo`, `created_at`) VALUES
(4, '/store/1/default_images/payment gateways/paypal.png', 1678874235),
(5, '/store/1/default_images/payment gateways/stripe.png', 1679090196);

-- --------------------------------------------------------

--
-- Structure de la table `user_bank_specifications`
--

CREATE TABLE `user_bank_specifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_bank_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_bank_specifications`
--

INSERT INTO `user_bank_specifications` (`id`, `user_bank_id`) VALUES
(10, 4),
(11, 4),
(12, 5),
(13, 5);

-- --------------------------------------------------------

--
-- Structure de la table `user_bank_specification_translations`
--

CREATE TABLE `user_bank_specification_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_bank_specification_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_bank_specification_translations`
--

INSERT INTO `user_bank_specification_translations` (`id`, `user_bank_specification_id`, `locale`, `name`) VALUES
(15, 10, 'en', 'Account Holder'),
(16, 11, 'en', 'Email'),
(17, 12, 'en', 'Account Holder'),
(18, 13, 'en', 'Account ID');

-- --------------------------------------------------------

--
-- Structure de la table `user_bank_translations`
--

CREATE TABLE `user_bank_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_bank_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_bank_translations`
--

INSERT INTO `user_bank_translations` (`id`, `user_bank_id`, `locale`, `title`) VALUES
(6, 4, 'en', 'Paypal'),
(7, 5, 'en', 'Stripe');

-- --------------------------------------------------------

--
-- Structure de la table `user_commissions`
--

CREATE TABLE `user_commissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED DEFAULT NULL,
  `source` enum('courses','bundles','virtual_products','physical_products','meetings') NOT NULL,
  `type` enum('percent','fixed_amount') NOT NULL,
  `value` double(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_firebase_sessions`
--

CREATE TABLE `user_firebase_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` text NOT NULL,
  `fcm_token` text DEFAULT NULL,
  `ip` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_form_fields`
--

CREATE TABLE `user_form_fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `become_instructor_id` int(10) UNSIGNED DEFAULT NULL,
  `form_field_id` int(10) UNSIGNED NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_login_histories`
--

CREATE TABLE `user_login_histories` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `location` point DEFAULT NULL,
  `session_id` text NOT NULL,
  `session_start_at` bigint(20) UNSIGNED DEFAULT NULL,
  `session_end_at` bigint(20) UNSIGNED DEFAULT NULL,
  `end_session_type` enum('default','by_admin','by_user') DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_login_histories`
--

INSERT INTO `user_login_histories` (`id`, `user_id`, `browser`, `device`, `os`, `ip`, `country`, `city`, `location`, `session_id`, `session_start_at`, `session_end_at`, `end_session_type`, `created_at`) VALUES
(1, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.167.17', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, '8WkdWYyihq9iC3S0eeRTt418YD9AxE828jkvGb9E', 1768167741, NULL, NULL, 1768167741),
(2, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8091:4d0b:75b4:adaf:6110:42ee', 'Saudi Arabia', 'Sayhāt', 0x000000000101000000ebe2361ac07b3a4091ed7c3f35064940, 'eHs7veVShpX8LgDQMIbVpAyczVUg7vrsfDSzKwwd', 1768304000, NULL, NULL, 1768304000),
(3, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8091:4d0b:75b4:adaf:6110:42ee', 'Saudi Arabia', 'Sayhāt', 0x000000000101000000ebe2361ac07b3a4091ed7c3f35064940, 'z69h4lqj6flkuR9wWtZ2znUnPZ2KGEGCDQjXpIgZ', 1768321036, NULL, NULL, 1768321036),
(4, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.169.249', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'pGEMMQpUjMHpRqCxW2T5hVHV7BRmO3yh8FSlMdWX', 1768334924, NULL, NULL, 1768334924),
(5, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:5099:2200:6986:f477:677e:b000', 'Saudi Arabia', 'Riyadh', 0x000000000101000000f46c567daeb63840917efb3a70564740, 'pMi4UlA8Lt21LkhtPMH8qou1yEnZ0OrWMK1lPM71', 1768362431, NULL, NULL, 1768362431),
(7, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8092:5b1a:3813:da78:2e2a:a809', 'Saudi Arabia', 'Dammam', 0x000000000101000000e561a1d6346f3a40a1d634ef380d4940, '8vsZF2Y2UsKNQX9EUbIvLEAxjaxBwlLzwzZixQ2d', 1769071094, NULL, NULL, 1769071094),
(8, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.164.178', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'Kpra0Sm619Akf6WRhzaxaJxE4QERkriReDdStQPW', 1769442243, 1769443622, 'default', 1769442243),
(9, 1, 'Chrome', 'desktop', 'Windows-10.0', '156.203.110.9', 'Egypt', 'Luxor', 0x0000000001010000004faf946588b33940ef38454772514040, 'RnYoAGQ5hhtT1zow2eguULOUhFcLl0QkbLlzJWOQ', 1769534260, NULL, NULL, 1769534260),
(10, 1, 'Chrome', 'desktop', 'Windows-10.0', '156.209.235.230', 'Egypt', 'Asyut', 0x00000000010100000039454772f92f3b406ea301bc05323f40, 'lK4T6V9xowts2xzFdtSJd58FSRRWlw4ZwutDb6UL', 1769640547, NULL, NULL, 1769640547),
(11, 1, 'Chrome', 'desktop', 'Windows-10.0', '37.242.64.65', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'zCzEgTNFKuMj2TleqZjFsZiOUoZT7Jr6GSQ4laVV', 1769679653, NULL, NULL, 1769679653),
(12, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.160.189', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'BiaBY9QZAJ26kUUV0N9AbQqtwBhw2FSmlIpANmCF', 1769702006, NULL, NULL, 1769702006),
(13, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.160.189', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'fhqudCqRNM81lCvaLQms12Iu5dEIO9rBDRGs8xzp', 1769783336, NULL, NULL, 1769783336),
(14, 1, 'Chrome', 'desktop', 'Windows-10.0', '156.203.107.217', 'Egypt', 'Luxor', 0x0000000001010000004faf946588b33940ef38454772514040, 't95FvoIe7vBMiqH85DAjP6Ansn9njQaWiQ6TEXBk', 1769787715, NULL, NULL, 1769787715),
(15, 1, 'Chrome', 'desktop', 'Windows-10.0', '37.105.151.181', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'zbd5qyo2r233V3y7hrgKZWieMIO3roaQAq3L9wmq', 1769898862, NULL, NULL, 1769898862),
(16, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.162.13', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'WOlmXFDNJuMlQZekjwks2hyOaRbgerM7tv6rCzvf', 1769982229, 1769982854, 'default', 1769982229),
(17, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.162.13', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'HBA83K5tUnGd4yQRPhuXsKu6bCNleNf8V19UreGx', 1769988106, 1769988201, 'default', 1769988106),
(19, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.163.55', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'Ey8tDStR6OOBXkyRz102VCtMyOaj4z3kl2nIxXpD', 1770216550, NULL, NULL, 1770216550),
(21, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.163.55', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'GiNTKuSgLBsvsjsQGLu8xPzp6IGqKlSPxI77dMA0', 1770223166, NULL, NULL, 1770223166),
(23, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.164.188', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, '4jtV92r7XRMV2fatJsSUedJRsw5PZbfYI1E0x5Ax', 1770323408, NULL, NULL, 1770323408),
(24, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.164.188', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'lsU83h6qmwmdhPCj1pSwB2Nn3OeXRy40recWPY3a', 1770325788, NULL, NULL, 1770325788),
(30, 1113, 'Chrome', 'desktop', 'Windows-10.0', '196.188.37.64', 'Ethiopia', 'Addis Ababa', 0x000000000101000000068195438b0c22402b8716d9ce5f4340, 'g6r8ZaixlwMAQYCkMxxvPoGV9XNjcgfwhkFRR27z', 1771138211, NULL, NULL, 1771138211),
(31, 1, 'Chrome', 'desktop', 'Windows-10.0', '196.138.216.58', 'Egypt', 'Cairo', 0x0000000001010000003ee8d9acfa0c3e4072f90fe9b73f3f40, 'YeTo1pmpw3xsSuoKoK18rvMtrMa4vNsFjOY6YTOu', 1771146662, NULL, NULL, 1771146662),
(34, 1, 'Chrome', 'desktop', 'Windows-10.0', '197.132.67.167', 'Egypt', 'Cairo', 0x0000000001010000003ee8d9acfa0c3e4072f90fe9b73f3f40, 'bhnutsRorCpqmJwg3CkLiPrQKt46GmCLvG5UnMqX', 1772012628, NULL, NULL, 1772012628),
(35, 1113, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8092:5f72:e821:f2d5:49b2:b249', 'Saudi Arabia', 'Dammam', 0x000000000101000000e561a1d6346f3a40a1d634ef380d4940, 'pD4FFGUZBz5HZM3dozURlId0OtiCqljjaD1lrPbC', 1772092878, 1772092899, 'default', 1772092878),
(36, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8092:5f72:e821:f2d5:49b2:b249', 'Saudi Arabia', 'Dammam', 0x000000000101000000e561a1d6346f3a40a1d634ef380d4940, 'ibplMfvUYtRtLvU83HwbQ44loUWr4Fqo5W46Wp81', 1772092913, NULL, NULL, 1772092913),
(37, 1, 'Chrome', 'desktop', 'Windows-10.0', '197.132.67.167', 'Egypt', 'Cairo', 0x0000000001010000003ee8d9acfa0c3e4072f90fe9b73f3f40, '52AkkBBwvMlkO5ZE0yaYayxBV2AGWqLR138G5Mmu', 1772103656, NULL, NULL, 1772103656),
(38, 1, 'Chrome', 'phone', 'AndroidOS-10', '197.132.14.140', 'Egypt', 'Cairo', 0x0000000001010000003ee8d9acfa0c3e4072f90fe9b73f3f40, 'rW6QuCpijf2W1IiFhHGs9i0KN2iIR3ibTyNLb1OD', 1772372500, 1772372519, 'default', 1772372500),
(39, 1129, 'Chrome', 'phone', 'AndroidOS-10', '2001:16a2:c177:6bee:b883:d4ff:fe75:973d', 'Saudi Arabia', 'Makkah', 0x0000000001010000003f355eba496c35400c022b8716e94340, '5f4Kq5PsiuYNgOKWDvhrhZWfdg7AhhTPcRUbrgAB', 1772401048, NULL, NULL, 1772401048),
(40, 1129, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8092:5f72:7cae:282a:718f:8f2', 'Saudi Arabia', 'Dammam', 0x000000000101000000e561a1d6346f3a40a1d634ef380d4940, '5WS2UEeqjZJNSiyOviAZGRzNqXdYTCqbqTx8jviP', 1772437090, NULL, NULL, 1772437090),
(41, 1129, 'Chrome', 'phone', 'AndroidOS-10', '2001:16a4:21b:6fe4:d8d8:b3ff:fef7:7030', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'w9DmHAhSW0PbzDBjtOpBv9PXD0sgIfIQikK4EcZ3', 1772489355, NULL, NULL, 1772489355),
(42, 1129, 'Edge', 'desktop', 'Windows-10.0', '2001:16a2:50e2:6000:7888:2fff:9aa2:c513', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'mTUvSuqhC8vu9wRgBcHKsIxa1aIkYDmfE0HCyL8P', 1772490438, NULL, NULL, 1772490438),
(44, 1129, 'Chrome', 'phone', 'AndroidOS-10', '2001:16a4:21b:6fe4:fc9a:9dff:fe37:8a93', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'ahNd1FEzCTYkyhgtQx9AAfLqmL1sgEJV0BnD4wsS', 1772557946, 1772559827, 'default', 1772557946),
(45, 1129, 'Chrome', 'phone', 'AndroidOS-10', '2001:16a4:21b:6fe4:fc9a:9dff:fe37:8a93', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'FojOvGx1gBOJB1irKeAw1gkvfTzbNVgy8zZZQ2oa', 1772559957, 1772559966, 'default', 1772559957),
(46, 1129, 'Chrome', 'phone', 'AndroidOS-10', '2001:16a4:21b:6fe4:fc9a:9dff:fe37:8a93', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'fM9cEoRscUQmoJVtytw38iz2MlpvkBia8NweG7h5', 1772560030, NULL, NULL, 1772560030),
(47, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:cb80:4270:aebf:ec0c:eaa1:53d4:c40', 'Saudi Arabia', 'Riyadh', 0x000000000101000000569fabadd8af3840b1506b9a775c4740, 'qdAOJtaRQHkcFJEVS1mJh6Fntx4OHSmazSIIUAc4', 1772577084, NULL, NULL, 1772577084),
(48, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.160.21', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, '9Ej6O7X9qS5shYul5kDmzVZ3VFOWPE6nwGbAItOm', 1772585020, NULL, NULL, 1772585020),
(53, 1134, 'Chrome', 'desktop', 'Windows-10.0', '105.76.160.21', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'rvHoTa1Nuy0D4yzUKkVwklQJM2TqwJbDRQA6mvAb', 1772591182, 1772591279, 'default', 1772591182),
(54, 1129, 'Safari', 'tablet', 'iOS-18_6_2', '2001:16a2:53cb:8500:4ded:1640:28fe:2769', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'kByuSECDiWS8rFwm4Nvvvtw0mvxnuTWie0zInxSs', 1772598663, NULL, NULL, 1772598663),
(55, 1135, 'Chrome', 'desktop', 'Windows-10.0', '86.48.11.98', 'Singapore', 'Singapore', 0x000000000101000000b79c4b7155d9f43f273108ac1cfa5940, 'kjywTtarOt4ocLcVbs916U99to00u4qxnfsx9HpQ', 1772789741, NULL, NULL, 1772789741),
(56, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:cb80:4166:68ba:5007:a971:b7ad:6627', 'Saudi Arabia', 'Khobar', 0x0000000001010000009d8026c286473a40dfe00b93a91a4940, 'i9F1if6AqoFwaSzq2nopMmg5cNTdIhwlzuyXDbUY', 1772929110, NULL, NULL, 1772929110),
(57, 1129, 'Safari', 'tablet', 'iOS-18_6_2', '2001:16a2:53cb:8500:c98d:c7a5:ed23:a97a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, '3netlgsYfATPaOA0O4YPB1rKxjdtgqxfbxidYxFI', 1772934041, NULL, NULL, 1772934041),
(58, 1129, 'Edge', 'desktop', 'Windows-10.0', '2001:16a2:53cb:8500:9d48:7cc4:7688:c579', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, '5gmrR67ZfpZeTsitvG52AivI3l3aFKjaHYZeJdyv', 1772936153, NULL, NULL, 1772936153),
(59, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8013:8532:78e3:880d:e2bf:b35b', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'XJJ7VNzIyIEgva7tT3cdNyilNmQhIkjJqVuDpirz', 1772939622, NULL, NULL, 1772939622),
(60, 1129, 'Safari', 'tablet', 'iOS-18_6_2', '2001:16a2:53cb:8500:c98d:c7a5:ed23:a97a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'VTGsCAlaoqQ4UWLFjehcXhXJXVNN9V9XSnsFuJkk', 1772950060, NULL, NULL, 1772950060),
(61, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:4d49:dd00:b998:f3ab:957c:26ff', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'PJRPEie8TLfbAmMZXmN5ClRcoIpezBn1BxXnGmnK', 1772967431, NULL, NULL, 1772967431),
(62, 1136, 'Edge', 'desktop', 'Windows-10.0', '2001:16a2:4d49:dd00:b998:f3ab:957c:26ff', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'eDdwAcXVZcswhE7bQdqC36sBeUq1xxcPz6Evudgu', 1772967926, NULL, NULL, 1772967926),
(63, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:53ad:8a00:ad71:3f5a:3d70:645a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'O2yki1fVf7PZIhZLFj90CeMXFVappFGDeyhAjE8f', 1774522446, NULL, NULL, 1774522446),
(64, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:c178:b2aa:e9f1:3146', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, '01C4eH9KNHGh3I2z8DWzpKxRJdJyNOxEJa1YeEex', 1774779878, NULL, NULL, 1774779878),
(65, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:dc83:535b:436f:f18d', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, '4ZBhj1zpFXRIaopbB0C86ze6eYCD2oqDQubjWRO9', 1774782685, NULL, NULL, 1774782685),
(66, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:541b:6400:1579:e27a:7416:ab0a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'yBhRaJKGVdXOwlpY4CsYcff5nej0n0SRPz5zRxL6', 1774808137, 1774809284, 'default', 1774808137),
(67, 1138, 'Chrome', 'desktop', 'OS X-10_15_7', '2001:16a2:541b:6400:fdb3:1944:a50:355b', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, '6BzxOa0yNy6awpoADULDEW7iBrPh9QkhvDLyjNSU', 1774808439, 1774808977, 'default', 1774808439),
(68, 1138, 'Chrome', 'desktop', 'OS X-10_15_7', '2001:16a2:541b:6400:fdb3:1944:a50:355b', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'oZewYBWG3kgI9Ru5Ct8mev8yKUh03jYs4sHv8iDl', 1774808987, NULL, NULL, 1774808987),
(69, 1109, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:541b:6400:1579:e27a:7416:ab0a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'saAC8xuwUyUHU1lAFFSCU1JWRlRlQ7JCsEDT34Nv', 1774809329, NULL, NULL, 1774809329),
(70, 1109, 'Chrome', 'desktop', 'OS X-10_15_7', '51.36.140.16', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'HNLKbwUlr4DhilSMpPP3Aq14YZqRcVQz4SC1cmBx', 1774856690, 1774856918, 'default', 1774856690),
(71, 1138, 'Chrome', 'desktop', 'OS X-10_15_7', '51.36.140.16', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'IYQswbB4VYoXSzgCZ4CJtdOJDDCCE26LnKpFv305', 1774856956, 1774857903, 'default', 1774856956),
(72, 1109, 'Chrome', 'desktop', 'OS X-10_15_7', '51.36.140.16', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'tCw1pt5PRnvmrvK6GLQRoc86iUzpTfvUGOE6mb6L', 1774857932, NULL, NULL, 1774857932),
(73, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'odF119xHiR6hdnlTAIYWjxOOCiJzrD8oGpcJs2Rg', 1774858195, 1774859493, 'default', 1774858195),
(74, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'J9yCw0jIXVVDWVt5bxtOlaIQ8549XyOGBI5XRu9y', 1774859607, 1774859723, 'default', 1774859607),
(75, 1139, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'nh5rLvUv10o2FkZdwPKvV3OathdEH2cHlTyjeNBA', 1774859796, 1774859954, 'default', 1774859796),
(76, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'kBLcZamhBxHrifn6eOKY3BAKLICDKhcgZ4Tfhs5n', 1774859966, 1774860060, 'default', 1774859966),
(77, 1139, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'uZbjoMGMZmPeqZCqGsMGhjoqLrwrrXM59fswqqcH', 1774860078, 1774860156, 'default', 1774860078),
(78, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'Tr9raGygPlRBlJR6R8yqREjmnWq6ie5FnTvUi0Cg', 1774860173, 1774860214, 'default', 1774860173),
(79, 1139, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:1d39:7085:8b77:d08a:a9b2', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'PHoaWZrTjgeLO5G91ptuk1VKfX8nr6xdJWfXlzgF', 1774860234, NULL, NULL, 1774860234),
(80, 1139, 'Safari', 'phone', 'iOS-26_2_0', '2a02:9b0:8091:1d39:a19f:46a6:d9ab:317e', 'Saudi Arabia', 'Khobar', 0x0000000001010000000d71ac8bdb483a40b4c876be9f1a4940, 'BzocLBEypi4bY7yHMCj0wZzR0VqC5Pdxhhg8MGiT', 1774860414, NULL, NULL, 1774860414),
(81, 1113, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:754c:8700:f4a8:88cd:b604:aea', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'a82ZL4lmY3uJScGIrEOUeLdefQbJy1ApVU7ImLhw', 1774941170, NULL, NULL, 1774941170),
(82, 1113, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:754c:8700:f4a8:88cd:b604:aea', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'auDjnDV1N15syQWsKVuVFTGVidhcfgV7o1LnN6JS', 1775020320, 1775020360, 'default', 1775020320),
(83, 1, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:754c:8700:f4a8:88cd:b604:aea', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'f4xXl0U6W9usuNtUauzWU7GBghhehd2tCBox3XMh', 1775020374, NULL, NULL, 1775020374),
(84, 1140, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:754c:8700:f4a8:88cd:b604:aea', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'GmB9W4biUnRzOlSFmVUDchBW9GqWd5kgVjzgHtXu', 1775021574, NULL, NULL, 1775021574),
(85, 1, 'Chrome', 'desktop', 'Windows-10.0', '156.205.68.253', 'Egypt', 'Cairo', 0x0000000001010000003ee8d9acfa0c3e4072f90fe9b73f3f40, 'PWW4c4sbQzQ6NRBgHMzyQ6FH1OcXMMlnxhP0pkOX', 1775068220, NULL, NULL, 1775068220),
(86, 1, 'Chrome', 'desktop', 'Windows-10.0', '64.16.212.242', 'Saudi Arabia', 'Riyadh', 0x000000000101000000f46c567daeb63840917efb3a70564740, 't1Ln3zt6nnxVybf9Yy7eV1VRFSlDLeBfjrunFzGM', 1776096543, NULL, NULL, 1776096543),
(87, 1113, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:6f40:2400:4c68:561e:26f1:b8b4', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, '9jiTzezBgvEKXClMd3q4x75IeAvGTF7xsOkvFBmj', 1776190856, NULL, NULL, 1776190856),
(88, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.169.66', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'bYxAEuZTtH46M0nunm2Dt3oont9GPz2W0pek3piu', 1776191133, NULL, NULL, 1776191133),
(89, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.164.96', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'ky0IXAsNfhW9FOqa8hiBpvdOoUcgNFFMJG1zGryH', 1776349697, NULL, NULL, 1776349697),
(90, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.169.204', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'gVoHSgi41oJfgmDGELMlGaCPumRtR6TJ0T854UwR', 1776441314, NULL, NULL, 1776441314),
(91, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.169.204', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'BStFFmdISrpZBcq32zeOCVUkGiyMz3IoI4Jkhshq', 1776461960, NULL, NULL, 1776461960),
(92, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.161.176', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, '9DHs2XexApdy8jWnLmKfnbpCjwi04QXyyGD9SWbM', 1776611218, NULL, NULL, 1776611218),
(93, 1138, 'Chrome', 'desktop', 'OS X-10_15_7', '2a02:9b0:8091:69c7:e8b6:fa4d:78d8:a5bc', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, '1sMnMSCIv7CJOYJbSqWMJE8qXTwXBsg5OlfGgPE6', 1776664718, NULL, NULL, 1776664718),
(94, 1, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:751a:ad00:adb2:fb41:a03a:8228', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'peexzt9XHj2AW6onwO70Ge2vUXq5xjHH7DRGjnde', 1776790526, NULL, NULL, 1776790526),
(95, 1, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:75a4:5100:b587:200e:2b29:e49d', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'PW9ET8dz344C1Edqzd8wf7tC98jvnMqsO8tylLZf', 1777144591, NULL, NULL, 1777144591),
(96, 1, 'Chrome', 'desktop', 'Windows-10.0', '2001:16a2:75b0:2000:d4d9:1972:7623:c847', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, '52tU51cdETJmsz3OP0w6Zy0ZTmXX5IgbPCVnKpoV', 1777170592, NULL, NULL, 1777170592),
(97, 1, 'Chrome', 'desktop', 'Windows-10.0', '105.76.168.186', 'Morocco', 'Oujda', 0x0000000001010000003b014d840d57414061545227a089febf, 'pNom6hI3diyBY7OZbud8U9EjQueQIAVU3ak6cI1J', 1777238152, NULL, NULL, 1777238152),
(98, 1137, 'Edge', 'desktop', 'Windows-10.0', '2a02:9b0:8091:69c7:f1c3:e4f1:9608:497a', 'Saudi Arabia', 'Dammam', 0x000000000101000000ac8bdb68006f3a40e71da7e8480e4940, 'ddPKhyZRKqykFF6GcN52ayQPmnqsiUrY40jf0ICm', 1777272625, NULL, NULL, 1777272625),
(99, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:4030:7269:f18a:cb14:2e4a:6dd3', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, '6IGSTrs13kD9vmIqY2OyTAzfZr9pGB5uuxorBSP2', 1777825879, 1777826330, 'default', 1777825879),
(100, 1, 'Chrome', 'desktop', 'Windows-10.0', '2a02:9b0:4030:7269:f18a:cb14:2e4a:6dd3', 'Saudi Arabia', 'Jeddah', 0x000000000101000000598638d6c57d3540c898bb9690974340, 'xnIwu6eycXc08yzDXDvtX3uVbr9uqXr1tfefTNLR', 1777826350, NULL, NULL, 1777826350);

-- --------------------------------------------------------

--
-- Structure de la table `user_profile_attachments`
--

CREATE TABLE `user_profile_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `file_type` enum('pdf','powerpoint','sound','video','image','archive','document','project') NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_profile_attachment_translations`
--

CREATE TABLE `user_profile_attachment_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_profile_attachment_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_selected_banks`
--

CREATE TABLE `user_selected_banks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_bank_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_selected_bank_specifications`
--

CREATE TABLE `user_selected_bank_specifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_selected_bank_id` int(10) UNSIGNED NOT NULL,
  `user_bank_specification_id` int(10) UNSIGNED NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `verifications`
--

CREATE TABLE `verifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `mobile` char(16) DEFAULT NULL,
  `email` char(64) DEFAULT NULL,
  `code` varchar(6) NOT NULL,
  `verified_at` int(10) UNSIGNED DEFAULT NULL,
  `expired_at` int(10) UNSIGNED DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `verifications`
--

INSERT INTO `verifications` (`id`, `user_id`, `mobile`, `email`, `code`, `verified_at`, `expired_at`, `created_at`) VALUES
(108, 1070, NULL, 'radwalhusiny@gmail.com', '97434', 1764148515, 1764148565, 1764147972),
(111, 1074, NULL, 'maha2abaa@gmail.com', '53652', NULL, 1764414795, 1764411195),
(139, 1109, NULL, 'Almeshafi@siematsa.com', '37970', 1766488440, 1766488490, 1766488348),
(154, 1128, NULL, 'mhmd.1414m@gamil.com', '97759', NULL, 1772492565, 1772488965),
(155, 1128, '966553412320', NULL, '31717', NULL, 1772560412, 1772556812),
(156, 1129, NULL, 'mhmd.1414m@gmail.com', '55183', 1772401047, 1772401097, 1772400999),
(161, 1134, NULL, 'morocconaturel@gmail.com', '82600', 1772591181, 1772591231, 1772591164),
(162, 1135, NULL, 'sprinces407+951@gmail.com', '23781', 1772789740, 1772789790, 1772789696),
(163, 1136, NULL, 'almeshafi@gmail.com', '74987', 1772967925, 1772967975, 1772967867),
(164, 1137, NULL, 'info@siematsa.com', '88080', 1774782685, 1774782735, 1774782647),
(165, 1138, NULL, 'dema@siematsa.com', '21905', 1774808438, 1774808488, 1774808407),
(166, 1139, NULL, 'rema072233@gmail.com', '64712', 1774859795, 1774859845, 1774859760),
(167, 1140, NULL, 'albaseryunistep@gmail.com', '76463', 1775021573, 1775021623, 1775021516);

-- --------------------------------------------------------

--
-- Structure de la table `visits_logs`
--

CREATE TABLE `visits_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED DEFAULT NULL,
  `targetable_id` int(10) UNSIGNED NOT NULL,
  `targetable_type` varchar(255) NOT NULL,
  `visitor_id` int(10) UNSIGNED DEFAULT NULL,
  `visitor_uid` varchar(255) DEFAULT NULL,
  `visited_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `visits_logs`
--

INSERT INTO `visits_logs` (`id`, `owner_id`, `targetable_id`, `targetable_type`, `visitor_id`, `visitor_uid`, `visited_at`) VALUES
(1372, 1015, 2008, 'App\\Models\\Webinar', NULL, '37b7845fec34aceb38f0ceeee65ef25660a4fd37', 1768176712),
(1373, 1048, 2062, 'App\\Models\\Webinar', NULL, '54a2055e1f8870975eeba9420ed98d54d427ea03', 1768185568),
(1374, 1015, 2008, 'App\\Models\\Webinar', NULL, '2993782fde70bf3ea967d32494706fdc672ca5a1', 1768212105),
(1375, 1015, 5, 'App\\Models\\Product', NULL, '89ce005a13840185c9abb2890590cfd9f2aeaa53', 1768270766),
(1376, 1048, 2062, 'App\\Models\\Webinar', NULL, 'e9c82e22801db62c4707f08d3ed4dea4409740d1', 1768280134),
(1377, 1015, 2008, 'App\\Models\\Webinar', NULL, '1989ae6a014f62b7ae81161b2c52eef74f63a5db', 1768280135),
(1378, 1048, 2062, 'App\\Models\\Webinar', NULL, '0f7b26868c82879fbe5bcd8f80a14d158301f5e4', 1768331504),
(1379, 1015, 2008, 'App\\Models\\Webinar', NULL, 'fc9cb0e4c240941ac3dfce319499e105a1e7d475', 1768331506),
(1380, 1048, 2062, 'App\\Models\\Webinar', NULL, '4977ff757cdfad28f3a0ca3f71a07d13b3f2033c', 1768404639),
(1381, 1, 6, 'App\\Models\\Product', NULL, '7114220a755a62d880cef81655274b0c856e0440', 1768492531),
(1382, 1015, 2008, 'App\\Models\\Webinar', NULL, '210174ae3b7ff8dec852bdbd172ee48464ca4c09', 1768495507),
(1383, 1015, 5, 'App\\Models\\Product', NULL, '995111b78fe7a158152045f5b2e660fc6de25808', 1768531700),
(1384, 1048, 2062, 'App\\Models\\Webinar', NULL, '40c7489caa862aa021f63f8a46392d98ac6f7cf8', 1768548024),
(1385, 1015, 2008, 'App\\Models\\Webinar', NULL, 'ab7ce62ffab83efb52ab092424ca5332ff5e7ea9', 1768597135),
(1386, 1015, 2008, 'App\\Models\\Webinar', NULL, '49f04f1041bc9f22fb864e4c32a7faaf7b04e13b', 1768702648),
(1387, 1048, 2062, 'App\\Models\\Webinar', NULL, '5401c332e48ec1d078b842caf9947f1bcb3b7535', 1768807456),
(1388, 1048, 2062, 'App\\Models\\Webinar', NULL, 'c1377e57dce50b3b59df1d9628c8a2d5d5e1afb2', 1768874924),
(1389, 1015, 2008, 'App\\Models\\Webinar', NULL, 'fa9b39fd6f92b0f83da58217d37df1122850f54f', 1768874925),
(1390, 1015, 2008, 'App\\Models\\Webinar', NULL, '460228d35981925ebc55bff9e448d8149354b23c', 1768891287),
(1391, 1015, 2008, 'App\\Models\\Webinar', NULL, 'f89938e6b2088670bd030f1a2a63df2c3af95286', 1768891728),
(1392, 1048, 30, 'App\\Models\\Blog', NULL, '9577c5847cd1a4007aa7915eae69195b4c23f9ff', 1768939283),
(1393, 1015, 2008, 'App\\Models\\Webinar', NULL, 'c9b82580783bda0a8d72cc30ccf74fb9f12e60a5', 1768988261),
(1394, 1048, 30, 'App\\Models\\Blog', NULL, 'e399d46f9978561b388f6423303db4bd3deafcba', 1769032298),
(1395, 1048, 2062, 'App\\Models\\Webinar', NULL, '346699c0e4d0219463bc58ebaa09b484a4499f48', 1769071062),
(1396, 1015, 2008, 'App\\Models\\Webinar', NULL, '346699c0e4d0219463bc58ebaa09b484a4499f48', 1769071074),
(1397, 1048, 2062, 'App\\Models\\Webinar', NULL, '9f63cd558f9987891f514c69bc5c21b3642dfa77', 1769076504),
(1398, 1015, 2008, 'App\\Models\\Webinar', NULL, '9f5e697a221e0ef2d95288d381114116dacaf102', 1769076505),
(1399, 1, 6, 'App\\Models\\Product', NULL, '5f0d53f5336777f77e32c5ec2560068713b7c367', 1769096681),
(1400, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd1f40efecc2d9ee29140d14284146eadfcbf1cdf', 1769128601),
(1401, 1015, 5, 'App\\Models\\Product', NULL, '5d9db73c7c13911730533a8bb259d67d3b221d21', 1769136026),
(1402, 1048, 2062, 'App\\Models\\Webinar', NULL, '333845aea2fc0f7436c176e27bd76c65b897b0a2', 1769139638),
(1403, 1015, 2008, 'App\\Models\\Webinar', NULL, '3b56f7960ed72185a68e40bc7a51ebf619b0af0e', 1769139639),
(1404, 1048, 30, 'App\\Models\\Blog', NULL, 'c23bd29bb000da0ce4487bb2a2e548f8defaa473', 1769182259),
(1405, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd9ada31f9a1e23b8d6c756bf8736398376d7328d', 1769306035),
(1406, 1015, 2008, 'App\\Models\\Webinar', NULL, '0b8f418997416eae38487fadc11b5264528a4f0f', 1769313841),
(1407, 1048, 2062, 'App\\Models\\Webinar', NULL, '0b8f418997416eae38487fadc11b5264528a4f0f', 1769313926),
(1408, 1048, 30, 'App\\Models\\Blog', NULL, '8b210ff87a84ce0f9b95220c4cfd509758dc8e71', 1769314783),
(1409, 1048, 2062, 'App\\Models\\Webinar', NULL, 'ddcd591e77dbfd2e4da5f5d97dd18fb3d2b4396e', 1769340400),
(1410, 1015, 2008, 'App\\Models\\Webinar', NULL, '5d23b8e33740a952ea9edb498b3c02d536bf2653', 1769340401),
(1411, 1015, 2008, 'App\\Models\\Webinar', NULL, '6b605f1009b0c2e692a4ce27172f7abd89bcaa3c', 1769403398),
(1412, 1048, 2062, 'App\\Models\\Webinar', NULL, '93d0d62718e5444682528e61ff248b18671b3659', 1769409236),
(1413, 1048, 30, 'App\\Models\\Blog', NULL, '5020f71a8fd4f7c088bd9ba5e9ee9710b069b7d6', 1769429452),
(1414, 1048, 2062, 'App\\Models\\Webinar', NULL, '308a198b18963a68bd3424c6bd96793c7c6eaada', 1769528309),
(1415, 1048, 2062, 'App\\Models\\Webinar', NULL, '2364a4c26713238901fbae646f1dca3dacc444f6', 1769565936),
(1416, 1015, 2008, 'App\\Models\\Webinar', NULL, '2f74419a95ea35f35b0ba6574b5359e262dd6d42', 1769565937),
(1417, 1048, 2062, 'App\\Models\\Webinar', 1048, '4748a54606c8e48fc838272c2d7b8c96667dfb91', 1769680311),
(1418, 1048, 2062, 'App\\Models\\Webinar', NULL, 'e9c82e22801db62c4707f08d3ed4dea4409740d1', 1769696928),
(1419, 1015, 2008, 'App\\Models\\Webinar', NULL, '62dfadf6fe558c3520247e98fd52543223fc5683', 1769696929),
(1420, 1015, 2008, 'App\\Models\\Webinar', NULL, '4840339fda2e77168e5cc03524515bfeb7f1c867', 1769701923),
(1421, 1, 6, 'App\\Models\\Product', NULL, '39a2fe84b5ec9c9681fd2c8ed52dba5922729cd1', 1769702538),
(1422, 1048, 2062, 'App\\Models\\Webinar', NULL, '827129de03f04e928b0bb4cf9dfcac7cdbf5c306', 1769779758),
(1423, 1015, 2008, 'App\\Models\\Webinar', NULL, '527cfc5bbfc2957648d65f41336bea9bbf661dad', 1769779759),
(1424, 1048, 2062, 'App\\Models\\Webinar', NULL, 'df40620d85e807e33ec136cf7020ec9f785bee3e', 1769780894),
(1425, 1015, 2008, 'App\\Models\\Webinar', NULL, 'ca79e4377045f0af37bb421c643fa40e100855b7', 1769781986),
(1426, 1048, 30, 'App\\Models\\Blog', NULL, '7b82da2d14754accabfa8595b4f744fadc397f07', 1769796539),
(1427, 1048, 2062, 'App\\Models\\Webinar', NULL, '5dca4991904828d9bc72a7d6005f60072bb1f807', 1769825525),
(1428, 1015, 2008, 'App\\Models\\Webinar', NULL, '632a67a9c915fb77c3ac91ae7c6b5eec37b6c283', 1769825526),
(1429, 1015, 2008, 'App\\Models\\Webinar', NULL, 'ba34c8422f318ec2380a143c65c8c0634a3e00f5', 1769911959),
(1430, 1015, 2008, 'App\\Models\\Webinar', NULL, '66a007976c2691b0470e5a66422a41d3b7275353', 1769937366),
(1431, 1015, 2008, 'App\\Models\\Webinar', NULL, '4840339fda2e77168e5cc03524515bfeb7f1c867', 1769937396),
(1432, 1015, 2008, 'App\\Models\\Webinar', NULL, '233d68b7188d79a12338cccc61acb58c9cfaeb4b', 1769948455),
(1433, 1015, 5, 'App\\Models\\Product', NULL, '56ddee306013104637c2cf20b7accd665db421f8', 1769948486),
(1434, 1015, 1, 'App\\Models\\Product', NULL, '56ddee306013104637c2cf20b7accd665db421f8', 1769948486),
(1435, 1048, 2062, 'App\\Models\\Webinar', NULL, 'a26974ccb25b4412311da11d42791157803a18d1', 1769950930),
(1436, 1048, 2062, 'App\\Models\\Webinar', NULL, '2f1339c791784a4082b63684e2af98b3a6615698', 1769974416),
(1437, 1015, 2008, 'App\\Models\\Webinar', NULL, '69e5a22048b914423a5707dc08a1f4902ed9d947', 1770007086),
(1438, 1048, 2062, 'App\\Models\\Webinar', NULL, 'a80782a0894283e70c39236a54f53dfa18f36d25', 1770007086),
(1439, 1048, 2062, 'App\\Models\\Webinar', NULL, 'ef72f848180f9204bb2cf7ae49173026493c2015', 1770021025),
(1440, 1015, 2008, 'App\\Models\\Webinar', NULL, '47140710b04bae7023adf4b4d61a6114728e652f', 1770021026),
(1441, 1048, 2062, 'App\\Models\\Webinar', NULL, '6b4196b78243ce02cd1fc2708a3e49ebb0d8f3c2', 1770022333),
(1442, 1048, 2062, 'App\\Models\\Webinar', NULL, 'bb6b196225e5414300d4cda22613bd14d2a14093', 1770161171),
(1443, 1048, 2062, 'App\\Models\\Webinar', NULL, 'cf45a219d6174e3f64be50936d29927771e1c20d', 1770161610),
(1444, 1015, 2008, 'App\\Models\\Webinar', NULL, '0252d97ce08be43e899cd132a8dbd15cf727bac2', 1770161612),
(1445, 1015, 2008, 'App\\Models\\Webinar', NULL, '83faef97ca7cf2b15b772ce364ad92f89af7709a', 1770166688),
(1446, 1048, 30, 'App\\Models\\Blog', NULL, 'efaa8cf3b79286d76b02809892ca6043e01bd1ca', 1770185762),
(1447, 1015, 2008, 'App\\Models\\Webinar', NULL, '407c77ce4d1742d5f7ebc5de9986770055f86aa7', 1770194753),
(1448, 1048, 2062, 'App\\Models\\Webinar', NULL, '0142f99bde896b267f69d742ac3094b57e324bcc', 1770204920),
(1449, 1015, 2008, 'App\\Models\\Webinar', NULL, '7b78458e7d4a183ea738e876e995b5ca67335d8c', 1770204922),
(1450, 1048, 2062, 'App\\Models\\Webinar', NULL, '081c4439022bb9fb8744c73ac677ce8fa934e78d', 1770280701),
(1451, 1015, 2008, 'App\\Models\\Webinar', NULL, '3ce76866a5006a15d889d888d9817307bb6600ff', 1770315395),
(1452, 1, 6, 'App\\Models\\Product', NULL, '838e90428be0c2c08a7e58e7cac258f805cd277c', 1770316892),
(1453, 1015, 2008, 'App\\Models\\Webinar', NULL, '928075c1acc4aae131de661359939d892232c351', 1770318415),
(1454, 1048, 2062, 'App\\Models\\Webinar', 1048, 'fde726a9cc819cb128e5bd2ed84f68bba461382e', 1770324281),
(1455, 1048, 2062, 'App\\Models\\Webinar', NULL, 'c9d2820036dabe7a4c0dd9713c39d23d920e8f00', 1770337935),
(1456, 1048, 2063, 'App\\Models\\Webinar', NULL, '845be0dbb132e864861686c02d00d8a2d6180ac2', 1770337936),
(1457, 1015, 2008, 'App\\Models\\Webinar', NULL, '1d8790927980469221103970755851267af0339b', 1770337937),
(1458, 1015, 5, 'App\\Models\\Product', NULL, '6e48fb63b1bb846af6e7c8ae830cc4e882ce5ab2', 1770346049),
(1459, 1048, 2062, 'App\\Models\\Webinar', NULL, '15efa07764a4179ca0ef29810ae18151c107cba3', 1770382950),
(1460, 1015, 2008, 'App\\Models\\Webinar', NULL, '190df0092af4f1262b15bcf561f21ad5ef8c47ea', 1770382951),
(1461, 1015, 2008, 'App\\Models\\Webinar', NULL, 'c4f6d1b151090d9c14fad63d8fe01182e7199c82', 1770398764),
(1462, 1048, 2063, 'App\\Models\\Webinar', NULL, 'abb97a8f041cc2a68b2558536cff06c80769cf6c', 1770410033),
(1463, 1048, 2063, 'App\\Models\\Webinar', NULL, 'a5a3b77cec5a861d3596af4c6d8c97014b75b972', 1770427973),
(1464, 1048, 2063, 'App\\Models\\Webinar', NULL, '3cf6b5b50c58acacd058838fa32fd59413fb7269', 1770432409),
(1465, 1015, 2008, 'App\\Models\\Webinar', NULL, '1572396f704b3462915cfdadb5d446c1c0d1e23e', 1770514679),
(1466, 1048, 2062, 'App\\Models\\Webinar', NULL, '0d83e3c0468bdd37dd1122f46bde341354b79d6a', 1770516472),
(1467, 1048, 2063, 'App\\Models\\Webinar', NULL, '601899e6f6bdb9bbf13fba86a22cc21957e0fb80', 1770516473),
(1468, 1015, 2008, 'App\\Models\\Webinar', NULL, '2175143b13afcafa96da25f19206b4d06445cdca', 1770516474),
(1469, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd7caf294f79a1283bd6fa416729de5cb101581e3', 1770539749),
(1470, 1015, 2008, 'App\\Models\\Webinar', NULL, '665e5cb3e4c2e036112eeef7e14c5d95ba4e3743', 1770545055),
(1471, 1048, 2062, 'App\\Models\\Webinar', NULL, '9f5173879eb773511f2e3c2708dded3b98e1a5a1', 1770567451),
(1472, 1048, 2063, 'App\\Models\\Webinar', NULL, '1856b167dcee296046c519beb47b5ebaefb19bb7', 1770567453),
(1473, 1015, 2008, 'App\\Models\\Webinar', NULL, '61420e2f5d177f88e7f7fccd5831eccc81241f0b', 1770567454),
(1474, 1048, 30, 'App\\Models\\Blog', NULL, '62247538ce58b89c3ff4fc271ac39b9152039a80', 1770580648),
(1475, 1015, 2008, 'App\\Models\\Webinar', NULL, 'b574dd3c3c59792e0db275f5db73073a17c59e3b', 1770580755),
(1476, 1015, 5, 'App\\Models\\Product', NULL, 'e80f5d47a9c95943a96bb0cb4e1ffa64b023b869', 1770587913),
(1477, 1, 9, 'App\\Models\\Product', NULL, 'e80f5d47a9c95943a96bb0cb4e1ffa64b023b869', 1770587916),
(1478, 1015, 1, 'App\\Models\\Product', NULL, 'e80f5d47a9c95943a96bb0cb4e1ffa64b023b869', 1770587919),
(1479, 1048, 2062, 'App\\Models\\Webinar', NULL, '7d06d6012453b632ff948d245075a3e6c3599146', 1770639431),
(1480, 1048, 2062, 'App\\Models\\Webinar', NULL, 'e400361e8b3907bc72c577ab4245fda81a76608d', 1770672448),
(1481, 1048, 2062, 'App\\Models\\Webinar', NULL, 'bd8bff0011bf43b696a5c0bf8ea202858091ffda', 1770702426),
(1482, 1015, 2008, 'App\\Models\\Webinar', NULL, '72837b569d77b1f0892bf5ed32b38ca3d2d965ca', 1770702427),
(1483, 1048, 2062, 'App\\Models\\Webinar', NULL, '88e64a57087b6a370d071395c8b37726a95d3cff', 1770725891),
(1484, 1048, 2062, 'App\\Models\\Webinar', NULL, '1c3af909170d19c6edf076a04a232de21f187998', 1770751872),
(1485, 1048, 2063, 'App\\Models\\Webinar', NULL, 'de27aceba02ab6a6f51edfde44475d8266cfcd83', 1770751873),
(1486, 1015, 2008, 'App\\Models\\Webinar', NULL, '5419b89ca4d9b22694a48ad6b7de620628828b3a', 1770751874),
(1487, 1015, 2008, 'App\\Models\\Webinar', NULL, '218c1014d79a92cc06b6a7ae1e5ff7ae2f325819', 1770787960),
(1488, 1048, 2062, 'App\\Models\\Webinar', NULL, '972397309781edfb260ffcee244eb581879ce5f7', 1770887775),
(1489, 1048, 2063, 'App\\Models\\Webinar', NULL, '760dd9101c4e5fdafff6bd0ce3591a964301036d', 1770887776),
(1490, 1015, 2008, 'App\\Models\\Webinar', NULL, '913027a4a724041f8bff79e9641ff832486ed83e', 1770887777),
(1491, 1015, 2008, 'App\\Models\\Webinar', NULL, '2815972ecf66fb5fd0b2bf71b3b4b745c5706277', 1770888844),
(1492, 1, 6, 'App\\Models\\Product', NULL, 'c18a758ac9b43e730f9c1d3b6dc8a445286e9e75', 1770911458),
(1493, 1048, 2062, 'App\\Models\\Webinar', NULL, '0dd26dfbf19991faab9f24b2f2c311ab363c3431', 1770934605),
(1494, 1048, 2063, 'App\\Models\\Webinar', NULL, '70b741612e8e7abdaf8639e2f924e4397ebd34da', 1770934606),
(1495, 1015, 2008, 'App\\Models\\Webinar', NULL, '87d98a9107069c8d3c02be4996b2866612b0d538', 1770934607),
(1496, 1015, 5, 'App\\Models\\Product', NULL, '698906d0b4c23ac3d488aafc8bc3dcaa6f711ced', 1770950841),
(1497, 1015, 2008, 'App\\Models\\Webinar', NULL, 'a5a3b77cec5a861d3596af4c6d8c97014b75b972', 1771000799),
(1498, 1048, 30, 'App\\Models\\Blog', NULL, '4090cd83ebd0af7d847000eef090cbe9731d2195', 1771015721),
(1499, 1015, 2008, 'App\\Models\\Webinar', NULL, '770aee16837988bcd1e0953629e0aaac5ed0f3d6', 1771036949),
(1500, 1048, 2062, 'App\\Models\\Webinar', NULL, 'f6456b13da0e60744af9b6edfd124c1641e55541', 1771047646),
(1501, 1048, 2062, 'App\\Models\\Webinar', NULL, '190df0092af4f1262b15bcf561f21ad5ef8c47ea', 1771067230),
(1502, 1048, 2063, 'App\\Models\\Webinar', NULL, '0cd18ed90bc6fd74d8a70eb1b5ff322e50c7f172', 1771067231),
(1503, 1015, 2008, 'App\\Models\\Webinar', NULL, '0da6c67b12528a03b5590ceeeb25032f35b6195b', 1771067232),
(1504, 1048, 2062, 'App\\Models\\Webinar', NULL, '12f6712d031e3342e566cd99d8a14db47efe4cc6', 1771111140),
(1505, 1048, 2063, 'App\\Models\\Webinar', NULL, 'a41b97a92b78ca9dc3ace64f7e03b966249e5324', 1771111142),
(1506, 1015, 2008, 'App\\Models\\Webinar', NULL, 'bafda61fc02e7635701a216a6b0f9161be28e9c7', 1771111143),
(1507, 1015, 2008, 'App\\Models\\Webinar', NULL, '65dd948bf75422a09660f9528a5d7f89b82f70a3', 1771137523),
(1508, 1048, 2063, 'App\\Models\\Webinar', NULL, '65dd948bf75422a09660f9528a5d7f89b82f70a3', 1771137584),
(1509, 1015, 2008, 'App\\Models\\Webinar', NULL, '6a6d9af3df20ccc01f250e59c8a1b5bc4c585794', 1771177642),
(1510, 1048, 2063, 'App\\Models\\Webinar', NULL, '66c6a4a8057e2d02a2c734e970ee2e4acdb6b3a5', 1771205759),
(1511, 1048, 2062, 'App\\Models\\Webinar', NULL, 'a41b97a92b78ca9dc3ace64f7e03b966249e5324', 1771238860),
(1512, 1048, 2063, 'App\\Models\\Webinar', NULL, '6f36884dd8b1b705d2f1f68f92f84f5c0e4720d0', 1771238861),
(1513, 1015, 2008, 'App\\Models\\Webinar', NULL, 'b3f0a5cf4db25189a8803de49f6293b5c58645ce', 1771238863),
(1514, 1048, 2062, 'App\\Models\\Webinar', NULL, '6a1564b27c6db42fe309e6f76d17ef338a605307', 1771284106),
(1515, 1048, 2063, 'App\\Models\\Webinar', NULL, '014c272379f1f391b70d99372a1993cff2d74b10', 1771284108),
(1516, 1015, 2008, 'App\\Models\\Webinar', NULL, '93917298960910e26527228cd678892a7732162a', 1771284109),
(1517, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd4e3b0ff67c387b1b84887de008b521eceea80e6', 1771295398),
(1518, 1015, 2008, 'App\\Models\\Webinar', NULL, 'cac24bd3d57e08c9d1e06c2dbf9549e6a581f068', 1771390748),
(1519, 1048, 2062, 'App\\Models\\Webinar', NULL, '296333c32da45b62aaad23fbaab5d46d2d2856d2', 1771408383),
(1520, 1048, 2063, 'App\\Models\\Webinar', NULL, '21df29057f7b0268d3c16628e56793c2e8162fb4', 1771408385),
(1521, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd354548c6806f1102cbd2c31b4ca8f150eda9421', 1771408388),
(1522, 1048, 2062, 'App\\Models\\Webinar', NULL, '0cba91f5be4d672415f64dc898fd00ca98cb658c', 1771454370),
(1523, 1048, 2063, 'App\\Models\\Webinar', NULL, '6d9d4f5b371e874ce96429ab724a588bfcc9a3c8', 1771454371),
(1524, 1015, 2008, 'App\\Models\\Webinar', NULL, '2f74419a95ea35f35b0ba6574b5359e262dd6d42', 1771454372),
(1525, 1048, 2062, 'App\\Models\\Webinar', NULL, '6cf38f5d6b693e2e7f3b99bbf6d8c77f9a95f483', 1771469669),
(1526, 1015, 2008, 'App\\Models\\Webinar', NULL, '8f0d6f2b628cf8e114a42edf986f2722386352aa', 1771470938),
(1527, 1048, 30, 'App\\Models\\Blog', NULL, '898848dd22f1e7d0d488c1ad0452fe7f816bf41b', 1771508589),
(1528, 1, 6, 'App\\Models\\Product', NULL, '6b1ec8867eaedcb59c2dd40173ad802ecbf17516', 1771516750),
(1529, 1048, 2063, 'App\\Models\\Webinar', NULL, '7d280f95b2f5c4c9b5b1d8c29c43b81d732d76d9', 1771561314),
(1530, 1048, 2062, 'App\\Models\\Webinar', NULL, 'c1377e57dce50b3b59df1d9628c8a2d5d5e1afb2', 1771584073),
(1531, 1048, 2063, 'App\\Models\\Webinar', NULL, '2f74419a95ea35f35b0ba6574b5359e262dd6d42', 1771584074),
(1532, 1015, 2008, 'App\\Models\\Webinar', NULL, '2175143b13afcafa96da25f19206b4d06445cdca', 1771584075),
(1533, 1048, 30, 'App\\Models\\Blog', NULL, '2fdc8c58c057f7cc8b068c2f191721cea8deab57', 1771612475),
(1534, 1015, 5, 'App\\Models\\Product', NULL, 'bee96b32c7394a9661908fa3cdee0e3d40bd77d2', 1771620542),
(1535, 1048, 2062, 'App\\Models\\Webinar', NULL, 'b3f0a5cf4db25189a8803de49f6293b5c58645ce', 1771635679),
(1536, 1048, 2063, 'App\\Models\\Webinar', NULL, 'ef72f848180f9204bb2cf7ae49173026493c2015', 1771635680),
(1537, 1015, 2008, 'App\\Models\\Webinar', NULL, '18c37ba865845d8cec8e2865bf3525af77722d1b', 1771635682),
(1538, 1015, 2008, 'App\\Models\\Webinar', NULL, 'a49a1974bebbbd68ce4f95497e870ae8e3412a13', 1771640149),
(1539, 1015, 2008, 'App\\Models\\Webinar', NULL, '17b0105977cc035336c84115201effd8a18c54d7', 1771641379),
(1540, 1015, 2008, 'App\\Models\\Webinar', NULL, 'a4cc327550b85d57cba1ec66c464f6e6cda49aef', 1771733778),
(1541, 1048, 2063, 'App\\Models\\Webinar', NULL, 'b751d4c737547c6c86d37fce60a05fd9d3796800', 1771757705),
(1542, 1048, 2062, 'App\\Models\\Webinar', NULL, '630a3147672f6b728b62a56174a31dbc4e461553', 1771780493),
(1543, 1048, 2063, 'App\\Models\\Webinar', NULL, '6ec6546195b14113146ebb7968f0618636b2e8d4', 1771780494),
(1544, 1015, 2008, 'App\\Models\\Webinar', NULL, 'a02b80ce0b65d8867c7ff4fa73412224f120dfb9', 1771780495),
(1545, 1048, 2062, 'App\\Models\\Webinar', NULL, 'f3db386b78ef9573f3c392e81ae614b88650ab7d', 1771825124),
(1546, 1048, 2063, 'App\\Models\\Webinar', NULL, 'ea3b75d563f95c01eb53e39339895968f8f10720', 1771825125),
(1547, 1015, 2008, 'App\\Models\\Webinar', NULL, 'ef40ae05759aab6dbf501971aee6ac7d7c9bbd45', 1771825126),
(1548, 1048, 2062, 'App\\Models\\Webinar', NULL, '48d5f6452e9e93572aae611a364f5335e26d6b5e', 1771941675),
(1549, 1048, 2063, 'App\\Models\\Webinar', NULL, 'bf21d08eebbbf3b0a2b2f3e346039d85796d8c21', 1771941677),
(1550, 1015, 2008, 'App\\Models\\Webinar', NULL, 'd86232fd91fc689f7efb87089aabd77669a7fc5f', 1771941678),
(1551, 1048, 2062, 'App\\Models\\Webinar', NULL, '3b7c569d26fb9fa5aed2e5e32bd6d542d6f77d2c', 1771973585),
(1552, 1048, 2062, 'App\\Models\\Webinar', NULL, '7be96f85e906e847778092b2d88ee7908ef36721', 1771984475),
(1553, 1048, 2063, 'App\\Models\\Webinar', NULL, '76434322cc5d9f096bfa4f01c25b3c0e13d63b24', 1771984477),
(1554, 1015, 2008, 'App\\Models\\Webinar', NULL, 'ea3b75d563f95c01eb53e39339895968f8f10720', 1771984478),
(1555, 1015, 2008, 'App\\Models\\Webinar', NULL, '9dbca98c30df34d7a72912b85f8b0510474e5010', 1772026808),
(1556, 1048, 2062, 'App\\Models\\Webinar', NULL, 'f79a731407c84a1542eb8d400cfcb0ba9c64f8c9', 1772076295),
(1557, 1048, 2063, 'App\\Models\\Webinar', 1048, '915042fe254d37662bc22a27463549639600295f', 1772093014),
(1558, 1015, 2008, 'App\\Models\\Webinar', NULL, '58740b6b7ce5cd802f31d9e1f7a8b8502956394f', 1772093559),
(1559, 1048, 2062, 'App\\Models\\Webinar', NULL, 'ca5e5f152dd1e58ecb05b46d58072bcab381df34', 1772112245),
(1560, 1048, 2063, 'App\\Models\\Webinar', NULL, '97375758c07c44dea632e8d41f9267c3ae0cb03e', 1772112246),
(1561, 1015, 2008, 'App\\Models\\Webinar', NULL, 'a6b21f9bfc75c3e811196f2769ca470bd87fd028', 1772112247),
(1562, 1, 6, 'App\\Models\\Product', NULL, 'c835413fc596ceffa6497fe80d942747d69aab9f', 1772140189),
(1563, 1048, 30, 'App\\Models\\Blog', NULL, '39143d645567f043f31060a032e312cff1b1932f', 1772154578),
(1564, 1048, 2062, 'App\\Models\\Webinar', NULL, '0dd26dfbf19991faab9f24b2f2c311ab363c3431', 1772155828),
(1565, 1048, 2063, 'App\\Models\\Webinar', NULL, '630a3147672f6b728b62a56174a31dbc4e461553', 1772155830),
(1566, 1015, 2008, 'App\\Models\\Webinar', NULL, '0cd1173f685e857f9f7e79dfe16b608f1342e4d4', 1772155831),
(1567, 1015, 5, 'App\\Models\\Product', NULL, '320f6ca59035457d23142062ba10860eb273c188', 1772161434),
(1568, 1015, 2008, 'App\\Models\\Webinar', NULL, 'e20d7212b58d3b9598c2a508f31d40a55fbec873', 1772244770),
(1569, 1048, 2062, 'App\\Models\\Webinar', NULL, '014c272379f1f391b70d99372a1993cff2d74b10', 1772280119),
(1570, 1048, 2063, 'App\\Models\\Webinar', NULL, '78e0b20cc94b255e9c789db87b863a5a967abb2c', 1772280120),
(1571, 1015, 2008, 'App\\Models\\Webinar', NULL, '6a1564b27c6db42fe309e6f76d17ef338a605307', 1772280121),
(1572, 1048, 2062, 'App\\Models\\Webinar', NULL, '5868b73194070e057931dd34e00498142684f259', 1772314920),
(1573, 1048, 2062, 'App\\Models\\Webinar', NULL, '760dd9101c4e5fdafff6bd0ce3591a964301036d', 1772324340),
(1574, 1048, 2063, 'App\\Models\\Webinar', NULL, 'ce9c13542bc56cf6d91706ce1d891bc16935bbc5', 1772324341),
(1575, 1015, 2008, 'App\\Models\\Webinar', NULL, '15efa07764a4179ca0ef29810ae18151c107cba3', 1772324343),
(1576, 1048, 2063, 'App\\Models\\Webinar', NULL, '346aa60f32721aeef68a5e261261876455f4338b', 1772486591),
(1577, 1129, 2064, 'App\\Models\\Webinar', 1129, '37847a431826ff3984fecf47893e2e4b9fe6da14', 1772491082),
(1578, 1129, 2064, 'App\\Models\\Webinar', NULL, '3be638972d5844a1afe21f80f3cbe01c67bf3b16', 1772512967),
(1579, 1048, 2062, 'App\\Models\\Webinar', NULL, 'bafda61fc02e7635701a216a6b0f9161be28e9c7', 1772512968),
(1580, 1048, 2063, 'App\\Models\\Webinar', NULL, 'ca5e5f152dd1e58ecb05b46d58072bcab381df34', 1772512970),
(1581, 1129, 2064, 'App\\Models\\Webinar', NULL, 'ea3b75d563f95c01eb53e39339895968f8f10720', 1772554551),
(1582, 1048, 2062, 'App\\Models\\Webinar', NULL, '76434322cc5d9f096bfa4f01c25b3c0e13d63b24', 1772554552),
(1583, 1048, 2063, 'App\\Models\\Webinar', NULL, '788d21676baf18a1325a1c6153eda44f07895c31', 1772554553),
(1584, 1129, 2064, 'App\\Models\\Webinar', NULL, '9caca1030e6c0bcc9042ecf8deb7d225c414b152', 1772556664),
(1585, 1015, 2008, 'App\\Models\\Webinar', NULL, '9caca1030e6c0bcc9042ecf8deb7d225c414b152', 1772559875),
(1586, 1015, 2008, 'App\\Models\\Webinar', NULL, '05d6176a05de42fbc828a20b43a12c7b55b38988', 1772569701),
(1587, 1048, 2063, 'App\\Models\\Webinar', NULL, '05d6176a05de42fbc828a20b43a12c7b55b38988', 1772569880),
(1588, 1048, 2062, 'App\\Models\\Webinar', NULL, '05d6176a05de42fbc828a20b43a12c7b55b38988', 1772569965),
(1589, 1048, 30, 'App\\Models\\Blog', NULL, 'b54928563810b7985c49faa05f2a1e398c4623ee', 1772570040),
(1590, 1048, 2063, 'App\\Models\\Webinar', NULL, '77d920172699fee419cfb352ee78bc8e5093eec8', 1772583943),
(1591, 1048, 30, 'App\\Models\\Blog', NULL, '466bac6acba78d01c2e012c4382c909a532fed52', 1772584102),
(1592, 1048, 2062, 'App\\Models\\Webinar', NULL, '77d920172699fee419cfb352ee78bc8e5093eec8', 1772584149),
(1593, 1129, 2064, 'App\\Models\\Webinar', 1129, '824e9eaecd2949d92e1ce50a154a28fc7072ee04', 1772598680),
(1594, 1048, 2063, 'App\\Models\\Webinar', NULL, 'fdd7d60b61bf19b1bb4e821d45dcec8f72b5c873', 1772659454),
(1595, 1048, 2062, 'App\\Models\\Webinar', NULL, 'a04ec16455d3c8036a182fa7f0ac10f37c2cd95c', 1772659454),
(1596, 1015, 2008, 'App\\Models\\Webinar', NULL, '2dfc29400122ea137ec28a045bfacf76e3b88254', 1772659456),
(1597, 1048, 30, 'App\\Models\\Blog', NULL, '001907b2d369ebcd5d8dcec6c532e5e36dc00ecc', 1772659456),
(1598, 1048, 2063, 'App\\Models\\Webinar', NULL, '84118294c7c7d5a018d97625bf14d24007dd0dc3', 1772659519),
(1599, 1048, 2062, 'App\\Models\\Webinar', NULL, '322e205ff0594803458f0e5633889d1d24c247d6', 1772659526),
(1600, 1015, 2008, 'App\\Models\\Webinar', NULL, '8338f4aef2c429bceefd3b94edcf28c4bb7685f7', 1772659736),
(1601, 1048, 2062, 'App\\Models\\Webinar', NULL, 'e94e3aab62f54377355970e1870258025ab1f9b8', 1772660056),
(1602, 1048, 2062, 'App\\Models\\Webinar', NULL, '172d37dd05af1a92d2d405ae0a4e15186d33345b', 1772660452),
(1603, 1048, 2063, 'App\\Models\\Webinar', NULL, '6ade397c9ebea575ddb3c9ced2aa9d98d4017613', 1772660705),
(1604, 1048, 2062, 'App\\Models\\Webinar', NULL, '89135c429948cce818656ef8041c2717dd0153af', 1772660710),
(1605, 1015, 2008, 'App\\Models\\Webinar', NULL, '06dc9743ade1bf4e2201b1399fd708e0d94d689e', 1772660784),
(1606, 1048, 2063, 'App\\Models\\Webinar', NULL, 'c851ebc202a94e97961599a6ce6665cf46ced8d6', 1772661984),
(1607, 1015, 2008, 'App\\Models\\Webinar', NULL, '721b56f18e8e4bba0cbc992c7f3263576ada96df', 1772693169),
(1608, 1015, 2008, 'App\\Models\\Webinar', NULL, '154de9ae284c556d83d131fdc3a7430c2f5bf279', 1772699241),
(1609, 1048, 2063, 'App\\Models\\Webinar', NULL, 'bd8bff0011bf43b696a5c0bf8ea202858091ffda', 1772706876),
(1610, 1015, 2008, 'App\\Models\\Webinar', NULL, '2d46f40273147c90505b1717c9d392813ff39fdd', 1772706878),
(1611, 1, 6, 'App\\Models\\Product', NULL, '09f2c17c1c1f01f0d8f583c8eebc1ab535bd1426', 1772725780),
(1612, 1048, 2063, 'App\\Models\\Webinar', NULL, '3f151c76f193ea61d8428c0d5489406ae6511762', 1772742352),
(1613, 1015, 5, 'App\\Models\\Product', NULL, '186a427e28e0cb3c2139b75dff9b9c8e2aee07d7', 1772764560),
(1614, 1048, 2062, 'App\\Models\\Webinar', NULL, 'a61c5350b9042b329563fcc9c4adcfb1029fbe53', 1772776341),
(1615, 1048, 2063, 'App\\Models\\Webinar', NULL, '4f423472b5ad47a5c1a998dcd77763034d4aa71e', 1772776342),
(1616, 1015, 2008, 'App\\Models\\Webinar', NULL, '4f423472b5ad47a5c1a998dcd77763034d4aa71e', 1772776343),
(1617, 1015, 2008, 'App\\Models\\Webinar', NULL, '2338745803b2840739d857dc517bfbcf9c7e96df', 1772798723),
(1618, 1015, 2008, 'App\\Models\\Webinar', NULL, '8ef4d1f53bbcd014556e19cf4704aa743f590897', 1772848685),
(1619, 1048, 2063, 'App\\Models\\Webinar', NULL, '33ede7ffa609d8045dcebd08743f47e5a1dd2e88', 1772918610),
(1620, 1129, 2064, 'App\\Models\\Webinar', 1129, 'd1ff6dc5d6c53b6eebc5b81043018669f2f67569', 1772935672),
(1621, 1129, 2064, 'App\\Models\\Webinar', 1129, '4e3f720ef8decf15320054ad3e42260cb59d1dd6', 1772939665),
(1622, 1129, 2065, 'App\\Models\\Webinar', 1129, 'a037c4e73610ff23955981800e73318ce0206e9c', 1772940550),
(1623, 1136, 2067, 'App\\Models\\Webinar', 1136, '8da7a4a78dc8a4033c7c1656f83fd50278c72fd2', 1772971140),
(1624, 1136, 2067, 'App\\Models\\Webinar', NULL, 'd86232fd91fc689f7efb87089aabd77669a7fc5f', 1773017337),
(1625, 1136, 2067, 'App\\Models\\Webinar', NULL, '342d7f40610c9b90abc7bd298a4c2e5f1945e7f9', 1773257058),
(1626, 1136, 2067, 'App\\Models\\Webinar', NULL, '70bbd86dfa46b4c2279281818f02975e64e22844', 1773322388),
(1627, 1, 6, 'App\\Models\\Product', NULL, 'f90e5d0c67eb9ca9aff9ebf0e71b38abf7f7fdd8', 1773330507),
(1628, 1136, 2067, 'App\\Models\\Webinar', NULL, '7b54f81f188a8abf3a3cb90a89fabd98b850d53d', 1773336555),
(1629, 1136, 2067, 'App\\Models\\Webinar', NULL, '7404474a8dfacb0b0cb9f473cc5ccc6963113266', 1773347027),
(1630, 1136, 2067, 'App\\Models\\Webinar', NULL, '102ee432e30e124547a8745eb7fd799f29fa9ed3', 1773367349),
(1631, 1136, 2067, 'App\\Models\\Webinar', NULL, '045966e31a7140c28b7c3af624c2d6c5f99eddf6', 1773379444),
(1632, 1136, 2067, 'App\\Models\\Webinar', NULL, '6576852a990bdd488cac0841bf5af53e5a42da46', 1773485361),
(1633, 1136, 2067, 'App\\Models\\Webinar', NULL, '972397309781edfb260ffcee244eb581879ce5f7', 1773547261),
(1634, 1136, 2067, 'App\\Models\\Webinar', NULL, 'b666b3c552bfd0b41ab531c7023ea455991cbb54', 1773776345),
(1635, 1136, 2067, 'App\\Models\\Webinar', NULL, '17ab04ef6d7d39c88e2ee6d0b1efb583a0493a96', 1773912970),
(1636, 1, 6, 'App\\Models\\Product', NULL, 'c17544c3ba381a2d2e46d0bb015c19777babde61', 1773935067),
(1637, 1136, 2067, 'App\\Models\\Webinar', NULL, '0f3222a11cdafd2ba746949fe1ba94fdac38dd99', 1773944108),
(1638, 1136, 2067, 'App\\Models\\Webinar', NULL, 'a9c61f4182cb21c885cf932084f30263d437bb3c', 1774070859),
(1639, 1136, 2067, 'App\\Models\\Webinar', NULL, '0cb55fb780d4e93fb7216ba5722992aaf21d757d', 1774103694),
(1640, 1136, 2067, 'App\\Models\\Webinar', NULL, '527cfc5bbfc2957648d65f41336bea9bbf661dad', 1774293163),
(1641, 1136, 2067, 'App\\Models\\Webinar', NULL, '0f7a0a5ecb81174255705e4f9af0f27bf7d9bba1', 1774304880),
(1642, 1136, 2067, 'App\\Models\\Webinar', NULL, '62d4292209733d66453c7d3a1426f755ba3e1048', 1774472875),
(1643, 1, 6, 'App\\Models\\Product', NULL, '7d90a6ac73623a4cbbf165f234297b330d95aa46', 1774540037),
(1644, 1136, 2067, 'App\\Models\\Webinar', NULL, 'e01cbabf8ae10c46cd555870841bf91033eaba97', 1774647659),
(1645, 1137, 2069, 'App\\Models\\Webinar', 1137, 'b0605087c90d624c476112086d6f7b7b4a135b60', 1774859342),
(1646, 1137, 2069, 'App\\Models\\Webinar', 1109, '9450bbba61ca5e9c1e3beb26e8f43836731a8dab', 1774859517),
(1647, 1137, 2070, 'App\\Models\\Webinar', 1139, 'b0605087c90d624c476112086d6f7b7b4a135b60', 1774860246),
(1648, 1137, 2069, 'App\\Models\\Webinar', 1139, 'e5fe8387a0143470f0313b12a582bd74f0471871', 1774860491),
(1649, 1137, 2070, 'App\\Models\\Webinar', 1139, 'e5fe8387a0143470f0313b12a582bd74f0471871', 1774860552),
(1650, 1137, 2070, 'App\\Models\\Webinar', NULL, '6f6c68e324c106f287b3f9212c6796363a453e07', 1774860555),
(1651, 1137, 2070, 'App\\Models\\Webinar', NULL, '0d3921cedf8ca87e49574532e27429c2aa7fe31e', 1774860556),
(1652, 1137, 2070, 'App\\Models\\Webinar', NULL, '8239c73f3629dddfe4303a18126f5a98b1f466f5', 1774860556),
(1653, 1137, 2069, 'App\\Models\\Webinar', NULL, '3214d6da1de96cdab974dca612cbdbed64a5933e', 1774900416),
(1654, 1137, 2069, 'App\\Models\\Webinar', NULL, '04a095e5d6686b0c53db864add740441cababc14', 1774931279),
(1655, 1137, 2070, 'App\\Models\\Webinar', NULL, '102ee432e30e124547a8745eb7fd799f29fa9ed3', 1774931281),
(1656, 1137, 2069, 'App\\Models\\Webinar', NULL, '37a7a9b8041e561812268f2b4acd5c9881772167', 1774941153),
(1657, 1137, 2069, 'App\\Models\\Webinar', NULL, '4977ff757cdfad28f3a0ca3f71a07d13b3f2033c', 1775012614),
(1658, 1137, 2070, 'App\\Models\\Webinar', NULL, '4311c41d24e9870d14ecf3a6fc4726d578aa4892', 1775017109),
(1659, 1137, 2069, 'App\\Models\\Webinar', 1139, '37a7a9b8041e561812268f2b4acd5c9881772167', 1775021381),
(1660, 1129, 2065, 'App\\Models\\Webinar', 1129, '37a7a9b8041e561812268f2b4acd5c9881772167', 1775022307),
(1661, 1129, 2064, 'App\\Models\\Webinar', 1129, '37a7a9b8041e561812268f2b4acd5c9881772167', 1775022343),
(1662, 1137, 2069, 'App\\Models\\Webinar', NULL, 'e691bb8e050404472b4a5d8e5d5d7415caaebe90', 1775073830),
(1663, 1137, 2069, 'App\\Models\\Webinar', NULL, '7af2d1e8ef405924f0c417323f11605d2096a39e', 1775383601),
(1664, 1137, 2070, 'App\\Models\\Webinar', NULL, '39f649cb08462bd3328b4f6e8af5e49d3af16e7b', 1775385063),
(1665, 1137, 2069, 'App\\Models\\Webinar', NULL, '6b4f6ca7b9f4a6d7577fa08106f32931f57ea741', 1775405345),
(1666, 1137, 2069, 'App\\Models\\Webinar', NULL, 'c168708e01c3eb0d385723c7054c921bab9b72d7', 1775452908),
(1667, 1137, 2070, 'App\\Models\\Webinar', NULL, '3b88385c894092e9844aa450e6a7adbd2da7792d', 1775472160),
(1668, 1137, 2069, 'App\\Models\\Webinar', NULL, '5742b0e0e0ae3b5f85dc148785483fe6d810617f', 1775482888),
(1669, 1137, 2070, 'App\\Models\\Webinar', NULL, '7693fa18c508451ab166c99bdd5b13a386c93279', 1775526497),
(1670, 1137, 2069, 'App\\Models\\Webinar', NULL, 'eb21c29fb319fe5a77c72678fe568dee7f3284b2', 1775531134),
(1671, 1137, 2069, 'App\\Models\\Webinar', NULL, '9f30c711069c61f6e5c8e7dbfdd6734906384e1e', 1775587785),
(1672, 1137, 2069, 'App\\Models\\Webinar', NULL, '9cb05d6922aa808611d12a7b0361f63b79094d6b', 1775589213),
(1673, 1137, 2070, 'App\\Models\\Webinar', NULL, '0cc0aef78c8eb8ce0794f5c18de10a59a9c6ebef', 1775640799),
(1674, 1137, 2069, 'App\\Models\\Webinar', NULL, '06b5065152f12619055eb67ab66f7825b15b6447', 1775640823),
(1675, 1137, 2069, 'App\\Models\\Webinar', NULL, 'b751d4c737547c6c86d37fce60a05fd9d3796800', 1775652547),
(1676, 1, 6, 'App\\Models\\Product', NULL, 'c9e438b33346c590ff6b702e144c07dd00baa47a', 1775664602),
(1677, 1137, 2070, 'App\\Models\\Webinar', NULL, '9b6fcccb367f6d1801518414bc1517a93f50bd05', 1775669818),
(1678, 1137, 2070, 'App\\Models\\Webinar', NULL, '0ce677a58e66d0ef888490619f475ff944a062e2', 1775706325),
(1679, 1137, 2069, 'App\\Models\\Webinar', NULL, 'ef72f848180f9204bb2cf7ae49173026493c2015', 1775712731),
(1680, 1137, 2070, 'App\\Models\\Webinar', NULL, 'bafda61fc02e7635701a216a6b0f9161be28e9c7', 1775712733),
(1681, 1137, 2069, 'App\\Models\\Webinar', NULL, '0e61d47a3b0a4ee0058f8bed4a33c24845593032', 1775717937),
(1682, 1137, 2069, 'App\\Models\\Webinar', NULL, 'e00b5a9291092b545858ed67fdc7af57badf8211', 1775763674),
(1683, 1137, 2070, 'App\\Models\\Webinar', NULL, '54a38eb3e5e37397a67fffcdfe2ddafe0091502a', 1775771129),
(1684, 1137, 2069, 'App\\Models\\Webinar', NULL, 'dfd993776c84a3e01b7db766afb378627c7b873b', 1775782977),
(1685, 1137, 2070, 'App\\Models\\Webinar', NULL, '98327e07ca1ec329b61792f656e2bb402e24a4a6', 1775811872),
(1686, 1137, 2069, 'App\\Models\\Webinar', NULL, '96d6df9558f14aef536959e3f0e5f20f4fe4f6e9', 1775827230),
(1687, 1137, 2069, 'App\\Models\\Webinar', NULL, '28292b4076d732c98404ba48bf0a6731336c2143', 1775987466),
(1688, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ed91105b88a772d1a702ff4b4d9a040aa0230a9b', 1776090849),
(1689, 1137, 2071, 'App\\Models\\Webinar', 1, '845d958e94b8a4eeea702e4564cb2fa6f2a83999', 1776097257),
(1690, 1, 9, 'App\\Models\\Product', NULL, '7cfa0c045226223976d443463ad494131b7753ac', 1776105152),
(1691, 1137, 2069, 'App\\Models\\Webinar', NULL, 'a69143c6bcd470c732bb69c3bfaef9061784b98b', 1776112427),
(1692, 1137, 2069, 'App\\Models\\Webinar', NULL, 'dfd8d18cd2849318c34943cb0b0522841637f005', 1776132926),
(1693, 1137, 2070, 'App\\Models\\Webinar', NULL, 'dfd8d18cd2849318c34943cb0b0522841637f005', 1776146627),
(1694, 1137, 2069, 'App\\Models\\Webinar', NULL, '15efa07764a4179ca0ef29810ae18151c107cba3', 1776169864),
(1695, 1137, 2070, 'App\\Models\\Webinar', NULL, '760dd9101c4e5fdafff6bd0ce3591a964301036d', 1776169867),
(1696, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ff9818edd4e2dd2048df4cd8b62ea896b6fb7725', 1776173001),
(1697, 1137, 2069, 'App\\Models\\Webinar', 1113, 'ce170d0dac9ea01ead992b419ee5f511da97b5a7', 1776190871),
(1698, 1137, 2070, 'App\\Models\\Webinar', 1140, '55b08ef3a240036b048b4729d29e5de93208bda5', 1776193309),
(1699, 1137, 2069, 'App\\Models\\Webinar', NULL, '72def455db516f43e4ebdab16c4c3a3621c2bf4e', 1776245736),
(1700, 1137, 2069, 'App\\Models\\Webinar', NULL, 'ef84d469f769b0a1c3e73dc8194ea2f85d8974f3', 1776256330),
(1701, 1137, 2069, 'App\\Models\\Webinar', NULL, 'e2f965c4550bb681a7a5c174cb2b711f833f591a', 1776266110),
(1702, 1137, 2069, 'App\\Models\\Webinar', NULL, '228e5e9431ac168890d260e40cf0deed1cac83a7', 1776288906),
(1703, 1137, 2070, 'App\\Models\\Webinar', 1140, '0665bb135f1c7cab6101085889e7e40c7fc985e3', 1776351811),
(1704, 1137, 2069, 'App\\Models\\Webinar', NULL, '7202156a64e9054188a7fbf7b4c1b4244fbc8138', 1776396108),
(1705, 1137, 2070, 'App\\Models\\Webinar', NULL, 'c17d5357012eeaeb83e9b6938301edb358e10bd8', 1776425174),
(1706, 1137, 2069, 'App\\Models\\Webinar', NULL, '9e37dcbd29273967e5d346ebfdd696200a316329', 1776481535),
(1707, 1137, 2069, 'App\\Models\\Webinar', NULL, '7077d0825cf71baf77c62c8808d917ba9f5d6598', 1776482676),
(1708, 1137, 2070, 'App\\Models\\Webinar', NULL, '802a37d5bd4dcdc0d9cd67e44d8003f5829af091', 1776558989),
(1709, 1137, 2069, 'App\\Models\\Webinar', NULL, 'be15a621df50973b42709a514d18ce2c9cadf3ec', 1776563824),
(1710, 1137, 2070, 'App\\Models\\Webinar', 1140, 'ee14d3a9961d873d9e84cf225f12d5b5747f7e0f', 1776618563),
(1711, 1137, 2069, 'App\\Models\\Webinar', NULL, '867746a618601ad34d193d18d6659cff657f93f4', 1776664657),
(1712, 1137, 2069, 'App\\Models\\Webinar', NULL, '46d703b6fc8d36d7c4388654728b738504205fbb', 1776758866),
(1713, 1137, 2069, 'App\\Models\\Webinar', NULL, '68cadea9102738c6de5412092aab6f2ba817b82c', 1776850113),
(1714, 1137, 2069, 'App\\Models\\Webinar', NULL, 'ef7124a20cc8c83c985aef804bd2a168da47ac28', 1777085993),
(1715, 1137, 2070, 'App\\Models\\Webinar', NULL, '1fb2768486bed36ec6a618a820c661e423e2156d', 1777085996),
(1716, 1137, 2072, 'App\\Models\\Webinar', 1, '0427a7a59d679c5bd9574d1d6ea4bbb214842954', 1777144899),
(1717, 1137, 2071, 'App\\Models\\Webinar', 1137, '4836987fc2c7ad36f23ed29007f08801456ac6f8', 1777174389),
(1718, 1137, 2072, 'App\\Models\\Webinar', 1137, '4836987fc2c7ad36f23ed29007f08801456ac6f8', 1777174404),
(1719, 1137, 2070, 'App\\Models\\Webinar', 1137, '8d39f9b89da3dae48faa0300c4dd89b9f86f2667', 1777272650),
(1720, 1137, 2070, 'App\\Models\\Webinar', NULL, 'c3ba5fa05b723e63fb281922aa2ed1cce91de4b6', 1777284614),
(1721, 1137, 2069, 'App\\Models\\Webinar', NULL, 'c9cfb3583b44d7d39f5730bdaea2a5c7f4bd5b62', 1777458776),
(1722, 1137, 2070, 'App\\Models\\Webinar', NULL, '82d684a16d6800ed9a9d0a7fa5648ccc8c6df7f7', 1777461583),
(1723, 1137, 2069, 'App\\Models\\Webinar', NULL, '9d45dce79459031302e110886dd6bc459b1114e1', 1777491772),
(1724, 1137, 2070, 'App\\Models\\Webinar', NULL, '9d45dce79459031302e110886dd6bc459b1114e1', 1777491774),
(1725, 1137, 2070, 'App\\Models\\Webinar', NULL, '14efefff8b8c94ea637e4a1659ae154cf9e738a3', 1777498612),
(1726, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ee085a29339d7499e3d0911ff49abd96c545ac7a', 1777543900),
(1727, 1137, 2069, 'App\\Models\\Webinar', NULL, '491eef8af24949edecc05b53ae94e1d178a7f00e', 1777639593),
(1728, 1137, 2070, 'App\\Models\\Webinar', NULL, '48d5f6452e9e93572aae611a364f5335e26d6b5e', 1777639596),
(1729, 1, 9, 'App\\Models\\Product', NULL, '7de4a03a34e6cdeeff7c92539252d78341cdd151', 1777667326),
(1730, 1137, 2069, 'App\\Models\\Webinar', NULL, '3bcb71ea5cba18b7d87e5ea9ee604e1c9e3f375c', 1777671791),
(1731, 1137, 2069, 'App\\Models\\Webinar', NULL, 'b84f4527c02ca7aeac13294af7d47461e0c06d41', 1777673463),
(1732, 1137, 2069, 'App\\Models\\Webinar', NULL, '07690899cf41881aa586c5e8f08ef6ff12e4bbb4', 1777733204),
(1733, 1137, 2070, 'App\\Models\\Webinar', NULL, 'dafd6d79779d2f273b6cd493bf124326933f6669', 1777767722),
(1734, 1137, 2069, 'App\\Models\\Webinar', NULL, 'cf2007b1c1b0039864a2f805f091b9b745fa6f0e', 1777802482),
(1735, 1137, 2072, 'App\\Models\\Webinar', 1137, 'd05fb7819dd26ec46801911d37e5b4a4c4618080', 1777825955),
(1736, 1137, 2070, 'App\\Models\\Webinar', NULL, '82d684a16d6800ed9a9d0a7fa5648ccc8c6df7f7', 1777829725),
(1737, 1137, 2069, 'App\\Models\\Webinar', NULL, '82d684a16d6800ed9a9d0a7fa5648ccc8c6df7f7', 1777830025),
(1738, 1137, 2069, 'App\\Models\\Webinar', NULL, 'bf60816dedecc076f880119d37c404fe1c0c897e', 1777834728),
(1739, 1137, 2070, 'App\\Models\\Webinar', NULL, 'bf60816dedecc076f880119d37c404fe1c0c897e', 1777834735),
(1740, 1137, 2069, 'App\\Models\\Webinar', NULL, 'ef7124a20cc8c83c985aef804bd2a168da47ac28', 1777847729),
(1741, 1137, 2070, 'App\\Models\\Webinar', NULL, 'b3f0a5cf4db25189a8803de49f6293b5c58645ce', 1777847732),
(1742, 1137, 2069, 'App\\Models\\Webinar', NULL, 'b3f0a5cf4db25189a8803de49f6293b5c58645ce', 1777935895),
(1743, 1137, 2070, 'App\\Models\\Webinar', NULL, 'a4be9cf1b52bb52820b2ee925b4c3711168b7964', 1777935898),
(1744, 1137, 2069, 'App\\Models\\Webinar', NULL, '9b6195413fdc8e19bac475af807157b486a62b92', 1777944820),
(1745, 1137, 2069, 'App\\Models\\Webinar', NULL, 'cfd5c2d1f9fc17cb976930dd3aa5325c21c3e3b2', 1777967878),
(1746, 1137, 2070, 'App\\Models\\Webinar', NULL, 'cfd5c2d1f9fc17cb976930dd3aa5325c21c3e3b2', 1777971224),
(1747, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ff9818edd4e2dd2048df4cd8b62ea896b6fb7725', 1777997554),
(1748, 1137, 2069, 'App\\Models\\Webinar', NULL, '10f3937f6e07d51e37561956cdb9aacc9c4004e8', 1778048796),
(1749, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ee33ab087f4f37daafd1870bd477de91a68f803c', 1778048799),
(1750, 1, 6, 'App\\Models\\Product', NULL, 'f4c370a76ac41ef17055158bebb45245a55669bd', 1778051114),
(1751, 1137, 2069, 'App\\Models\\Webinar', NULL, '8577f72c9b9592a8596878a9a167485821bac737', 1778108134),
(1752, 1137, 2069, 'App\\Models\\Webinar', NULL, 'ad4e3e22256c65163d8b4dbd8a6f0ce91fde13ca', 1778108159),
(1753, 1137, 2069, 'App\\Models\\Webinar', NULL, '9db941bd0109d044ea72cbb697aca6cf22d2d215', 1778119645),
(1754, 1137, 2069, 'App\\Models\\Webinar', NULL, '5e0ae9e2d095233e620bd56924a2b4fb87077103', 1778130697),
(1755, 1137, 2070, 'App\\Models\\Webinar', NULL, '190df0092af4f1262b15bcf561f21ad5ef8c47ea', 1778130700),
(1756, 1137, 2070, 'App\\Models\\Webinar', NULL, 'ff29c66e560de5081f4e6d096bc08b6125c29c76', 1778135974),
(1757, 1137, 2069, 'App\\Models\\Webinar', NULL, '817696e6ae41f41414bd128b58f8baee3725221d', 1778139318),
(1758, 1137, 2069, 'App\\Models\\Webinar', NULL, 'c88667a49d6b1cbc473143115e8e8f4d52c5a235', 1778143997);

-- --------------------------------------------------------

--
-- Structure de la table `waitlists`
--

CREATE TABLE `waitlists` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinars`
--

CREATE TABLE `webinars` (
  `id` int(10) UNSIGNED NOT NULL,
  `teacher_id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('webinar','course','text_lesson') NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `slug` varchar(255) NOT NULL,
  `start_date` int(11) DEFAULT NULL,
  `duration` int(10) UNSIGNED DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `image_cover` varchar(255) DEFAULT NULL,
  `video_demo` varchar(255) DEFAULT NULL,
  `video_demo_source` enum('upload','youtube','vimeo','external_link','google_drive','iframe','s3','secure_host') DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `sales_count_number` int(10) UNSIGNED DEFAULT NULL,
  `price` double(15,2) UNSIGNED DEFAULT NULL,
  `organization_price` double(15,2) UNSIGNED DEFAULT NULL,
  `support` tinyint(1) DEFAULT 0,
  `certificate` tinyint(1) NOT NULL DEFAULT 0,
  `downloadable` tinyint(1) DEFAULT 0,
  `partner_instructor` tinyint(1) DEFAULT 0,
  `subscribe` tinyint(1) DEFAULT 0,
  `forum` tinyint(1) NOT NULL DEFAULT 0,
  `enable_waitlist` tinyint(1) NOT NULL DEFAULT 0,
  `only_for_students` tinyint(1) NOT NULL DEFAULT 0,
  `access_days` int(10) UNSIGNED DEFAULT NULL COMMENT 'Number of days to access the course',
  `points` int(11) DEFAULT NULL,
  `message_for_reviewer` text DEFAULT NULL,
  `status` enum('active','pending','is_draft','inactive') NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `webinars`
--

INSERT INTO `webinars` (`id`, `teacher_id`, `creator_id`, `category_id`, `type`, `private`, `slug`, `start_date`, `duration`, `timezone`, `thumbnail`, `image_cover`, `video_demo`, `video_demo_source`, `icon`, `capacity`, `sales_count_number`, `price`, `organization_price`, `support`, `certificate`, `downloadable`, `partner_instructor`, `subscribe`, `forum`, `enable_waitlist`, `only_for_students`, `access_days`, `points`, `message_for_reviewer`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2064, 1129, 1129, NULL, 'text_lesson', 0, 'باقة-متكاملة-للتربوي-العام', NULL, NULL, NULL, '/store/1129/webinars/2064/thumbnail.jpg', '/store/1129/webinars/2064/image_cover.jpg', NULL, NULL, '/store/1129/webinars/2064/icon.jpg', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 'is_draft', 1772490706, 1772558311, NULL),
(2065, 1129, 1129, NULL, 'course', 0, 'دورة-الإدارة-الصفية', NULL, NULL, NULL, '/store/1129/webinars/2065/thumbnail.jpeg', '/store/1129/webinars/2065/image_cover.jpeg', NULL, NULL, '/store/1129/webinars/2065/icon.jpeg', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 'is_draft', 1772940544, NULL, NULL),
(2068, 1138, 1138, NULL, 'course', 0, 'الاستشارات', NULL, NULL, NULL, '/store/1138/webinars/2068/thumbnail.jpg', '/store/1138/webinars/2068/image_cover.png', 'https://youtu.be/C-ijVG9Pbnw?si=sRv-ukNA-7xOCe9_', 'youtube', '/store/1138/webinars/2068/icon.png', NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 'is_draft', 1774857669, NULL, NULL),
(2069, 1137, 1137, 612, 'course', 0, 'استشارات', NULL, 5, NULL, '/store/1137/webinars/2069/thumbnail.png', '/store/1137/webinars/2069/image_cover.png', 'https://youtu.be/C-ijVG9Pbnw?si=_deR5lSE51elO9c7', 'youtube', '/store/1137/webinars/2069/icon.png', 10, NULL, 1.00, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 30, NULL, NULL, 'active', 1774858394, 1774860053, NULL),
(2070, 1137, 1137, 612, 'course', 0, 'استشارات-نسخ', NULL, 5, NULL, '/store/1137/webinars/2069/thumbnail.png', '/store/1137/webinars/2069/image_cover.png', 'https://youtu.be/C-ijVG9Pbnw?si=_deR5lSE51elO9c7', 'youtube', '/store/1137/webinars/2069/icon.png', 10, NULL, 1.00, NULL, 0, 0, 1, 0, 0, 0, 0, 0, 30, NULL, NULL, 'active', 1774860187, 1774860204, NULL),
(2071, 1137, 1137, 614, 'course', 0, 'goahead', 1776373200, 60, 'Asia/Riyadh', '/store/1/unnamed.png', '/store/1/icon.png', 'https://www.youtube.com/watch?v=dScrtqm11ME', 'youtube', '/store/1/dashboard.png', NULL, NULL, 10.00, NULL, 1, 1, 0, 0, 0, 0, 0, 0, 5, 500, 'احتاج اضيف الماتريال', 'inactive', 1776097193, 1776097620, NULL),
(2072, 1137, 1137, 614, 'webinar', 0, 'التسويق-الرقمي', 1777064400, 60, 'Asia/Riyadh', '/store/1/dashboard.png', '/store/1/1.jpeg', 'marketing', 'upload', NULL, 50, 50, 50.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 6, 500, NULL, 'is_draft', 1777144822, 1777826475, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `webinar_assignments`
--

CREATE TABLE `webinar_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `chapter_id` int(10) UNSIGNED NOT NULL,
  `grade` int(10) UNSIGNED DEFAULT NULL,
  `pass_grade` int(10) UNSIGNED DEFAULT NULL,
  `deadline` int(10) UNSIGNED DEFAULT NULL,
  `attempts` int(10) UNSIGNED DEFAULT NULL,
  `check_previous_parts` tinyint(1) NOT NULL DEFAULT 0,
  `access_after_day` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_assignment_attachments`
--

CREATE TABLE `webinar_assignment_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `assignment_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `attach` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_assignment_history`
--

CREATE TABLE `webinar_assignment_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `instructor_id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `assignment_id` int(10) UNSIGNED NOT NULL,
  `grade` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('pending','passed','not_passed','not_submitted') NOT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_assignment_history_messages`
--

CREATE TABLE `webinar_assignment_history_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `assignment_history_id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `file_title` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_assignment_translations`
--

CREATE TABLE `webinar_assignment_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `webinar_assignment_id` int(10) UNSIGNED NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_chapters`
--

CREATE TABLE `webinar_chapters` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `check_all_contents_pass` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_chapters`
--

INSERT INTO `webinar_chapters` (`id`, `user_id`, `webinar_id`, `order`, `check_all_contents_pass`, `status`, `created_at`) VALUES
(150, 1129, 2064, NULL, 0, 'active', 1772490906),
(151, 1129, 2064, NULL, 0, 'active', 1772490930),
(155, 1137, 2069, NULL, 0, 'active', 1774858574),
(156, 1137, 2072, NULL, 0, 'active', 1777145363),
(157, 1137, 2072, NULL, 0, 'active', 1777145489);

-- --------------------------------------------------------

--
-- Structure de la table `webinar_chapter_items`
--

CREATE TABLE `webinar_chapter_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `chapter_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `type` enum('file','session','text_lesson','quiz','assignment') NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_chapter_items`
--

INSERT INTO `webinar_chapter_items` (`id`, `user_id`, `chapter_id`, `item_id`, `type`, `order`, `created_at`) VALUES
(221, 1129, 151, 43, 'quiz', 1, 1772491061),
(224, 1137, 155, 96, 'file', 1, 1774858836),
(225, 1137, 155, 45, 'quiz', 2, 1774859004),
(226, 1137, 156, 105, 'session', 1, 1777151102),
(227, 1137, 156, 106, 'session', 2, 1777826151);

-- --------------------------------------------------------

--
-- Structure de la table `webinar_chapter_translations`
--

CREATE TABLE `webinar_chapter_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `webinar_chapter_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_chapter_translations`
--

INSERT INTO `webinar_chapter_translations` (`id`, `webinar_chapter_id`, `locale`, `title`) VALUES
(190, 150, 'ar', 'رابط الكتيب ( لتبسيط المعاني التربوية )'),
(191, 151, 'ar', 'رابط الأسئلة'),
(195, 155, 'ar', 'استشارات'),
(196, 156, 'ar', 'المحاضرة الاولي'),
(197, 157, 'ar', 'المحاضرة الثانية');

-- --------------------------------------------------------

--
-- Structure de la table `webinar_extra_descriptions`
--

CREATE TABLE `webinar_extra_descriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `upcoming_course_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('learning_materials','company_logos','requirements') NOT NULL,
  `order` int(10) UNSIGNED DEFAULT NULL,
  `created_at` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_extra_descriptions`
--

INSERT INTO `webinar_extra_descriptions` (`id`, `creator_id`, `webinar_id`, `upcoming_course_id`, `type`, `order`, `created_at`) VALUES
(695, 1129, 2064, NULL, 'company_logos', 1, 1772491007);

-- --------------------------------------------------------

--
-- Structure de la table `webinar_extra_description_translations`
--

CREATE TABLE `webinar_extra_description_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `webinar_extra_description_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_extra_description_translations`
--

INSERT INTO `webinar_extra_description_translations` (`id`, `webinar_extra_description_id`, `locale`, `value`) VALUES
(695, 695, 'ar', '/store/1129/webinars/2064/IFcF58_1772491007.jpeg');

-- --------------------------------------------------------

--
-- Structure de la table `webinar_filter_option`
--

CREATE TABLE `webinar_filter_option` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `filter_option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_partner_teacher`
--

CREATE TABLE `webinar_partner_teacher` (
  `id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `teacher_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_reports`
--

CREATE TABLE `webinar_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_reviews`
--

CREATE TABLE `webinar_reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `creator_id` int(10) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED DEFAULT NULL,
  `bundle_id` int(10) UNSIGNED DEFAULT NULL,
  `content_quality` int(10) UNSIGNED NOT NULL,
  `instructor_skills` int(10) UNSIGNED NOT NULL,
  `purchase_worth` int(10) UNSIGNED NOT NULL,
  `support_quality` int(10) UNSIGNED NOT NULL,
  `rates` char(10) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','active') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `webinar_translations`
--

CREATE TABLE `webinar_translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `webinar_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `seo_description` text DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `webinar_translations`
--

INSERT INTO `webinar_translations` (`id`, `webinar_id`, `locale`, `title`, `seo_description`, `summary`, `description`) VALUES
(174, 2064, 'ar', 'باقة متكاملة للتربوي العام', NULL, 'هذا البكج يشمل الاختبار التربوي العام بطريقة مختلفة ومتنوعة، حيث يتم شرح جميع محاضرات التدريس المصغر في 55 صفحة كاملة.\r\n\r\n(مثال: إذا كان المعيار الأول والثاني والثالث في مكان آخر 30 صفحة، نقدمها لكم في 8 صفحات فقط)\r\n\r\n\r\n\r\n\r\n\r\nمميزات البكج:\r\n55 صفحة تعليمية مقسمة على 12 محاضرة مختصرة وشاملة\r\n12 مقطع فيديو شرح\r\nكتيب أسئلة تربوية\r\nشرح ربط المعايير بالأسئلة\r\nتحليل الدروس والمواقف التربوية\r\nتقديم المعلومات بطرق متنوعة لفهم أعمق وأكثر فعالية\r\nضمان الاشتراك', '<p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\">مؤجز ثري – بكج متكامل يغنيك عن أي مرجع آخر!</p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\">هذا البكج يشمل <span style=\"background-color: rgb(246, 235, 188);\">الاختبار التربوي العام</span> بطريقة مختلفة ومتنوعة، حيث يتم شرح جميع محاضرات التدريس المصغر في 55 صفحة كاملة.</p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><em>(مثال: إذا كان المعيار الأول والثاني والثالث في مكان آخر 30 صفحة، نقدمها لكم في 8 صفحات فقط)</em></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><h3 style=\"font-family: inherit; font-weight: 500; line-height: 1.53846; color: inherit; font-size: 1.17em; letter-spacing: -0.015em; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><span style=\"font-family: PingARLT, serif; background-color: rgb(246, 231, 189);\">مميزات البكج:</span></h3><ul style=\"font-family: PingARLT, serif; padding-left: 1.5em; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><li style=\"padding-left: 1.5em;\">55 صفحة تعليمية مقسمة على 12 محاضرة مختصرة وشاملة</li><li style=\"padding-left: 1.5em;\">12 مقطع فيديو شرح</li><li style=\"padding-left: 1.5em;\">كتيب أسئلة تربوية</li><li style=\"padding-left: 1.5em;\">شرح ربط المعايير بالأسئلة</li><li style=\"padding-left: 1.5em;\">تحليل الدروس والمواقف التربوية</li><li style=\"padding-left: 1.5em;\">تقديم المعلومات بطرق متنوعة لفهم أعمق وأكثر فعالية</li><li style=\"padding-left: 1.5em;\">ضمان الاشتراك</li></ul><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><h3 style=\"font-family: inherit; font-weight: 500; line-height: 1.53846; color: inherit; font-size: 1.17em; letter-spacing: -0.015em; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><span style=\"font-family: PingARLT, serif; background-color: rgb(249, 235, 195);\">طريقة التسجيل:</span></h3><ol style=\"font-family: PingARLT, serif; padding-left: 1.5em; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0;\"><li style=\"padding-left: 1.5em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; counter-increment: list-0 1;\">الدخول إلى الموقع الإلكتروني.</li><li style=\"padding-left: 1.5em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; counter-increment: list-0 1;\">بعد الشراء، يفتح الطلب تلقائيًا.</li><li style=\"padding-left: 1.5em; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; counter-increment: list-0 1;\">اضغط تنفيذ ثم تنزيل رابط قناة المحتوى الرقمي بضغطه واحدة.</li></ol><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\">📌 ملاحظة هامة</p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\">للدعم الفني أو للاستفسارات والمساعدة يرجى التواصل على الرقم:</p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><a href=\"https://ttowardss.com/whatsapp/send\" target=\"_blank\" style=\"background-color: rgb(243, 244, 246); text-decoration-line: underline; cursor: pointer; outline-style: initial; outline-width: 0px;\">+966502117367</a></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><a href=\"https://t.me/mnmd2030/16556\" target=\"_blank\" style=\"background-color: transparent; text-decoration-line: underline; cursor: pointer; outline-style: initial; outline-width: 0px;\">https://t.me/mnmd2030/16556</a></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><a href=\"https://ttowardss.com/\" target=\"_blank\" style=\"background-color: transparent; color: rgb(0, 102, 204); text-decoration-line: underline; cursor: pointer; outline-style: initial; outline-width: 0px;\">منصة نحو القمة منتجات الرقمية</a></p><p style=\"font-family: PingARLT, serif; cursor: text; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; line-height: 1.8;\"><br style=\"color: rgb(68, 68, 68); font-size: 13px; white-space-collapse: preserve;\"></p>'),
(175, 2065, 'ar', 'دورة الإدارة الصفية', 'دورة الإدارة الصفية تهدف إلى تعليم المعلم أو المدرب كيفية تنظيم الصف وإدارته بطريقة تساعد على تحقيق أفضل بيئة تعليمية ممكنة.', 'تناولت الدورة مفهوم الإدارة الصفية وأهميتها في تحقيق بيئة تعليمية منظمة ومحفزة للتعلم، كما استعرضت مجموعة من الأساليب والاستراتيجيات التي تساعد المعلم على تنظيم الصف وضبط سلوك الطلاب وإدارة الوقت داخل الحصة الدراسية بفعالية. وركزت الدورة كذلك على تعزيز التفاعل والمشاركة بين الطلاب، وبناء علاقة إيجابية بين المعلم وطلابه بما يسهم في تحسين عملية التعلم ورفع مستوى التحصيل الدراسي.', '<ul data-start=\"199\" data-end=\"500\"><li data-section-id=\"6pnqwt\" data-start=\"199\" data-end=\"233\"><p data-start=\"201\" data-end=\"233\"><strong data-start=\"201\" data-end=\"216\">اسم الدورة:</strong> الإدارة الصفية</p>\r\n</li>\r\n<li data-section-id=\"1xj7b7a\" data-start=\"234\" data-end=\"277\">\r\n<p data-start=\"236\" data-end=\"277\"><strong data-start=\"236\" data-end=\"252\">مجال الدورة:</strong> التطوير المهني التربوي</p>\r\n</li>\r\n<li data-section-id=\"11dtgdq\" data-start=\"278\" data-end=\"345\">\r\n<p data-start=\"280\" data-end=\"345\"><strong data-start=\"280\" data-end=\"300\">الفئة المستهدفة:</strong> المعلمون والمعلمات وطلاب التخصصات التربوية</p>\r\n</li>\r\n<li data-section-id=\"1gvy5f1\" data-start=\"346\" data-end=\"397\">\r\n<p data-start=\"348\" data-end=\"397\"><strong data-start=\"348\" data-end=\"363\">مدة الدورة:</strong> 30 ساعة تدريبية</p>\r\n</li>\r\n<li data-section-id=\"1rw51cr\" data-start=\"398\" data-end=\"447\">\r\n<p data-start=\"400\" data-end=\"447\"><strong data-start=\"400\" data-end=\"416\">جهة التنفيذ:</strong> شركة سمات للاستشارات والتطوير</p>\r\n</li>\r\n<li data-section-id=\"872s8v\" data-start=\"448\" data-end=\"500\">\r\n<p data-start=\"450\" data-end=\"500\"><strong data-start=\"450\" data-end=\"468\">تاريخ التنفيذ:</strong> 8 مارس</p>\r\n</li>\r\n</ul><hr data-start=\"502\" data-end=\"505\"><h2 data-section-id=\"kn6s6d\" data-start=\"507\" data-end=\"520\">وصف الدورة</h2><p data-start=\"521\" data-end=\"892\">تهدف دورة الإدارة الصفية إلى تنمية مهارات المعلمين في إدارة وتنظيم الصف الدراسي بطريقة فعّالة تسهم في خلق بيئة تعليمية إيجابية ومحفزة للتعلم. كما تركز الدورة على تزويد المعلمين بالاستراتيجيات الحديثة للتعامل مع سلوكيات الطلاب المختلفة، وتنظيم الوقت داخل الحصة الدراسية، وتعزيز التفاعل والمشاركة بين الطلاب، بما يحقق أهداف العملية التعليمية ويرفع من مستوى التحصيل الدراسي.</p><hr data-start=\"894\" data-end=\"897\"><h2 data-section-id=\"16vj7sk\" data-start=\"899\" data-end=\"914\">أهداف الدورة</h2><ul data-start=\"915\" data-end=\"1246\">\r\n<li data-section-id=\"1jg0lj0\" data-start=\"915\" data-end=\"981\">\r\n<p data-start=\"917\" data-end=\"981\">التعرف على مفهوم الإدارة الصفية وأهميتها في العملية التعليمية.</p>\r\n</li>\r\n<li data-section-id=\"1fyzmxt\" data-start=\"982\" data-end=\"1029\">\r\n<p data-start=\"984\" data-end=\"1029\">تنمية مهارات المعلم في تنظيم البيئة الصفية.</p>\r\n</li>\r\n<li data-section-id=\"90pdu3\" data-start=\"1030\" data-end=\"1076\">\r\n<p data-start=\"1032\" data-end=\"1076\">اكتساب استراتيجيات فعالة لضبط سلوك الطلاب.</p>\r\n</li>\r\n<li data-section-id=\"1sni03l\" data-start=\"1077\" data-end=\"1127\">\r\n<p data-start=\"1079\" data-end=\"1127\">تحسين مهارات إدارة الوقت أثناء الحصة الدراسية.</p>\r\n</li>\r\n<li data-section-id=\"1rdad18\" data-start=\"1128\" data-end=\"1177\">\r\n<p data-start=\"1130\" data-end=\"1177\">تعزيز التفاعل والمشاركة الإيجابية بين الطلاب.</p>\r\n</li>\r\n<li data-section-id=\"126mf1a\" data-start=\"1178\" data-end=\"1246\">\r\n<p data-start=\"1180\" data-end=\"1246\">بناء علاقة إيجابية قائمة على الاحترام المتبادل بين المعلم والطلاب.</p>\r\n</li>\r\n</ul><hr data-start=\"1248\" data-end=\"1251\"><h2 data-section-id=\"mum8bz\" data-start=\"1253\" data-end=\"1268\">محاور الدورة</h2><p>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n</p><ol data-start=\"1269\" data-end=\"1742\">\r\n<li data-section-id=\"10jpu5w\" data-start=\"1269\" data-end=\"1334\">\r\n<p data-start=\"1272\" data-end=\"1334\"><strong data-start=\"1272\" data-end=\"1305\">مفهوم الإدارة الصفية وأهميتها</strong> في تحسين البيئة التعليمية.</p>\r\n</li>\r\n<li data-section-id=\"5t530y\" data-start=\"1335\" data-end=\"1412\">\r\n<p data-start=\"1338\" data-end=\"1412\"><strong data-start=\"1338\" data-end=\"1361\">تنظيم البيئة الصفية</strong> (ترتيب المقاعد – توزيع الأدوار – تنظيم الأدوات).</p>\r\n</li>\r\n<li data-section-id=\"45ud8t\" data-start=\"1413\" data-end=\"1473\">\r\n<p data-start=\"1416\" data-end=\"1473\"><strong data-start=\"1416\" data-end=\"1442\">استراتيجيات ضبط السلوك</strong> والتعامل مع المشكلات الصفية.</p>\r\n</li>\r\n<li data-section-id=\"wbaebs\" data-start=\"1474\" data-end=\"1549\">\r\n<p data-start=\"1477\" data-end=\"1549\"><strong data-start=\"1477\" data-end=\"1512\">إدارة الوقت داخل الحصة الدراسية</strong> لتحقيق أفضل استفادة من وقت التعلم.</p>\r\n</li>\r\n<li data-section-id=\"1k5xc44\" data-start=\"1550\" data-end=\"1626\">\r\n<p data-start=\"1553\" data-end=\"1626\"><strong data-start=\"1553\" data-end=\"1592\">تحفيز الطلاب وتعزيز المشاركة الصفية</strong> باستخدام أساليب تعليمية متنوعة.</p>\r\n</li>\r\n<li data-section-id=\"penzo\" data-start=\"1627\" data-end=\"1687\">\r\n<p data-start=\"1630\" data-end=\"1687\"><strong data-start=\"1630\" data-end=\"1656\">بناء بيئة صفية إيجابية</strong> قائمة على الاحترام والتعاون.</p>\r\n</li>\r\n<li data-section-id=\"1vfjp9s\" data-start=\"1688\" data-end=\"1742\">\r\n<p data-start=\"1691\" data-end=\"1742\"><strong data-start=\"1691\" data-end=\"1731\">التعامل مع الفروق الفردية بين الطلاب</strong> داخل الصف.</p>\r\n</li>\r\n</ol>'),
(178, 2068, 'ar', 'الاستشارات', 'لشاغلي الوظائف التعليمية', 'لماذا الاستشارات تكلفتها عالية', '<p>لماذا الاستشارات تكلفتها عالية</p>'),
(179, 2069, 'ar', 'استشارات', 'استشارات تعليمية', 'لماذا الاستشارات تكلفتها عالية', '<p>لماذا الاستشارات تكلفتها عالية</p>'),
(180, 2070, 'ar', 'استشارات نسخ', 'استشارات تعليمية', 'ghhjk', '<p>لماذا الاستشارات تكلفتها عالية</p>'),
(181, 2071, 'ar', 'التواصل الفعال', NULL, 'الاخوة الزملاء في سمات الاستشارية \r\nالسلام عليكم ورحمة الله وبركاته،،\r\nأشكركم شكرا جميلا  على إرسال عقد التعاون الاستشاري، وعلى ما أبديتموه من تعاون وتنسيق خلال الفترة الماضية.\r\nأفيدكم بالموافقة على العقد بصيغته الحالية، مع التأكيد على أهمية تضمين خطة تشغيلية واضحة ومفصلة لمنصة سمات بلس، بحيث تكون مرجعًا فنيًا معتمدًا للتعاقد، وذلك ضمانًا لوضوح نطاق العمل، وآلية التنفيذ، والجوانب التشغيلية والفنية ذات العلاقة. مع الافادة انني بدأت العمل على جدول مهام مرفق مع هذه الرسالة كسبا للوقت \r\nكما يمكن ايضا بدء الاجراءات النظامية المرتبطة بالعقد لحين اكتمال بقية الجوانب الفنية للاعمال \r\nشاكرًا ومقدرًا لكم تعاونكم،\r\nوتفضلوا بقبول خالص التحية والتقدير،،', '<p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">الاخوة\r\nالزملاء في سمات الاستشارية <o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">السلام\r\nعليكم ورحمة الله وبركاته،،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">أشكركم\r\nشكرا جميلا  على إرسال عقد التعاون\r\nالاستشاري، وعلى ما أبديتموه من تعاون وتنسيق خلال الفترة الماضية</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.<o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">أفيدكم\r\nبالموافقة على العقد بصيغته الحالية، مع التأكيد على أهمية تضمين خطة <b>تشغيلية\r\nواضحة ومفصلة لمنصة سمات بلس</b>، بحيث تكون <b>مرجعًا فنيًا معتمدًا للتعاقد</b>،\r\nوذلك ضمانًا لوضوح نطاق العمل، وآلية التنفيذ، والجوانب التشغيلية والفنية ذات\r\nالعلاقة</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.</span><span dir=\"RTL\"></span><span dir=\"RTL\"></span><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"RTL\"></span><span dir=\"RTL\"></span> مع الافادة انني بدأت العمل على جدول مهام مرفق مع هذه الرسالة كسبا\r\nللوقت <o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">كما\r\nيمكن ايضا بدء الاجراءات النظامية المرتبطة بالعقد لحين اكتمال بقية الجوانب\r\nالفنية للاعمال </span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">شاكرًا\r\nومقدرًا لكم تعاونكم،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><br>\r\n</span><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">وتفضلوا\r\nبقبول خالص التحية والتقدير،،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n</p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p> </o:p></span></p>'),
(182, 2071, 'en', 'التواصل الفعال', NULL, 'الاخوة الزملاء في سمات الاستشارية \r\nالسلام عليكم ورحمة الله وبركاته،،\r\nأشكركم شكرا جميلا  على إرسال عقد التعاون الاستشاري، وعلى ما أبديتموه من تعاون وتنسيق خلال الفترة الماضية.\r\nأفيدكم بالموافقة على العقد بصيغته الحالية، مع التأكيد على أهمية تضمين خطة تشغيلية واضحة ومفصلة لمنصة سمات بلس، بحيث تكون مرجعًا فنيًا معتمدًا للتعاقد، وذلك ضمانًا لوضوح نطاق العمل، وآلية التنفيذ، والجوانب التشغيلية والفنية ذات العلاقة. مع الافادة انني بدأت العمل على جدول مهام مرفق مع هذه الرسالة كسبا للوقت \r\nكما يمكن ايضا بدء الاجراءات النظامية المرتبطة بالعقد لحين اكتمال بقية الجوانب الفنية للاعمال \r\nشاكرًا ومقدرًا لكم تعاونكم،\r\nوتفضلوا بقبول خالص التحية والتقدير،،', '<p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">الاخوة\r\nالزملاء في سمات الاستشارية <o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">السلام\r\nعليكم ورحمة الله وبركاته،،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">أشكركم\r\nشكرا جميلا  على إرسال عقد التعاون\r\nالاستشاري، وعلى ما أبديتموه من تعاون وتنسيق خلال الفترة الماضية</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.<o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">أفيدكم\r\nبالموافقة على العقد بصيغته الحالية، مع التأكيد على أهمية تضمين خطة <b>تشغيلية\r\nواضحة ومفصلة لمنصة سمات بلس</b>، بحيث تكون <b>مرجعًا فنيًا معتمدًا للتعاقد</b>،\r\nوذلك ضمانًا لوضوح نطاق العمل، وآلية التنفيذ، والجوانب التشغيلية والفنية ذات\r\nالعلاقة</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.</span><span dir=\"RTL\"></span><span dir=\"RTL\"></span><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><span dir=\"RTL\"></span><span dir=\"RTL\"></span> مع الافادة انني بدأت العمل على جدول مهام مرفق مع هذه الرسالة كسبا\r\nللوقت <o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">كما\r\nيمكن ايضا بدء الاجراءات النظامية المرتبطة بالعقد لحين اكتمال بقية الجوانب\r\nالفنية للاعمال </span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">شاكرًا\r\nومقدرًا لكم تعاونكم،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><br>\r\n</span><span lang=\"AR-SA\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\">وتفضلوا\r\nبقبول خالص التحية والتقدير،،</span><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p></o:p></span></p><p>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n</p><p class=\"MsoNormal\" dir=\"RTL\" style=\"unicode-bidi: embed;\"><span dir=\"LTR\" style=\"font-family:\"IBM Plex Sans Arabic\",sans-serif\"><o:p> </o:p></span></p>'),
(183, 2072, 'ar', 'التحدي', NULL, 'الدليل الكامل للأسئلة الشائعة (FAQ) - منحة \"ادرس في السعودية\"\r\nأولاً: أسئلة عامة عن المنحة\r\n•	ما هي المنحة التعليمية السعودية؟ هي برنامج وطني تقوده وزارة التعليم لجذب الطلاب المتميزين من العالم للدراسة في الجامعات الحكومية والخاصة في المملكة.\r\n•	ما الجهات التي تقدم المنحة؟ وزارة التعليم السعودية بالتنسيق مع أكثر من 27 جامعة حكومية وعشرت الجامعات الخاصة.\r\n•	ما الهدف من المنحة؟ نشر الثقافة والعلوم، وتعزيز التبادل الثقافي الدولي، وتحقيق رؤية المملكة 2030 في تصدير التعليم السعودي للعالم.', '<p class=\"MsoNormal\" dir=\"RTL\" style=\"direction: rtl; unicode-bidi: embed;\"><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">الدليل\r\nالكامل للأسئلة الشائعة</span></b><span dir=\"LTR\"></span><span dir=\"LTR\"></span><b><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span> (FAQ) - </span></b><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">منحة\r\n\"ادرس في السعودية</span></b><span dir=\"LTR\"></span><span dir=\"LTR\"></span><b><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>\"<o:p></o:p></span></b></p><p class=\"MsoNormal\" dir=\"RTL\" style=\"direction: rtl; unicode-bidi: embed;\"><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">أولاً:\r\nأسئلة عامة عن المنحة</span></b><b><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><o:p></o:p></span></b></p><p>\r\n\r\n\r\n\r\n</p><ul style=\"margin-top:0in\" type=\"disc\">\r\n <li class=\"MsoNormal\" dir=\"RTL\" style=\"margin-right: 0.5in; margin-left: 0in; direction: rtl; unicode-bidi: embed;\"><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">ما\r\n     هي المنحة التعليمية السعودية؟</span></b><span lang=\"AR-SA\" style=\"font-family:\r\n     &quot;IBM Plex Sans Arabic&quot;,sans-serif\"> هي برنامج وطني تقوده وزارة التعليم\r\n     لجذب الطلاب المتميزين من العالم للدراسة في الجامعات الحكومية والخاصة في\r\n     المملكة</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.<o:p></o:p></span></li>\r\n <li class=\"MsoNormal\" dir=\"RTL\" style=\"margin-right: 0.5in; margin-left: 0in; direction: rtl; unicode-bidi: embed;\"><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">ما\r\n     الجهات التي تقدم المنحة؟</span></b><span lang=\"AR-SA\" style=\"font-family:\r\n     &quot;IBM Plex Sans Arabic&quot;,sans-serif\"> وزارة التعليم السعودية بالتنسيق مع\r\n     أكثر من 27 جامعة حكومية وعشرت الجامعات الخاصة</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.<o:p></o:p></span></li>\r\n <li class=\"MsoNormal\" dir=\"RTL\" style=\"margin-right: 0.5in; margin-left: 0in; direction: rtl; unicode-bidi: embed;\"><b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">ما\r\n     الهدف من المنحة؟</span></b><span lang=\"AR-SA\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\">\r\n     نشر الثقافة والعلوم، وتعزيز التبادل الثقافي الدولي، وتحقيق رؤية المملكة\r\n     2030 في تصدير التعليم السعودي للعالم</span><span dir=\"LTR\"></span><span dir=\"LTR\"></span><span dir=\"LTR\" style=\"font-family:&quot;IBM Plex Sans Arabic&quot;,sans-serif\"><span dir=\"LTR\"></span><span dir=\"LTR\"></span>.<o:p></o:p></span></li>\r\n</ul>');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `abandoned_cart_rules`
--
ALTER TABLE `abandoned_cart_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `abandoned_cart_rules_discount_id_foreign` (`discount_id`);

--
-- Index pour la table `abandoned_cart_rule_histories`
--
ALTER TABLE `abandoned_cart_rule_histories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `abandoned_cart_rule_specification_items`
--
ALTER TABLE `abandoned_cart_rule_specification_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `abandoned_cart_rule_id_foreign` (`abandoned_cart_rule_id`),
  ADD KEY `abandoned_cart_rule_specification_items_category_id_foreign` (`category_id`),
  ADD KEY `abandoned_cart_rule_specification_items_instructor_id_foreign` (`instructor_id`),
  ADD KEY `abandoned_cart_rule_specification_items_seller_id_foreign` (`seller_id`),
  ADD KEY `abandoned_cart_rule_specification_items_webinar_id_foreign` (`webinar_id`),
  ADD KEY `abandoned_cart_rule_specification_items_product_id_foreign` (`product_id`),
  ADD KEY `abandoned_cart_rule_specification_items_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `abandoned_cart_rule_translations`
--
ALTER TABLE `abandoned_cart_rule_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `abandoned_cart_rule_id_trans` (`abandoned_cart_rule_id`),
  ADD KEY `abandoned_cart_rule_translations_locale_index` (`locale`);

--
-- Index pour la table `abandoned_cart_rule_users_groups`
--
ALTER TABLE `abandoned_cart_rule_users_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `abandoned_cart_rule_id` (`abandoned_cart_rule_id`),
  ADD KEY `abandoned_cart_rule_users_groups_group_id_foreign` (`group_id`),
  ADD KEY `abandoned_cart_rule_users_groups_user_id_foreign` (`user_id`);

--
-- Index pour la table `accounting`
--
ALTER TABLE `accounting`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id` (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `webinar_id` (`webinar_id`) USING BTREE,
  ADD KEY `meeting_time_id` (`meeting_time_id`) USING BTREE,
  ADD KEY `subscribe_id` (`subscribe_id`) USING BTREE,
  ADD KEY `promotion_id` (`promotion_id`) USING BTREE,
  ADD KEY `accounting_installment_payment_id_foreign` (`installment_payment_id`);

--
-- Index pour la table `advertising_banners`
--
ALTER TABLE `advertising_banners`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `advertising_banners_translations`
--
ALTER TABLE `advertising_banners_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `advertising_banners_translations_advertising_banner_id_foreign` (`advertising_banner_id`),
  ADD KEY `advertising_banners_translations_locale_index` (`locale`);

--
-- Index pour la table `affiliates`
--
ALTER TABLE `affiliates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `affiliates_affiliate_user_id_foreign` (`affiliate_user_id`),
  ADD KEY `affiliates_referred_user_id_foreign` (`referred_user_id`);

--
-- Index pour la table `affiliates_codes`
--
ALTER TABLE `affiliates_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `affiliates_codes_code_unique` (`code`),
  ADD KEY `affiliates_codes_user_id_foreign` (`user_id`);

--
-- Index pour la table `agora_history`
--
ALTER TABLE `agora_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agora_history_session_id_foreign` (`session_id`);

--
-- Index pour la table `ai_contents`
--
ALTER TABLE `ai_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_contents_user_id_foreign` (`user_id`),
  ADD KEY `ai_contents_service_id_foreign` (`service_id`);

--
-- Index pour la table `ai_content_templates`
--
ALTER TABLE `ai_content_templates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ai_content_template_translations`
--
ALTER TABLE `ai_content_template_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_content_template_id_trans` (`ai_content_template_id`),
  ADD KEY `ai_content_template_translations_locale_index` (`locale`);

--
-- Index pour la table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `badges_type_index` (`type`) USING BTREE;

--
-- Index pour la table `badge_translations`
--
ALTER TABLE `badge_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `badge_translations_badge_id_foreign` (`badge_id`),
  ADD KEY `badge_translations_locale_index` (`locale`);

--
-- Index pour la table `become_instructors`
--
ALTER TABLE `become_instructors`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `become_instructors_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `blog_category_id_foreign` (`category_id`) USING BTREE,
  ADD KEY `slug` (`slug`) USING BTREE,
  ADD KEY `blog_author_id_foreign` (`author_id`);

--
-- Index pour la table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_category_translations_blog_category_id_foreign` (`blog_category_id`),
  ADD KEY `blog_category_translations_locale_index` (`locale`);

--
-- Index pour la table `blog_featured_categories`
--
ALTER TABLE `blog_featured_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_featured_categories_category_id_foreign` (`category_id`);

--
-- Index pour la table `blog_translations`
--
ALTER TABLE `blog_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_translations_blog_id_locale_unique` (`blog_id`,`locale`),
  ADD KEY `blog_translations_locale_index` (`locale`);

--
-- Index pour la table `bulk_imports`
--
ALTER TABLE `bulk_imports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bulk_imports_user_id_foreign` (`user_id`);

--
-- Index pour la table `bundles`
--
ALTER TABLE `bundles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bundles_creator_id_foreign` (`creator_id`),
  ADD KEY `bundles_teacher_id_foreign` (`teacher_id`),
  ADD KEY `bundles_category_id_foreign` (`category_id`),
  ADD KEY `bundles_slug_index` (`slug`);

--
-- Index pour la table `bundle_filter_option`
--
ALTER TABLE `bundle_filter_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bundle_filter_option_bundle_id_foreign` (`bundle_id`),
  ADD KEY `bundle_filter_option_filter_option_id_foreign` (`filter_option_id`);

--
-- Index pour la table `bundle_translations`
--
ALTER TABLE `bundle_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bundle_translations_bundle_id_foreign` (`bundle_id`),
  ADD KEY `bundle_translations_locale_index` (`locale`);

--
-- Index pour la table `bundle_webinars`
--
ALTER TABLE `bundle_webinars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bundle_webinars_bundle_id_foreign` (`bundle_id`),
  ADD KEY `bundle_webinars_webinar_id_foreign` (`webinar_id`);

--
-- Index pour la table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `cart_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `cart_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `cart_ticket_id_foreign` (`ticket_id`) USING BTREE,
  ADD KEY `cart_reserve_meeting_id_foreign` (`reserve_meeting_id`) USING BTREE,
  ADD KEY `cart_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  ADD KEY `cart_promotion_id_foreign` (`promotion_id`) USING BTREE,
  ADD KEY `cart_special_offer_id_foreign` (`special_offer_id`),
  ADD KEY `cart_product_order_id_foreign` (`product_order_id`),
  ADD KEY `cart_product_discount_id_foreign` (`product_discount_id`),
  ADD KEY `cart_bundle_id_foreign` (`bundle_id`),
  ADD KEY `cart_installment_payment_id_foreign` (`installment_payment_id`),
  ADD KEY `cart_gift_id_foreign` (`gift_id`);

--
-- Index pour la table `cart_discounts`
--
ALTER TABLE `cart_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_discounts_discount_id_foreign` (`discount_id`);

--
-- Index pour la table `cart_discount_translations`
--
ALTER TABLE `cart_discount_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_discount_translations_cart_discount_id_foreign` (`cart_discount_id`),
  ADD KEY `cart_discount_translations_locale_index` (`locale`);

--
-- Index pour la table `cashback_rules`
--
ALTER TABLE `cashback_rules`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cashback_rule_specification_items`
--
ALTER TABLE `cashback_rule_specification_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashback_rule_specification_items_cashback_rule_id_foreign` (`cashback_rule_id`),
  ADD KEY `cashback_rule_specification_items_category_id_foreign` (`category_id`),
  ADD KEY `cashback_rule_specification_items_instructor_id_foreign` (`instructor_id`),
  ADD KEY `cashback_rule_specification_items_seller_id_foreign` (`seller_id`),
  ADD KEY `cashback_rule_specification_items_webinar_id_foreign` (`webinar_id`),
  ADD KEY `cashback_rule_specification_items_product_id_foreign` (`product_id`),
  ADD KEY `cashback_rule_specification_items_bundle_id_foreign` (`bundle_id`),
  ADD KEY `cashback_rule_specification_items_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `rules_registration_package_id` (`registration_package_id`);

--
-- Index pour la table `cashback_rule_translations`
--
ALTER TABLE `cashback_rule_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashback_rule_translations_cashback_rule_id_foreign` (`cashback_rule_id`),
  ADD KEY `cashback_rule_translations_locale_index` (`locale`);

--
-- Index pour la table `cashback_rule_users_groups`
--
ALTER TABLE `cashback_rule_users_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashback_rule_users_groups_cashback_rule_id_foreign` (`cashback_rule_id`),
  ADD KEY `cashback_rule_users_groups_group_id_foreign` (`group_id`),
  ADD KEY `cashback_rule_users_groups_user_id_foreign` (`user_id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `parent_id` (`parent_id`) USING BTREE;

--
-- Index pour la table `category_translations`
--
ALTER TABLE `category_translations`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `category_translations_category_id_foreign` (`category_id`) USING BTREE,
  ADD KEY `category_translations_locale_index` (`locale`) USING BTREE;

--
-- Index pour la table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `certificates_quiz_id_foreign` (`quiz_id`) USING BTREE,
  ADD KEY `certificates_quiz_result_id_foreign` (`quiz_result_id`) USING BTREE,
  ADD KEY `certificates_student_id_foreign` (`student_id`) USING BTREE,
  ADD KEY `certificates_webinar_id_foreign` (`webinar_id`),
  ADD KEY `certificates_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `certificates_templates`
--
ALTER TABLE `certificates_templates`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `certificate_template_translations`
--
ALTER TABLE `certificate_template_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificate_template_id` (`certificate_template_id`),
  ADD KEY `certificate_template_translations_locale_index` (`locale`);

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `comments_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `comments_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `comments_review_id_foreign` (`review_id`) USING BTREE,
  ADD KEY `comments_reply_id_foreign` (`reply_id`) USING BTREE,
  ADD KEY `comments_product_id_foreign` (`product_id`),
  ADD KEY `comments_bundle_id_foreign` (`bundle_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `comments_upcoming_course_id_foreign` (`upcoming_course_id`);

--
-- Index pour la table `comments_reports`
--
ALTER TABLE `comments_reports`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `comments_reports_comment_id_foreign` (`comment_id`) USING BTREE,
  ADD KEY `comments_reports_product_id_foreign` (`product_id`);

--
-- Index pour la table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `content_delete_requests`
--
ALTER TABLE `content_delete_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `content_delete_requests_user_id_foreign` (`user_id`);

--
-- Index pour la table `course_forums`
--
ALTER TABLE `course_forums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_forums_webinar_id_foreign` (`webinar_id`),
  ADD KEY `course_forums_user_id_foreign` (`user_id`);

--
-- Index pour la table `course_forum_answers`
--
ALTER TABLE `course_forum_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_forum_answers_user_id_foreign` (`user_id`),
  ADD KEY `course_forum_answers_forum_id_foreign` (`forum_id`);

--
-- Index pour la table `course_learning`
--
ALTER TABLE `course_learning`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_learning_user_id_foreign` (`user_id`),
  ADD KEY `course_learning_text_lesson_id_foreign` (`text_lesson_id`),
  ADD KEY `course_learning_file_id_foreign` (`file_id`),
  ADD KEY `course_learning_session_id_foreign` (`session_id`);

--
-- Index pour la table `course_learning_last_views`
--
ALTER TABLE `course_learning_last_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_learning_last_views_user_id_foreign` (`user_id`),
  ADD KEY `course_learning_last_views_webinar_id_foreign` (`webinar_id`);

--
-- Index pour la table `course_noticeboards`
--
ALTER TABLE `course_noticeboards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_noticeboards_creator_id_foreign` (`creator_id`),
  ADD KEY `course_noticeboards_webinar_id_foreign` (`webinar_id`);

--
-- Index pour la table `course_noticeboard_status`
--
ALTER TABLE `course_noticeboard_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_noticeboard_status_noticeboard_id_foreign` (`noticeboard_id`);

--
-- Index pour la table `course_personal_notes`
--
ALTER TABLE `course_personal_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_personal_notes_user_id_foreign` (`user_id`),
  ADD KEY `course_personal_notes_course_id_foreign` (`course_id`);

--
-- Index pour la table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `delete_account_requests`
--
ALTER TABLE `delete_account_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delete_account_requests_user_id_foreign` (`user_id`);

--
-- Index pour la table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `discounts_code_unique` (`code`),
  ADD KEY `discounts_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `discount_bundles`
--
ALTER TABLE `discount_bundles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_bundles_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_bundles_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `discount_categories`
--
ALTER TABLE `discount_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_categories_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_categories_category_id_foreign` (`category_id`);

--
-- Index pour la table `discount_courses`
--
ALTER TABLE `discount_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_courses_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_courses_course_id_foreign` (`course_id`);

--
-- Index pour la table `discount_events`
--
ALTER TABLE `discount_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_events_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_events_event_id_foreign` (`event_id`);

--
-- Index pour la table `discount_groups`
--
ALTER TABLE `discount_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_groups_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_groups_group_id_foreign` (`group_id`);

--
-- Index pour la table `discount_meeting_packages`
--
ALTER TABLE `discount_meeting_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_meeting_packages_discount_id_foreign` (`discount_id`),
  ADD KEY `discount_meeting_packages_meeting_package_id_foreign` (`meeting_package_id`);

--
-- Index pour la table `discount_users`
--
ALTER TABLE `discount_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `discount_users_discount_id_foreign` (`discount_id`) USING BTREE,
  ADD KEY `discount_users_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `events_slug_unique` (`slug`),
  ADD KEY `events_creator_id_foreign` (`creator_id`),
  ADD KEY `events_category_id_foreign` (`category_id`);

--
-- Index pour la table `event_filter_options`
--
ALTER TABLE `event_filter_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_filter_options_event_id_foreign` (`event_id`),
  ADD KEY `event_filter_options_filter_option_id_foreign` (`filter_option_id`);

--
-- Index pour la table `event_reports`
--
ALTER TABLE `event_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_reports_event_id_foreign` (`event_id`);

--
-- Index pour la table `event_speakers`
--
ALTER TABLE `event_speakers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_speakers_event_id_foreign` (`event_id`);

--
-- Index pour la table `event_speaker_translations`
--
ALTER TABLE `event_speaker_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_speaker_translations_event_speaker_id_foreign` (`event_speaker_id`),
  ADD KEY `event_speaker_translations_locale_index` (`locale`);

--
-- Index pour la table `event_tickets`
--
ALTER TABLE `event_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_tickets_event_id_foreign` (`event_id`);

--
-- Index pour la table `event_tickets_sold`
--
ALTER TABLE `event_tickets_sold`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_tickets_sold_code_unique` (`code`);

--
-- Index pour la table `event_ticket_translations`
--
ALTER TABLE `event_ticket_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_ticket_translations_event_ticket_id_foreign` (`event_ticket_id`),
  ADD KEY `event_ticket_translations_locale_index` (`locale`);

--
-- Index pour la table `event_translations`
--
ALTER TABLE `event_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_translations_event_id_foreign` (`event_id`),
  ADD KEY `event_translations_locale_index` (`locale`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `faqs_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `faqs_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `faqs_bundle_id_foreign` (`bundle_id`),
  ADD KEY `faqs_upcoming_course_id_foreign` (`upcoming_course_id`);

--
-- Index pour la table `faq_translations`
--
ALTER TABLE `faq_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faq_translations_faq_id_foreign` (`faq_id`),
  ADD KEY `faq_translations_locale_index` (`locale`);

--
-- Index pour la table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `favorites_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `favorites_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `favorites_bundle_id_foreign` (`bundle_id`),
  ADD KEY `favorites_upcoming_course_id_foreign` (`upcoming_course_id`);

--
-- Index pour la table `feature_webinars`
--
ALTER TABLE `feature_webinars`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `feature_webinars_webinar_id_index` (`webinar_id`) USING BTREE;

--
-- Index pour la table `feature_webinar_translations`
--
ALTER TABLE `feature_webinar_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_webinar_translations_feature_webinar_id_foreign` (`feature_webinar_id`),
  ADD KEY `feature_webinar_translations_locale_index` (`locale`);

--
-- Index pour la table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `files_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `files_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `files_chapter_id_foreign` (`chapter_id`);

--
-- Index pour la table `file_translations`
--
ALTER TABLE `file_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_translations_file_id_foreign` (`file_id`),
  ADD KEY `file_translations_locale_index` (`locale`);

--
-- Index pour la table `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `filters_category_id_foreign` (`category_id`) USING BTREE;

--
-- Index pour la table `filter_options`
--
ALTER TABLE `filter_options`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `filter_options_filter_id_foreign` (`filter_id`) USING BTREE;

--
-- Index pour la table `filter_option_translations`
--
ALTER TABLE `filter_option_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filter_option_translations_filter_option_id_foreign` (`filter_option_id`),
  ADD KEY `filter_option_translations_locale_index` (`locale`);

--
-- Index pour la table `filter_translations`
--
ALTER TABLE `filter_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filter_translations_filter_id_foreign` (`filter_id`),
  ADD KEY `filter_translations_locale_index` (`locale`);

--
-- Index pour la table `floating_bars`
--
ALTER TABLE `floating_bars`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `floating_bar_translations`
--
ALTER TABLE `floating_bar_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `floating_bar_translations_floating_bar_id_foreign` (`floating_bar_id`),
  ADD KEY `floating_bar_translations_locale_index` (`locale`);

--
-- Index pour la table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `follows_follower_foreign` (`follower`) USING BTREE,
  ADD KEY `follows_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forms_url_unique` (`url`);

--
-- Index pour la table `form_fields`
--
ALTER TABLE `form_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_fields_form_id_foreign` (`form_id`);

--
-- Index pour la table `form_field_options`
--
ALTER TABLE `form_field_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_field_options_form_field_id_foreign` (`form_field_id`);

--
-- Index pour la table `form_field_option_translations`
--
ALTER TABLE `form_field_option_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_field_option_id_trans` (`form_field_option_id`),
  ADD KEY `form_field_option_translations_locale_index` (`locale`);

--
-- Index pour la table `form_field_translations`
--
ALTER TABLE `form_field_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_field_translations_form_field_id_foreign` (`form_field_id`),
  ADD KEY `form_field_translations_locale_index` (`locale`);

--
-- Index pour la table `form_roles_users_groups`
--
ALTER TABLE `form_roles_users_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_roles_users_groups_form_id_foreign` (`form_id`),
  ADD KEY `form_roles_users_groups_role_id_foreign` (`role_id`),
  ADD KEY `form_roles_users_groups_user_id_foreign` (`user_id`),
  ADD KEY `form_roles_users_groups_group_id_foreign` (`group_id`);

--
-- Index pour la table `form_submissions`
--
ALTER TABLE `form_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_submissions_user_id_foreign` (`user_id`),
  ADD KEY `form_submissions_form_id_foreign` (`form_id`);

--
-- Index pour la table `form_submission_items`
--
ALTER TABLE `form_submission_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_submission_items_submission_id_foreign` (`submission_id`),
  ADD KEY `form_submission_items_form_field_id_foreign` (`form_field_id`);

--
-- Index pour la table `form_translations`
--
ALTER TABLE `form_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_translations_form_id_foreign` (`form_id`),
  ADD KEY `form_translations_locale_index` (`locale`);

--
-- Index pour la table `forums`
--
ALTER TABLE `forums`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forums_slug_unique` (`slug`),
  ADD KEY `forums_role_id_foreign` (`role_id`),
  ADD KEY `forums_group_id_foreign` (`group_id`);

--
-- Index pour la table `forum_featured_topics`
--
ALTER TABLE `forum_featured_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_featured_topics_topic_id_foreign` (`topic_id`);

--
-- Index pour la table `forum_recommended_topics`
--
ALTER TABLE `forum_recommended_topics`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `forum_recommended_topic_items`
--
ALTER TABLE `forum_recommended_topic_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_recommended_topic_items_recommended_topic_id_foreign` (`recommended_topic_id`),
  ADD KEY `forum_recommended_topic_items_topic_id_foreign` (`topic_id`);

--
-- Index pour la table `forum_recommended_topic_translations`
--
ALTER TABLE `forum_recommended_topic_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_recommended_topic_id_trans` (`forum_recommended_topic_id`),
  ADD KEY `forum_recommended_topic_translations_locale_index` (`locale`);

--
-- Index pour la table `forum_topics`
--
ALTER TABLE `forum_topics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_topics_slug_unique` (`slug`),
  ADD KEY `forum_topics_creator_id_foreign` (`creator_id`),
  ADD KEY `forum_topics_forum_id_foreign` (`forum_id`);

--
-- Index pour la table `forum_topic_attachments`
--
ALTER TABLE `forum_topic_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_attachments_topic_id_foreign` (`topic_id`),
  ADD KEY `forum_topic_attachments_creator_id_foreign` (`creator_id`);

--
-- Index pour la table `forum_topic_bookmarks`
--
ALTER TABLE `forum_topic_bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_bookmarks_user_id_foreign` (`user_id`),
  ADD KEY `forum_topic_bookmarks_topic_id_foreign` (`topic_id`);

--
-- Index pour la table `forum_topic_likes`
--
ALTER TABLE `forum_topic_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_likes_user_id_foreign` (`user_id`),
  ADD KEY `forum_topic_likes_topic_id_foreign` (`topic_id`),
  ADD KEY `forum_topic_likes_topic_post_id_foreign` (`topic_post_id`);

--
-- Index pour la table `forum_topic_posts`
--
ALTER TABLE `forum_topic_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_posts_user_id_foreign` (`user_id`),
  ADD KEY `forum_topic_posts_topic_id_foreign` (`topic_id`),
  ADD KEY `forum_topic_posts_parent_id_foreign` (`parent_id`);

--
-- Index pour la table `forum_topic_reports`
--
ALTER TABLE `forum_topic_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_reports_user_id_foreign` (`user_id`),
  ADD KEY `forum_topic_reports_topic_id_foreign` (`topic_id`),
  ADD KEY `forum_topic_reports_topic_post_id_foreign` (`topic_post_id`);

--
-- Index pour la table `forum_topic_visits`
--
ALTER TABLE `forum_topic_visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_topic_visits_forum_id_foreign` (`forum_id`),
  ADD KEY `forum_topic_visits_topic_id_foreign` (`topic_id`);

--
-- Index pour la table `forum_translations`
--
ALTER TABLE `forum_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_translations_forum_id_foreign` (`forum_id`),
  ADD KEY `forum_translations_locale_index` (`locale`);

--
-- Index pour la table `gifts`
--
ALTER TABLE `gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gifts_user_id_foreign` (`user_id`),
  ADD KEY `gifts_webinar_id_foreign` (`webinar_id`),
  ADD KEY `gifts_bundle_id_foreign` (`bundle_id`),
  ADD KEY `gifts_product_id_foreign` (`product_id`);

--
-- Index pour la table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `groups_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `groups_registration_packages`
--
ALTER TABLE `groups_registration_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groups_registration_packages_group_id_foreign` (`group_id`);

--
-- Index pour la table `group_users`
--
ALTER TABLE `group_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `group_users_group_id_foreign` (`group_id`) USING BTREE,
  ADD KEY `group_users_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `home_page_statistics`
--
ALTER TABLE `home_page_statistics`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `home_page_statistic_translations`
--
ALTER TABLE `home_page_statistic_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_page_statistic_id` (`home_page_statistic_id`),
  ADD KEY `home_page_statistic_translations_locale_index` (`locale`);

--
-- Index pour la table `home_sections`
--
ALTER TABLE `home_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_sections_name_index` (`name`);

--
-- Index pour la table `installments`
--
ALTER TABLE `installments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `installment_orders`
--
ALTER TABLE `installment_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_orders_installment_id_foreign` (`installment_id`),
  ADD KEY `installment_orders_user_id_foreign` (`user_id`),
  ADD KEY `installment_orders_webinar_id_foreign` (`webinar_id`),
  ADD KEY `installment_orders_product_id_foreign` (`product_id`),
  ADD KEY `installment_orders_bundle_id_foreign` (`bundle_id`),
  ADD KEY `installment_orders_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `installment_orders_registration_package_id_foreign` (`registration_package_id`),
  ADD KEY `installment_product_order_id` (`product_order_id`);

--
-- Index pour la table `installment_order_attachments`
--
ALTER TABLE `installment_order_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_order_id_attachment` (`installment_order_id`);

--
-- Index pour la table `installment_order_payments`
--
ALTER TABLE `installment_order_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_order_id` (`installment_order_id`),
  ADD KEY `installment_order_payments_sale_id_foreign` (`sale_id`),
  ADD KEY `installment_order_payments_selected_installment_step_id_foreign` (`selected_installment_step_id`);

--
-- Index pour la table `installment_reminders`
--
ALTER TABLE `installment_reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_reminders_user_id_foreign` (`user_id`);

--
-- Index pour la table `installment_specification_items`
--
ALTER TABLE `installment_specification_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_specification_items_installment_id_foreign` (`installment_id`),
  ADD KEY `installment_specification_items_category_id_foreign` (`category_id`),
  ADD KEY `installment_specification_items_instructor_id_foreign` (`instructor_id`),
  ADD KEY `installment_specification_items_seller_id_foreign` (`seller_id`),
  ADD KEY `installment_specification_items_webinar_id_foreign` (`webinar_id`),
  ADD KEY `installment_specification_items_product_id_foreign` (`product_id`),
  ADD KEY `installment_specification_items_bundle_id_foreign` (`bundle_id`),
  ADD KEY `installment_specification_items_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `installment_specification_items_registration_package_id_foreign` (`registration_package_id`);

--
-- Index pour la table `installment_steps`
--
ALTER TABLE `installment_steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_steps_installment_id_foreign` (`installment_id`);

--
-- Index pour la table `installment_step_translations`
--
ALTER TABLE `installment_step_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_step_translations_installment_step_id_foreign` (`installment_step_id`),
  ADD KEY `installment_step_translations_locale_index` (`locale`);

--
-- Index pour la table `installment_translations`
--
ALTER TABLE `installment_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_translations_installment_id_foreign` (`installment_id`),
  ADD KEY `installment_translations_locale_index` (`locale`);

--
-- Index pour la table `installment_user_groups`
--
ALTER TABLE `installment_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `installment_user_groups_installment_id_foreign` (`installment_id`),
  ADD KEY `installment_user_groups_group_id_foreign` (`group_id`);

--
-- Index pour la table `ip_restrictions`
--
ALTER TABLE `ip_restrictions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jazzcash_transactions`
--
ALTER TABLE `jazzcash_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `landings`
--
ALTER TABLE `landings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `landings_url_unique` (`url`);

--
-- Index pour la table `landing_builder_components`
--
ALTER TABLE `landing_builder_components`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `landing_builder_components_name_unique` (`name`);

--
-- Index pour la table `landing_components`
--
ALTER TABLE `landing_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `landing_components_landing_id_foreign` (`landing_id`),
  ADD KEY `landing_components_component_id_foreign` (`component_id`);

--
-- Index pour la table `landing_component_translations`
--
ALTER TABLE `landing_component_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `landing_component_id_trans` (`landing_component_id`),
  ADD KEY `landing_component_translations_locale_index` (`locale`);

--
-- Index pour la table `landing_translations`
--
ALTER TABLE `landing_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `landing_translations_landing_id_foreign` (`landing_id`),
  ADD KEY `landing_translations_locale_index` (`locale`);

--
-- Index pour la table `meetings`
--
ALTER TABLE `meetings`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `meetings_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `meeting_packages`
--
ALTER TABLE `meeting_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_packages_creator_id_foreign` (`creator_id`);

--
-- Index pour la table `meeting_packages_sold`
--
ALTER TABLE `meeting_packages_sold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_packages_sold_meeting_package_id_foreign` (`meeting_package_id`),
  ADD KEY `meeting_packages_sold_user_id_foreign` (`user_id`),
  ADD KEY `meeting_packages_sold_sale_id_foreign` (`sale_id`);

--
-- Index pour la table `meeting_package_translations`
--
ALTER TABLE `meeting_package_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_package_translations_meeting_package_id_foreign` (`meeting_package_id`),
  ADD KEY `meeting_package_translations_locale_index` (`locale`);

--
-- Index pour la table `meeting_times`
--
ALTER TABLE `meeting_times`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `meeting_times_meeting_id_foreign` (`meeting_id`) USING BTREE;

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `navbar_buttons`
--
ALTER TABLE `navbar_buttons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `navbar_buttons_role_id_foreign` (`role_id`);

--
-- Index pour la table `navbar_button_translations`
--
ALTER TABLE `navbar_button_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `navbar_button_translations_navbar_button_id_foreign` (`navbar_button_id`),
  ADD KEY `navbar_button_translations_locale_index` (`locale`);

--
-- Index pour la table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `newsletters_history`
--
ALTER TABLE `newsletters_history`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `noticeboards`
--
ALTER TABLE `noticeboards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `noticeboards_organ_id_foreign` (`organ_id`),
  ADD KEY `noticeboards_user_id_foreign` (`user_id`),
  ADD KEY `noticeboards_instructor_id_foreign` (`instructor_id`),
  ADD KEY `noticeboards_webinar_id_foreign` (`webinar_id`),
  ADD KEY `noticeboards_sender_id_foreign` (`sender_id`);

--
-- Index pour la table `noticeboards_status`
--
ALTER TABLE `noticeboards_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `noticeboards_status_noticeboard_id_foreign` (`noticeboard_id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `notifications_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `notifications_group_id_foreign` (`group_id`) USING BTREE,
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Index pour la table `notifications_status`
--
ALTER TABLE `notifications_status`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `notifications_status_notification_id_foreign` (`notification_id`) USING BTREE;

--
-- Index pour la table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `offline_banks`
--
ALTER TABLE `offline_banks`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `offline_bank_specifications`
--
ALTER TABLE `offline_bank_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offline_bank_specifications_offline_bank_id_foreign` (`offline_bank_id`);

--
-- Index pour la table `offline_bank_specification_translations`
--
ALTER TABLE `offline_bank_specification_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offline_bank_specification_id` (`offline_bank_specification_id`),
  ADD KEY `locale` (`locale`) USING BTREE;

--
-- Index pour la table `offline_bank_translations`
--
ALTER TABLE `offline_bank_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `offline_bank_translations_offline_bank_id_foreign` (`offline_bank_id`),
  ADD KEY `offline_bank_translations_locale_index` (`locale`);

--
-- Index pour la table `offline_payments`
--
ALTER TABLE `offline_payments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `offline_payments_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `offline_payments_offline_bank_id_foreign` (`offline_bank_id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `orders_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `order_items_order_id_foreign` (`order_id`) USING BTREE,
  ADD KEY `order_items_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `order_items_ticket_id_foreign` (`ticket_id`) USING BTREE,
  ADD KEY `order_items_reserve_meeting_id_foreign` (`reserve_meeting_id`) USING BTREE,
  ADD KEY `order_items_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  ADD KEY `order_items_promotion_id_foreign` (`promotion_id`) USING BTREE,
  ADD KEY `order_items_gift_id_foreign` (`gift_id`);

--
-- Index pour la table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_link_unique` (`link`);

--
-- Index pour la table `page_translations`
--
ALTER TABLE `page_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_translations_page_id_foreign` (`page_id`),
  ADD KEY `page_translations_locale_index` (`locale`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`) USING BTREE;

--
-- Index pour la table `payku_payments`
--
ALTER TABLE `payku_payments`
  ADD UNIQUE KEY `payku_payments_transaction_id_unique` (`transaction_id`);

--
-- Index pour la table `payku_transactions`
--
ALTER TABLE `payku_transactions`
  ADD UNIQUE KEY `payku_transactions_id_unique` (`id`),
  ADD UNIQUE KEY `payku_transactions_order_unique` (`order`);

--
-- Index pour la table `payment_channels`
--
ALTER TABLE `payment_channels`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `payouts`
--
ALTER TABLE `payouts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `payouts_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `payout_user_selected_bank_id` (`user_selected_bank_id`) USING BTREE;

--
-- Index pour la table `payu_transactions`
--
ALTER TABLE `payu_transactions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `payu_transactions_transaction_id_unique` (`transaction_id`) USING BTREE,
  ADD KEY `payu_transactions_status_index` (`status`) USING BTREE,
  ADD KEY `payu_transactions_verified_at_index` (`verified_at`) USING BTREE;

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `permissions_role_id_index` (`role_id`) USING BTREE,
  ADD KEY `permissions_section_id_index` (`section_id`) USING BTREE;

--
-- Index pour la table `prerequisites`
--
ALTER TABLE `prerequisites`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `prerequisites_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `prerequisite_id` (`prerequisite_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_creator_id_foreign` (`creator_id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_type_index` (`type`),
  ADD KEY `products_slug_index` (`slug`);

--
-- Index pour la table `product_badges`
--
ALTER TABLE `product_badges`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `product_badge_contents`
--
ALTER TABLE `product_badge_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_badge_contents_product_badge_id_foreign` (`product_badge_id`);

--
-- Index pour la table `product_badge_translations`
--
ALTER TABLE `product_badge_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_badge_translations_product_badge_id_foreign` (`product_badge_id`),
  ADD KEY `product_badge_translations_locale_index` (`locale`);

--
-- Index pour la table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `product_category_translations`
--
ALTER TABLE `product_category_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_category_id` (`product_category_id`),
  ADD KEY `product_category_translations_locale_index` (`locale`);

--
-- Index pour la table `product_discounts`
--
ALTER TABLE `product_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_discounts_creator_id_foreign` (`creator_id`),
  ADD KEY `product_discounts_product_id_foreign` (`product_id`);

--
-- Index pour la table `product_faqs`
--
ALTER TABLE `product_faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_faqs_product_id_foreign` (`product_id`),
  ADD KEY `product_faqs_creator_id_foreign` (`creator_id`);

--
-- Index pour la table `product_faq_translations`
--
ALTER TABLE `product_faq_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_faq_id` (`product_faq_id`),
  ADD KEY `product_faq_translations_locale_index` (`locale`);

--
-- Index pour la table `product_featured_categories`
--
ALTER TABLE `product_featured_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_featured_categories_category_id_foreign` (`category_id`);

--
-- Index pour la table `product_files`
--
ALTER TABLE `product_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_product_id` (`product_id`),
  ADD KEY `file_creator_id` (`creator_id`);

--
-- Index pour la table `product_file_translations`
--
ALTER TABLE `product_file_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_file_id` (`product_file_id`),
  ADD KEY `product_file_translations_locale_index` (`locale`);

--
-- Index pour la table `product_filters`
--
ALTER TABLE `product_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_filters_category_id_foreign` (`category_id`);

--
-- Index pour la table `product_filter_options`
--
ALTER TABLE `product_filter_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_filter_options_filter_id_foreign` (`filter_id`);

--
-- Index pour la table `product_filter_option_translations`
--
ALTER TABLE `product_filter_option_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_filter_option_id` (`product_filter_option_id`),
  ADD KEY `product_filter_option_translations_locale_index` (`locale`);

--
-- Index pour la table `product_filter_translations`
--
ALTER TABLE `product_filter_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_filter_id` (`product_filter_id`),
  ADD KEY `product_filter_translations_locale_index` (`locale`);

--
-- Index pour la table `product_media`
--
ALTER TABLE `product_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_product_id` (`product_id`),
  ADD KEY `media_creator_id` (`creator_id`);

--
-- Index pour la table `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_orders_installment_order_id_foreign` (`installment_order_id`),
  ADD KEY `product_orders_gift_id_foreign` (`gift_id`);

--
-- Index pour la table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_reviews_creator_id_foreign` (`creator_id`),
  ADD KEY `product_reviews_product_id_foreign` (`product_id`);

--
-- Index pour la table `product_selected_filter_options`
--
ALTER TABLE `product_selected_filter_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_selected_filter_options_product_id_foreign` (`product_id`),
  ADD KEY `product_selected_filter_options_filter_option_id_foreign` (`filter_option_id`);

--
-- Index pour la table `product_selected_specifications`
--
ALTER TABLE `product_selected_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_selected_specifications_creator_id_foreign` (`creator_id`),
  ADD KEY `product_selected_specifications_product_id_foreign` (`product_id`),
  ADD KEY `product_selected_specifications_product_specification_id_foreign` (`product_specification_id`);

--
-- Index pour la table `product_selected_specification_multi_values`
--
ALTER TABLE `product_selected_specification_multi_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selected_specification_id` (`selected_specification_id`),
  ADD KEY `specification_multi_value_id` (`specification_multi_value_id`);

--
-- Index pour la table `product_selected_specification_translations`
--
ALTER TABLE `product_selected_specification_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_selected_specification_id_translations` (`product_selected_specification_id`),
  ADD KEY `product_selected_specification_translations_locale_index` (`locale`);

--
-- Index pour la table `product_specifications`
--
ALTER TABLE `product_specifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `product_specification_categories`
--
ALTER TABLE `product_specification_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_specification_categories_specification_id_foreign` (`specification_id`),
  ADD KEY `product_specification_categories_category_id_foreign` (`category_id`);

--
-- Index pour la table `product_specification_multi_values`
--
ALTER TABLE `product_specification_multi_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_specification_multi_values_specification_id_foreign` (`specification_id`);

--
-- Index pour la table `product_specification_multi_value_translations`
--
ALTER TABLE `product_specification_multi_value_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_specification_multi_value_id` (`product_specification_multi_value_id`),
  ADD KEY `product_specification_multi_value_translations_locale_index` (`locale`);

--
-- Index pour la table `product_specification_translations`
--
ALTER TABLE `product_specification_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_specification_id` (`product_specification_id`),
  ADD KEY `product_specification_translations_locale_index` (`locale`);

--
-- Index pour la table `product_top_categories`
--
ALTER TABLE `product_top_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_top_categories_category_id_foreign` (`category_id`);

--
-- Index pour la table `product_translations`
--
ALTER TABLE `product_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_translations_locale_index` (`locale`);

--
-- Index pour la table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `promotion_translations`
--
ALTER TABLE `promotion_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `promotion_translations_promotion_id_foreign` (`promotion_id`),
  ADD KEY `promotion_translations_locale_index` (`locale`);

--
-- Index pour la table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `purchases_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `purchases_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `purchase_code`
--
ALTER TABLE `purchase_code`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `purchase_notifications`
--
ALTER TABLE `purchase_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `purchase_notification_histories`
--
ALTER TABLE `purchase_notification_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_notification_id_history` (`purchase_notification_id`),
  ADD KEY `purchase_notification_histories_user_id_foreign` (`user_id`);

--
-- Index pour la table `purchase_notification_roles_groups_contents`
--
ALTER TABLE `purchase_notification_roles_groups_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_notification_id_role_group` (`purchase_notification_id`),
  ADD KEY `purchase_notification_roles_groups_contents_role_id_foreign` (`role_id`),
  ADD KEY `purchase_notification_roles_groups_contents_group_id_foreign` (`group_id`),
  ADD KEY `purchase_notification_roles_groups_contents_webinar_id_foreign` (`webinar_id`),
  ADD KEY `purchase_notification_roles_groups_contents_bundle_id_foreign` (`bundle_id`),
  ADD KEY `purchase_notification_roles_groups_contents_product_id_foreign` (`product_id`);

--
-- Index pour la table `purchase_notification_translations`
--
ALTER TABLE `purchase_notification_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_notification_id_trans` (`purchase_notification_id`),
  ADD KEY `purchase_notification_translations_locale_index` (`locale`);

--
-- Index pour la table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `quizzes_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `quizzes_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `quizzes_chapter_id_foreign` (`chapter_id`);

--
-- Index pour la table `quizzes_questions`
--
ALTER TABLE `quizzes_questions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `quizzes_questions_quiz_id_foreign` (`quiz_id`) USING BTREE,
  ADD KEY `quizzes_questions_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `quizzes_questions_answers`
--
ALTER TABLE `quizzes_questions_answers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `quizzes_questions_answers_question_id_foreign` (`question_id`) USING BTREE,
  ADD KEY `quizzes_questions_answers_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `quizzes_questions_answer_translations`
--
ALTER TABLE `quizzes_questions_answer_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quizzes_questions_answer_id` (`quizzes_questions_answer_id`),
  ADD KEY `quizzes_questions_answer_translations_locale_index` (`locale`);

--
-- Index pour la table `quizzes_results`
--
ALTER TABLE `quizzes_results`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `quizzes_results_quiz_id_foreign` (`quiz_id`) USING BTREE,
  ADD KEY `quizzes_results_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `quiz_question_translations`
--
ALTER TABLE `quiz_question_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_question_translations_quiz_question_id_foreign` (`quizzes_question_id`),
  ADD KEY `quiz_question_translations_locale_index` (`locale`);

--
-- Index pour la table `quiz_translations`
--
ALTER TABLE `quiz_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_translations_quiz_id_foreign` (`quiz_id`),
  ADD KEY `quiz_translations_locale_index` (`locale`);

--
-- Index pour la table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `rating_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `rating_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `rating_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `regions_country_id_foreign` (`country_id`),
  ADD KEY `regions_province_id_foreign` (`province_id`),
  ADD KEY `regions_city_id_foreign` (`city_id`);

--
-- Index pour la table `registration_packages`
--
ALTER TABLE `registration_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registration_packages_role_index` (`role`);

--
-- Index pour la table `registration_packages_translations`
--
ALTER TABLE `registration_packages_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registration_package` (`registration_package_id`),
  ADD KEY `registration_packages_translations_locale_index` (`locale`);

--
-- Index pour la table `related_courses`
--
ALTER TABLE `related_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_courses_creator_id_foreign` (`creator_id`),
  ADD KEY `related_courses_course_id_foreign` (`course_id`);

--
-- Index pour la table `related_posts`
--
ALTER TABLE `related_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_posts_post_id_foreign` (`post_id`);

--
-- Index pour la table `related_products`
--
ALTER TABLE `related_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_products_product_id_foreign` (`product_id`);

--
-- Index pour la table `reserve_meetings`
--
ALTER TABLE `reserve_meetings`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `reserve_meetings_meeting_time_id_foreign` (`meeting_time_id`) USING BTREE,
  ADD KEY `reserve_meetings_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `reserve_meetings_sale_id_foreign` (`sale_id`);

--
-- Index pour la table `rewards`
--
ALTER TABLE `rewards`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rewards_accounting`
--
ALTER TABLE `rewards_accounting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rewards_accounting_user_id_foreign` (`user_id`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `role_translations`
--
ALTER TABLE `role_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_translations_role_id_foreign` (`role_id`),
  ADD KEY `role_translations_locale_index` (`locale`);

--
-- Index pour la table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `sales_order_id_foreign` (`order_id`) USING BTREE,
  ADD KEY `sales_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `sales_meeting_id_foreign` (`meeting_id`) USING BTREE,
  ADD KEY `sales_ticket_id_foreign` (`ticket_id`) USING BTREE,
  ADD KEY `sales_buyer_id_foreign` (`buyer_id`) USING BTREE,
  ADD KEY `sales_seller_id_foreign` (`seller_id`) USING BTREE,
  ADD KEY `sales_promotion_id_foreign` (`promotion_id`) USING BTREE,
  ADD KEY `sales_installment_payment_id_foreign` (`installment_payment_id`);

--
-- Index pour la table `sales_log`
--
ALTER TABLE `sales_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_status_sale_id_foreign` (`sale_id`);

--
-- Index pour la table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `selected_installments`
--
ALTER TABLE `selected_installments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selected_installments_user_id_foreign` (`user_id`),
  ADD KEY `selected_installments_installment_id_foreign` (`installment_id`),
  ADD KEY `selected_installments_installment_order_id_foreign` (`installment_order_id`);

--
-- Index pour la table `selected_installment_steps`
--
ALTER TABLE `selected_installment_steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selected_installment_steps_selected_installment_id_foreign` (`selected_installment_id`),
  ADD KEY `selected_installment_steps_installment_step_id_foreign` (`installment_step_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `sessions_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `sessions_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `sessions_chapter_id_foreign` (`chapter_id`),
  ADD KEY `sessions_reserve_meeting_id_foreign` (`reserve_meeting_id`),
  ADD KEY `sessions_event_id_foreign` (`event_id`),
  ADD KEY `meeting_package_sold_id` (`meeting_package_sold_id`);

--
-- Index pour la table `session_attendance`
--
ALTER TABLE `session_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_attendance_student_id_foreign` (`student_id`),
  ADD KEY `session_attendance_session_id_foreign` (`session_id`);

--
-- Index pour la table `session_attendance_notifications`
--
ALTER TABLE `session_attendance_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_attendance_notifications_session_id_foreign` (`session_id`);

--
-- Index pour la table `session_reminds`
--
ALTER TABLE `session_reminds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_reminds_session_id_foreign` (`session_id`),
  ADD KEY `session_reminds_user_id_foreign` (`user_id`);

--
-- Index pour la table `session_translations`
--
ALTER TABLE `session_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_translations_session_id_foreign` (`session_id`),
  ADD KEY `session_translations_locale_index` (`locale`);

--
-- Index pour la table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `name` (`name`) USING BTREE;

--
-- Index pour la table `setting_translations`
--
ALTER TABLE `setting_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setting_translations_setting_id_foreign` (`setting_id`),
  ADD KEY `setting_translations_locale_index` (`locale`);

--
-- Index pour la table `special_offers`
--
ALTER TABLE `special_offers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `special_offers_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `special_offers_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `special_offers_bundle_id_foreign` (`bundle_id`),
  ADD KEY `special_offers_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `special_offers_registration_package_id_foreign` (`registration_package_id`);

--
-- Index pour la table `specific_locations`
--
ALTER TABLE `specific_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specific_locations_country_id_foreign` (`country_id`),
  ADD KEY `specific_locations_province_id_foreign` (`province_id`),
  ADD KEY `specific_locations_city_id_foreign` (`city_id`),
  ADD KEY `specific_locations_district_id_foreign` (`district_id`);

--
-- Index pour la table `subscribes`
--
ALTER TABLE `subscribes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `subscribe_reminds`
--
ALTER TABLE `subscribe_reminds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscribe_reminds_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `subscribe_reminds_user_id_foreign` (`user_id`);

--
-- Index pour la table `subscribe_specification_items`
--
ALTER TABLE `subscribe_specification_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscribe_specification_items_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `subscribe_specification_items_category_id_foreign` (`category_id`),
  ADD KEY `subscribe_specification_items_instructor_id_foreign` (`instructor_id`),
  ADD KEY `subscribe_specification_items_course_id_foreign` (`course_id`),
  ADD KEY `subscribe_specification_items_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `subscribe_translations`
--
ALTER TABLE `subscribe_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscribe_translations_subscribe_id_foreign` (`subscribe_id`),
  ADD KEY `subscribe_translations_locale_index` (`locale`);

--
-- Index pour la table `subscribe_uses`
--
ALTER TABLE `subscribe_uses`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `subscribe_uses_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `subscribe_uses_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `subscribe_uses_subscribe_id_foreign` (`subscribe_id`) USING BTREE,
  ADD KEY `subscribe_uses_sale_id_foreign` (`sale_id`) USING BTREE,
  ADD KEY `subscribe_uses_bundle_id_foreign` (`bundle_id`),
  ADD KEY `subscribe_uses_installment_order_id_foreign` (`installment_order_id`);

--
-- Index pour la table `supports`
--
ALTER TABLE `supports`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `supports_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `supports_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `supports_department_id_foreign` (`department_id`) USING BTREE;

--
-- Index pour la table `support_conversations`
--
ALTER TABLE `support_conversations`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `support_conversations_support_id_foreign` (`support_id`) USING BTREE,
  ADD KEY `support_conversations_sender_id_foreign` (`sender_id`) USING BTREE,
  ADD KEY `support_conversations_supporter_id_foreign` (`supporter_id`) USING BTREE;

--
-- Index pour la table `support_departments`
--
ALTER TABLE `support_departments`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `support_department_translations`
--
ALTER TABLE `support_department_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `support_department_id` (`support_department_id`),
  ADD KEY `support_department_translations_locale_index` (`locale`);

--
-- Index pour la table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `tags_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `tags_bundle_id_foreign` (`bundle_id`),
  ADD KEY `tags_upcoming_course_id_foreign` (`upcoming_course_id`);

--
-- Index pour la table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testimonial_translations_testimonial_id_foreign` (`testimonial_id`),
  ADD KEY `testimonial_translations_locale_index` (`locale`);

--
-- Index pour la table `text_lessons`
--
ALTER TABLE `text_lessons`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `text_lessons_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `text_lessons_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `text_lessons_chapter_id_foreign` (`chapter_id`);

--
-- Index pour la table `text_lessons_attachments`
--
ALTER TABLE `text_lessons_attachments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `text_lessons_attachments_text_lesson_id_foreign` (`text_lesson_id`) USING BTREE,
  ADD KEY `text_lessons_attachments_file_id_foreign` (`file_id`) USING BTREE;

--
-- Index pour la table `text_lesson_translations`
--
ALTER TABLE `text_lesson_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `text_lesson_id` (`text_lesson_id`),
  ADD KEY `text_lesson_translations_locale_index` (`locale`);

--
-- Index pour la table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `themes_color_id_foreign` (`color_id`),
  ADD KEY `themes_font_id_foreign` (`font_id`),
  ADD KEY `themes_header_id_foreign` (`header_id`),
  ADD KEY `themes_footer_id_foreign` (`footer_id`),
  ADD KEY `themes_home_landing_id_foreign` (`home_landing_id`);

--
-- Index pour la table `theme_colors_fonts`
--
ALTER TABLE `theme_colors_fonts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `theme_headers_footers`
--
ALTER TABLE `theme_headers_footers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `theme_headers_footers_component_name_unique` (`component_name`);

--
-- Index pour la table `theme_header_footer_translations`
--
ALTER TABLE `theme_header_footer_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `theme_header_footer_id_trans` (`theme_header_footer_id`),
  ADD KEY `theme_header_footer_translations_locale_index` (`locale`);

--
-- Index pour la table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `tickets_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `tickets_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `tickets_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `ticket_translations`
--
ALTER TABLE `ticket_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_translations_ticket_id_foreign` (`ticket_id`),
  ADD KEY `ticket_translations_locale_index` (`locale`);

--
-- Index pour la table `ticket_users`
--
ALTER TABLE `ticket_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `ticket_users_ticket_id_foreign` (`ticket_id`) USING BTREE,
  ADD KEY `ticket_users_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `time_spent_on_courses`
--
ALTER TABLE `time_spent_on_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time_spent_on_courses_course_id_foreign` (`course_id`);

--
-- Index pour la table `trend_categories`
--
ALTER TABLE `trend_categories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `trend_categories_category_id_index` (`category_id`) USING BTREE;

--
-- Index pour la table `upcoming_courses`
--
ALTER TABLE `upcoming_courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `upcoming_courses_slug_unique` (`slug`),
  ADD KEY `upcoming_courses_creator_id_foreign` (`creator_id`),
  ADD KEY `upcoming_courses_teacher_id_foreign` (`teacher_id`),
  ADD KEY `upcoming_courses_category_id_foreign` (`category_id`),
  ADD KEY `upcoming_courses_webinar_id_foreign` (`webinar_id`);

--
-- Index pour la table `upcoming_course_filter_option`
--
ALTER TABLE `upcoming_course_filter_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `upcoming_course_filter_option_upcoming_course_id_foreign` (`upcoming_course_id`),
  ADD KEY `upcoming_course_filter_option_filter_option_id_foreign` (`filter_option_id`);

--
-- Index pour la table `upcoming_course_followers`
--
ALTER TABLE `upcoming_course_followers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `upcoming_course_followers_upcoming_course_id_foreign` (`upcoming_course_id`),
  ADD KEY `upcoming_course_followers_user_id_foreign` (`user_id`);

--
-- Index pour la table `upcoming_course_reports`
--
ALTER TABLE `upcoming_course_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `upcoming_course_reports_upcoming_course_id_foreign` (`upcoming_course_id`),
  ADD KEY `upcoming_course_reports_user_id_foreign` (`user_id`);

--
-- Index pour la table `upcoming_course_translations`
--
ALTER TABLE `upcoming_course_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `upcoming_course_translations_upcoming_course_id_foreign` (`upcoming_course_id`),
  ADD KEY `upcoming_course_translations_locale_index` (`locale`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE,
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`) USING BTREE,
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_country_id_foreign` (`country_id`),
  ADD KEY `users_province_id_foreign` (`province_id`),
  ADD KEY `users_city_id_foreign` (`city_id`),
  ADD KEY `users_district_id_foreign` (`district_id`);

--
-- Index pour la table `users_badges`
--
ALTER TABLE `users_badges`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `users_badges_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `users_badges_badge_id_foreign` (`badge_id`) USING BTREE;

--
-- Index pour la table `users_cookie_security`
--
ALTER TABLE `users_cookie_security`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_cookie_security_user_id_foreign` (`user_id`);

--
-- Index pour la table `users_manual_purchase`
--
ALTER TABLE `users_manual_purchase`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users_metas`
--
ALTER TABLE `users_metas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_metas_user_id_foreign` (`user_id`);

--
-- Index pour la table `users_occupations`
--
ALTER TABLE `users_occupations`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `users_occupations_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `users_occupations_category_id_foreign` (`category_id`) USING BTREE;

--
-- Index pour la table `users_registration_packages`
--
ALTER TABLE `users_registration_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_registration_packages_user_id_foreign` (`user_id`);

--
-- Index pour la table `users_zoom_api`
--
ALTER TABLE `users_zoom_api`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_zoom_api_user_id_foreign` (`user_id`);

--
-- Index pour la table `user_banks`
--
ALTER TABLE `user_banks`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_bank_specifications`
--
ALTER TABLE `user_bank_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_bank_specifications_user_bank_id_foreign` (`user_bank_id`);

--
-- Index pour la table `user_bank_specification_translations`
--
ALTER TABLE `user_bank_specification_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_bank_specification_id` (`user_bank_specification_id`),
  ADD KEY `user_bank_specification_translations_locale_index` (`locale`);

--
-- Index pour la table `user_bank_translations`
--
ALTER TABLE `user_bank_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_bank_translations_user_bank_id_foreign` (`user_bank_id`),
  ADD KEY `user_bank_translations_locale_index` (`locale`);

--
-- Index pour la table `user_commissions`
--
ALTER TABLE `user_commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_commissions_user_id_foreign` (`user_id`),
  ADD KEY `user_commissions_user_group_id_foreign` (`user_group_id`);

--
-- Index pour la table `user_firebase_sessions`
--
ALTER TABLE `user_firebase_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_firebase_sessions_user_id_foreign` (`user_id`);

--
-- Index pour la table `user_form_fields`
--
ALTER TABLE `user_form_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_form_fields_user_id_foreign` (`user_id`),
  ADD KEY `user_form_fields_become_instructor_id_foreign` (`become_instructor_id`),
  ADD KEY `user_form_fields_form_field_id_foreign` (`form_field_id`);

--
-- Index pour la table `user_login_histories`
--
ALTER TABLE `user_login_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_login_histories_user_id_foreign` (`user_id`);

--
-- Index pour la table `user_profile_attachments`
--
ALTER TABLE `user_profile_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_profile_attachments_user_id_foreign` (`user_id`);

--
-- Index pour la table `user_profile_attachment_translations`
--
ALTER TABLE `user_profile_attachment_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_profile_attachment_id_trans` (`user_profile_attachment_id`),
  ADD KEY `user_profile_attachment_translations_locale_index` (`locale`);

--
-- Index pour la table `user_selected_banks`
--
ALTER TABLE `user_selected_banks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_selected_banks_user_bank_id_foreign` (`user_bank_id`),
  ADD KEY `user_selected_banks_user_id_foreign` (`user_id`);

--
-- Index pour la table `user_selected_bank_specifications`
--
ALTER TABLE `user_selected_bank_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_selected_bank_id_specifications` (`user_selected_bank_id`),
  ADD KEY `user_bank_specification_id_specifications` (`user_bank_specification_id`);

--
-- Index pour la table `verifications`
--
ALTER TABLE `verifications`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `verifications_user_id_foreign` (`user_id`) USING BTREE;

--
-- Index pour la table `visits_logs`
--
ALTER TABLE `visits_logs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `waitlists`
--
ALTER TABLE `waitlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `waitlists_webinar_id_foreign` (`webinar_id`),
  ADD KEY `waitlists_user_id_foreign` (`user_id`);

--
-- Index pour la table `webinars`
--
ALTER TABLE `webinars`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `webinars_slug_unique` (`slug`) USING BTREE,
  ADD KEY `webinars_teacher_id_foreign` (`teacher_id`) USING BTREE,
  ADD KEY `webinars_category_id_foreign` (`category_id`) USING BTREE,
  ADD KEY `webinars_slug_index` (`slug`) USING BTREE,
  ADD KEY `webinars_creator_id_foreign` (`creator_id`) USING BTREE;

--
-- Index pour la table `webinar_assignments`
--
ALTER TABLE `webinar_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_assignments_creator_id_foreign` (`creator_id`),
  ADD KEY `webinar_assignments_webinar_id_foreign` (`webinar_id`),
  ADD KEY `webinar_assignments_chapter_id_foreign` (`chapter_id`);

--
-- Index pour la table `webinar_assignment_attachments`
--
ALTER TABLE `webinar_assignment_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_assignment_attachments_assignment_id_foreign` (`assignment_id`);

--
-- Index pour la table `webinar_assignment_history`
--
ALTER TABLE `webinar_assignment_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_assignment_history_instructor_id_foreign` (`instructor_id`),
  ADD KEY `webinar_assignment_history_student_id_foreign` (`student_id`),
  ADD KEY `webinar_assignment_history_assignment_id_foreign` (`assignment_id`);

--
-- Index pour la table `webinar_assignment_history_messages`
--
ALTER TABLE `webinar_assignment_history_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_assignment_history_id` (`assignment_history_id`);

--
-- Index pour la table `webinar_assignment_translations`
--
ALTER TABLE `webinar_assignment_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_assignment_id_translate_foreign` (`webinar_assignment_id`),
  ADD KEY `webinar_assignment_translations_locale_index` (`locale`);

--
-- Index pour la table `webinar_chapters`
--
ALTER TABLE `webinar_chapters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_chapters_user_id_foreign` (`user_id`),
  ADD KEY `webinar_chapters_webinar_id_foreign` (`webinar_id`);

--
-- Index pour la table `webinar_chapter_items`
--
ALTER TABLE `webinar_chapter_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_chapter_items_chapter_id_foreign` (`chapter_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `webinar_chapter_translations`
--
ALTER TABLE `webinar_chapter_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_chapter_id` (`webinar_chapter_id`),
  ADD KEY `webinar_chapter_translations_locale_index` (`locale`);

--
-- Index pour la table `webinar_extra_descriptions`
--
ALTER TABLE `webinar_extra_descriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_extra_descriptions_creator_id_foreign` (`creator_id`),
  ADD KEY `webinar_extra_descriptions_webinar_id_foreign` (`webinar_id`),
  ADD KEY `webinar_extra_descriptions_upcoming_course_id_foreign` (`upcoming_course_id`);

--
-- Index pour la table `webinar_extra_description_translations`
--
ALTER TABLE `webinar_extra_description_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_extra_description_id_foreign` (`webinar_extra_description_id`),
  ADD KEY `webinar_extra_description_translations_locale_index` (`locale`);

--
-- Index pour la table `webinar_filter_option`
--
ALTER TABLE `webinar_filter_option`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `webinar_filter_option_filter_option_id_foreign` (`filter_option_id`) USING BTREE,
  ADD KEY `webinar_filter_option_webinar_id_foreign` (`webinar_id`) USING BTREE;

--
-- Index pour la table `webinar_partner_teacher`
--
ALTER TABLE `webinar_partner_teacher`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `webinar_partner_teacher_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `webinar_partner_teacher_teacher_id_foreign` (`teacher_id`) USING BTREE;

--
-- Index pour la table `webinar_reports`
--
ALTER TABLE `webinar_reports`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `webinar_reports_webinar_id_foreign` (`webinar_id`) USING BTREE;

--
-- Index pour la table `webinar_reviews`
--
ALTER TABLE `webinar_reviews`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `webinar_reviews_webinar_id_foreign` (`webinar_id`) USING BTREE,
  ADD KEY `webinar_reviews_creator_id_foreign` (`creator_id`) USING BTREE,
  ADD KEY `webinar_reviews_bundle_id_foreign` (`bundle_id`);

--
-- Index pour la table `webinar_translations`
--
ALTER TABLE `webinar_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_translations_webinar_id_foreign` (`webinar_id`),
  ADD KEY `webinar_translations_locale_index` (`locale`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `abandoned_cart_rules`
--
ALTER TABLE `abandoned_cart_rules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `abandoned_cart_rule_histories`
--
ALTER TABLE `abandoned_cart_rule_histories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `abandoned_cart_rule_specification_items`
--
ALTER TABLE `abandoned_cart_rule_specification_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `abandoned_cart_rule_translations`
--
ALTER TABLE `abandoned_cart_rule_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `abandoned_cart_rule_users_groups`
--
ALTER TABLE `abandoned_cart_rule_users_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `accounting`
--
ALTER TABLE `accounting`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `advertising_banners`
--
ALTER TABLE `advertising_banners`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `advertising_banners_translations`
--
ALTER TABLE `advertising_banners_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `affiliates`
--
ALTER TABLE `affiliates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `affiliates_codes`
--
ALTER TABLE `affiliates_codes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `agora_history`
--
ALTER TABLE `agora_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `ai_contents`
--
ALTER TABLE `ai_contents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `ai_content_templates`
--
ALTER TABLE `ai_content_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `ai_content_template_translations`
--
ALTER TABLE `ai_content_template_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `badges`
--
ALTER TABLE `badges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT pour la table `badge_translations`
--
ALTER TABLE `badge_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `become_instructors`
--
ALTER TABLE `become_instructors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `blog_featured_categories`
--
ALTER TABLE `blog_featured_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `blog_translations`
--
ALTER TABLE `blog_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `bulk_imports`
--
ALTER TABLE `bulk_imports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bundles`
--
ALTER TABLE `bundles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `bundle_filter_option`
--
ALTER TABLE `bundle_filter_option`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT pour la table `bundle_translations`
--
ALTER TABLE `bundle_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `bundle_webinars`
--
ALTER TABLE `bundle_webinars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT pour la table `cart_discounts`
--
ALTER TABLE `cart_discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cart_discount_translations`
--
ALTER TABLE `cart_discount_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cashback_rules`
--
ALTER TABLE `cashback_rules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `cashback_rule_specification_items`
--
ALTER TABLE `cashback_rule_specification_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `cashback_rule_translations`
--
ALTER TABLE `cashback_rule_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `cashback_rule_users_groups`
--
ALTER TABLE `cashback_rule_users_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=615;

--
-- AUTO_INCREMENT pour la table `category_translations`
--
ALTER TABLE `category_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT pour la table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `certificates_templates`
--
ALTER TABLE `certificates_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `certificate_template_translations`
--
ALTER TABLE `certificate_template_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT pour la table `comments_reports`
--
ALTER TABLE `comments_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `content_delete_requests`
--
ALTER TABLE `content_delete_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `course_forums`
--
ALTER TABLE `course_forums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `course_forum_answers`
--
ALTER TABLE `course_forum_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `course_learning`
--
ALTER TABLE `course_learning`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT pour la table `course_learning_last_views`
--
ALTER TABLE `course_learning_last_views`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `course_noticeboards`
--
ALTER TABLE `course_noticeboards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `course_noticeboard_status`
--
ALTER TABLE `course_noticeboard_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `course_personal_notes`
--
ALTER TABLE `course_personal_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `delete_account_requests`
--
ALTER TABLE `delete_account_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `discount_bundles`
--
ALTER TABLE `discount_bundles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `discount_categories`
--
ALTER TABLE `discount_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `discount_courses`
--
ALTER TABLE `discount_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `discount_events`
--
ALTER TABLE `discount_events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `discount_groups`
--
ALTER TABLE `discount_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `discount_meeting_packages`
--
ALTER TABLE `discount_meeting_packages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `discount_users`
--
ALTER TABLE `discount_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_filter_options`
--
ALTER TABLE `event_filter_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_reports`
--
ALTER TABLE `event_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_speakers`
--
ALTER TABLE `event_speakers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_speaker_translations`
--
ALTER TABLE `event_speaker_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_tickets`
--
ALTER TABLE `event_tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_tickets_sold`
--
ALTER TABLE `event_tickets_sold`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_ticket_translations`
--
ALTER TABLE `event_ticket_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `event_translations`
--
ALTER TABLE `event_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `faq_translations`
--
ALTER TABLE `faq_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `feature_webinars`
--
ALTER TABLE `feature_webinars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `feature_webinar_translations`
--
ALTER TABLE `feature_webinar_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT pour la table `file_translations`
--
ALTER TABLE `file_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT pour la table `filters`
--
ALTER TABLE `filters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1848;

--
-- AUTO_INCREMENT pour la table `filter_options`
--
ALTER TABLE `filter_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9293;

--
-- AUTO_INCREMENT pour la table `filter_option_translations`
--
ALTER TABLE `filter_option_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1227;

--
-- AUTO_INCREMENT pour la table `filter_translations`
--
ALTER TABLE `filter_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=278;

--
-- AUTO_INCREMENT pour la table `floating_bars`
--
ALTER TABLE `floating_bars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `floating_bar_translations`
--
ALTER TABLE `floating_bar_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `follows`
--
ALTER TABLE `follows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `form_fields`
--
ALTER TABLE `form_fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `form_field_options`
--
ALTER TABLE `form_field_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `form_field_option_translations`
--
ALTER TABLE `form_field_option_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `form_field_translations`
--
ALTER TABLE `form_field_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `form_roles_users_groups`
--
ALTER TABLE `form_roles_users_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `form_submissions`
--
ALTER TABLE `form_submissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `form_submission_items`
--
ALTER TABLE `form_submission_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `form_translations`
--
ALTER TABLE `form_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `forums`
--
ALTER TABLE `forums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `forum_featured_topics`
--
ALTER TABLE `forum_featured_topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `forum_recommended_topics`
--
ALTER TABLE `forum_recommended_topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `forum_recommended_topic_items`
--
ALTER TABLE `forum_recommended_topic_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `forum_recommended_topic_translations`
--
ALTER TABLE `forum_recommended_topic_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `forum_topics`
--
ALTER TABLE `forum_topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `forum_topic_attachments`
--
ALTER TABLE `forum_topic_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `forum_topic_bookmarks`
--
ALTER TABLE `forum_topic_bookmarks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `forum_topic_likes`
--
ALTER TABLE `forum_topic_likes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `forum_topic_posts`
--
ALTER TABLE `forum_topic_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `forum_topic_reports`
--
ALTER TABLE `forum_topic_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `forum_topic_visits`
--
ALTER TABLE `forum_topic_visits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `forum_translations`
--
ALTER TABLE `forum_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `gifts`
--
ALTER TABLE `gifts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `groups_registration_packages`
--
ALTER TABLE `groups_registration_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `group_users`
--
ALTER TABLE `group_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT pour la table `home_page_statistics`
--
ALTER TABLE `home_page_statistics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `home_page_statistic_translations`
--
ALTER TABLE `home_page_statistic_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `home_sections`
--
ALTER TABLE `home_sections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `installments`
--
ALTER TABLE `installments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `installment_orders`
--
ALTER TABLE `installment_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `installment_order_attachments`
--
ALTER TABLE `installment_order_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `installment_order_payments`
--
ALTER TABLE `installment_order_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `installment_reminders`
--
ALTER TABLE `installment_reminders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `installment_specification_items`
--
ALTER TABLE `installment_specification_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `installment_steps`
--
ALTER TABLE `installment_steps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `installment_step_translations`
--
ALTER TABLE `installment_step_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `installment_translations`
--
ALTER TABLE `installment_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `installment_user_groups`
--
ALTER TABLE `installment_user_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ip_restrictions`
--
ALTER TABLE `ip_restrictions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `jazzcash_transactions`
--
ALTER TABLE `jazzcash_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `landings`
--
ALTER TABLE `landings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `landing_builder_components`
--
ALTER TABLE `landing_builder_components`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT pour la table `landing_components`
--
ALTER TABLE `landing_components`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=439;

--
-- AUTO_INCREMENT pour la table `landing_component_translations`
--
ALTER TABLE `landing_component_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=432;

--
-- AUTO_INCREMENT pour la table `landing_translations`
--
ALTER TABLE `landing_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `meetings`
--
ALTER TABLE `meetings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT pour la table `meeting_packages`
--
ALTER TABLE `meeting_packages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `meeting_packages_sold`
--
ALTER TABLE `meeting_packages_sold`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `meeting_package_translations`
--
ALTER TABLE `meeting_package_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `meeting_times`
--
ALTER TABLE `meeting_times`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=626;

--
-- AUTO_INCREMENT pour la table `navbar_buttons`
--
ALTER TABLE `navbar_buttons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `navbar_button_translations`
--
ALTER TABLE `navbar_button_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `newsletters_history`
--
ALTER TABLE `newsletters_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `noticeboards`
--
ALTER TABLE `noticeboards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `noticeboards_status`
--
ALTER TABLE `noticeboards_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT pour la table `notifications_status`
--
ALTER TABLE `notifications_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT pour la table `offline_banks`
--
ALTER TABLE `offline_banks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `offline_bank_specifications`
--
ALTER TABLE `offline_bank_specifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `offline_bank_specification_translations`
--
ALTER TABLE `offline_bank_specification_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `offline_bank_translations`
--
ALTER TABLE `offline_bank_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `offline_payments`
--
ALTER TABLE `offline_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `page_translations`
--
ALTER TABLE `page_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `payment_channels`
--
ALTER TABLE `payment_channels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT pour la table `payouts`
--
ALTER TABLE `payouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `payu_transactions`
--
ALTER TABLE `payu_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23454;

--
-- AUTO_INCREMENT pour la table `prerequisites`
--
ALTER TABLE `prerequisites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `product_badges`
--
ALTER TABLE `product_badges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `product_badge_contents`
--
ALTER TABLE `product_badge_contents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `product_badge_translations`
--
ALTER TABLE `product_badge_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `product_category_translations`
--
ALTER TABLE `product_category_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `product_discounts`
--
ALTER TABLE `product_discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `product_faqs`
--
ALTER TABLE `product_faqs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `product_faq_translations`
--
ALTER TABLE `product_faq_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `product_featured_categories`
--
ALTER TABLE `product_featured_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `product_files`
--
ALTER TABLE `product_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `product_file_translations`
--
ALTER TABLE `product_file_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `product_filters`
--
ALTER TABLE `product_filters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `product_filter_options`
--
ALTER TABLE `product_filter_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `product_filter_option_translations`
--
ALTER TABLE `product_filter_option_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `product_filter_translations`
--
ALTER TABLE `product_filter_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `product_media`
--
ALTER TABLE `product_media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT pour la table `product_orders`
--
ALTER TABLE `product_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `product_selected_filter_options`
--
ALTER TABLE `product_selected_filter_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT pour la table `product_selected_specifications`
--
ALTER TABLE `product_selected_specifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `product_selected_specification_multi_values`
--
ALTER TABLE `product_selected_specification_multi_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `product_selected_specification_translations`
--
ALTER TABLE `product_selected_specification_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `product_specifications`
--
ALTER TABLE `product_specifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `product_specification_categories`
--
ALTER TABLE `product_specification_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT pour la table `product_specification_multi_values`
--
ALTER TABLE `product_specification_multi_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `product_specification_multi_value_translations`
--
ALTER TABLE `product_specification_multi_value_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `product_specification_translations`
--
ALTER TABLE `product_specification_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `product_top_categories`
--
ALTER TABLE `product_top_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `product_translations`
--
ALTER TABLE `product_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `promotion_translations`
--
ALTER TABLE `promotion_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `purchase_code`
--
ALTER TABLE `purchase_code`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `purchase_notifications`
--
ALTER TABLE `purchase_notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `purchase_notification_histories`
--
ALTER TABLE `purchase_notification_histories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `purchase_notification_roles_groups_contents`
--
ALTER TABLE `purchase_notification_roles_groups_contents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT pour la table `purchase_notification_translations`
--
ALTER TABLE `purchase_notification_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT pour la table `quizzes_questions`
--
ALTER TABLE `quizzes_questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT pour la table `quizzes_questions_answers`
--
ALTER TABLE `quizzes_questions_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT pour la table `quizzes_questions_answer_translations`
--
ALTER TABLE `quizzes_questions_answer_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT pour la table `quizzes_results`
--
ALTER TABLE `quizzes_results`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `quiz_question_translations`
--
ALTER TABLE `quiz_question_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `quiz_translations`
--
ALTER TABLE `quiz_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT pour la table `registration_packages`
--
ALTER TABLE `registration_packages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `registration_packages_translations`
--
ALTER TABLE `registration_packages_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `related_courses`
--
ALTER TABLE `related_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `related_posts`
--
ALTER TABLE `related_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `related_products`
--
ALTER TABLE `related_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reserve_meetings`
--
ALTER TABLE `reserve_meetings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `rewards`
--
ALTER TABLE `rewards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `rewards_accounting`
--
ALTER TABLE `rewards_accounting`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=333;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `role_translations`
--
ALTER TABLE `role_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `sales_log`
--
ALTER TABLE `sales_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100304;

--
-- AUTO_INCREMENT pour la table `selected_installments`
--
ALTER TABLE `selected_installments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `selected_installment_steps`
--
ALTER TABLE `selected_installment_steps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT pour la table `session_attendance`
--
ALTER TABLE `session_attendance`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `session_attendance_notifications`
--
ALTER TABLE `session_attendance_notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `session_reminds`
--
ALTER TABLE `session_reminds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `session_translations`
--
ALTER TABLE `session_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT pour la table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT pour la table `setting_translations`
--
ALTER TABLE `setting_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT pour la table `special_offers`
--
ALTER TABLE `special_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `specific_locations`
--
ALTER TABLE `specific_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `subscribes`
--
ALTER TABLE `subscribes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `subscribe_reminds`
--
ALTER TABLE `subscribe_reminds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `subscribe_specification_items`
--
ALTER TABLE `subscribe_specification_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `subscribe_translations`
--
ALTER TABLE `subscribe_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `subscribe_uses`
--
ALTER TABLE `subscribe_uses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `supports`
--
ALTER TABLE `supports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `support_conversations`
--
ALTER TABLE `support_conversations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `support_departments`
--
ALTER TABLE `support_departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `support_department_translations`
--
ALTER TABLE `support_department_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6779;

--
-- AUTO_INCREMENT pour la table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `text_lessons`
--
ALTER TABLE `text_lessons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `text_lessons_attachments`
--
ALTER TABLE `text_lessons_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `text_lesson_translations`
--
ALTER TABLE `text_lesson_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `themes`
--
ALTER TABLE `themes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `theme_colors_fonts`
--
ALTER TABLE `theme_colors_fonts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `theme_headers_footers`
--
ALTER TABLE `theme_headers_footers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `theme_header_footer_translations`
--
ALTER TABLE `theme_header_footer_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT pour la table `ticket_translations`
--
ALTER TABLE `ticket_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `ticket_users`
--
ALTER TABLE `ticket_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `time_spent_on_courses`
--
ALTER TABLE `time_spent_on_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT pour la table `trend_categories`
--
ALTER TABLE `trend_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `upcoming_courses`
--
ALTER TABLE `upcoming_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `upcoming_course_filter_option`
--
ALTER TABLE `upcoming_course_filter_option`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT pour la table `upcoming_course_followers`
--
ALTER TABLE `upcoming_course_followers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `upcoming_course_reports`
--
ALTER TABLE `upcoming_course_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `upcoming_course_translations`
--
ALTER TABLE `upcoming_course_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1141;

--
-- AUTO_INCREMENT pour la table `users_badges`
--
ALTER TABLE `users_badges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `users_cookie_security`
--
ALTER TABLE `users_cookie_security`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `users_manual_purchase`
--
ALTER TABLE `users_manual_purchase`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users_metas`
--
ALTER TABLE `users_metas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT pour la table `users_occupations`
--
ALTER TABLE `users_occupations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1080;

--
-- AUTO_INCREMENT pour la table `users_registration_packages`
--
ALTER TABLE `users_registration_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users_zoom_api`
--
ALTER TABLE `users_zoom_api`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user_banks`
--
ALTER TABLE `user_banks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user_bank_specifications`
--
ALTER TABLE `user_bank_specifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `user_bank_specification_translations`
--
ALTER TABLE `user_bank_specification_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `user_bank_translations`
--
ALTER TABLE `user_bank_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `user_commissions`
--
ALTER TABLE `user_commissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_firebase_sessions`
--
ALTER TABLE `user_firebase_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_form_fields`
--
ALTER TABLE `user_form_fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_login_histories`
--
ALTER TABLE `user_login_histories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT pour la table `user_profile_attachments`
--
ALTER TABLE `user_profile_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_profile_attachment_translations`
--
ALTER TABLE `user_profile_attachment_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_selected_banks`
--
ALTER TABLE `user_selected_banks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user_selected_bank_specifications`
--
ALTER TABLE `user_selected_bank_specifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `verifications`
--
ALTER TABLE `verifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT pour la table `visits_logs`
--
ALTER TABLE `visits_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1759;

--
-- AUTO_INCREMENT pour la table `waitlists`
--
ALTER TABLE `waitlists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `webinars`
--
ALTER TABLE `webinars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2073;

--
-- AUTO_INCREMENT pour la table `webinar_assignments`
--
ALTER TABLE `webinar_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `webinar_assignment_attachments`
--
ALTER TABLE `webinar_assignment_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `webinar_assignment_history`
--
ALTER TABLE `webinar_assignment_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `webinar_assignment_history_messages`
--
ALTER TABLE `webinar_assignment_history_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `webinar_assignment_translations`
--
ALTER TABLE `webinar_assignment_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `webinar_chapters`
--
ALTER TABLE `webinar_chapters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT pour la table `webinar_chapter_items`
--
ALTER TABLE `webinar_chapter_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT pour la table `webinar_chapter_translations`
--
ALTER TABLE `webinar_chapter_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- AUTO_INCREMENT pour la table `webinar_extra_descriptions`
--
ALTER TABLE `webinar_extra_descriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=696;

--
-- AUTO_INCREMENT pour la table `webinar_extra_description_translations`
--
ALTER TABLE `webinar_extra_description_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=696;

--
-- AUTO_INCREMENT pour la table `webinar_filter_option`
--
ALTER TABLE `webinar_filter_option`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11828;

--
-- AUTO_INCREMENT pour la table `webinar_partner_teacher`
--
ALTER TABLE `webinar_partner_teacher`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT pour la table `webinar_reports`
--
ALTER TABLE `webinar_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `webinar_reviews`
--
ALTER TABLE `webinar_reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `webinar_translations`
--
ALTER TABLE `webinar_translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `abandoned_cart_rules`
--
ALTER TABLE `abandoned_cart_rules`
  ADD CONSTRAINT `abandoned_cart_rules_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `abandoned_cart_rule_specification_items`
--
ALTER TABLE `abandoned_cart_rule_specification_items`
  ADD CONSTRAINT `abandoned_cart_rule_id_foreign` FOREIGN KEY (`abandoned_cart_rule_id`) REFERENCES `abandoned_cart_rules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_specification_items_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `abandoned_cart_rule_translations`
--
ALTER TABLE `abandoned_cart_rule_translations`
  ADD CONSTRAINT `abandoned_cart_rule_id_trans` FOREIGN KEY (`abandoned_cart_rule_id`) REFERENCES `abandoned_cart_rules` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `abandoned_cart_rule_users_groups`
--
ALTER TABLE `abandoned_cart_rule_users_groups`
  ADD CONSTRAINT `abandoned_cart_rule_id` FOREIGN KEY (`abandoned_cart_rule_id`) REFERENCES `abandoned_cart_rules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_users_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `abandoned_cart_rule_users_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `accounting`
--
ALTER TABLE `accounting`
  ADD CONSTRAINT `accounting_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `advertising_banners_translations`
--
ALTER TABLE `advertising_banners_translations`
  ADD CONSTRAINT `advertising_banners_translations_advertising_banner_id_foreign` FOREIGN KEY (`advertising_banner_id`) REFERENCES `advertising_banners` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `affiliates`
--
ALTER TABLE `affiliates`
  ADD CONSTRAINT `affiliates_affiliate_user_id_foreign` FOREIGN KEY (`affiliate_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `affiliates_referred_user_id_foreign` FOREIGN KEY (`referred_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `affiliates_codes`
--
ALTER TABLE `affiliates_codes`
  ADD CONSTRAINT `affiliates_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `agora_history`
--
ALTER TABLE `agora_history`
  ADD CONSTRAINT `agora_history_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ai_contents`
--
ALTER TABLE `ai_contents`
  ADD CONSTRAINT `ai_contents_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `ai_content_templates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ai_contents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ai_content_template_translations`
--
ALTER TABLE `ai_content_template_translations`
  ADD CONSTRAINT `ai_content_template_id_trans` FOREIGN KEY (`ai_content_template_id`) REFERENCES `ai_content_templates` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `badge_translations`
--
ALTER TABLE `badge_translations`
  ADD CONSTRAINT `badge_translations_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `become_instructors`
--
ALTER TABLE `become_instructors`
  ADD CONSTRAINT `become_instructors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `blog`
--
ALTER TABLE `blog`
  ADD CONSTRAINT `blog_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `blog_category_translations`
--
ALTER TABLE `blog_category_translations`
  ADD CONSTRAINT `blog_category_translations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `blog_featured_categories`
--
ALTER TABLE `blog_featured_categories`
  ADD CONSTRAINT `blog_featured_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `blog_translations`
--
ALTER TABLE `blog_translations`
  ADD CONSTRAINT `blog_translations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bulk_imports`
--
ALTER TABLE `bulk_imports`
  ADD CONSTRAINT `bulk_imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bundles`
--
ALTER TABLE `bundles`
  ADD CONSTRAINT `bundles_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bundles_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bundles_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bundle_filter_option`
--
ALTER TABLE `bundle_filter_option`
  ADD CONSTRAINT `bundle_filter_option_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bundle_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bundle_translations`
--
ALTER TABLE `bundle_translations`
  ADD CONSTRAINT `bundle_translations_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bundle_webinars`
--
ALTER TABLE `bundle_webinars`
  ADD CONSTRAINT `bundle_webinars_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bundle_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_product_discount_id_foreign` FOREIGN KEY (`product_discount_id`) REFERENCES `product_discounts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cart_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_reserve_meeting_id_foreign` FOREIGN KEY (`reserve_meeting_id`) REFERENCES `reserve_meetings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_special_offer_id_foreign` FOREIGN KEY (`special_offer_id`) REFERENCES `special_offers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cart_discounts`
--
ALTER TABLE `cart_discounts`
  ADD CONSTRAINT `cart_discounts_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cart_discount_translations`
--
ALTER TABLE `cart_discount_translations`
  ADD CONSTRAINT `cart_discount_translations_cart_discount_id_foreign` FOREIGN KEY (`cart_discount_id`) REFERENCES `cart_discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cashback_rule_specification_items`
--
ALTER TABLE `cashback_rule_specification_items`
  ADD CONSTRAINT `cashback_rule_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_specification_items_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rules_registration_package_id` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cashback_rule_translations`
--
ALTER TABLE `cashback_rule_translations`
  ADD CONSTRAINT `cashback_rule_translations_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cashback_rule_users_groups`
--
ALTER TABLE `cashback_rule_users_groups`
  ADD CONSTRAINT `cashback_rule_users_groups_cashback_rule_id_foreign` FOREIGN KEY (`cashback_rule_id`) REFERENCES `cashback_rules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_users_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cashback_rule_users_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `category_translations`
--
ALTER TABLE `category_translations`
  ADD CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificates_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificates_quiz_result_id_foreign` FOREIGN KEY (`quiz_result_id`) REFERENCES `quizzes_results` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificates_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificates_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `certificate_template_translations`
--
ALTER TABLE `certificate_template_translations`
  ADD CONSTRAINT `certificate_template_id` FOREIGN KEY (`certificate_template_id`) REFERENCES `certificates_templates` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_reply_id_foreign` FOREIGN KEY (`reply_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `webinar_reviews` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `comments_reports`
--
ALTER TABLE `comments_reports`
  ADD CONSTRAINT `comments_reports_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_reports_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `content_delete_requests`
--
ALTER TABLE `content_delete_requests`
  ADD CONSTRAINT `content_delete_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Contraintes pour la table `course_forums`
--
ALTER TABLE `course_forums`
  ADD CONSTRAINT `course_forums_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_forums_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_forum_answers`
--
ALTER TABLE `course_forum_answers`
  ADD CONSTRAINT `course_forum_answers_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `course_forums` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_forum_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_learning`
--
ALTER TABLE `course_learning`
  ADD CONSTRAINT `course_learning_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_learning_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_learning_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_learning_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_learning_last_views`
--
ALTER TABLE `course_learning_last_views`
  ADD CONSTRAINT `course_learning_last_views_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_learning_last_views_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_noticeboards`
--
ALTER TABLE `course_noticeboards`
  ADD CONSTRAINT `course_noticeboards_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_noticeboard_status`
--
ALTER TABLE `course_noticeboard_status`
  ADD CONSTRAINT `course_noticeboard_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `course_noticeboards` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `course_personal_notes`
--
ALTER TABLE `course_personal_notes`
  ADD CONSTRAINT `course_personal_notes_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_personal_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `delete_account_requests`
--
ALTER TABLE `delete_account_requests`
  ADD CONSTRAINT `delete_account_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discounts`
--
ALTER TABLE `discounts`
  ADD CONSTRAINT `discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_bundles`
--
ALTER TABLE `discount_bundles`
  ADD CONSTRAINT `discount_bundles_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_bundles_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_categories`
--
ALTER TABLE `discount_categories`
  ADD CONSTRAINT `discount_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_categories_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_courses`
--
ALTER TABLE `discount_courses`
  ADD CONSTRAINT `discount_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_courses_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_groups`
--
ALTER TABLE `discount_groups`
  ADD CONSTRAINT `discount_groups_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_meeting_packages`
--
ALTER TABLE `discount_meeting_packages`
  ADD CONSTRAINT `discount_meeting_packages_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_meeting_packages_meeting_package_id_foreign` FOREIGN KEY (`meeting_package_id`) REFERENCES `meeting_packages` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `discount_users`
--
ALTER TABLE `discount_users`
  ADD CONSTRAINT `discount_users_discount_id_foreign` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discount_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `events_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_filter_options`
--
ALTER TABLE `event_filter_options`
  ADD CONSTRAINT `event_filter_options_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_filter_options_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_reports`
--
ALTER TABLE `event_reports`
  ADD CONSTRAINT `event_reports_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_speakers`
--
ALTER TABLE `event_speakers`
  ADD CONSTRAINT `event_speakers_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_speaker_translations`
--
ALTER TABLE `event_speaker_translations`
  ADD CONSTRAINT `event_speaker_translations_event_speaker_id_foreign` FOREIGN KEY (`event_speaker_id`) REFERENCES `event_speakers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_tickets`
--
ALTER TABLE `event_tickets`
  ADD CONSTRAINT `event_tickets_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_ticket_translations`
--
ALTER TABLE `event_ticket_translations`
  ADD CONSTRAINT `event_ticket_translations_event_ticket_id_foreign` FOREIGN KEY (`event_ticket_id`) REFERENCES `event_tickets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `event_translations`
--
ALTER TABLE `event_translations`
  ADD CONSTRAINT `event_translations_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faqs_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faqs_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `faq_translations`
--
ALTER TABLE `faq_translations`
  ADD CONSTRAINT `faq_translations_faq_id_foreign` FOREIGN KEY (`faq_id`) REFERENCES `faqs` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `feature_webinars`
--
ALTER TABLE `feature_webinars`
  ADD CONSTRAINT `feature_webinars_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `feature_webinar_translations`
--
ALTER TABLE `feature_webinar_translations`
  ADD CONSTRAINT `feature_webinar_translations_feature_webinar_id_foreign` FOREIGN KEY (`feature_webinar_id`) REFERENCES `feature_webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `files_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `files_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `file_translations`
--
ALTER TABLE `file_translations`
  ADD CONSTRAINT `file_translations_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `filters`
--
ALTER TABLE `filters`
  ADD CONSTRAINT `filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `filter_options`
--
ALTER TABLE `filter_options`
  ADD CONSTRAINT `filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `filter_option_translations`
--
ALTER TABLE `filter_option_translations`
  ADD CONSTRAINT `filter_option_translations_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `filter_translations`
--
ALTER TABLE `filter_translations`
  ADD CONSTRAINT `filter_translations_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `floating_bar_translations`
--
ALTER TABLE `floating_bar_translations`
  ADD CONSTRAINT `floating_bar_translations_floating_bar_id_foreign` FOREIGN KEY (`floating_bar_id`) REFERENCES `floating_bars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_follower_foreign` FOREIGN KEY (`follower`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `follows_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_fields`
--
ALTER TABLE `form_fields`
  ADD CONSTRAINT `form_fields_form_id_foreign` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_field_options`
--
ALTER TABLE `form_field_options`
  ADD CONSTRAINT `form_field_options_form_field_id_foreign` FOREIGN KEY (`form_field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_field_option_translations`
--
ALTER TABLE `form_field_option_translations`
  ADD CONSTRAINT `form_field_option_id_trans` FOREIGN KEY (`form_field_option_id`) REFERENCES `form_field_options` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_field_translations`
--
ALTER TABLE `form_field_translations`
  ADD CONSTRAINT `form_field_translations_form_field_id_foreign` FOREIGN KEY (`form_field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_roles_users_groups`
--
ALTER TABLE `form_roles_users_groups`
  ADD CONSTRAINT `form_roles_users_groups_form_id_foreign` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `form_roles_users_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `form_roles_users_groups_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `form_roles_users_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_submissions`
--
ALTER TABLE `form_submissions`
  ADD CONSTRAINT `form_submissions_form_id_foreign` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `form_submissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_submission_items`
--
ALTER TABLE `form_submission_items`
  ADD CONSTRAINT `form_submission_items_form_field_id_foreign` FOREIGN KEY (`form_field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `form_submission_items_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `form_submissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `form_translations`
--
ALTER TABLE `form_translations`
  ADD CONSTRAINT `form_translations_form_id_foreign` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forums`
--
ALTER TABLE `forums`
  ADD CONSTRAINT `forums_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forums_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_featured_topics`
--
ALTER TABLE `forum_featured_topics`
  ADD CONSTRAINT `forum_featured_topics_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_recommended_topic_items`
--
ALTER TABLE `forum_recommended_topic_items`
  ADD CONSTRAINT `forum_recommended_topic_items_recommended_topic_id_foreign` FOREIGN KEY (`recommended_topic_id`) REFERENCES `forum_recommended_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_recommended_topic_items_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_recommended_topic_translations`
--
ALTER TABLE `forum_recommended_topic_translations`
  ADD CONSTRAINT `forum_recommended_topic_id_trans` FOREIGN KEY (`forum_recommended_topic_id`) REFERENCES `forum_recommended_topics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topics`
--
ALTER TABLE `forum_topics`
  ADD CONSTRAINT `forum_topics_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topics_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_attachments`
--
ALTER TABLE `forum_topic_attachments`
  ADD CONSTRAINT `forum_topic_attachments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_attachments_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_bookmarks`
--
ALTER TABLE `forum_topic_bookmarks`
  ADD CONSTRAINT `forum_topic_bookmarks_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_likes`
--
ALTER TABLE `forum_topic_likes`
  ADD CONSTRAINT `forum_topic_likes_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_likes_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_posts`
--
ALTER TABLE `forum_topic_posts`
  ADD CONSTRAINT `forum_topic_posts_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `forum_topic_posts_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_reports`
--
ALTER TABLE `forum_topic_reports`
  ADD CONSTRAINT `forum_topic_reports_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_reports_topic_post_id_foreign` FOREIGN KEY (`topic_post_id`) REFERENCES `forum_topic_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_topic_visits`
--
ALTER TABLE `forum_topic_visits`
  ADD CONSTRAINT `forum_topic_visits_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_topic_visits_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `forum_translations`
--
ALTER TABLE `forum_translations`
  ADD CONSTRAINT `forum_translations_forum_id_foreign` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `gifts`
--
ALTER TABLE `gifts`
  ADD CONSTRAINT `gifts_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gifts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gifts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gifts_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `groups_registration_packages`
--
ALTER TABLE `groups_registration_packages`
  ADD CONSTRAINT `groups_registration_packages_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `group_users`
--
ALTER TABLE `group_users`
  ADD CONSTRAINT `group_users_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `home_page_statistic_translations`
--
ALTER TABLE `home_page_statistic_translations`
  ADD CONSTRAINT `home_page_statistic_id` FOREIGN KEY (`home_page_statistic_id`) REFERENCES `home_page_statistics` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_orders`
--
ALTER TABLE `installment_orders`
  ADD CONSTRAINT `installment_orders_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_orders_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_product_order_id` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_order_attachments`
--
ALTER TABLE `installment_order_attachments`
  ADD CONSTRAINT `installment_order_id_attachment` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_order_payments`
--
ALTER TABLE `installment_order_payments`
  ADD CONSTRAINT `installment_order_id` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_order_payments_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_order_payments_selected_installment_step_id_foreign` FOREIGN KEY (`selected_installment_step_id`) REFERENCES `selected_installment_steps` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_reminders`
--
ALTER TABLE `installment_reminders`
  ADD CONSTRAINT `installment_reminders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_specification_items`
--
ALTER TABLE `installment_specification_items`
  ADD CONSTRAINT `installment_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_specification_items_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_steps`
--
ALTER TABLE `installment_steps`
  ADD CONSTRAINT `installment_steps_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_step_translations`
--
ALTER TABLE `installment_step_translations`
  ADD CONSTRAINT `installment_step_translations_installment_step_id_foreign` FOREIGN KEY (`installment_step_id`) REFERENCES `installment_steps` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_translations`
--
ALTER TABLE `installment_translations`
  ADD CONSTRAINT `installment_translations_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `installment_user_groups`
--
ALTER TABLE `installment_user_groups`
  ADD CONSTRAINT `installment_user_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `installment_user_groups_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `landing_components`
--
ALTER TABLE `landing_components`
  ADD CONSTRAINT `landing_components_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `landing_builder_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `landing_components_landing_id_foreign` FOREIGN KEY (`landing_id`) REFERENCES `landings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `landing_component_translations`
--
ALTER TABLE `landing_component_translations`
  ADD CONSTRAINT `landing_component_id_trans` FOREIGN KEY (`landing_component_id`) REFERENCES `landing_components` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `landing_translations`
--
ALTER TABLE `landing_translations`
  ADD CONSTRAINT `landing_translations_landing_id_foreign` FOREIGN KEY (`landing_id`) REFERENCES `landings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `meetings`
--
ALTER TABLE `meetings`
  ADD CONSTRAINT `meetings_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `meeting_packages`
--
ALTER TABLE `meeting_packages`
  ADD CONSTRAINT `meeting_packages_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `meeting_packages_sold`
--
ALTER TABLE `meeting_packages_sold`
  ADD CONSTRAINT `meeting_packages_sold_meeting_package_id_foreign` FOREIGN KEY (`meeting_package_id`) REFERENCES `meeting_packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meeting_packages_sold_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meeting_packages_sold_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `meeting_package_translations`
--
ALTER TABLE `meeting_package_translations`
  ADD CONSTRAINT `meeting_package_translations_meeting_package_id_foreign` FOREIGN KEY (`meeting_package_id`) REFERENCES `meeting_packages` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `meeting_times`
--
ALTER TABLE `meeting_times`
  ADD CONSTRAINT `meeting_times_meeting_id_foreign` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `navbar_buttons`
--
ALTER TABLE `navbar_buttons`
  ADD CONSTRAINT `navbar_buttons_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `navbar_button_translations`
--
ALTER TABLE `navbar_button_translations`
  ADD CONSTRAINT `navbar_button_translations_navbar_button_id_foreign` FOREIGN KEY (`navbar_button_id`) REFERENCES `navbar_buttons` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `noticeboards`
--
ALTER TABLE `noticeboards`
  ADD CONSTRAINT `noticeboards_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `noticeboards_organ_id_foreign` FOREIGN KEY (`organ_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `noticeboards_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `noticeboards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `noticeboards_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `noticeboards_status`
--
ALTER TABLE `noticeboards_status`
  ADD CONSTRAINT `noticeboards_status_noticeboard_id_foreign` FOREIGN KEY (`noticeboard_id`) REFERENCES `noticeboards` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications_status`
--
ALTER TABLE `notifications_status`
  ADD CONSTRAINT `notifications_status_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offline_bank_specifications`
--
ALTER TABLE `offline_bank_specifications`
  ADD CONSTRAINT `offline_bank_specifications_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offline_bank_specification_translations`
--
ALTER TABLE `offline_bank_specification_translations`
  ADD CONSTRAINT `offline_bank_specification_id` FOREIGN KEY (`offline_bank_specification_id`) REFERENCES `offline_bank_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offline_bank_translations`
--
ALTER TABLE `offline_bank_translations`
  ADD CONSTRAINT `offline_bank_translations_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offline_payments`
--
ALTER TABLE `offline_payments`
  ADD CONSTRAINT `offline_payments_offline_bank_id_foreign` FOREIGN KEY (`offline_bank_id`) REFERENCES `offline_banks` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `offline_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `page_translations`
--
ALTER TABLE `page_translations`
  ADD CONSTRAINT `page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `payku_payments`
--
ALTER TABLE `payku_payments`
  ADD CONSTRAINT `payku_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `payku_transactions` (`id`);

--
-- Contraintes pour la table `payouts`
--
ALTER TABLE `payouts`
  ADD CONSTRAINT `payout_user_selected_bank_id` FOREIGN KEY (`user_selected_bank_id`) REFERENCES `user_selected_banks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payouts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permissions_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`);

--
-- Contraintes pour la table `prerequisites`
--
ALTER TABLE `prerequisites`
  ADD CONSTRAINT `prerequisite_id` FOREIGN KEY (`prerequisite_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prerequisites_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_badge_contents`
--
ALTER TABLE `product_badge_contents`
  ADD CONSTRAINT `product_badge_contents_product_badge_id_foreign` FOREIGN KEY (`product_badge_id`) REFERENCES `product_badges` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_badge_translations`
--
ALTER TABLE `product_badge_translations`
  ADD CONSTRAINT `product_badge_translations_product_badge_id_foreign` FOREIGN KEY (`product_badge_id`) REFERENCES `product_badges` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_category_translations`
--
ALTER TABLE `product_category_translations`
  ADD CONSTRAINT `product_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_discounts`
--
ALTER TABLE `product_discounts`
  ADD CONSTRAINT `product_discounts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_discounts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_faqs`
--
ALTER TABLE `product_faqs`
  ADD CONSTRAINT `product_faqs_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_faqs_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_faq_translations`
--
ALTER TABLE `product_faq_translations`
  ADD CONSTRAINT `product_faq_id` FOREIGN KEY (`product_faq_id`) REFERENCES `product_faqs` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_featured_categories`
--
ALTER TABLE `product_featured_categories`
  ADD CONSTRAINT `product_featured_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_files`
--
ALTER TABLE `product_files`
  ADD CONSTRAINT `file_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `file_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_file_translations`
--
ALTER TABLE `product_file_translations`
  ADD CONSTRAINT `product_file_id` FOREIGN KEY (`product_file_id`) REFERENCES `product_files` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_filters`
--
ALTER TABLE `product_filters`
  ADD CONSTRAINT `product_filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_filter_options`
--
ALTER TABLE `product_filter_options`
  ADD CONSTRAINT `product_filter_options_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_filter_option_translations`
--
ALTER TABLE `product_filter_option_translations`
  ADD CONSTRAINT `product_filter_option_id` FOREIGN KEY (`product_filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_filter_translations`
--
ALTER TABLE `product_filter_translations`
  ADD CONSTRAINT `product_filter_id` FOREIGN KEY (`product_filter_id`) REFERENCES `product_filters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_media`
--
ALTER TABLE `product_media`
  ADD CONSTRAINT `media_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `media_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_orders`
--
ALTER TABLE `product_orders`
  ADD CONSTRAINT `product_orders_gift_id_foreign` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_orders_installment_order_id_foreign` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_selected_filter_options`
--
ALTER TABLE `product_selected_filter_options`
  ADD CONSTRAINT `product_selected_filter_options_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `product_filter_options` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_selected_filter_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_selected_specifications`
--
ALTER TABLE `product_selected_specifications`
  ADD CONSTRAINT `product_selected_specifications_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_selected_specifications_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_selected_specifications_product_specification_id_foreign` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_selected_specification_multi_values`
--
ALTER TABLE `product_selected_specification_multi_values`
  ADD CONSTRAINT `selected_specification_id` FOREIGN KEY (`selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `specification_multi_value_id` FOREIGN KEY (`specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_selected_specification_translations`
--
ALTER TABLE `product_selected_specification_translations`
  ADD CONSTRAINT `product_selected_specification_id_translations` FOREIGN KEY (`product_selected_specification_id`) REFERENCES `product_selected_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_specification_categories`
--
ALTER TABLE `product_specification_categories`
  ADD CONSTRAINT `product_specification_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_specification_categories_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_specification_multi_values`
--
ALTER TABLE `product_specification_multi_values`
  ADD CONSTRAINT `product_specification_multi_values_specification_id_foreign` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_specification_multi_value_translations`
--
ALTER TABLE `product_specification_multi_value_translations`
  ADD CONSTRAINT `product_specification_multi_value_id` FOREIGN KEY (`product_specification_multi_value_id`) REFERENCES `product_specification_multi_values` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_specification_translations`
--
ALTER TABLE `product_specification_translations`
  ADD CONSTRAINT `product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `product_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_top_categories`
--
ALTER TABLE `product_top_categories`
  ADD CONSTRAINT `product_top_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_translations`
--
ALTER TABLE `product_translations`
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `promotion_translations`
--
ALTER TABLE `promotion_translations`
  ADD CONSTRAINT `promotion_translations_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchases_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `purchase_notification_histories`
--
ALTER TABLE `purchase_notification_histories`
  ADD CONSTRAINT `purchase_notification_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_id_history` FOREIGN KEY (`purchase_notification_id`) REFERENCES `purchase_notifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `purchase_notification_roles_groups_contents`
--
ALTER TABLE `purchase_notification_roles_groups_contents`
  ADD CONSTRAINT `purchase_notification_id_role_group` FOREIGN KEY (`purchase_notification_id`) REFERENCES `purchase_notifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_roles_groups_contents_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_roles_groups_contents_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_roles_groups_contents_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_roles_groups_contents_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_notification_roles_groups_contents_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `purchase_notification_translations`
--
ALTER TABLE `purchase_notification_translations`
  ADD CONSTRAINT `purchase_notification_id_trans` FOREIGN KEY (`purchase_notification_id`) REFERENCES `purchase_notifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quizzes_questions`
--
ALTER TABLE `quizzes_questions`
  ADD CONSTRAINT `quizzes_questions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quizzes_questions_answers`
--
ALTER TABLE `quizzes_questions_answers`
  ADD CONSTRAINT `quizzes_questions_answers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_questions_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quizzes_questions_answer_translations`
--
ALTER TABLE `quizzes_questions_answer_translations`
  ADD CONSTRAINT `quizzes_questions_answer_id` FOREIGN KEY (`quizzes_questions_answer_id`) REFERENCES `quizzes_questions_answers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quizzes_results`
--
ALTER TABLE `quizzes_results`
  ADD CONSTRAINT `quizzes_results_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quiz_question_translations`
--
ALTER TABLE `quiz_question_translations`
  ADD CONSTRAINT `quiz_question_translations_quiz_question_id_foreign` FOREIGN KEY (`quizzes_question_id`) REFERENCES `quizzes_questions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `quiz_translations`
--
ALTER TABLE `quiz_translations`
  ADD CONSTRAINT `quiz_translations_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rating_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rating_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `regions`
--
ALTER TABLE `regions`
  ADD CONSTRAINT `regions_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `regions_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `registration_packages_translations`
--
ALTER TABLE `registration_packages_translations`
  ADD CONSTRAINT `registration_package` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `related_courses`
--
ALTER TABLE `related_courses`
  ADD CONSTRAINT `related_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `related_courses_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `related_posts`
--
ALTER TABLE `related_posts`
  ADD CONSTRAINT `related_posts_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `related_products`
--
ALTER TABLE `related_products`
  ADD CONSTRAINT `related_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reserve_meetings`
--
ALTER TABLE `reserve_meetings`
  ADD CONSTRAINT `reserve_meetings_meeting_time_id_foreign` FOREIGN KEY (`meeting_time_id`) REFERENCES `meeting_times` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reserve_meetings_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reserve_meetings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `rewards_accounting`
--
ALTER TABLE `rewards_accounting`
  ADD CONSTRAINT `rewards_accounting_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `role_translations`
--
ALTER TABLE `role_translations`
  ADD CONSTRAINT `role_translations_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_installment_payment_id_foreign` FOREIGN KEY (`installment_payment_id`) REFERENCES `installment_order_payments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `sales_log`
--
ALTER TABLE `sales_log`
  ADD CONSTRAINT `sales_status_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `selected_installments`
--
ALTER TABLE `selected_installments`
  ADD CONSTRAINT `selected_installments_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `installments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `selected_installments_installment_order_id_foreign` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `selected_installments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `selected_installment_steps`
--
ALTER TABLE `selected_installment_steps`
  ADD CONSTRAINT `selected_installment_steps_installment_step_id_foreign` FOREIGN KEY (`installment_step_id`) REFERENCES `installment_steps` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `selected_installment_steps_selected_installment_id_foreign` FOREIGN KEY (`selected_installment_id`) REFERENCES `selected_installments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `meeting_package_sold_id` FOREIGN KEY (`meeting_package_sold_id`) REFERENCES `meeting_packages_sold` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_reserve_meeting_id_foreign` FOREIGN KEY (`reserve_meeting_id`) REFERENCES `reserve_meetings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sessions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `session_attendance`
--
ALTER TABLE `session_attendance`
  ADD CONSTRAINT `session_attendance_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `session_attendance_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `session_attendance_notifications`
--
ALTER TABLE `session_attendance_notifications`
  ADD CONSTRAINT `session_attendance_notifications_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `session_reminds`
--
ALTER TABLE `session_reminds`
  ADD CONSTRAINT `session_reminds_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `session_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `session_translations`
--
ALTER TABLE `session_translations`
  ADD CONSTRAINT `session_translations_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `setting_translations`
--
ALTER TABLE `setting_translations`
  ADD CONSTRAINT `setting_translations_setting_id_foreign` FOREIGN KEY (`setting_id`) REFERENCES `settings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `special_offers`
--
ALTER TABLE `special_offers`
  ADD CONSTRAINT `special_offers_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `special_offers_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `special_offers_registration_package_id_foreign` FOREIGN KEY (`registration_package_id`) REFERENCES `registration_packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `special_offers_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `special_offers_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `specific_locations`
--
ALTER TABLE `specific_locations`
  ADD CONSTRAINT `specific_locations_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `specific_locations_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `specific_locations_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `specific_locations_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `subscribe_reminds`
--
ALTER TABLE `subscribe_reminds`
  ADD CONSTRAINT `subscribe_reminds_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_reminds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `subscribe_specification_items`
--
ALTER TABLE `subscribe_specification_items`
  ADD CONSTRAINT `subscribe_specification_items_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_specification_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_specification_items_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_specification_items_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_specification_items_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `subscribe_translations`
--
ALTER TABLE `subscribe_translations`
  ADD CONSTRAINT `subscribe_translations_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `subscribe_uses`
--
ALTER TABLE `subscribe_uses`
  ADD CONSTRAINT `subscribe_uses_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_uses_installment_order_id_foreign` FOREIGN KEY (`installment_order_id`) REFERENCES `installment_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_uses_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_uses_subscribe_id_foreign` FOREIGN KEY (`subscribe_id`) REFERENCES `subscribes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_uses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribe_uses_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `supports`
--
ALTER TABLE `supports`
  ADD CONSTRAINT `supports_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `support_conversations`
--
ALTER TABLE `support_conversations`
  ADD CONSTRAINT `support_conversations_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `support_conversations_support_id_foreign` FOREIGN KEY (`support_id`) REFERENCES `supports` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `support_department_translations`
--
ALTER TABLE `support_department_translations`
  ADD CONSTRAINT `support_department_id` FOREIGN KEY (`support_department_id`) REFERENCES `support_departments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tags_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tags_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  ADD CONSTRAINT `testimonial_translations_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `text_lessons`
--
ALTER TABLE `text_lessons`
  ADD CONSTRAINT `text_lessons_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `text_lessons_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `text_lessons_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `text_lessons_attachments`
--
ALTER TABLE `text_lessons_attachments`
  ADD CONSTRAINT `text_lessons_attachments_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `text_lessons_attachments_text_lesson_id_foreign` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `text_lesson_translations`
--
ALTER TABLE `text_lesson_translations`
  ADD CONSTRAINT `text_lesson_id` FOREIGN KEY (`text_lesson_id`) REFERENCES `text_lessons` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `themes`
--
ALTER TABLE `themes`
  ADD CONSTRAINT `themes_color_id_foreign` FOREIGN KEY (`color_id`) REFERENCES `theme_colors_fonts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `themes_font_id_foreign` FOREIGN KEY (`font_id`) REFERENCES `theme_colors_fonts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `themes_footer_id_foreign` FOREIGN KEY (`footer_id`) REFERENCES `theme_headers_footers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `themes_header_id_foreign` FOREIGN KEY (`header_id`) REFERENCES `theme_headers_footers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `themes_home_landing_id_foreign` FOREIGN KEY (`home_landing_id`) REFERENCES `landings` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `theme_header_footer_translations`
--
ALTER TABLE `theme_header_footer_translations`
  ADD CONSTRAINT `theme_header_footer_id_trans` FOREIGN KEY (`theme_header_footer_id`) REFERENCES `theme_headers_footers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ticket_translations`
--
ALTER TABLE `ticket_translations`
  ADD CONSTRAINT `ticket_translations_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ticket_users`
--
ALTER TABLE `ticket_users`
  ADD CONSTRAINT `ticket_users_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `time_spent_on_courses`
--
ALTER TABLE `time_spent_on_courses`
  ADD CONSTRAINT `time_spent_on_courses_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `trend_categories`
--
ALTER TABLE `trend_categories`
  ADD CONSTRAINT `trend_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `upcoming_courses`
--
ALTER TABLE `upcoming_courses`
  ADD CONSTRAINT `upcoming_courses_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_courses_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_courses_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_courses_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `upcoming_course_filter_option`
--
ALTER TABLE `upcoming_course_filter_option`
  ADD CONSTRAINT `upcoming_course_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_course_filter_option_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `upcoming_course_followers`
--
ALTER TABLE `upcoming_course_followers`
  ADD CONSTRAINT `upcoming_course_followers_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_course_followers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `upcoming_course_reports`
--
ALTER TABLE `upcoming_course_reports`
  ADD CONSTRAINT `upcoming_course_reports_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `upcoming_course_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `upcoming_course_translations`
--
ALTER TABLE `upcoming_course_translations`
  ADD CONSTRAINT `upcoming_course_translations_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `regions` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `users_badges`
--
ALTER TABLE `users_badges`
  ADD CONSTRAINT `users_badges_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_badges_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_cookie_security`
--
ALTER TABLE `users_cookie_security`
  ADD CONSTRAINT `users_cookie_security_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_metas`
--
ALTER TABLE `users_metas`
  ADD CONSTRAINT `users_metas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_occupations`
--
ALTER TABLE `users_occupations`
  ADD CONSTRAINT `users_occupations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_occupations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_registration_packages`
--
ALTER TABLE `users_registration_packages`
  ADD CONSTRAINT `users_registration_packages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users_zoom_api`
--
ALTER TABLE `users_zoom_api`
  ADD CONSTRAINT `users_zoom_api_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_bank_specifications`
--
ALTER TABLE `user_bank_specifications`
  ADD CONSTRAINT `user_bank_specifications_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_bank_specification_translations`
--
ALTER TABLE `user_bank_specification_translations`
  ADD CONSTRAINT `user_bank_specification_id` FOREIGN KEY (`user_bank_specification_id`) REFERENCES `user_bank_specifications` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_bank_translations`
--
ALTER TABLE `user_bank_translations`
  ADD CONSTRAINT `user_bank_translations_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_commissions`
--
ALTER TABLE `user_commissions`
  ADD CONSTRAINT `user_commissions_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_commissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_firebase_sessions`
--
ALTER TABLE `user_firebase_sessions`
  ADD CONSTRAINT `user_firebase_sessions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_form_fields`
--
ALTER TABLE `user_form_fields`
  ADD CONSTRAINT `user_form_fields_become_instructor_id_foreign` FOREIGN KEY (`become_instructor_id`) REFERENCES `become_instructors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_form_fields_form_field_id_foreign` FOREIGN KEY (`form_field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_form_fields_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_login_histories`
--
ALTER TABLE `user_login_histories`
  ADD CONSTRAINT `user_login_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_profile_attachments`
--
ALTER TABLE `user_profile_attachments`
  ADD CONSTRAINT `user_profile_attachments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_profile_attachment_translations`
--
ALTER TABLE `user_profile_attachment_translations`
  ADD CONSTRAINT `user_profile_attachment_id_trans` FOREIGN KEY (`user_profile_attachment_id`) REFERENCES `user_profile_attachments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_selected_banks`
--
ALTER TABLE `user_selected_banks`
  ADD CONSTRAINT `user_selected_banks_user_bank_id_foreign` FOREIGN KEY (`user_bank_id`) REFERENCES `user_banks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_selected_banks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_selected_bank_specifications`
--
ALTER TABLE `user_selected_bank_specifications`
  ADD CONSTRAINT `user_bank_specification_id_specifications` FOREIGN KEY (`user_bank_specification_id`) REFERENCES `user_bank_specifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_selected_bank_id_specifications` FOREIGN KEY (`user_selected_bank_id`) REFERENCES `user_selected_banks` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `verifications`
--
ALTER TABLE `verifications`
  ADD CONSTRAINT `verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `waitlists`
--
ALTER TABLE `waitlists`
  ADD CONSTRAINT `waitlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `waitlists_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinars`
--
ALTER TABLE `webinars`
  ADD CONSTRAINT `webinars_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinars_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinars_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_assignments`
--
ALTER TABLE `webinar_assignments`
  ADD CONSTRAINT `webinar_assignments_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_assignments_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_assignments_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_assignment_attachments`
--
ALTER TABLE `webinar_assignment_attachments`
  ADD CONSTRAINT `webinar_assignment_attachments_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_assignment_history`
--
ALTER TABLE `webinar_assignment_history`
  ADD CONSTRAINT `webinar_assignment_history_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_assignment_history_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_assignment_history_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_assignment_history_messages`
--
ALTER TABLE `webinar_assignment_history_messages`
  ADD CONSTRAINT `webinar_assignment_history_id` FOREIGN KEY (`assignment_history_id`) REFERENCES `webinar_assignment_history` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_assignment_translations`
--
ALTER TABLE `webinar_assignment_translations`
  ADD CONSTRAINT `webinar_assignment_id_translate_foreign` FOREIGN KEY (`webinar_assignment_id`) REFERENCES `webinar_assignments` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_chapters`
--
ALTER TABLE `webinar_chapters`
  ADD CONSTRAINT `webinar_chapters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_chapters_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_chapter_items`
--
ALTER TABLE `webinar_chapter_items`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_chapter_items_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_chapter_translations`
--
ALTER TABLE `webinar_chapter_translations`
  ADD CONSTRAINT `webinar_chapter_id` FOREIGN KEY (`webinar_chapter_id`) REFERENCES `webinar_chapters` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_extra_descriptions`
--
ALTER TABLE `webinar_extra_descriptions`
  ADD CONSTRAINT `webinar_extra_descriptions_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_extra_descriptions_upcoming_course_id_foreign` FOREIGN KEY (`upcoming_course_id`) REFERENCES `upcoming_courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_extra_descriptions_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_extra_description_translations`
--
ALTER TABLE `webinar_extra_description_translations`
  ADD CONSTRAINT `webinar_extra_description_id_foreign` FOREIGN KEY (`webinar_extra_description_id`) REFERENCES `webinar_extra_descriptions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_filter_option`
--
ALTER TABLE `webinar_filter_option`
  ADD CONSTRAINT `webinar_filter_option_filter_option_id_foreign` FOREIGN KEY (`filter_option_id`) REFERENCES `filter_options` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_filter_option_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_partner_teacher`
--
ALTER TABLE `webinar_partner_teacher`
  ADD CONSTRAINT `webinar_partner_teacher_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_partner_teacher_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_reports`
--
ALTER TABLE `webinar_reports`
  ADD CONSTRAINT `webinar_reports_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_reviews`
--
ALTER TABLE `webinar_reviews`
  ADD CONSTRAINT `webinar_reviews_bundle_id_foreign` FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_reviews_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `webinar_reviews_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `webinar_translations`
--
ALTER TABLE `webinar_translations`
  ADD CONSTRAINT `webinar_translations_webinar_id_foreign` FOREIGN KEY (`webinar_id`) REFERENCES `webinars` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
