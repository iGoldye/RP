Config = {}

Config.Animations = {
	{
		name  = 'facials',
		label = 'Настроение',
		items = {
			{label = "Обычное", type = "facial", data = {anim = "mood_normal_1"}},
			{label = "Счастливое", type = "facial", data = {anim = "mood_happy_1"}},
			{label = "Злое", type = "facial", data = {anim = "mood_angry_1"}},
			{label = "Сонное", type = "facial", data = {anim = "mood_sleeping_1"}},
			{label = "Бесознательное", type = "facial", data = {anim = "mood_knockout_1"}},
			{label = "Подозрительное", type = "facial", data = {anim = "mood_aiming_1"}},
			{label = "Удивленное", type = "facial", data = {anim = "mood_injured_1"}},
			{label = "Шокированное", type = "facial", data = {anim = "mood_stressed_1"}},
			{label = "Самодовольное", type = "facial", data = {anim = "mood_smug_1"}},
			{label = "Грустное", type = "facial", data = {anim = "mood_sulk_1"}},
			{label = "Пьяное", type = "facial", data = {anim = "mood_drunk_1"}},
		}
	},
	{
		name  = 'festives',
		label = 'Действия',
		items = {
			{label = "Пить кофе", type = "scenario", data = {anim = "WORLD_HUMAN_AA_COFFEE"}},
			{label = "Курить", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING", flag = 9}},
			{label = "Музицировать", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN", flag = 9}},
			{label = "Диджей", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj", flag = 9}},
			{label = "Пить пиво", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "Тусоваться с пивом", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "Воображаемая гитара", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "Air Shagging", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock", upper=true, control=true, flag = 9}},
			{label = "Курить косяк", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			{label = "Схватить", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high", upper=false, control=true, flag = 9}},
			{label = "Стучать", type = "anim", data = {lib = "amb@code_human_in_car_mp_actions@dance@bodhi@ds@base", anim = "idle_a_fp", flag = 9}},
			{label = "Копаться в", type = "scenario", data = {anim = "PROP_HUMAN_BUM_BIN"}},
			{label = "Руки за голову", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c", repeat_anim=true}},
		}
	},
	
	{
		name  = 'greetings',
		label = 'Приветствия',
		items = {
			{label = "Помахать", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello", upper=true, control=true}},
			{label = "Пожать руку", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a", upper=true, control=true}},
			{label = "Обнять", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a", upper=false, control=true}},
			{label = "Поцеловать", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a", flag = 9}},
			{label = "Отдать честь", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute", stop_last_frame=true}},
		}
	},

	{
		name  = 'work',
		label = 'Работа',
		items = {
			{label = "Рыбачить", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "Искать улики", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Police : radio chatter", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter", upper=true, control=true}},
			{label = "Смотреть в бинокль", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "Копать", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "Чинить двигатель", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped", flag = 9}},
			{label = "Чинить днище", type = "scenario", data = {anim = "WORLD_HUMAN_VEHICLE_MECHANIC"}},
			{label = "Сварка", type = "scenario", data = {anim = "WORLD_HUMAN_WELDING"}},
			{label = "Осматривать", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			{label = "Протирать", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "Перекладывать ящики", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper", flag = 9}},
			{label = "Налить рюмку", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b", flag = 9}},
			{label = "Фотографировать", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "Планшет", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "Блокнот", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"}},
			{label = "Светить фонарем", type = "scenario", data = {anim = "WORLD_HUMAN_SECURITY_SHINE_TORCH"}},
			{label = "Управление движением", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT", flag = 9}},
			{label = "Молоток", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "Просить деньги", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "Мим", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
			
		}
	},

	{
		name  = 'humors',
		label = 'Реакции',
		items = {
			{label = "Хлопать", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Лайк", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06", upper=true, control=true}},
			{label = "Эй ты", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point", upper=true, control=true}},
			{label = "Подойди", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft", upper=true, control=true}},
			{label = "Ну давай", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on", upper=true, control=true}},
			{label = "Рукалицо", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm", upper=true, control=true}},
			{label = "Осторожно осмотреть", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Испуг", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right", repeat_anim=true}},
			{label = "Вот черт!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn", upper=true, control=true}},
			{label = "Да пошли вы!", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter", upper=true, control=true}},
			{label = "Передернуть", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01", upper=true, control=true, flag = 9}},
			{label = "Застрелиться", type = "anim", data = {lib = "mp_suicide", anim = "pistol", stop_last_frame=true}},
			{label = "Это круто!", type = "anim", data = {lib = "anim@mp_player_intupperbanging_tunes", anim = "idle_a", upper=true, control=true, flag = 9}},
		}
	},

	{
		name  = 'sports',
		label = 'Спорт',
		items = {
			{label = "Показывать мускулы", type = "scenario", data = {anim = "WORLD_HUMAN_MUSCLE_FLEX"}},
			{label = "Отжиматься", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base", flag = 9}},
			{label = "Качать пресс", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base", flag = 9}},
			{label = "Йога", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a", flag = 9}},
			{label = "Йога 2", type = "anim", data = {lib = "amb@world_human_yoga@female@base", anim = "base_c", flag = 9}},
			{label = "Разминка перед дракой", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", flag = 9}},
			{label = "Зарядка", type = "anim", data = {lib = "timetable@tracy@ig_5@idle_b", anim = "idle_e", flag = 9}},
			{label = "Бег на месте", type = "scenario", data = {anim = "WORLD_HUMAN_JOG_STANDING"}},
			{label = "Турник", type = "scenario", data = {anim = "PROP_HUMAN_MUSCLE_CHIN_UPS"}},
			{label = "Жим лежа", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"}},
		}
	},
	{
		name  = 'sit',
		label = 'Сидеть/лежать',
		items = {
			{label = "На земле", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
			{label = "Лежать на спине", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Лежать на животе", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "Лежать на боку", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_right_side@base", anim = "base", flag = 9}},
		}
	},

	{
		name  = 'misc',
		label = 'Разное',
		items = {
			{label = "Селфи", type = "scenario", data = {anim = "world_human_tourist_mobile", upper=true, control=true}},
			{label = "Взламывать", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base", flag = 9}},
		}
	},
	{
		name  = 'stand',
		label = 'Стойки',
		items = {
			{label = "Пританцовывать бар", type = "anim", data = {lib = "anim@amb@nightclub@dancers@club_ambientpeds_transitions@", anim = "trans_li-mi_to_mi-hi_09_v1_male^3", flag = 9}},
			{label = "Завлекающая", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Коп", type = "scenario", data = {anim = "WORLD_HUMAN_COP_IDLES"}},
			{label = "Охрана", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND"}},	
			{label = "Ожидать", type = "scenario", data = {anim = "WORLD_HUMAN_STAND_IMPATIENT"}},
			{label = "Облокотиться 1", type = "scenario", data = {anim = "PROP_HUMAN_BUM_SHOPPING_CART"}},
			{label = "Скрестить руки Ж", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@base", anim = "base", flag = 9}},
			{label = "Опереться спиной", type = "scenario", data = {anim = "world_human_leaning"}},
			
		}

	},

	{
		name  = 'attitudem',
		label = 'Походки',
		items = {
			{label = "Сдержанная М", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Сдержанная Ж", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Депрессивная М", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			{label = "Депрессивная Ж", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Спокойная", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Уверенная", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Задумчивая", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Пухлая", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Хипстерская", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Хромая", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			{label = "Спешащая", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Пьяная", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			
			{label = "Гордая", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "Обычная", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			{label = "В развалку М", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "В развалку Ж", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
			{label = "Уставшая", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Очень уставшая", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Спешащая М", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Спешащая Ж", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},
			{label = "Пританцовывая", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			{label = "Бегом", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "На стиле", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},	
		}
	},
	{
		name  = 'porn',
		label = 'PEGI 21',
		items = {
			{label = "Homme se faire su*** en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop", in_vehicle=true}},
			{label = "Femme faire une gaterie en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop", in_vehicle=true}},
			{label = "Homme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player", in_vehicle=true, repeat_anim=true}},
			{label = "Femme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", in_vehicle=true, repeat_anim=true}},
			{label = "Se gratter les couilles", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", upper=true, control=true}},
			{label = "Faire du charme", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			{label = "Pose michto", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Montrer sa poitrine", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			{label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			{label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			{label = "Stip Tease au sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
		}
	},
	{
		name  = 'dance',
		label = 'Танцы',
		items = {
        {label = "Taniec 5", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6", flag = 9}},
        {label = "Taniec 6", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", anim = "li_dance_facedj_09_v1_male^6", flag = 9}},
        {label = "Taniec 9", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", flag = 9}},
        {label = "Taniec 13", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", flag = 9}},
        {label = "Taniec 18", type = "anim", data = {lib = "mini@strip_club@idles@dj@idle_04", anim = "idle_04", flag = 9}},
        {label = "Taniec 21", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", flag = 9}},
        {label = "Taniec 22", type = "anim", data = {lib = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", flag = 9}},
        {label = "Taniec 24", type = "anim", data = {lib = "anim@amb@nightclub@dancers@dixon_entourage@", anim = "mi_dance_facedj_15_v1_male^4", flag = 9}},
        {label = "Taniec 25", type = "anim", data = {lib = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", flag = 9}},
        {label = "Taniec 28", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", flag = 9}},
        {label = "Taniec 33", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", flag = 9}},
        {label = "Taniec 34", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", flag = 9}},
        {label = "Taniec 35", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", flag = 9}},
				{label = "Taniec 40", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_06_base_laz", flag = 9}},
				{label = "Dans1", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^1", flag = 9}},
				{label = "Dans2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^2", flag = 9}},
				{label = "Dans3", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^3", flag = 9}},
				{label = "Dans4", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^4", flag = 9}},
				-- {label = "Dans5", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^5", flag = 9}},
				{label = "Dans6", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_11_v1_female^1", flag = 9}},
				{label = "Dans7", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_15_v1_female^1", flag = 9}},
				{label = "Dans8", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", flag = 9}},
				{label = "Dans9", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^3", flag = 9}},
				{label = "Dans10", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^1", flag = 9}},
				{label = "Dans12", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_female^1", flag = 9}},
				{label = "Dans13", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_female^3", flag = 9}},
				{label = "Dans14", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_female^3", flag = 9}},
				{label = "Dans15", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_female^3", flag = 9}},
				{label = "Dans16", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_female^1", flag = 9}},
				{label = "Dans17", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^3", flag = 9}},
				{label = "Dans19", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^2", flag = 9}},
		}
	},
	{
		name  = 'test',
		label = 'test',
		items = {
			
			{label = "Сидеть тест", type = "scenario", data = {anim = "WORLD_HUMAN_SEAT_LEDGE"}},
			{label = "Сидеть с пончиком", type = "scenario", data = {anim = "WORLD_HUMAN_SEAT_LEDGE_EATING"}},
			{label = "Сидеть тест2", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_ARMCHAIR"}},
			-- ------------------------ЖИВОТНЫЕ
			{label = "A67", type = "scenario", data = {anim = "WORLD_BOAR_GRAZING"}},
			{label = "68", type = "scenario", data = {anim = "WORLD_CAT_SLEEPING_GROUND"}},
			{label = "69", type = "scenario", data = {anim = "WORLD_CAT_SLEEPING_LEDGE"}},
			{label = "70", type = "scenario", data = {anim = "WORLD_COW_GRAZING"}},
			{label = "71", type = "scenario", data = {anim = "WORLD_COYOTE_HOWL"}},
			{label = "72", type = "scenario", data = {anim = "WORLD_COYOTE_REST"}},
			{label = "73", type = "scenario", data = {anim = "WORLD_COYOTE_WANDER"}},
			{label = "74", type = "scenario", data = {anim = "WORLD_CHICKENHAWK_FEEDING"}},
			{label = "75", type = "scenario", data = {anim = "WORLD_CHICKENHAWK_STANDING"}},
			{label = "76", type = "scenario", data = {anim = "WORLD_CORMORANT_STANDING"}},
			{label = "77", type = "scenario", data = {anim = "WORLD_CROW_FEEDING"}},
			{label = "78", type = "scenario", data = {anim = "WORLD_CROW_STANDING"}},
			{label = "79", type = "scenario", data = {anim = "WORLD_DEER_GRAZING"}},
			{label = "80", type = "scenario", data = {anim = "WORLD_DOG_BARKING_ROTTWEILER"}},
			{label = "81", type = "scenario", data = {anim = "WORLD_DOG_BARKING_RETRIEVER"}},
			{label = "82", type = "scenario", data = {anim = "WORLD_DOG_BARKING_SHEPHERD"}},
			{label = "83", type = "scenario", data = {anim = "WORLD_DOG_SITTING_ROTTWEILER"}},
			{label = "84", type = "scenario", data = {anim = "WORLD_DOG_SITTING_RETRIEVER"}},
			{label = "85", type = "scenario", data = {anim = "WORLD_DOG_SITTING_SHEPHERD"}},
			{label = "86", type = "scenario", data = {anim = "WORLD_DOG_BARKING_SMALL"}},
			{label = "87", type = "scenario", data = {anim = "WORLD_DOG_SITTING_SMALL"}},
			{label = "88", type = "scenario", data = {anim = "WORLD_FISH_IDLE"}},
			{label = "89", type = "scenario", data = {anim = "WORLD_GULL_FEEDING"}},
			{label = "90", type = "scenario", data = {anim = "WORLD_GULL_STANDING"}},
			{label = "91", type = "scenario", data = {anim = "WORLD_HEN_PECKING"}},
			{label = "92", type = "scenario", data = {anim = "WORLD_HEN_STANDING"}},
			{label = "93", type = "scenario", data = {anim = "WORLD_MOUNTAIN_LION_REST"}},
			{label = "94", type = "scenario", data = {anim = "WORLD_MOUNTAIN_LION_WANDER"}},
			{label = "95", type = "scenario", data = {anim = "WORLD_PIG_GRAZING"}},
			{label = "96", type = "scenario", data = {anim = "WORLD_PIGEON_FEEDING"}},
			{label = "97", type = "scenario", data = {anim = "WORLD_PIGEON_STANDING"}},
			{label = "98", type = "scenario", data = {anim = "WORLD_RABBIT_EATING"}},
			{label = "A99", type = "scenario", data = {anim = "WORLD_SHARK_SWIM"}},
		}
		
			
	
},
		
	{
		name  = 'hakanonur',
		label = '+18',
		items = {
		{label = "Özel Dans Erkek", type = "anim", data = {lib = "mp_am_stripper", anim = "lap_dance_player"}},
		{label = "Özel Dans Kız", type = "anim", data = {lib = "mp_am_stripper", anim = "lap_dance_girl"}},
		{label = "Özel Dans Kız 2", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p2", anim = "ld_girl_a_song_a_p2_f"}},
		{label = "Özel Dans Kız 3", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p3", anim = "ld_girl_a_song_a_p3_f"}},
		{label = "Özel Dans Kız 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1"}},
		{label = "Sakso Çek Kız", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_hooker"}},
		{label = "Sakso Çek Erkek", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_punter"}},
		{label = "Sokakta Ver Kız", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "shagloop_hooker"}},
		{label = "Sokakta Ver Erkek", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "shagloop_pimp"}},
		{label = "Arka Koltuk Erkek", type = "anim", data = {lib = "oddjobs@assassinate@vice@sex", anim = "frontseat_carsex_loop_m"}},
		{label = "Arka Koltuk Üstüne Bin", type = "anim", data = {lib = "oddjobs@assassinate@vice@sex", anim = "frontseat_carsex_intro_f"}},
		{label = "Arka Koltuk Üstünde Zıpla", type = "anim", data = {lib = "oddjobs@assassinate@vice@sex", anim = "frontseat_carsex_loop_f"}},
		{label = "Üstünde Zıpla", type = "anim", data = {lib = "random@drunk_driver_2", anim = "cardrunksex_loop_f"}},
			}
		},
	
			

}

