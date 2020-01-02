CREATE TABLE `bank_transactions` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8_bin NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(50) COLLATE utf8_bin NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `bank_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `description` (`description`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `identifier` (`identifier`);

ALTER TABLE `bank_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
