INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Off-Duty'),
  ('offambulance','Off-Duty'),
  ('offmechanic', 'Off-Duty'),
  ('offmechanic-bennys', 'Off-Duty'),
  ('offtaxi', 'Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Recruit',12,'{}','{}'),
  ('offpolice',1,'officer','Officer',24,'{}','{}'),
  ('offpolice',2,'sergeant','Sergeant',36,'{}','{}'),
  ('offpolice',3,'lieutenant','Lieutenant',48,'{}','{}'),
  ('offpolice',4,'boss','Boss',0,'{}','{}'),
  ('offambulance',0,'ambulance','Ambulance',12,'{}','{}'),
  ('offambulance',1,'doctor','Doctor',24,'{}','{}'),
  ('offambulance',2,'chief_doctor','Chef',36,'{}','{}'),
  ('offambulance',3,'boss','Boss',48,'{}','{}'),
  ('offtaxi', 0, 'recrue', 'Новобранец', 13, '{}', '{}'),
  ('offtaxi', 1, 'novice', 'Новичок', 24, '{}', '{}'),
  ('offtaxi', 2, 'experimente', 'Опытный', 36, '{}', '{}'),
  ('offtaxi', 3, 'uber', 'Убер', 48, '{}', '{}'),
  ('offmechanic', 4, 'boss', 'Босс', 120, '{}', '{}'),
  ('offmechanic', 3, 'chief', 'Заместитель', 95, '{}', '{}'),
  ('offmechanic', 2, 'experimente', 'Опытный', 85, '{}', '{}'),
  ('offmechanic', 1, 'novice', 'Механик', 75, '{}', '{}'),
  ('offmechanic', 0, 'recrue', 'Новичок', 10, '{}', '{}'),
  ('offmechanic-bennys', 4, 'boss', 'Босс', 120, '{}', '{}'),
  ('offmechanic-bennys', 3, 'chief', 'Заместитель', 95, '{}', '{}'),
  ('offmechanic-bennys', 2, 'experimente', 'Опытный', 85, '{}', '{}'),
  ('offmechanic-bennys', 1, 'novice', 'Механик', 75, '{}', '{}'),
  ('offmechanic-bennys', 0, 'recrue', 'Новичок', 10, '{}', '{}')
;

ALTER TABLE `job_grades` ADD UNIQUE `job_name_grade` (`job_name`, `grade`);