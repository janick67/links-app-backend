-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 29 Wrz 2019, 23:15
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
  `description` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `links`
--

INSERT INTO `links` (`id`, `name`, `url`, `description`) VALUES
(1, 'Facebook', 'https://www.facebook.com/', 'media spolecznosciowe'),
(2, 'Google', 'https://www.google.com/', 'wyszukiwarka'),
(3, 'Gmail', 'https://www.google.com/gmail', 'poczta'),
(4, 'YouTube', 'https://www.youtube.com', 'rozrywka'),
(5, 'Vue-proxy', 'https://vuejs-templates.github.io/webpack/proxy.html', 'Informacja jak skonfigurowac proxy w vue dla dev serwera'),
(6, 'Vue-flex', 'https://vuetifyjs.com/en/styles/flex', 'Sposób uzycia flex w vuetify'),
(7, 'Jebzdzidy', 'https://jbzdy.cc', 'Storna z memami'),
(8, '9gag', 'https://9gag.com/', 'Strona z memami po angielsku');

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
('21d580ad-44cb-46c4-820f-4ef94666772e', 1569790237, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":\"tesla\"}}'),
('40e12f1a-7a51-496d-90ef-9d3b3ebf937a', 1569789849, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('550e3d4d-f1ce-4b20-8de2-5a07664f1b3a', 1569790255, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}'),
('9d113ba2-6dcf-4938-b143-399556cb8d36', 1569801765, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"passport\":{\"user\":\"einstein\"}}');

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
