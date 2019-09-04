CREATE DATABASE IF NOT EXISTS essentialmode;
USE `test`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_nightclub', 'Ночной клуб', 1);

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_nightclub', 'Ночной клуб', 1),
    ('society_nightclub_fridge', 'Ночной клуб (холодильник)', 1);

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_nightclub', 'Ночной клуб', 1);

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('juice', 'Сок', 5),
	('beer', 'Пиво', 2);

INSERT INTO `jobs` (name, label, whitelisted) VALUES
	('nightclub', 'Ночной клуб', 1);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('nightclub', 0, 'interim', 'Посетитель', 0, '{}', '{}'),
    ('nightclub', 1, 'security', 'Охранник', 0, '{}', '{}'),
    ('nightclub', 2, 'barman', 'Бармен', 0, '{}', '{}'),
    ('nightclub', 3, 'dancer', 'Танцовщик', 0, '{}', '{}'),
    ('nightclub', 4, 'chefsecurity', 'Шеф охраны', 0, '{}', '{}'),
    ('nightclub', 5, 'viceboss', 'Менеджер', 0, '{}', '{}'),
    ('nightclub', 6, 'boss', 'Шеф', 0, '{}', '{}');