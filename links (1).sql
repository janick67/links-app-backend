-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 01 Paź 2019, 22:19
-- Wersja serwera: 10.3.16-MariaDB
-- Wersja PHP: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `links`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `links`
--

CREATE TABLE `links` (
  `id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(256) NOT NULL,
  `description` varchar(512) NOT NULL,
  `imageURL` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `links`
--

INSERT INTO `links` (`id`, `name`, `url`, `description`, `imageURL`) VALUES
(1, 'Facebook', 'https://www.facebook.com/', 'media spolecznosciowe', 'https://www.facebook.com/images/fb_icon_325x325.png'),
(2, 'Google', 'https://www.google.com/', 'wyszukiwarka', 'https://www.wprost.pl/_thumb/eb/0a/916ecd6cd846ccd9b4bbc8bbe1ea.jpeg'),
(3, 'Gmail', 'https://www.google.com/gmail', 'poczta', './images/gmail.png'),
(4, 'YouTube', 'https://www.youtube.com', 'rozrywka', 'https://img.etimg.com/thumb/msid-69533333,width-643,imgsize-35861,resizemode-4/youtube-on-android-may-get-bigger-better-video-streaming-giant-tests-enlarged-play-cancel-buttons.jpg'),
(5, 'Vue-proxy', 'https://vuejs-templates.github.io/webpack/proxy.html', 'Informacja jak skonfigurowac proxy w vue dla dev serwera', 'https://miro.medium.com/proxy/1*kz9D-JB0Lrk4RfhInh_3fg.png'),
(6, 'Vue-flex', 'https://vuetifyjs.com/en/styles/flex', 'Sposób uzycia flex w vuetify', 'https://miro.medium.com/proxy/1*kz9D-JB0Lrk4RfhInh_3fg.png'),
(7, 'Jebzdzidy', 'https://jbzdy.cc', 'Storna z memami', 'https://vignette.wikia.nocookie.net/logopedia/images/c/cc/Jbzd-logo2.png/revision/latest?cb=20151205160144'),
(8, '9gag', 'https://9gag.com/', 'Strona z memami po angielsku', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/9GAG_new_logo.svg/2000px-9GAG_new_logo.svg.png');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roles`
--

CREATE TABLE `roles` (
  `id` int(10) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'Admin', 'wszystkie linki'),
(2, 'Frontendowiec', 'Ma dostep tylko do linkow zwiazanymi z frontendem'),
(3, 'PM', 'linki z frontu, google, gmail'),
(4, 'Dyrektor', 'wszystkie linki poza memami');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roleslinks`
--

CREATE TABLE `roleslinks` (
  `roleId` int(10) NOT NULL,
  `linkId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `roleslinks`
--

INSERT INTO `roleslinks` (`roleId`, `linkId`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 5),
(2, 6),
(3, 2),
(3, 3),
(3, 5),
(3, 6),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('0009e95c-70e6-406b-8e5a-998713034801', 1569971408, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0445536d-a1c1-4104-a8c2-ffd76c31f0c6', 1569971726, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('05b6c59d-6159-4766-a7bd-7d6bdcd90c2a', 1569971534, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('066576dd-32e7-4682-95d1-83ec225b5fa7', 1569971432, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0932fe99-28ba-4c6f-9953-a2b892ef2889', 1569971741, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0ae357d6-2cdf-4f31-9979-d05517ce5d65', 1569971477, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0b82db3a-bdf0-476e-89e1-885840e7609e', 1569971420, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0c25ec91-68c6-47c5-8a0b-a419754f808d', 1569971656, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0cb293af-b555-436d-b915-b4a991ec7436', 1569971734, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('0fe8b688-b4af-4461-8a65-c22ea61aeedc', 1569971481, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1144539a-2dfc-484f-a16e-8e998b7a8b5c', 1569971428, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('11c1f5c3-320b-4216-93c2-aa83d088c1c3', 1569971462, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1265a434-a20f-4b37-b358-83d3bbad38fc', 1569969957, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{}}'),
('13ef4679-224e-4f80-bd9f-c1ceb51640a7', 1569971802, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1493068d-2224-4fd9-9d4c-d091354471ac', 1569971423, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('17396a3c-ba9c-4389-9950-f6d3f50e0a6f', 1569971549, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1760f864-491e-4f5d-a56c-5445b4e7a471', 1569971504, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('18eeb8ab-465d-4308-86d6-007c2e2cb059', 1569971737, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('19309926-7f5a-4e60-b8ac-88f242f23af6', 1569971666, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1a527d5b-979e-4eb1-9a8e-bb6c5d64a34b', 1569971737, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1c39d4cb-5ed9-40e9-8ff4-a58b876c48f9', 1569971931, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1d7619a8-6da9-40c2-8f4c-ee215cc63a97', 1569971535, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('1f3f6cbf-2d46-4ae9-8494-58b296aaac2f', 1569971392, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('20c20c67-28ce-413e-aa6e-1e00d26ec75a', 1569971519, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('213285da-0366-431c-ad5e-b644f1df26f0', 1569971508, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('237f7448-b33f-42ba-acfb-75e560778fec', 1569971580, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('26ee63d6-0fe1-4f8d-9b24-ae221318df97', 1569971725, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('27148c15-6f14-4f6d-8aff-fa80f9eaa2ab', 1569971661, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('27cd49f0-4e80-413c-900f-41ebc392b97f', 1569971738, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('28776e72-2eae-4cb1-b4b2-e55fdfa1d937', 1569971466, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('29c50577-bcde-43ae-9fd5-995a9db4b221', 1569971723, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2aaaa0a3-949e-421e-98d9-9c1c671d52f6', 1569971416, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2b9aac3c-567b-45e8-af45-a51d46aa81e3', 1569971730, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2c08648a-cc4c-405b-bb30-d6aa7827cad7', 1569971727, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2c308bf1-7fbc-4df7-97f0-27644df2d42a', 1569971738, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2dfe7107-5ed7-40e9-b7d4-0e91595e2275', 1569971503, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('2fad333d-b239-4c64-bcfd-945e87aa7d67', 1569968227, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('31120e06-8239-4659-a18d-2d4c58657133', 1569971557, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('314d79cc-c388-44c2-9733-8711522e11a4', 1569971458, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('31a98556-5342-4f9a-b291-6d3fe835c33e', 1569971454, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('31eda67a-ba53-4a4c-bac9-1e829b3f20fb', 1569971467, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('32de4790-6439-43ef-a3df-fe2f2d58ab8b', 1569971397, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3487594a-2759-4873-89c7-a00e302ea270', 1569971800, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('35dffab1-c847-4961-a0d4-2dc8199415f0', 1569971526, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3700a817-3b3f-4004-8c52-8743f1931fdf', 1569971435, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3716edb0-654a-451f-a88b-a29ea23b0c6e', 1569970040, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('389bf911-c7cb-4f6a-9658-f4e699cce77b', 1569971722, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('395b8743-646d-4f1d-a464-ad36864d307e', 1569971562, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('398aeee6-ae49-45e4-bf33-e9521927301e', 1569971542, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('39a4cf77-34b3-4c9c-be6c-9f6921f6c514', 1569971434, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('39c2efa7-1921-46fd-b4c9-a8e275228f8d', 1569971420, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3a57f6c6-eb4d-455d-92a8-5ca12e7adc88', 1569971653, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3b218caf-6cf8-48f5-bcfc-b0b500f3ade9', 1569971455, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3bb730d7-8104-4317-a62f-21d12c392876', 1569971557, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3dbce14c-7958-46d4-aa19-254b45e095df', 1569971554, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3fb136fd-4c04-4e09-953a-1b9c30b83222', 1569971662, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('3fc93d35-fc6a-497c-8024-f716fdd67397', 1569971424, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('41150420-72ab-4920-96cd-812503c4cb2a', 1569971475, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('424c297b-ae65-4f5d-82ad-1f97984e1561', 1569968235, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":5}}'),
('4681900a-5730-446c-afaa-96845068a40a', 1569971458, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('47cffa6e-20da-4ad3-9efb-a85b47a4c821', 1569970409, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('48375926-089c-46f9-807c-c03b15103c5e', 1569971543, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('498d0e88-e027-4a5f-befb-90cecfa8cac9', 1569971665, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('4b4bd026-6d97-4911-bebd-af1e16134c49', 1569971523, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('4c31a77b-5219-444f-b992-68c88d225239', 1569971576, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('4da856a3-4fd2-44b5-bfd6-2682c7502798', 1569971478, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('50793c5e-90f2-4bfa-8249-0b182e2df1e4', 1569971734, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('52a43f1d-6d3a-4cbd-aae4-010ed6ae763b', 1569971730, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('52ed26ba-6210-494f-ab5b-c4518f77a841', 1569971802, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('53dcdb86-466b-43cc-b2be-0035a90e1c83', 1569971474, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('552fe117-485f-48d5-847c-0b06b5a2c045', 1569971801, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('582c940f-7d55-478d-b468-ddac952935e6', 1569971473, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('58a6811b-ae1d-4f73-902c-e15d94aa4e22', 1569971543, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('59f646b1-cdb6-4194-a9f9-af4b461bba30', 1569971546, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5a3c2f49-03b9-4d9e-954a-e4d5e5985d6e', 1569971463, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5d9f74db-de56-4277-8b36-5c8670f42ae9', 1569971457, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5e4fdd87-7f54-4876-a884-2630d617a8c3', 1569971427, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5e68ae6b-a3c8-4f0c-b69d-29fdc28a50aa', 1569971550, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5f11fe83-d0bc-4b7e-abdb-070d6d481aaf', 1569971650, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5f435d0f-6351-4f53-ae35-b8117e13cbce', 1569971419, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('5fca8efd-c948-4fcb-a7d0-d3f2dec3cfb0', 1569971554, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('61773a8e-df34-4c34-b77f-179bfc055c5d', 1569971412, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('61e82ec1-e616-4ad3-b198-62341f5b5ed5', 1569971454, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6653976a-0435-4f94-9f88-f088bfe34af3', 1569971798, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6658a075-32a1-4c80-bded-7cac2ca99e6b', 1569971653, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('69040bd3-9a67-43b7-815a-b9d72398e118', 1569971462, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('69f53591-225a-41dd-bb8d-8731fba596a1', 1569971500, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6abd35cb-8cfb-4d32-b06f-fa55a6d8620f', 1569971500, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6b5a5072-e58f-4e57-b908-d0edd02ccbc9', 1569971619, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6b6c894a-7d76-41f1-a8c8-847c838da091', 1569971398, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6c285f6d-afaf-4145-958c-90f44fc9796e', 1569971618, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6ca73587-287b-4fa6-8047-35396bae2c72', 1569971662, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6d7bc4cf-6937-498c-9824-75618fb5bea0', 1569971657, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6e8c144c-f681-4786-baef-6922717b0d5f', 1569971664, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('6e9abb4b-00ff-4242-8178-35a4bb7b6f65', 1569971929, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('750b6755-ff05-4ce5-acc9-95bce55af573', 1569971530, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('75c92803-d217-461b-a8f9-614f3c0c8767', 1569971659, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('75ec4dc4-bca3-4855-8b53-15a69cd7524c', 1569971562, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('76f7d3dc-503d-4d17-8a06-07c8492e9e1c', 1569971477, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('776bb152-faa3-4ed9-8a7e-45de83293c2b', 1569971653, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('793b9a90-e583-4eee-98b7-5784d894ad03', 1569971655, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7973e0a9-8e93-4243-90a2-b84f763bab6b', 1569971515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7a1efb08-7392-4f83-95be-cfaa1d2784ec', 1569971474, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7a4d9d41-4516-4b13-9d9f-86d04dd599bb', 1569971519, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7af86996-dbb7-4ef9-9a59-4e1951842f61', 1569971482, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7b0a8eb5-6470-46a5-b622-b3710151c23c', 1569969801, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7b5c8e2c-2659-4619-b400-977dfa86413c', 1569971436, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7e2c27df-210d-4cb0-8c66-c7d9d9073bc8', 1569971619, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('7f00b24e-7368-44d3-bec5-7e00819e3500', 1569971412, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('81237b20-2399-492c-86fc-9796459294c1', 1569971461, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('8288c442-bbe4-4b48-88d3-253c86d718f0', 1569971535, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('82d13c23-180c-4556-bec2-e056e34caad9', 1569971459, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('8533f911-4665-4fa3-a017-8daf4a5a16ab', 1569971511, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('89235dc4-8e2b-44bf-92a4-fc491fbfed84', 1569971427, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('89d91917-d3bd-4039-9c10-11eaf269a025', 1569971801, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('8d428081-969c-4ade-95e0-5caddaba8205', 1569971534, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('8dd1cf66-e12c-4655-b666-a7e0d95fbdd1', 1569971664, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('90a94bbb-c980-4898-83af-a932793e9fed', 1569971576, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('91eb0e9e-187b-4adc-a0f9-02e1fc7537aa', 1569971799, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('92ca5cc1-f43e-4ca6-9217-7d3d5ca5ec4f', 1569971465, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('92e2d3ca-e8d7-457e-9af5-b24a0b9b1989', 1569971742, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('93ab3acd-bc16-4118-a4a0-88f5479e7638', 1569971421, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('948285c0-126d-4b38-8335-e71f8adf87db', 1569968236, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('95abe6e2-66e1-435d-a770-de9852bc3263', 1569971536, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('97a15bcb-5e12-4277-a572-4ee2322ba870', 1569971741, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('98338362-d76a-481a-a222-09fad0fbbb05', 1569971408, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9b5e4b38-aed0-4c7e-ac7c-f9b017f0b17d', 1569971522, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9bd7c041-8025-4806-91fd-54d38456c6a5', 1569971726, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9c72faee-5eb8-4fe7-9ba9-b980713fa15d', 1569971412, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9d0130b4-cd49-4fd6-96da-fdcbf2bd9bcf', 1569971835, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{}}'),
('9e2f7f0d-dfd5-44c6-821e-aab2a72dbb86', 1569971413, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9ed29138-f44b-4743-8fa1-c554c391df57', 1569971389, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9f3528e2-a865-49a2-867f-049aa396de70', 1569971482, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a0fdfb1f-2afd-4c12-9b3f-56e008e49a97', 1569971721, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a2b399d1-450b-4f90-9839-08183ca98e48', 1569963798, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":\"tesla\"}}'),
('a2bc06de-62d3-4af5-8bd2-1da14c5c6613', 1569971729, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a2dbde49-b8df-49d0-9334-cd00e54b2c44', 1569971470, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a30ae072-fad4-4a7a-b024-dfda31fc6556', 1569971542, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a75b6ed8-8562-4573-beee-13f19d922b72', 1569971580, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a7b280ef-2f07-4b7d-8547-e28578ab0f2a', 1569971424, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a856b7e9-31f5-49ac-b00f-45c4547ad6f1', 1569971546, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a9a3d82c-f13d-4166-9a46-7aaea836fd04', 1569971550, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a9c0dcf7-031e-4eee-939e-ad7c2897412e', 1569971527, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('a9f35891-001f-4939-919c-7dde5e931960', 1569971393, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('aa2c6458-a2fa-4895-8a8b-a5096f15f68c', 1569971469, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('aecf5223-6ed7-4ca3-8180-9adaa2727f10', 1569971553, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('af127ccb-f0d7-48f7-a8a8-21f23ed385e7', 1569971657, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('afd23895-da67-4c7a-a82d-5ba545358ac0', 1569971551, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('b049497e-8636-420c-a190-db2e138b89fe', 1569971722, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('b0b319f7-3d5d-438f-91d4-3664238a23b6', 1569971547, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('b4cbb169-92ec-47de-99ba-413b0cee4f8c', 1569971618, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('b522f107-00dd-4007-b0a8-6b331a9eaf27', 1569971435, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('bcf02a35-50dd-4f48-970f-15675482d22d', 1569971475, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('bcf87480-8f91-49c8-8e7c-f6cf46e05052', 1569971385, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('bd61f2a0-9d79-4ec2-b596-68468bf6cf8b', 1569971455, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('bd73583c-7208-433a-abfb-9e3a9b9db1e7', 1569971554, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('bdad4e13-f5db-47bd-b0b1-74eb3c786793', 1569971658, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('be8460bf-f225-4bf4-8f47-0ebe8b7b2851', 1569971466, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c0160b8f-55e1-4926-aae9-0b897e46adfc', 1569971507, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c1301d4f-893d-4643-b543-42f4feb89d58', 1569971394, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c2c27338-b582-4b9c-bf80-eb8c8cceb2ab', 1569971658, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c42313be-b897-4f4a-a100-9567e3264b38', 1569971733, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c5264ab7-1e17-4b77-80fc-136999ede643', 1569971481, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('c98bd0a4-9d5b-4b4f-b8be-8f5ade0cd364', 1569971558, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ca4d7e84-4c77-4bf5-983a-dcd411529d89', 1569971799, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('cc762470-c6db-4874-9817-e5d7a60c210d', 1569971649, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('cd546edd-cb1d-425c-a9b4-4c44226b4cca', 1569971662, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('cf0c8653-52dd-4a03-8dc3-293c742fcbc6', 1569971511, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d0b9687c-4f93-4d13-808a-aec83b903c5d', 1569971470, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d224a5fd-5173-4220-91dc-e9b04a8e607b', 1569968156, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d429bf83-facd-42c6-bc79-a18069b359bc', 1569971649, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d5d8d1ac-156a-4f78-9e47-7db8b4327af3', 1569971650, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d6b196e3-94e3-4466-9d93-852b8c0ba96f', 1569971800, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d87107a7-0b98-4495-92bf-0dd744a7a917', 1569971390, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('d9eed5ec-19b1-4d59-8c77-3e876a18f9ca', 1569971409, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('da4f41b0-9bc9-4848-bac4-f05d5bdd4014', 1569971545, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('dafa4744-1b67-47f7-a5e9-03ab28f32720', 1569971733, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('db1a34a9-9e80-45b7-a65e-5c0f6246ddbb', 1569971385, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('db280198-eddc-4887-b73f-ef651a846749', 1569971423, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('db6a3da2-4c83-41ab-b4cd-bf9a2a0f890b', 1569971383, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('db8de657-b0ad-45a5-89f5-9efb0e3792b8', 1569971558, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('dbf7b5c9-0176-48d4-a687-ee074073100c', 1569970173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{}}'),
('dc50ff34-f1ab-47f9-b45a-a67394fef160', 1569971393, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ddb982b2-c12e-4e5b-b6da-0cf072dcca78', 1569971466, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ddbda3ea-580c-458a-a239-03e22a094f83', 1569971388, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('df7bd859-dff0-4a8d-8c19-9f3697dcfaa7', 1569971651, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e001f450-6415-4070-b4cb-43a7d889cebb', 1569969598, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e0a3d91c-5e98-4a21-9cb7-cf3a201d8235', 1569971531, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e1438ce0-058f-4f18-a8b3-522a4c3b170e', 1569971536, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e1aac3c1-a118-4416-8ecc-4db514302f75', 1569971432, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e3e2a64e-52ba-4429-b2cb-23d7bb3ad5db', 1569971385, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e6083986-0efe-4d02-8c07-c86bc11ef3f5', 1569968254, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('e65aabc9-046e-4ab6-9047-38ba70566c89', 1569971515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ea46f7fe-a47d-4903-b3cd-1474b7872c19', 1569971561, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('eab82fab-0648-4908-aae0-3d776295286c', 1569971730, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('eabf2a99-f261-482f-a156-9885b110c7c0', 1569971654, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('eb795229-8ead-4b31-8482-e01a84b2798f', 1569971469, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ec503322-930c-4a57-87bb-6b48a1599fb0', 1569971477, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ec87422d-c7f7-4088-ab93-051132a68299', 1569971389, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ecfed085-3e57-486e-94ee-894d0047235d', 1569970417, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ee126a40-81f4-4cf1-bcba-0a810154893d', 1569971480, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ee23688c-137b-40b8-86e5-ff6e7a7943ec', 1569971415, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('ef8967e9-4888-466f-ba75-cb303bfdd3e2', 1569971665, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f02ceffa-1a74-4885-b46c-8716bc3126d2', 1569971660, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f24a91ca-5afd-4aaa-a9cd-c579f93611c6', 1569971396, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f428535b-3cc4-400f-b9d3-9d6a550238d8', 1569971483, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f44886f2-2480-40c8-add6-bdb0c990fe30', 1569971654, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f5eea45f-502d-43c7-a74b-761919ac66ba', 1569971416, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f60cd04f-a2bd-4975-bb27-81c8d16ccf5e', 1569971478, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f6a5766b-d815-4a77-b241-e5d122e598ec', 1569971798, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f6ae1f3d-778d-4c07-b386-6ebd3b7840da', 1569971561, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('f9add10f-48b2-4909-a940-a55425da200a', 1569971409, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fbc05290-1c80-4071-9cad-d02ac1fc7763', 1569971397, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fcc6300d-34c8-471f-a417-9e413203bd42', 1569971417, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fd7fef81-0103-4a80-9290-72ddf9baf076', 1569971661, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fea22c45-5a92-40ed-a055-3c13c827f198', 1569971473, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('fef0ce3f-96d7-4465-84ca-ff851a37efaa', 1569971390, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `roleId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `uid`, `username`, `email`, `password`, `roleId`) VALUES
(1, '', 'test', 'test@test.com', 'password', 2),
(2, '', 'test2', 'test2@test.com', 'password', 2),
(4, 'tesla', 'admin', 'admin', 'admin', 1),
(5, 'newton', 'pm', 'pm', 'pm', 3),
(6, 'galieleo', 'vue', 'vue', 'vue', 2),
(7, 'einstein', 'dyr', 'dyr', 'dyr', 4);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `roleslinks`
--
ALTER TABLE `roleslinks`
  ADD PRIMARY KEY (`roleId`,`linkId`);

--
-- Indeksy dla tabeli `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `links`
--
ALTER TABLE `links`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
