CREATE TABLE `identifiers` (
  `id` int(11) NOT NULL,
  `steam` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `license` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `discord` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `live` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `xbl` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8_bin NOT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `allowed` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `identifiers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `steam` (`steam`),
  ADD UNIQUE KEY `discord` (`discord`),
  ADD KEY `license` (`license`) USING BTREE,
  ADD KEY `xbl` (`xbl`) USING BTREE,
  ADD KEY `live` (`live`) USING BTREE;

ALTER TABLE `identifiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
