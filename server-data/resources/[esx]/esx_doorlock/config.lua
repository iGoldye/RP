Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	-- {
	-- 	textCoords = vector3(434.7, -982.0, 31.5),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = false,
	-- 	distance = 2.5,
	-- 	doors = {
	-- 		{
	-- 			objName = 'v_ilev_ph_door01',
	-- 			objYaw = -90.0,
	-- 			objCoords = vector3(434.7, -980.6, 30.8)
	-- 		},

	-- 		{
	-- 			objName = 'v_ilev_ph_door002',
	-- 			objYaw = -90.0,
	-- 			objCoords = vector3(434.7, -983.2, 30.8)
	-- 		}
	-- 	}
	-- },

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Armory
	-- {
	-- 	objName = 'v_ilev_arm_secdoor',
	-- 	objYaw = -90.0,
	-- 	objCoords  = vector3(452.6, -982.7, 30.6),
	-- 	textCoords = vector3(453.0, -982.6, 31.7),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true
	-- },

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = 0.0,
		objCoords  = vector3(462.77, -1000.99, 35.93),
		textCoords = vector3(462.77, -1000.99, 35.93),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},
-- Допросные
	{
		textCoords = vector3(460.9, -990.88, 30.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 270.0,
				objCoords = vector3(461.3, -992.1, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 90.0,
				objCoords = vector3(461.32, -989.77, 30.6)
			}
		}
	},

	-- STORAGE
	{
		objName = 'v_ilev_ph_gendoor006',
		objYaw = -90.0,
		objCoords  = vector3(471.41, -985.37, 24.91),
		textCoords = vector3(471.41, -985.37, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'prop_fnclink_02gate7',
		objYaw = 90.0,
		objCoords  = vector3(475.44, -986.87, 24.91),
		textCoords = vector3(475.51, -985.89, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
-- SERVER
{
	objName = 'v_ilev_ph_gendoor006',
	objYaw = 180.0,
	objCoords  = vector3(468.25, -977.83, 24.91),
	textCoords = vector3(468.25, -977.83, 24.91),
	authorizedJobs = { 'police' },
	locked = true
},
-- laba
{
	objName = 'v_ilev_ph_gendoor006',
	objYaw = 90.0,
	objCoords  = vector3(463.67, -981.24, 24.91),
	textCoords = vector3(463.67, -981.24, 24.91),
	authorizedJobs = { 'police' },
	locked = true
},
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 180.0,
		objCoords  = vector3(467.91, -1003.38, 24.91),
		textCoords = vector3(467.91, -1003.38, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 180.0,
		objCoords  = vector3(476.4, -1003.43, 24.91),
		textCoords = vector3(476.4, -1003.43, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- Cell 4
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(472.2, -996.35, 24.91),
		textCoords = vector3(472.2, -996.35, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
-- Cell 5
{
	objName = 'v_ilev_gtdoor',
	objYaw = 0.0,
	objCoords  = vector3(467.83, -996.64, 24.91),
	textCoords = vector3(467.83, -996.64, 24.91),
	authorizedJobs = { 'police' },
	locked = true
},
-- Cell 6
{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(476.4, -996.5, 24.91),
		textCoords = vector3(476.4, -996.5, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- Cell 7
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(480.75, -996.42, 24.91),
		textCoords = vector3(480.75, -996.42, 24.91),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(464.18, -1003.58, 25.0),
		textCoords = vector3(464.18, -1003.58, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},


	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objYaw = 0.0,
	-- 	objCoords  = vector3(481.9, -988.73, 25.0),
	-- 	textCoords = vector3(481.8, -988.13, 25.5),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true
	-- },
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objYaw = 0.0,
	-- 	objCoords  = vector3(482.1, -991.1, 25.0),
	-- 	textCoords = vector3(482.1, -991.8, 25.5),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true
	-- },
	-- Balk


	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objYaw = 0.0,
	-- 	objCoords  = vector3(481.9, -988.73, 25.0),
	-- 	textCoords = vector3(481.8, -988.13, 25.5),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true
	-- },
	-- {
	-- 	objName = 'v_ilev_ph_cellgate',
	-- 	objYaw = 0.0,
	-- 	objCoords  = vector3(482.1, -991.1, 25.0),
	-- 	textCoords = vector3(482.1, -991.8, 25.5),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true
	-- },
	-- Balk

	--
	-- Mission Row Back
	--

	-- Back (double doors)

	-- Back Gate
	-- {
	-- 	objName = 'hei_prop_station_gate',
	-- 	objYaw = 90.0,
	-- 	objCoords  = vector3(488.8, -1017.2, 27.1),
	-- 	textCoords = vector3(488.8, -1020.2, 30.0),
	-- 	authorizedJobs = { 'police' },
	-- 	locked = true,
	-- 	distance = 14,
	-- 	size = 2
	-- },

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police' },
		locked = false
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 120.0,
		objCoords  = vector3(1848.07, 3681.55, 34.29),
		textCoords = vector3(1848.35, 3681.08, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -60.0,
		objCoords  = vector3(1846.44, 3684.47, 34.29),
		textCoords = vector3(1846.1, 3685.02, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 120.0,
		objCoords  = vector3(1850.76, 3682.88, 34.29),
		textCoords = vector3(1850.76, 3682.88, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1856.66, 3689.87, 34.29),
		textCoords = vector3(1856.66, 3689.87, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1848.69, 3690.91, 34.29),
		textCoords = vector3(1848.69, 3690.91, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1845.67, 3688.84, 34.29),
		textCoords = vector3(1845.67, 3688.84, 34.29),
		authorizedJobs = { 'police' },
		locked = true
	},


	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},
	{
		textCoords = vector3(445.9, -999.1, 30.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_gtdoor',
				objYaw = -0.0,
				objCoords  = vector3(444.75, -999.36, 30.7),
			},

			{
				objName = 'v_ilev_gtdoor',
				objYaw = 180.0,
				objCoords  = vector3(446.85, -999.54, 30.7)
			}
		}
	},
-- BANKS

	--
	{
		id = 'pacific_vault',
		objName = 'hei_v_ilev_bk_gate2_pris',
		objYaw = 250.0,
		objCoords  = vector3(262.0, 221.91, 106.2),
		textCoords = vector3(261.9, 221.94, 106.2),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		id = 'blane',
		objName = 'v_ilev_cbankvaulgate01',
		objYaw = 50.0,
		objCoords  = vector3(-104.92, 6473.58, 31.63),
		textCoords = vector3(-105.25, 6472.83, 31.63),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1799.8, 2617.7, 44.6),
		textCoords = vector3(1796.99, 2617.51, 48.6),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_fnclink_03gate5',
		objYaw = 180.0,
		objCoords  = vector3(1797.5, 2591.72, 45.8),
		textCoords = vector3(1797.17, 2591.55, 45.8),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- PRISON
	{
		textCoords = vector3(1705.99, 2498.73, -78.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_gtdoor02',
				objYaw = 90.0,
				objCoords = vector3(1705.5, 2498.01, -78.6)
			},

			{
				objName = 'v_ilev_gtdoor02',
				objYaw = 270.0,
				objCoords = vector3(1705.59, -2499.49, -78.6)
			}
		}
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objYaw = 0.0,
		objCoords  = vector3(1722.39, 2500.33, -78.0),
		textCoords = vector3(1722.68, 2501.8, -77.5),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- PILLBOX HILL
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = 250.0,
		objCoords  = vector3(337.83, -583.62, 28.8),
		textCoords = vector3(337.83, -583.62, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = -20.0,
		objCoords  = vector3(333.53, -576.12, 28.8),
		textCoords = vector3(333.41, -577.17, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = 160.0,
		objCoords  = vector3(330.94, -576.16, 28.8),
		textCoords = vector3(330.94, -576.16, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		textCoords = vector3(334.21, -592.43, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 250.0,
				objCoords = vector3(334.32, -593.24, 28.79)
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(334.97, -591.56, 28.79)
			}
		}
	},
	{
		textCoords = vector3(341.88, -571.4, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 250.0,
				objCoords = vector3(341.72, -572.6, 28.79)
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(342.22, -570.52, 28.79)
			}
		}
	},
	{
		textCoords = vector3(319.89, -560.58, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = 207.0,
				objCoords = vector3(319.17, -561.2, 28.78)
			},

			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = 25.0,
				objCoords = vector3(320.9, -560.13, 28.78)
			}
		}
	},

	-- UNICORN
	{
		objName = 'prop_strip_door_01',
		objYaw = 30.0,
		objCoords  = vector3(128.93, -1298.93, 29.23),
		textCoords = vector3(128.54, -1298.19, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},
	{
		objName = 'prop_magenta_door',
		objYaw = 210.0,
		objCoords  = vector3(95.48, -1285.14, 29.50),
		textCoords = vector3(95.48, -1285.14, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door2',
		objYaw = 30.0,
		objCoords  = vector3(99.64, -1293.47, 29.50),
		textCoords = vector3(99.64, -1293.47, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},

	{
		objName = 'v_ilev_door_orangesolid',
		objYaw = -60.0,
		objCoords  = vector3(133.49, -1293.50, 29.50),
		textCoords = vector3(133.49, -1293.50, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
  },
		-- Tequila
	{
		objName = 'v_ilev_roc_door4',
		objYaw = -5.0,
		objCoords  = vector3(-564.49, 276.61, 83.11),
		textCoords = vector3(-564.49, 276.61, 83.11),
		authorizedJobs = { 'tequila' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door4',
		objYaw = 175.0,
		objCoords  = vector3(-561.94, 293.73, 87.6),
		textCoords = vector3(-561.94, 293.73, 87.6),
		authorizedJobs = { 'tequila' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door2',
		objYaw = -95.0,
		objCoords  = vector3(-560.19, 292.33, 82.18),
		textCoords = vector3(-560.19, 292.33, 82.18),
		authorizedJobs = { 'tequila' },
		locked = true
	},

	-- BAGAMA
	{
		textCoords = vector3(-1388.01, -587.23, 30.22),
		authorizedJobs = { 'bagama' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 32.0,
				objCoords = vector3(-1387.14, -586.67, 30.22)
			},

			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 214.0,
				objCoords = vector3(-1389.05, -587.76, 30.22)
			}
		}
	},


-- LS CUSTOMS
	{
		objName = 'prop_com_ls_door_01',
		objYaw = -110.0,
		ajar = 1206354175,

		objCoords  = vector3(-356.09, -134.77, 40.01),
		textCoords = vector3(-355.02698, -135.1586, 39),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 5,
		size = 1,
	},
-- Benny's
	{
		objName = 'lr_prop_supermod_door_01',
		objYaw = 0.0,
		ajar = -288764223,

		objCoords  = vector3(-205.7007, -1310.692, 30.2957),
		textCoords = vector3(-205.68283081055,-1310.6826171875,32.297708511353),
		authorizedJobs = { 'mechanic-bennys' },
		locked = true,
		distance = 5,
		size = 1,
	},
--

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1799.8, 2617.7, 44.6),
		textCoords = vector3(1796.99, 2617.51, 48.6),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_fnclink_03gate5',
		objYaw = 180.0,
		objCoords  = vector3(1797.5, 2591.72, 45.8),
		textCoords = vector3(1797.17, 2591.55, 45.8),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- PRISON
	{
		textCoords = vector3(1705.99, 2498.73, -78.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_gtdoor02',
				objYaw = 90.0,
				objCoords = vector3(1705.5, 2498.01, -78.6)
			},

			{
				objName = 'v_ilev_gtdoor02',
				objYaw = 270.0,
				objCoords = vector3(1705.59, -2499.49, -78.6)
			}
		}
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objYaw = 0.0,
		objCoords  = vector3(1722.39, 2500.33, -78.0),
		textCoords = vector3(1722.68, 2501.8, -77.5),
		authorizedJobs = { 'police' },
		locked = true
	},
	-- PILLBOX HILL
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = 250.0,
		objCoords  = vector3(337.83, -583.62, 28.8),
		textCoords = vector3(337.83, -583.62, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = -20.0,
		objCoords  = vector3(333.53, -576.12, 28.8),
		textCoords = vector3(333.41, -577.17, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = 160.0,
		objCoords  = vector3(330.94, -576.16, 28.8),
		textCoords = vector3(330.94, -576.16, 29.5),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
	{
		textCoords = vector3(334.21, -592.43, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 250.0,
				objCoords = vector3(334.32, -593.24, 28.79)
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(334.97, -591.56, 28.79)
			}
		}
	},
	{
		textCoords = vector3(341.88, -571.4, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 250.0,
				objCoords = vector3(341.72, -572.6, 28.79)
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(342.22, -570.52, 28.79)
			}
		}
	},
	{
		textCoords = vector3(319.89, -560.58, 28.79),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = 207.0,
				objCoords = vector3(319.17, -561.2, 28.78)
			},

			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = 25.0,
				objCoords = vector3(320.9, -560.13, 28.78)
			}
		}
	},

	-- UNICORN
	{
		objName = 'prop_strip_door_01',
		objYaw = 30.0,
		objCoords  = vector3(128.93, -1298.93, 29.23),
		textCoords = vector3(128.54, -1298.19, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},
	{
		objName = 'prop_magenta_door',
		objYaw = 210.0,
		objCoords  = vector3(95.48, -1285.14, 29.50),
		textCoords = vector3(95.48, -1285.14, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door2',
		objYaw = 30.0,
		objCoords  = vector3(99.64, -1293.47, 29.50),
		textCoords = vector3(99.64, -1293.47, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
	},

	{
		objName = 'v_ilev_door_orangesolid',
		objYaw = -60.0,
		objCoords  = vector3(133.49, -1293.50, 29.50),
		textCoords = vector3(133.49, -1293.50, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true
  },
		-- Tequila
	{
		objName = 'v_ilev_roc_door4',
		objYaw = -5.0,
		objCoords  = vector3(-564.49, 276.61, 83.11),
		textCoords = vector3(-564.49, 276.61, 83.11),
		authorizedJobs = { 'tequila' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door4',
		objYaw = 175.0,
		objCoords  = vector3(-561.94, 293.73, 87.6),
		textCoords = vector3(-561.94, 293.73, 87.6),
		authorizedJobs = { 'tequila' },
		locked = true
	},
	{
		objName = 'v_ilev_roc_door2',
		objYaw = -95.0,
		objCoords  = vector3(-560.19, 292.33, 82.18),
		textCoords = vector3(-560.19, 292.33, 82.18),
		authorizedJobs = { 'tequila' },
		locked = true
	},

	-- BAGAMA
	{
		textCoords = vector3(-1388.01, -587.23, 30.22),
		authorizedJobs = { 'bagama' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 32.0,
				objCoords = vector3(-1387.14, -586.67, 30.22)
			},

			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 214.0,
				objCoords = vector3(-1389.05, -587.76, 30.22)
			}
		}
	},


-- LS CUSTOMS
	{
		objName = 'prop_com_ls_door_01',
		objYaw = -110.0,
		ajar = 1206354175,

		objCoords  = vector3(-356.09, -134.77, 40.01),
		textCoords = vector3(-355.02698, -135.1586, 39),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 5,
		size = 1,
	},
-- Benny's
	{
		objName = 'lr_prop_supermod_door_01',
		objYaw = 0.0,
		ajar = -288764223,

		objCoords  = vector3(-205.7007, -1310.692, 30.2957),
		textCoords = vector3(-205.68283081055,-1310.6826171875,32.297708511353),
		authorizedJobs = { 'mechanic-bennys' },
		locked = true,
		distance = 5,
		size = 1,
	},
--

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}
