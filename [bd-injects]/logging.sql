-- отслеживаем активность игроков
ALTER TABLE `users` ADD `timestamp` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `identifier`;