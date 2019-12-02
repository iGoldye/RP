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
			{label = "Курить", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING", flag = 9}},
			{label = "Курить на ходу 1", type = "dpemotes", data = {anim = "smoke2"}},
			{label = "Курить на ходу 2", type = "dpemotes", data = {anim = "smoke3"}},
			{label = "Курить на ходу Ж", type = "dpemotes", data = {anim = "smoke4"}},
			{label = "Сиграрета в зубах", type = "dpemotes", data = {anim = "cigar2"}},
			{label = "Cигара в зубах", type = "dpemotes", data = {anim = "cigar"}},
			{label = "Музицировать", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN", flag = 9}},
			{label = "Играть на саксофоне", type = "dpemotes", data = {anim = "sax"}},
			{label = "Диджей", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj", flag = 9}},
			{label = "Воображаемая гитара", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "Сотрясать воздух", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock", upper=true, control=true, flag = 9}},
			{label = "Курить косяк", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			{label = "Схватить", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high", upper=false, control=true, flag = 9}},
			{label = "Стучать", type = "anim", data = {lib = "amb@code_human_in_car_mp_actions@dance@bodhi@ds@base", anim = "idle_a_fp", flag = 9}},
			{label = "Копаться в", type = "scenario", data = {anim = "PROP_HUMAN_BUM_BIN"}},
			{label = "Достать сверху", type = "anim", data = {lib = "mph_hum_fin_ext-0", anim = "s_m_m_highsec_01_dual-0", upper=true, flag = 9}},
			{label = "Я пожалуй пойду", type = "anim", data = {lib = "abigail_mcs_2-5", anim = "csb_abigail_dual-5"}},
			{label = "Руки за голову", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c", repeat_anim=true}},
			{label = "Вырвать", type = "anim", data = {lib = "anim@amb@clubhouse@respawn@female@", anim = "respawn_d"}},
			{label = "Селфи", type = "scenario", data = {anim = "world_human_tourist_mobile", upper=true, control=true}},
			{label = "Осмотреть Ж", type = "anim", data = {lib = "oddjobs@taxi@gyn@", anim = "idle_b_ped", flag = 9}},
			{label = "Ходить задумчиво", type = "anim", data = {lib = "martin_1_int-5", anim = "cs_patricia_dual-5", flag = 9}},
			{label = "Отряхиваться", type = "anim", data = {lib = "move_m@_idles@shake_off", anim = "shakeoff_1", flag = 9}},
			{label = "Перебирать бумаги", type = "anim", data = {lib = "iaa_int-14", anim = "cs_lestercrest_2_dual-14", flag = 9}},
			{label = "Барбекю", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "Уборщик", type = "scenario", data = {anim = "WORLD_HUMAN_JANITOR"}},
			{label = "Затянуться из бонга", type = "dpemotes", data = {anim = "bong"}},
			{label = "Читать книгу", type = "dpemotes", data = {anim = "book"}},
			{label = "Достать розу", type = "dpemotes", data = {anim = "rose"}},
			{label = "Достать ящик", type = "dpemotes", data = {anim = "box"}},
			{label = "Бросаться деньгами", type = "dpemotes", data = {anim = "makeitrain"}},
			{label = "Ловить попутку", type = "dpemotes", data = {anim = "lift"}},
			{label = "Намасте", type = "dpemotes", data = {anim = "namaste"}},
		}
	},
	{
	name  = 'festives2',
		label = 'Действия c едой',
		items = {
			{label = "Есть бургер", type = "dpemotes", data = {anim = "burger"}},
			{label = "Есть пончик", type = "dpemotes", data = {anim = "donut"}},
			{label = "Есть Батончик", type = "dpemotes", data = {anim = "egobar"}},
			{label = "Есть Сендвич", type = "dpemotes", data = {anim = "sandwich"}},
			{label = "Выпить виски", type = "dpemotes", data = {anim = "whiskey"}},
			{label = "Выпить шампанское", type = "dpemotes", data = {anim = "champagne"}},
			{label = "Держать пустой бокал", type = "dpemotes", data = {anim = "flute"}},
			{label = "Выпить вино", type = "dpemotes", data = {anim = "wine"}},
			{label = "Выпить Кофе", type = "dpemotes", data = {anim = "coffee"}},
			{label = "Пить кофе", type = "event", data = {anim = "esx_animations:anim_coffee"}},
			{label = "Пить из стаканчика", type = "dpemotes", data = {anim = "cup"}},
			{label = "Пить пиво", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "Тусоваться с пивом", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "Выпить содовой", type = "dpemotes", data = {anim = "soda"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Приветствия',
		items = {
			{label = "Помахать", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello", upper=true, control=true}},
			{label = "Пожать руку", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a", upper=true, control=true}},
			{label = "Приобнять", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a", upper=false, control=true}},
			{label = "Обнять", type = "anim", data = {lib = "anim@amb@nightclub@djs@switch@bmad_djset_switchover@", anim = "bmad_out_soldix_in_a_bg_male1"}},
			{label = "Поцеловать", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a", flag = 9}},
			{label = "Братство", type = "anim", data = {lib = "anim@random@shop_clothes@watches", anim = "base", upper=true, control=true, flag = 9}},
			{label = "Отдать честь", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute", stop_last_frame=true, upper=true, control=true,}},
			{label = "Бро", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@bro_love", anim = "bro_love"}},
			{label = "Воздушный поцелуй", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss"}},
			{label = "Воздушный поцелуй Ж", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_a"}},
		}
	},

	{
		name  = 'work',
		label = 'Работа',
		items = {
			{label = "Рыбачить", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "Искать улики", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Смотреть в бинокль", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "Копать", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "Чинить двигатель", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped", flag = 9}},
			{label = "Чинить днище", type = "scenario", data = {anim = "WORLD_HUMAN_VEHICLE_MECHANIC"}},
			{label = "Сварка", type = "scenario", data = {anim = "WORLD_HUMAN_WELDING"}},
			{label = "Прикрутить", type = "anim", data = {lib = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flag = 9}},
			{label = "Осматривать", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			{label = "Протирать", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "Перекладывать ящики", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper", flag = 9}},
			{label = "Налить рюмку", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b", flag = 9}},
			{label = "Фотографировать", type = "dpemotes", data = {anim = "camera"}},
			{label = "Планшет", type = "dpemotes", data = {anim = "clipboard"}},
			{label = "Блокнот", type = "dpemotes", data = {anim = "notepad"}},
			{label = "Светить фонарем М", type = "scenario", data = {anim = "WORLD_HUMAN_SECURITY_SHINE_TORCH"}},
			{label = "Управление движением М", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT", flag = 9}},
			{label = "Молоток", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "Бурить ", type = "scenario", data = {anim = "WORLD_HUMAN_CONST_DRILL"}},
			{label = "Листодув М", type = "dpemotes", data = {anim = "leafblower"}},
			{label = "Просить деньги М", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "Мим", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
			{label = "Обрывать", type = "anim", data = {lib = "anim@amb@business@weed@weed_inspecting_lo_med_hi@", anim = "weed_crouch_checkingleaves_idle_01_inspectorfemale", flag = 9}},
			{label = "Взламывать Сейф", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base", flag = 9}},
			{label = "Взламывать Замок", type = "anim", data = {lib = "low_int-0", anim = "ig_benny_dual-0", flag = 9}},
			{label = "Печатать", type = "dpemotes", data = {anim = "type4"}},
			{label = "Старт стритрейсеров", type = "anim", data = {lib = "random@street_race", anim = "grid_girl_race_start", flag = 9}},
			{label = "Мыть руки", type = "anim", data = {lib = "missheist_agency3aig_23", anim = "urinal_sink_loop", flag = 9}},
			{label = "Микрофон", type = "anim", data = {lib = "amb@world_human_aa_coffee@base", anim = "base", upper=true, control=true, flag = 9}},
			{label = "Печатать на компьютере", type = "anim", data = {lib = "maude_mcs_4-6", anim = "csb_maude_dual-6", upper=true, flag = 9}},
			{label = "Осмотр Доктора", type = "anim", data = {lib = "misscarsteal2fixer", anim = "confused_a", flag = 9}},
			{label = "Колдовать", type = "dpemotes", data = {anim = "mindcontrol2"}},
		}
	},

	{
		name  = 'humors',
		label = 'Реакции',
		items = {
			{label = "Хлопать", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Лайк", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06", upper=true, control=true}},
			{label = "Пальцы вверх", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_upbodhi@ps@", anim = "idle_a", upper=true, control=true, flag = 9}},
			{label = "Эй ты", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point", upper=true, control=true}},
			{label = "Подойди", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft", upper=true, control=true}},
			{label = "Ну давай", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on", upper=true, control=true}},
			{label = "Рукалицо", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm", upper=true, control=true}},
			{label = "Рукалицо Ж", type = "anim", data = {lib = "random@robbery", anim = "stand_worried_female", upper=true, control=true, flag = 9}},
			{label = "Осторожно осмотреть", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Испуг", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right", repeat_anim=true}},
			{label = "Вот черт!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn", upper=true, control=true}},
			{label = "Да пошли вы!", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter", upper=true, control=true}},
			{label = "Передернуть", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01", upper=true, control=true, flag = 9}},
			{label = "Застрелиться", type = "anim", data = {lib = "mp_suicide", anim = "pistol", stop_last_frame=true}},
			{label = "Это круто!", type = "anim", data = {lib = "anim@mp_player_intupperbanging_tunes", anim = "idle_a", upper=true, control=true, flag = 9}},
			{label = "Зачитать", type = "dpemotes", data = {anim = "danceupper"}},
			{label = "Хлопки", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", upper=true, control=true, flag = 9}},
			{label = "Незнаю", type = "anim", data = {lib = "gestures@miss@dockssetup1", anim = "floyd_dh1_afac_01_g1"}},
			{label = "Подумай", type = "anim", data = {lib = "gestures@miss@fra_0", anim = "lamar_fkn0_cjae_01_g4", flag = 9}},
			{label = "Обида", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_reject"}},
			{label = "За что?", type = "anim", data = {lib = "random@car_thief@waiting_ig_4", anim = "idle_a"}},
			{label = "Сердце прихватило", type = "anim", data = {lib = "rcmfanatic1out_of_breath", anim = "p_zero_tired_01", upper=true, flag = 9}},
			{label = "Плакать", type = "anim", data = {lib = "random@robbery", anim = "f_cower_01", flag = 9}},
			{label = "Восхищение", type = "anim", data = {lib = "random@bus_tour_guide@idle_a", anim = "idle_b", flag = 9}},
			{label = "Досада", type = "anim", data = {lib = "random@bicycle_thief@idle_a", anim = "idle_b", flag = 9}},
		  {label = "Неа!", type = "anim", data = {lib = "mini@prostitutestalk", anim = "street_argue_f_a", flag = 9}},
			{label = "Отчаяние", type = "anim", data = {lib = "misscarsteal2car_stolen", anim = "chad_car_stolen_reaction", flag = 9}},
			{label = "Клоун1", type = "dpemotes", data = {anim = "clown"}},
			{label = "Клоун2", type = "dpemotes", data = {anim = "clown2"}},
			{label = "Угроза", type = "dpemotes", data = {anim = "cutthroat"}},
			{label = "Пошел ты", type = "dpemotes", data = {anim = "finger"}},
			{label = "Мир", type = "dpemotes", data = {anim = "peace"}},
			{label = "Мир 2", type = "dpemotes", data = {anim = "peace2"}},
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
			{label = "Йога 3", type = "dpemotes", data = {anim = "stretch4"}},
			{label = "Разминка перед дракой", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", flag = 9}},
			{label = "Зарядка", type = "anim", data = {lib = "timetable@tracy@ig_5@idle_b", anim = "idle_e", flag = 9}},
			{label = "Бег на месте", type = "scenario", data = {anim = "WORLD_HUMAN_JOG_STANDING"}},
			{label = "Турник", type = "scenario", data = {anim = "PROP_HUMAN_MUSCLE_CHIN_UPS"}},
			{label = "Жим лежа", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"}},
			{label = "Медитация лотос", type = "anim", data = {lib = "rcmcollect_paperleadinout@", anim = "meditiate_idle", flag = 9}},
			{label = "Медитация стоя", type = "dpemotes", data = {anim = "statue3"}},
			{label = "Разминка 1", type = "anim", data = {lib = "mini@triathlon", anim = "idle_a", flag = 9}},
			{label = "Разминка 2", type = "anim", data = {lib = "mini@triathlon", anim = "idle_e", flag = 9}},
			{label = "Бэкфлип", type = "dpemotes", data = {anim = "flip"}},
			{label = "Фронтфлип", type = "dpemotes", data = {anim = "flip2"}},

		}
	},
	{
		name  = 'sit',
		label = 'Сидеть/Лежать',
		items = {
			{label = "Отдыхать", type = "dpemotes", data = {anim = "chill"}},
			{label = "Наблюдать за облаками", type = "dpemotes", data = {anim = "cloudgaze"}},
			{label = "Подстрелили", type = "dpemotes", data = {anim = "shot"}},
			{label = "Свернуться", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_sofa@", anim = "lowsofa_dlg_fuckedup_laz", flag = 9}},
			{label = "Лежать на спине", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Лежать на спине 2", type = "dpemotes", data = {anim = "cloudgaze2"}},
			{label = "Лежать на животе", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "Лежать на животе 2", type = "anim", data = {lib = "missarmenian2", anim = "drunk_loop", flag = 9}},
			{label = "Лежать на боку П", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_right_side@base", anim = "base", flag = 9}},
			{label = "Лежать на боку Л", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_left_side@base", anim = "base", flag = 9}},
			{label = "Лежать на боку Л2", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_intro", flag = 9}},
			{label = "Лежать раскинувшись", type = "anim", data = {lib = "missarmenian2", anim = "corpse_search_exit_ped", flag = 9}},
			{label = "Пьяный на земле", type = "anim", data = {lib = "timetable@amanda@drunk@idle_a", anim = "idle_pinot", flag = 9}},
			{label = "Сидеть облокотившись", type = "dpemotes", data = {anim = "sit2"}},
			{label = "Руки на коленях", type = "dpemotes", data = {anim = "sit5"}},
			{label = "Сидеть отрешенно", type = "anim", data = {lib = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_idle_03_nowork", flag = 9}},
			{label = "Скучать", type = "anim", data = {lib = "anim@amb@business@cfm@cfm_machine_no_work@", anim = "sleep_cycle_v2_operator", flag = 9}},
			{label = "Сидеть", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
			{label = "Наблюдать на колене", type = "dpemotes", data = {anim = "kneel3"}},
      -- {label = "Сидеть тест", type = "scenario", data = {anim = "WORLD_HUMAN_SEAT_LEDGE"}},
			-- {label = "Сидеть с пончиком", type = "scenario", data = {anim = "WORLD_HUMAN_SEAT_LEDGE_EATING"}},
			-- {label = "Сидеть тест2", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_ARMCHAIR"}},
			{label = "На кортах", type = "anim", data = {lib = "missheistdockssetup1ig_10@idle_a", anim = "talk_pipe_a_worker1", flag = 9}},
			{label = "На кортах 2", type = "dpemotes", data = {anim = "kneel2"}},
			{label = "В отчаянии", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", flag = 9}},
			{label = "В отчаянии 2", type = "dpemotes", data = {anim = "sitscared"}},
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
			{label = "Ожидать Ж", type = "anim", data = {lib = "friends@fra@ig_1", anim = "base_idle", flag = 9}},
			{label = "Облокотиться", type = "anim", data = {lib= "amb@prop_human_bum_shopping_cart@male@base", anim = "base",  flag = 9}},
			{label = "Опереться спиной", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "Задуматься", type = "anim", data = {lib = "anim@amb@board_room@whiteboard@", anim = "think_01_amy_skater_01", upper=true, control=true, flag = 9}},
			{label = "Опереться", type = "anim", data = {lib = "mp_safehousebeer@", anim = "base_drink", flag = 9}},
			{label = "Опереться низко", type = "anim", data = {lib = "anim@amb@board_room@diagram_blueprints@", anim = "idle_04_amy_skater_01", flag = 9}},
			{label = "Скучать М", type = "anim", data = {lib = "anim@amb@business@cfid@cfid_photograph@", anim = "camera_fiddle_model", flag = 9}},
			{label = "Скучать Ж", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "amb_world_human_hang_out_street_female_hold_arm_idle_b", flag = 9}},
			{label = "Облокотиться спиной", type = "anim", data = {lib = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", flag = 9}},
			{label = "Скрестить руки 1", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "amb_world_human_hang_out_street_male_c_base", flag = 9}},
			{label = "Скрестить руки 2", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", flag = 9}},
			{label = "Скрестить руки 3", type = "anim", data = {lib = "random@shop_gunstore", anim = "_idle", flag = 9}},
			{label = "Скрестить руки 4", type = "dpemotes", data = {anim = "crossarms"}},
			{label = "Скрестить руки 5", type = "dpemotes", data = {anim = "crossarms3"}},
			{label = "Скрестить руки Ж", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@base", anim = "base", flag = 9}},
			{label = "Скрестить руки Ж2", type = "anim", data = {lib = "low_fun_mcs1-0", anim = "mp_m_g_vagfun_01^11_dual-0", flag = 9}},
			{label = "Опереться бар", type = "anim", data = {lib = "anim@amb@yacht@bow@female@variation_01@", anim = "idle_b", flag = 9}},
			{label = "Руки за спиной", type = "anim", data = {lib = "ep_7_rcm-4", anim = "cs_jimmyboston_dual-4", upper=true, control=true, flag = 9}},
			{label = "Руки на поясе", type = "anim", data = {lib = "mmb_1_rcm-5", anim = "cs_joeminuteman_dual-5", upper=true, flag = 9}},
			{label = "Очень грустно", type = "anim", data = {lib = "oddjobs@bailbond_hobodepressed", anim = "idle_a", flag = 9}},
			{label = "Расставить руки", type = "anim", data = {lib = "martin_1_int-1", anim = "cs_martinmadrazo_dual-1", flag = 9}},
			{label = "Зажатая Ж", type = "anim", data = {lib = "low_fun_mcs1-0", anim = "mp_m_g_vagfun_01^12_dual-0", flag = 9}},
			{label = "Спиной к стене скрестить руки", type = "anim", data = {lib = "impexp_int_l1-10", anim = "mp_m_waremech_01_dual-10", flag = 9}},
			{label = "Думать", type = "anim", data = {lib = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director"}},
			{label = "Думать 2", type = "dpemotes", data = {anim = "think2"}},
			{label = "Висеть на крюке", type = "anim", data = {lib = "mic_2_mcs_1-0", anim = "player_zero_dual-0", flag = 9}},
			{label = "Опереться боком", type = "anim", data = {lib = "misscarsteal1car_1_ext_leadin", anim = "base_driver1", flag = 9}},
			{label = "Опереться рукой", type = "anim", data = {lib = "misscarstealfinale", anim = "packer_idle_1_trevor", flag = 9}},
			{label = "Опереться локтем", type = "anim", data = {lib = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", flag = 9}},
			{label = "Супергерой", type = "dpemotes", data = {anim = "superhero"}},

		}

	},

	{
		name  = 'attitudem',
		label = 'Походки М',
		items = {
			{label = "Обычная М", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			{label = "Сдержанная", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Депрессивная", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			{label = "Спокойная", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Уверенная", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Задумчивая", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Пухлая", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Хипстерская", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Хромая", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			{label = "Ритмичная", type = "attitude", data = {lib = "move_m@casual@e", anim = "move_m@casual@e"}},
			{label = "Угрожающая", type = "attitude", data = {lib = "move_characters@franklin@fire", anim = "move_characters@franklin@fire"}},
			{label = "Грозная", type = "attitude", data = {lib = "move_m@brave@b", anim = "move_m@brave@b"}},
			{label = "Выпивший", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			{label = "Пьяная", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "В стельку", type = "attitude", data = {lib = "move_m@drunk@verydrunk", anim = "move_m@drunk@verydrunk"}},
			{label = "Альфа", type = "attitude", data = {lib = "move_p_m_zero_slow", anim = "move_p_m_zero_slow"}},
			{label = "Гордая", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "В развалку", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "Уставшая", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Очень уставшая", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Спешащая М1", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Спешащая М2", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Бегом", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "На стиле", type = "attitude", data = {lib = "move_m@swagger", anim = "move_m@swagger"}},
			{label = "Боевая", type = "attitude", data = {lib = "move_action@generic@core", anim = "move_action@generic@core"}},
			{label = "Шатающаяся", type = "attitude", data = {lib = "move_characters@orleans@core@", anim = "move_characters@orleans@core@"}},
			{label = "Измученная", type = "attitude", data = {lib = "move_m@drunk@a", anim = "move_m@drunk@a"}},
			{label = "Без сил", type = "attitude", data = {lib = "move_m@drunk@moderatedrunk", anim = "move_m@drunk@moderatedrunk"}},
			{label = "Пританцовывая М", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
		  {label = "Пафосная", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
		  {label = "Сутенерская", type = "attitude", data = {lib = "move_m@swagger", anim = "move_m@swagger"}},
		}
	},

	{
		name  = 'attitudem2',
		label = 'Походки Ж',
		items = {
			{label = "Обычная Ж", type = "attitude", data = {lib = "move_f@generic", anim = "move_f@generic"}},
			{label = "Сдержанная Ж", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Депрессивная Ж", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Ритмичная Ж", type = "attitude", data = {lib = "anim@move_f@grooving@", anim = "anim@move_f@grooving@"}},
			{label = "Деловая Ж", type = "attitude", data = {lib = "move_f@tough_guy@", anim = "move_f@tough_guy@"}},
			{label = "В развалку Ж", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
			{label = "На стиле Ж", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			{label = "Пухлая Ж", type = "attitude", data = {lib = "move_f@fat@a", anim = "move_f@fat@a"}},
			{label = "От бедра Ж", type = "attitude", data = {lib = "move_f@femme@", anim = "move_f@femme@"}},
			{label = "Спешащая Ж", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},
			{label = "Спешащая Ж2", type = "attitude", data = {lib = "move_f@hurry@a", anim = "move_f@hurry@a"}},
			{label = "Грустная Ж", type = "attitude", data = {lib = "move_f@sad@a", anim = "move_f@sad@a"}},
			{label = "Свободная Ж", type = "attitude", data = {lib = "move_m@femme@", anim = "move_m@femme@"}},

		}
	},

	{
		name  = 'unic',
		label = 'Танцы',
		items = {

			{label = "Шафл", type = "dpemotes", data = {anim = "dancesilly7"}},
			{label = "Чечетка", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", flag = 9}},
			{label = "Водоворот", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", flag = 9}},
			{label = "Единорог медленный 1", type = "dpemotes", data = {anim = "unicorn1"}},
			{label = "Единорог медленный 2", type = "dpemotes", data = {anim = "unicorn6"}},
			{label = "Единорог активный 1", type = "dpemotes", data = {anim = "unicorn2"}},
			{label = "Единорог активный 2", type = "dpemotes", data = {anim = "unicorn3"}},
			{label = "Единорог активный 3", type = "dpemotes", data = {anim = "unicorn4"}},
			{label = "Единорог активный 4", type = "dpemotes", data = {anim = "unicorn5"}},
			{label = "Светящиеся палки 1", type = "dpemotes", data = {anim = "danceglowstick"}},
			{label = "Светящиеся палки 2", type = "dpemotes", data = {anim = "danceglowstick2"}},
			{label = "Светящиеся палки 3", type = "dpemotes", data = {anim = "danceglowstick3"}},

		}
	},

	{
		name  = 'dance',
		label = 'Танцы Ж',
		items = {

				{label = "Стильная", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^1", flag = 9}},
				{label = "Легкий денс", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^2", flag = 9}},
				{label = "На флексе", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^3", flag = 9}},
				{label = "Уставшая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_09_v2_female^4", flag = 9}},
				{label = "Звездная", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_15_v1_female^1", flag = 9}},
				{label = "На волне 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_female^3", flag = 9}},
				{label = "Пьяненькая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_female^3", flag = 9}},
				{label = "Энергичная", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "hi_dance_crowd_11_v1_female^1", flag = 9}},
				{label = "Энергичная 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_female^1", flag = 9}},
				{label = "Энергичная 3", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^1", flag = 9}},
	      {label = "Игривая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^1", flag = 9}},
	      {label = "Обычный", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^2", flag = 9}},
	      {label = "Игривая 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^3", flag = 9}},
	      {label = "Обычный 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_11_v1_female^3", flag = 9}},
	      {label = "В отрыв", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^2", flag = 9}},
	      {label = "Легкая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_female^5", flag = 9}},
	      {label = "Веселая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_13_v2_male^5", flag = 9}},
	      {label = "Волнистая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_17_v2_female^1", flag = 9}},
				{label = "Волнистая 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v1_female^1", flag = 9}},
				{label = "Волнистая 3", type = "dpemotes", data = {anim = "danceslow2"}},
				{label = "Соблазнительная", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "mini_strip_club_private_dance_idle_priv_dance_idle", flag = 9}},
				{label = "Мечтательная", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center", flag = 9}},
				{label = "Няшная", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center", flag = 9}},
				{label = "Заманивающая", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", flag = 9}},
				{label = "Плавная", type = "dpemotes", data = {anim = "dance5"}},

				-- {label = "Единорог медленный 1", type = "dpemotes", data = {anim = "unicorn1"}},
				-- {label = "Единорог медленный 2", type = "dpemotes", data = {anim = "unicorn6"}},
				-- {label = "Единорог активный 1", type = "dpemotes", data = {anim = "unicorn2"}},
				-- {label = "Единорог активный 2", type = "dpemotes", data = {anim = "unicorn3"}},
				-- {label = "Единорог активный 3", type = "dpemotes", data = {anim = "unicorn4"}},
				-- {label = "Единорог активный 4", type = "dpemotes", data = {anim = "unicorn5"}},


		}
	},

	{
		name  = 'dance2',
		label = 'Танцы M',
		items = {
        {label = "Разогрев", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6", flag = 9}},
        {label = "В теме", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", flag = 9}},
        {label = "Качает", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", flag = 9}},
        {label = "Заводила", type = "anim", data = {lib = "mini@strip_club@idles@dj@idle_04", anim = "idle_04", flag = 9}},
        {label = "Расслабленная", type = "anim", data = {lib = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", flag = 9}},
        {label = "Волна", type = "anim", data = {lib = "anim@amb@nightclub@dancers@dixon_entourage@", anim = "mi_dance_facedj_15_v1_male^4", flag = 9}},
        {label = "На стиле", type = "anim", data = {lib = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", flag = 9}},
        {label = "Легкий расколбас", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", flag = 9}},
        {label = "Топ-топ", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", flag = 9}},
				{label = "Низкий хлоп ", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^2", flag = 9}},
	      {label = "Стильная 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_female^6", flag = 9}},
				{label = "Уносящая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^2", flag = 9}},
				{label = "Уносящая 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v2_female^4", flag = 9}},
	      {label = "Безудержанная", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "hi_dance_facedj_09_v1_male^4", flag = 9}},
	      {label = "Флексовая", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "mi_dance_facedj_09_v1_male^4", flag = 9}},
	      {label = "Легкий", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@", anim = "mi_dance_facedj_11_v2_male^5", flag = 9}},
	      {label = "Заводила 2", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_17_spiderman_laz", flag = 9}},
	      {label = "Криминальное чтиво", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_li_15_flyingv_laz", flag = 9}},
	      {label = "Робот", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_15_robot_laz", flag = 9}},
	      {label = "Закружило", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_15_shimmy_laz", flag = 9}},
	      {label = "Диско", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_17_crotchgrab_laz", flag = 9}},
	      {label = "Диско М", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_17_teapotthrust_laz", flag = 9}},
	      {label = "Принудительная", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center", flag = 9}},
				{label = "Уставшая", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center", flag = 9}},
				{label = "Гэнгста", type = "dpemotes", data = {anim = "dance8"}},


		}
	},
-- {
-- 	name  = 'anims',
-- 	label = 'testanim',
-- 	items = {

-- 		{label = "Приват 1", type = "anim", data = {lib = "family_4_mcs_2-12", anim = "cs_tracydisanto_dual-12", flag = 9}},
-- 		{label = "Приват 2", type = "anim", data = {lib = "family_4_mcs_2-14", anim = "cs_tracydisanto_dual-14", flag = 9}},
-- 		{label = "Приват 3", type = "anim", data = {lib = "friends@", anim = "pickupwait", flag = 9}},

-- 		{label = "Приват 5", type = "anim", data = {lib = "friends@fra@ig_1", anim = "impatient_idle_a", flag = 9}},
-- 		{label = "Приват 6", type = "anim", data = {lib = "friends@fra@ig_1", anim = "impatient_idle_a", flag = 9}},

-- 		{label = "Приват 8", type = "anim", data = {lib = "gestures@miss@dockssetup1", anim = "floyd_dh1_atab_01_g1", flag = 9}},
-- 		{label = "Приват 9", type = "anim", data = {lib = "gestures@miss@dockssetup1", anim = "floyd_dh1_atag_01_g2", flag = 9}},


-- 		{label = "Приват 14", type = "anim", data = {lib = "mini@cpr@char_a@cpr_str", anim = "cpr_cpr_to_kol", flag = 9}},

-- 		{label = "Приват 16", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_wait", flag = 9}},
-- 		{label = "Приват 17", type = "anim", data = {lib = "mini@hookers_sp", anim = "ilde_d", flag = 9}},
-- 		{label = "Приват 18", type = "anim", data = {lib = "missfam2_washing_face", anim = "michael_washing_face", flag = 9}},



-- 	}
-- },

	{
		name  = 'misc',
		label = 'Стриптиз',
		items = {
			{label = "Приват 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p2", anim = "ld_girl_a_song_a_p2_f", flag = 9}},
		  {label = "Приват 2", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p3", anim = "ld_girl_a_song_a_p3_f", flag = 9}},
			{label = "Завлекающий 1", type = "anim", data = {lib = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1", flag = 9}},
			{label = "Завлекающий 2", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", flag = 9}},
			{label = "Стриптиз 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", flag = 9}},
		  {label = "Стриптиз 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", flag = 9}},
			{label = "Стриптиз 3", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", flag = 9}},
			{label = "Стриптиз 4", type = "anim", data = {lib = "mp_am_stripper", anim = "lap_dance_girl", flag = 9}},
			{label = "У шеста 1", type = "anim", data = {lib = "mini@strip_club@pole_dance@pole_dance1", anim = "pd_dance_01", flag = 9}},
			{label = "У шеста 2", type = "anim", data = {lib = "mini@strip_club@pole_dance@pole_dance2", anim = "pd_dance_02", flag = 9}},
			{label = "У шеста 3", type = "anim", data = {lib = "mini@strip_club@pole_dance@pole_dance3", anim = "pd_dance_03", flag = 9}},
		}
	},

	{
		name  = 'hakanonur',
		label = '+18',
		items = {
		{label = "Минет", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_hooker", flag = 9}},
		{label = "У стенки", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "pimpsex_punter"}},
		{label = "Сзади", type = "anim", data = {lib = "misscarsteal2pimpsex", anim = "shagloop_pimp", flag = 9}},
	  {label = "Минет в машине Ж", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop", in_vehicle=true, flag = 9}},
		{label = "За рулем 1", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop", in_vehicle=true, flag = 9}},
		{label = "За рулем 2", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player", in_vehicle=true, repeat_anim=true, flag = 9}},
		{label = "За рулем 3", type = "anim", data = {lib = "oddjobs@assassinate@vice@sex", anim = "frontseat_carsex_loop_m", flag = 9}},
		{label = "В машине сверху Ж", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", in_vehicle=true, repeat_anim=true, flag = 9}},
		{label = "В машине сверху Ж2", type = "anim", data = {lib = "oddjobs@assassinate@vice@sex", anim = "frontseat_carsex_loop_f", flag = 9}},
		{label = "Эскорт", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", flag = 9}},
		{label = "Тверк", type = "dpemotes", data = {anim = "twerk"}},


		}
	},
	{
		name  = 'animaltest',
		label = 'Животные',
		items = {
			-- ------------------------ЖИВОТНЫЕ
			{label = "Кошка свернуться клубочком", type = "scenario", data = {anim = "WORLD_CAT_SLEEPING_GROUND"}},
			{label = "Cобака найти что-то", type = "scenario", data = {anim = "WORLD_DOG_BARKING_ROTTWEILER"}},
			{label = "Cобака сесть", type = "scenario", data = {anim = "WORLD_DOG_SITTING_ROTTWEILER"}},
			-- {label = "69", type = "scenario", data = {anim = "WORLD_CAT_SLEEPING_LEDGE"}},
			-- {label = "Койот выть", type = "scenario", data = {anim = "WORLD_COYOTE_HOWL"}},
			-- {label = "72", type = "scenario", data = {anim = "WORLD_COYOTE_REST"}},
			-- {label = "73", type = "scenario", data = {anim = "WORLD_COYOTE_WANDER"}},
			{label = "Орел кушать", type = "scenario", data = {anim = "WORLD_CHICKENHAWK_FEEDING"}},
			{label = "Орел отдыхать", type = "scenario", data = {anim = "WORLD_CHICKENHAWK_STANDING"}},
			{label = "Ворон кушать", type = "scenario", data = {anim = "WORLD_CROW_FEEDING"}},
			{label = "Ворон отдыхать", type = "scenario", data = {anim = "WORLD_CROW_STANDING"}},
			{label = "Олень", type = "scenario", data = {anim = "WORLD_DEER_GRAZING"}},
			{label = "Кабан", type = "scenario", data = {anim = "WORLD_BOAR_GRAZING"}},
			{label = "Корова", type = "scenario", data = {anim = "WORLD_COW_GRAZING"}},
			{label = "Пеликан", type = "scenario", data = {anim = "WORLD_CORMORANT_STANDING"}},
			{label = "Кролик", type = "scenario", data = {anim = "WORLD_RABBIT_EATING"}},
			{label = "Свинья", type = "scenario", data = {anim = "WORLD_PIG_GRAZING"}},
			-- {label = "Cобака ", type = "scenario", data = {anim = "WORLD_DOG_BARKING_RETRIEVER"}},
			-- {label = "Cобака", type = "scenario", data = {anim = "WORLD_DOG_BARKING_SHEPHERD"}},
			-- {label = "Cобака", type = "scenario", data = {anim = "WORLD_DOG_SITTING_RETRIEVER"}},
			-- {label = "Cобака", type = "scenario", data = {anim = "WORLD_DOG_SITTING_SHEPHERD"}},
			-- {label = "Cобака", type = "scenario", data = {anim = "WORLD_DOG_BARKING_SMALL"}},
			-- {label = "Cобака", type = "scenario", data = {anim = "WORLD_DOG_SITTING_SMALL"}},
			-- {label = "88", type = "scenario", data = {anim = "WORLD_FISH_IDLE"}},
			-- {label = "89", type = "scenario", data = {anim = "WORLD_GULL_FEEDING"}},
			-- {label = "90", type = "scenario", data = {anim = "WORLD_GULL_STANDING"}},
			-- {label = "91", type = "scenario", data = {anim = "WORLD_HEN_PECKING"}},
			-- {label = "92", type = "scenario", data = {anim = "WORLD_HEN_STANDING"}},
			-- -- {label = "93", type = "scenario", data = {anim = "WORLD_MOUNTAIN_LION_REST"}},
			-- -- {label = "94", type = "scenario", data = {anim = "WORLD_MOUNTAIN_LION_WANDER"}}
			-- {label = "96", type = "scenario", data = {anim = "WORLD_PIGEON_FEEDING"}},
			-- {label = "97", type = "scenario", data = {anim = "WORLD_PIGEON_STANDING"}},

			-- {label = "A99", type = "scenario", data = {anim = "WORLD_SHARK_SWIM"}},
		}
 },

--  {
-- 	name  = 'test',
-- 	label = 'Тест',
-- 	items = {
-- 		-- ------------------------ЖИВОТНЫЕ



-- 	  {label = "Разминка 1", type = "anim", data = {lib = "mini@triathlon", anim = "idle_a", flag = 9}},
-- 		{label = "Разминка 2", type = "anim", data = {lib = "mini@triathlon", anim = "idle_e", flag = 9}},

-- 		{label = "Лежать раскинувшись", type = "anim", data = {lib = "missarmenian2", anim = "corpse_search_exit_ped", flag = 9}},
-- 		{label = "Лежать на животе 2", type = "anim", data = {lib = "missarmenian2", anim = "drunk_loop", flag = 9}},

-- 		{label = "Отчаянеие", type = "anim", data = {lib = "misscarsteal2car_stolen", anim = "chad_car_stolen_reaction", flag = 9}},


-- 		{label = "Думать", type = "anim", data = {lib = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director"}},
-- 		{label = "Висеть на крюке", type = "anim", data = {lib = "mic_2_mcs_1-0", anim = "player_zero_dual-0", flag = 9}},
-- 		{label = "Опереться боком", type = "anim", data = {lib = "misscarsteal1car_1_ext_leadin", anim = "base_driver1", flag = 9}},
-- 		{label = "Опереться рукой", type = "anim", data = {lib = "misscarstealfinale", anim = "packer_idle_1_trevor", flag = 9}},
-- 	  {label = "Опереться локтем", type = "anim", data = {lib = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", flag = 9}},

-- 	}
-- },

}
