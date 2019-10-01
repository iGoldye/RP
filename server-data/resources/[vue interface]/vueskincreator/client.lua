------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local isSkinCreatorOpened = false			-- Change this value to show/hide UI
local cam = -1						-- Camera control
local heading = 332.219879				-- Heading coord
local zoom = "face"					-- Define which tab is shown first (Default: Head)

local Skin = {}

function skinSetTorso(torso_1, torso_2)
	Skin["torso_1"] = torso_1
	Skin["torso_2"] = torso_2
end

function skinSetArms(arms_1, arms_2)
	Skin["arms_1"] = arms_1
	Skin["arms_2"] = arms_2
end

function skinSetChain(chain_1, chain_2)
	Skin["chain_1"] = chain_1
	Skin["chain_2"] = chain_2
end

function skinSetTshirt(tshirt_1, tshirt_2)
	Skin["tshirt_1"] = tshirt_1
	Skin["tshirt_2"] = tshirt_2
end

function skinSetPants(pants_1, pants_2)
	Skin["pants_1"] = pants_1
	Skin["pants_2"] = pants_2
end

function skinSetShoes(shoes_1, shoes_2)
	Skin["shoes_1"] = shoes_1
	Skin["shoes_2"] = shoes_2
end

function skinSetHelmet(helmet_1, helmet_2)
	Skin["helmet_1"] = helmet_1
	Skin["helmet_2"] = helmet_2
end

function skinSetGlasses(glasses_1, glasses_2)
	Skin["glasses_1"] = glasses_1
	Skin["glasses_2"] = glasses_2
end

function skinSetEars(ears_1, ears_2)
	Skin["ears_1"] = ears_1
	Skin["ears_2"] = ears_2
end

function skinSetWatches(watches_1, watches_2)
	Skin["watches_1"] = watches_1
	Skin["watches_2"] = watches_2
end

------------------------------------------------------------------
--                          NUI
------------------------------------------------------------------

RegisterNUICallback('updateSkin', function(data)
	v = data.value
	-- Face
	dad = tonumber(data.dad)
	mum = tonumber(data.mum)
	dadmumpercent = tonumber(data.dadmumpercent)
	skincolor = tonumber(data.skin)
	eyecolor = tonumber(data.eyecolor)
	acne = tonumber(data.acne)
	skinproblem = tonumber(data.skinproblem)
	freckle = tonumber(data.freckle)
	wrinkle = tonumber(data.wrinkle)
	wrinkleopacity = tonumber(data.wrinkleopacity)
	hair = tonumber(data.hair)
	haircolor = tonumber(data.haircolor)
	eyebrow = tonumber(data.eyebrow)
	eyebrowopacity = tonumber(data.eyebrowopacity)
	beard = tonumber(data.beard)
	beardopacity = tonumber(data.beardopacity)
	beardcolor = tonumber(data.beardcolor)
	-- Clothes
	hats = tonumber(data.hats)
	glasses = tonumber(data.glasses)
	ears = tonumber(data.ears)
	tops = tonumber(data.tops)
	pants = tonumber(data.pants)
	shoes = tonumber(data.shoes)
	watches = tonumber(data.watches)
	-- face extended
	nose_width = tonumber(data.nose_width)
	nose_peak_height = tonumber(data.nose_peak_height)
	nose_peak_length = tonumber(data.nose_peak_length)
	nose_bone_height = tonumber(data.nose_bone_height)
	nose_peak_lowering = tonumber(data.nose_peak_lowering)
	nose_peak_twist = tonumber(data.nose_peak_twist)
	eyebrow_height = tonumber(data.eyebrow_height)
	eyebrow_forward = tonumber(data.eyebrow_forward)
	cheeks_bone_height = tonumber(data.cheeks_bone_height)
	cheeks_bone_width = tonumber(data.cheeks_bone_width)
	cheeks_width = tonumber(data.cheeks_width)
	eyes_opening = tonumber(data.eyes_opening)
	lips_thickness = tonumber(data.lips_thickness)
	jaw_bone_width = tonumber(data.jaw_bone_width)
	jaw_bone_back_length = tonumber(data.jaw_bone_back_length)
	chimp_bone_lowering = tonumber(data.chimp_bone_lowering)
	chimp_bone_length = tonumber(data.chimp_bone_length)
	chimp_bone_width = tonumber(data.chimp_bone_width)
	chimp_hole = tonumber(data.chimp_hole)
	neck_thickness = tonumber(data.neck_thickness)

	if(v == true) then
		local ped = GetPlayerPed(-1)
		local torso = GetPedDrawableVariation(ped, 3)
		local torsotext = GetPedTextureVariation(ped, 3)
		local leg = GetPedDrawableVariation(ped, 4)
		local legtext = GetPedTextureVariation(ped, 4)
		local shoes = GetPedDrawableVariation(ped, 6)
		local shoestext = GetPedTextureVariation(ped, 6)
		local accessory = GetPedDrawableVariation(ped, 7)
		local accessorytext = GetPedTextureVariation(ped, 7)
		local undershirt = GetPedDrawableVariation(ped, 8)
		local undershirttext = GetPedTextureVariation(ped, 8)
		local torso2 = GetPedDrawableVariation(ped, 11)
		local torso2text = GetPedTextureVariation(ped, 11)
		local prop_hat = GetPedPropIndex(ped, 0)
		local prop_hat_text = GetPedPropTextureIndex(ped, 0)
		local prop_glasses = GetPedPropIndex(ped, 1)
		local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
		local prop_earrings = GetPedPropIndex(ped, 2)
		local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
		local prop_watches = GetPedPropIndex(ped, 6)
		local prop_watches_text = GetPedPropTextureIndex(ped, 6)

		TriggerServerEvent("updateSkin", dad, mum, dadmumpercent, skincolor, eyecolor, acne, skinproblem, freckle, wrinkle, wrinkleopacity, eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, hair, haircolor, torso, torsotext, leg, legtext, shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat, prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches, prop_watches_text, nose_width, nose_peak_height, nose_peak_length, nose_bone_height, nose_peak_lowering, nose_peak_twist, eyebrow_height, eyebrow_forward, cheeks_bone_height, cheeks_bone_width, cheeks_width, eyes_opening, lips_thickness, jaw_bone_width, jaw_bone_back_length, chimp_bone_lowering, chimp_bone_length, chimp_bone_width, chimp_hole, neck_thickness)

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)
		end)
	else
--		SetPedDefaultComponentVariation(GetPlayerPed(-1))

		-- Face
		Skin['skin'] = skincolor
		Skin['face'] = dad
		Skin['face_2'] =  mum
		Skin['face_blend'] = dadmumpercent
		Skin['eye_color'] = eyecolor
		Skin['acne_1'] = acne
		Skin['acne_2'] = acne
--[[
		if acne == 0 then
			SetPedHeadOverlay		(GetPlayerPed(-1), 0, acne, 0.0)
		else
			SetPedHeadOverlay		(GetPlayerPed(-1), 0, acne, 1.0)
		end
]]--

--		SetPedHeadOverlay			(GetPlayerPed(-1), 6, skinproblem, 1.0)
		Skin['complexion_1'] = skinproblem
		Skin['complexion_2'] = 10

		if freckle == 0 then
--			SetPedHeadOverlay		(GetPlayerPed(-1), 9, freckle, 0.0)
			Skin['moles_2'] = 0
		else
--			SetPedHeadOverlay		(GetPlayerPed(-1), 9, freckle, 1.0)
			Skin['moles_1'] = freckle
			Skin['moles_2'] = 10
		end
--		SetPedHeadOverlay       	(GetPlayerPed(-1), 3, wrinkle, wrinkleopacity * 0.1)
		Skin['age_1'] = wrinkle
		Skin['age_2'] = wrinkleopacity
--		SetPedComponentVariation	(GetPlayerPed(-1), 2, hair, 0, 2)
		Skin['hair_1'] = hair
		Skin['hair_2'] = 0
--		SetPedHairColor				(GetPlayerPed(-1), haircolor, haircolor)
		Skin['hair_color_1'] = haircolor
		Skin['hair_color_2'] = haircolor
		Skin['eyebrows_1'] = eyebrow
		Skin['eyebrows_2'] = eyebrowopacity
--		SetPedHeadOverlay       	(GetPlayerPed(-1), 2, eyebrow, eyebrowopacity * 0.1)
		Skin['beard_1'] = beard
		Skin['beard_2'] = beardopacity
--		SetPedHeadOverlay       	(GetPlayerPed(-1), 1, beard, beardopacity * 0.1)
		Skin['beard_3'] = beardcolor
		Skin['beard_4'] = beardcolor
--		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 1, 1, beardcolor, beardcolor)
		Skin['eyebrows_3'] = beardcolor
		Skin['eyebrows_4'] = beardcolor
--		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 2, 1, beardcolor, beardcolor)
		Skin['nose_width'] = nose_width
		Skin['nose_peak_height'] = nose_peak_height
		Skin['nose_peak_length'] = nose_peak_length
		Skin['nose_bone_height'] = nose_bone_height
		Skin['nose_peak_lowering'] = nose_peak_lowering
		Skin['nose_peak_twist'] = nose_peak_twist
		Skin['eyebrow_height'] = eyebrow_height
		Skin['eyebrow_forward'] = eyebrow_forward
		Skin['cheeks_bone_height'] = cheeks_bone_height
		Skin['cheeks_bone_width'] = cheeks_bone_width
		Skin['cheeks_width'] = cheeks_width
		Skin['eyes_opening'] = eyes_opening
		Skin['lips_thickness'] = lips_thickness
		Skin['jaw_bone_width'] = jaw_bone_width
		Skin['jaw_bone_back_length'] = jaw_bone_back_length
		Skin['chimp_bone_lowering'] = chimp_bone_lowering
		Skin['chimp_bone_length'] = chimp_bone_length
		Skin['chimp_bone_width'] = chimp_bone_width
		Skin['chimp_hole'] = chimp_hole
		Skin['neck_thickness'] = neck_thickness

		-- Clothes variations
		if hats == 0 then	skinSetHelmet(-1, 0)
		elseif hats == 1 then	skinSetHelmet(2, 0)
		elseif hats == 2 then	skinSetHelmet(2, 6)
		elseif hats == 3 then	skinSetHelmet(3, 2)
		elseif hats == 4 then	skinSetHelmet(4, 0)
		elseif hats == 5 then	skinSetHelmet(4, 1)
		elseif hats == 6 then	skinSetHelmet(5, 0)
		elseif hats == 7 then	skinSetHelmet(7, 0)
		elseif hats == 8 then	skinSetHelmet(7, 1)
		elseif hats == 9 then	skinSetHelmet(7, 2)
		elseif hats == 10 then	skinSetHelmet(7, 5)
		elseif hats == 11 then	skinSetHelmet(10, 5)
		elseif hats == 12 then	skinSetHelmet(9, 5)
		elseif hats == 13 then	skinSetHelmet(10, 7)
		elseif hats == 14 then	skinSetHelmet(9, 7)
		elseif hats == 15 then	skinSetHelmet(12, 0)
		elseif hats == 16 then	skinSetHelmet(12, 1)
		elseif hats == 17 then	skinSetHelmet(13, 2)
		elseif hats == 18 then	skinSetHelmet(14, 0)
		elseif hats == 19 then	skinSetHelmet(14, 1)
		elseif hats == 20 then	skinSetHelmet(15, 1)
		elseif hats == 21 then	skinSetHelmet(15, 2)
		elseif hats == 22 then	skinSetHelmet(20, 5)
		elseif hats == 23 then	skinSetHelmet(21, 0)
		elseif hats == 24 then	skinSetHelmet(25, 1)
		elseif hats == 25 then	skinSetHelmet(26, 0)
		elseif hats == 26 then	skinSetHelmet(27, 0)
		elseif hats == 27 then	skinSetHelmet(34, 0)
		elseif hats == 28 then	skinSetHelmet(55, 0)
		elseif hats == 29 then	skinSetHelmet(55, 1)
		elseif hats == 30 then	skinSetHelmet(55, 2)
		elseif hats == 31 then	skinSetHelmet(76, 19)
		elseif hats == 32 then	skinSetHelmet(96, 2)
		end

		if glasses == 0 then		skinSetGlasses(-1, 0)
		elseif glasses == 1 then	skinSetGlasses(3, 0)
		elseif glasses == 2 then	skinSetGlasses(3, 9)
		elseif glasses == 3 then	skinSetGlasses(4, 4)
		elseif glasses == 4 then	skinSetGlasses(4, 9)
		elseif glasses == 5 then	skinSetGlasses(5, 0)
		elseif glasses == 6 then	skinSetGlasses(5, 8)
		elseif glasses == 7 then	skinSetGlasses(7, 0)
		elseif glasses == 8 then	skinSetGlasses(8, 1)
		elseif glasses == 9 then	skinSetGlasses(9, 0)
		elseif glasses == 10 then	skinSetGlasses(15, 6)
		elseif glasses == 11 then	skinSetGlasses(17, 9)
		elseif glasses == 12 then	skinSetGlasses(25, 0)
		end

		if ears == 0 then	skinSetEars(-1, 0)
		elseif ears == 1 then	skinSetEars(3, 0)
		elseif ears == 2 then	skinSetEars(4, 0)
		elseif ears == 3 then	skinSetEars(5, 0)
		elseif ears == 4 then	skinSetEars(9, 1)
		elseif ears == 5 then	skinSetEars(10, 1)
		elseif ears == 6 then	skinSetEars(11, 1)
		elseif ears == 7 then	skinSetEars(18, 3)
		elseif ears == 8 then	skinSetEars(19, 3)
		elseif ears == 9 then	skinSetEars(20, 3)
		elseif ears == 10 then	skinSetEars(27, 0)
		elseif ears == 11 then	skinSetEars(28, 0)
		elseif ears == 12 then	skinSetEars(29, 0)
		elseif ears == 13 then	skinSetEars(30, 0)
		elseif ears == 14 then	skinSetEars(31, 0)
		elseif ears == 15 then	skinSetEars(32, 0)
		end

		-- Keep these 4 variations together.
		-- It avoids empty arms or noisy clothes superposition
		if tops == 0 then
			skinSetArms(15, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(15, 0)
		elseif tops == 1 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(0, 0)
			skinSetTorso(0, 1)
		elseif tops == 2 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(0, 0)
			skinSetTorso(0, 7)
		elseif tops == 3 then
			skinSetArms(2, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(2, 9)
		elseif tops == 4 then
			skinSetArms(6, 0)
			skinSetChain(0, 0)
			skinSetTshirt(5, 0)
			skinSetTorso(3, 11)
		elseif tops == 5 then
			skinSetArms(6, 0)
			skinSetChain(0, 0)
			skinSetTshirt(5, 0)
			skinSetTorso(3, 15)
		elseif tops == 6 then
			skinSetArms(6, 0)
			skinSetChain(0, 0)
			skinSetTshirt(23, 0)
			skinSetTorso(4, 0)
		elseif tops == 7 then
			skinSetArms(6, 0)
			skinSetChain(0, 0)
			skinSetTshirt(4, 0)
			skinSetTorso(4, 0)
		elseif tops == 8 then
			skinSetArms(6, 0)
			skinSetChain(0, 0)
			skinSetTshirt(26, 0)
			skinSetTorso(4, 0)
		elseif tops == 9 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(5, 0)
			skinSetTorso(5, 0)
		elseif tops == 10 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(2, 4)
			skinSetTorso(6, 11)
		elseif tops == 11 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(2, 4)
			skinSetTorso(6, 0)
		elseif tops == 12 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(2, 4)
			skinSetTorso(6, 3)
		elseif tops == 13 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(23, 0)
			skinSetTorso(7, 4)
		elseif tops == 14 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(23, 0)
			skinSetTorso(7, 10)
		elseif tops == 15 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(23, 0)
			skinSetTorso(7, 12)
		elseif tops == 16 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(23, 0)
			skinSetTorso(7, 13)
		elseif tops == 17 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(9, 0)
			skinSetTorso(9, 0)
		elseif tops == 18 then
			skinSetArms(4, 0)
			skinSetChain(0, 0)
			skinSetTshirt(10, 0)
			skinSetTorso(10, 0)
		elseif tops == 19 then
			skinSetArms(4, 0)
			skinSetChain(12, 2)
			skinSetTshirt(10, 0)
			skinSetTorso(10, 0)
		elseif tops == 20 then
			skinSetArms(4, 0)
			skinSetChain(18, 0)
			skinSetTshirt(10, 0)
			skinSetTorso(10, 0)
		elseif tops == 21 then
			skinSetArms(4, 0)
			skinSetChain(11, 2)
			skinSetTshirt(10, 0)
			skinSetTorso(10, 0)
		elseif tops == 22 then
			skinSetArms(12, 0)
			skinSetChain(0, 0)
			skinSetTshirt(12, 10)
			skinSetTorso(12, 10)
		elseif tops == 23 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(13, 0)
			skinSetTorso(13, 0)
		elseif tops == 24 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(14, 0)
		elseif tops == 25 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(14, 1)
		elseif tops == 26 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(16, 0)
		elseif tops == 27 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(16, 1)
		elseif tops == 28 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(16, 2)
		elseif tops == 29 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(17, 0)
			skinSetTorso(17, 0)
		elseif tops == 30 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(17, 1)
			skinSetTorso(17, 1)
		elseif tops == 31 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(17, 4)
			skinSetTorso(17, 4)
		elseif tops == 32 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(27, 0)
			skinSetTorso(26, 0)
		elseif tops == 33 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(27, 5)
			skinSetTorso(26, 5)
		elseif tops == 34 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(27, 6)
			skinSetTorso(26, 6)
		elseif tops == 35 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(63, 0)
			skinSetTorso(31, 0)
		elseif tops == 36 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(57, 0)
			skinSetTorso(36, 4)
		elseif tops == 37 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(57, 0)
			skinSetTorso(36, 5)
		elseif tops == 38 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(24, 0)
			skinSetTorso(37, 0)
		elseif tops == 39 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(24, 0)
			skinSetTorso(37, 1)
		elseif tops == 40 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(24, 0)
			skinSetTorso(37, 2)
		elseif tops == 41 then
			skinSetArms(8, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(38, 0)
		elseif tops == 42 then
			skinSetArms(8, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(38, 3)
		elseif tops == 43 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(39, 0)
		elseif tops == 44 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(39, 1)
		elseif tops == 45 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(41, 0)
		elseif tops == 46 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(42, 0)
		elseif tops == 47 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(50, 0)
		elseif tops == 48 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(50, 3)
		elseif tops == 49 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(50, 4)
		elseif tops == 50 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(57, 0)
		elseif tops == 51 then
			skinSetArms(1, 0)
			skinSetChain(50, 1)
			skinSetTshirt(23, 0)
			skinSetTorso(70, 0)
		elseif tops == 52 then
			skinSetArms(1, 0)
			skinSetChain(50, 1)
			skinSetTshirt(23, 0)
			skinSetTorso(70, 1)
		elseif tops == 53 then
			skinSetArms(1, 0)
			skinSetChain(50, 1)
			skinSetTshirt(23, 0)
			skinSetTorso(70, 7)
		elseif tops == 54 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(3, 1)
			skinSetTorso(72, 1)
		elseif tops == 55 then
			skinSetArms(6, 0)
			skinSetChain(87, 0)
			skinSetTshirt(5, 0)
			skinSetTorso(74, 0)
		elseif tops == 56 then
			skinSetArms(1, 0)
			skinSetChain(12, 2)
			skinSetTshirt(28, 0)
			skinSetTorso(77, 0)
		elseif tops == 57 then
			skinSetArms(15, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(79, 0)
		elseif tops == 58 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(80, 0)
		elseif tops == 59 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(80, 1)
		elseif tops == 60 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(82, 5)
		elseif tops == 61 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(82, 8)
		elseif tops == 62 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(82, 9)
		elseif tops == 63 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(86, 0)
		elseif tops == 64 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(86, 2)
		elseif tops == 65 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(86, 4)
		elseif tops == 66 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 11)
		elseif tops == 67 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 0)
		elseif tops == 68 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 1)
		elseif tops == 69 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 2)
		elseif tops == 70 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 4)
		elseif tops == 71 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(87, 8)
		elseif tops == 72 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(89, 0)
		elseif tops == 73 then
			skinSetArms(11, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(95, 0)
		elseif tops == 74 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(31, 0)
			skinSetTorso(99, 1)
		elseif tops == 75 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(31, 13)
			skinSetTorso(99, 3)
		elseif tops == 76 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(31, 13)
			skinSetTorso(101, 0)
		elseif tops == 77 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(105, 0)
		elseif tops == 78 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(10, 0)
			skinSetTorso(106, 0)
		elseif tops == 79 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(73, 2)
			skinSetTorso(109, 0)
		elseif tops == 80 then
			skinSetArms(4, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(111, 0)
		elseif tops == 81 then
			skinSetArms(4, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(111, 3)
		elseif tops == 82 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(113, 0)
		elseif tops == 83 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(126, 5)
		elseif tops == 84 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(126, 9)
		elseif tops == 85 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(126, 10)
		elseif tops == 86 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(126, 14)
		elseif tops == 87 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(131, 0)
		elseif tops == 88 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(134, 0)
		elseif tops == 89 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(134, 1)
		elseif tops == 90 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 0)
		elseif tops == 91 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 2)
		elseif tops == 92 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 4)
		elseif tops == 93 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 5)
		elseif tops == 94 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 6)
		elseif tops == 95 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 8)
		elseif tops == 96 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(143, 9)
		elseif tops == 97 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(146, 0)
		elseif tops == 98 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(16, 2)
			skinSetTorso(166, 0)
		elseif tops == 99 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(167, 0)
		elseif tops == 100 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(167, 4)
		elseif tops == 101 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(167, 6)
		elseif tops == 102 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(167, 12)
		elseif tops == 103 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(169, 0)
		elseif tops == 104 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(172, 0)
		elseif tops == 105 then
			skinSetArms(2, 0)
			skinSetChain(0, 0)
			skinSetTshirt(38, 1)
			skinSetTorso(173, 0)
		elseif tops == 106 then
			skinSetArms(2, 0)
			skinSetChain(0, 0)
			skinSetTshirt(41, 2)
			skinSetTorso(185, 0)
		elseif tops == 107 then
			skinSetArms(2, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(202, 0)
		elseif tops == 108 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(203, 10)
		elseif tops == 109 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(203, 16)
		elseif tops == 110 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(203, 25)
		elseif tops == 111 then
			skinSetArms(2, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(205, 0)
		elseif tops == 112 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(226, 0)
		elseif tops == 113 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(257, 0)
		elseif tops == 114 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(257, 9)
		elseif tops == 115 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(257, 17)
		elseif tops == 116 then
			skinSetArms(1, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(259, 9)
		elseif tops == 117 then
			skinSetArms(5, 0)
			skinSetChain(0, 0)
			skinSetTshirt(5, 0)
			skinSetTorso(269, 2)
		elseif tops == 118 then
			skinSetArms(0, 0)
			skinSetChain(0, 0)
			skinSetTshirt(15, 0)
			skinSetTorso(282, 6)
		end

		if pants == 0 then	skinSetPants(61, 4)
		elseif pants == 1 then	skinSetPants(0, 0)
		elseif pants == 2 then	skinSetPants(0, 2)
		elseif pants == 3 then	skinSetPants(1, 12)
		elseif pants == 4 then	skinSetPants(2, 11)
		elseif pants == 5 then	skinSetPants(3, 0)
		elseif pants == 6 then	skinSetPants(4, 0)
		elseif pants == 7 then	skinSetPants(4, 1)
		elseif pants == 8 then	skinSetPants(4, 4)
		elseif pants == 9 then	skinSetPants(5, 0)
		elseif pants == 10 then	skinSetPants(5, 2)
		elseif pants == 11 then	skinSetPants(7, 0)
		elseif pants == 12 then	skinSetPants(7, 1)
		elseif pants == 13 then	skinSetPants(9, 0)
		elseif pants == 14 then	skinSetPants(9, 1)
		elseif pants == 15 then	skinSetPants(10, 0)
		elseif pants == 16 then	skinSetPants(10, 2)
		elseif pants == 17 then	skinSetPants(12, 0)
		elseif pants == 18 then	skinSetPants(12, 5)
		elseif pants == 19 then	skinSetPants(12, 7)
		elseif pants == 20 then	skinSetPants(14, 0)
		elseif pants == 21 then	skinSetPants(14, 1)
		elseif pants == 22 then	skinSetPants(14, 3)
		elseif pants == 23 then	skinSetPants(15, 0)
		elseif pants == 24 then	skinSetPants(20, 0)
		elseif pants == 25 then	skinSetPants(24, 0)
		elseif pants == 26 then	skinSetPants(24, 1)
		elseif pants == 27 then	skinSetPants(24, 5)
		elseif pants == 28 then	skinSetPants(26, 0)
		elseif pants == 29 then	skinSetPants(26, 4)
		elseif pants == 30 then	skinSetPants(26, 5)
		elseif pants == 31 then	skinSetPants(26, 6)
		elseif pants == 32 then	skinSetPants(28, 0)
		elseif pants == 33 then	skinSetPants(28, 3)
		elseif pants == 34 then	skinSetPants(28, 8)
		elseif pants == 35 then	skinSetPants(28, 14)
		elseif pants == 36 then	skinSetPants(42, 0)
		elseif pants == 37 then	skinSetPants(42, 1)
		elseif pants == 38 then	skinSetPants(48, 0)
		elseif pants == 39 then	skinSetPants(48, 1)
		elseif pants == 40 then	skinSetPants(49, 0)
		elseif pants == 41 then	skinSetPants(49, 1)
		elseif pants == 42 then	skinSetPants(54, 1)
		elseif pants == 43 then	skinSetPants(55, 0)
		elseif pants == 44 then	skinSetPants(60, 2)
		elseif pants == 45 then	skinSetPants(60, 9)
		elseif pants == 46 then	skinSetPants(71, 0)
		elseif pants == 47 then	skinSetPants(75, 2)
		elseif pants == 48 then	skinSetPants(76, 2)
		elseif pants == 49 then	skinSetPants(78, 0)
		elseif pants == 50 then	skinSetPants(78, 2)
		elseif pants == 51 then	skinSetPants(78, 4)
		elseif pants == 52 then	skinSetPants(82, 0)
		elseif pants == 53 then	skinSetPants(82, 2)
		elseif pants == 54 then	skinSetPants(82, 3)
		elseif pants == 55 then	skinSetPants(86, 9)
		elseif pants == 56 then	skinSetPants(88, 9)
		elseif pants == 57 then	skinSetPants(100, 9)
		end

		if shoes == 0 then 	skinSetShoes(34, 0)
		elseif shoes == 1 then	skinSetShoes(0, 10)
		elseif shoes == 2 then	skinSetShoes(1, 0)
		elseif shoes == 3 then	skinSetShoes(1, 1)
		elseif shoes == 4 then	skinSetShoes(1, 3)
		elseif shoes == 5 then	skinSetShoes(3, 0)
		elseif shoes == 6 then	skinSetShoes(3, 6)
		elseif shoes == 7 then	skinSetShoes(3, 14)
		elseif shoes == 8 then	skinSetShoes(48, 0)
		elseif shoes == 9 then	skinSetShoes(48, 1)
		elseif shoes == 10 then skinSetShoes(49, 0)
		elseif shoes == 11 then skinSetShoes(49, 1)
		elseif shoes == 12 then skinSetShoes(5, 0)
		elseif shoes == 13 then skinSetShoes(6, 0)
		elseif shoes == 14 then skinSetShoes(7, 0)
		elseif shoes == 15 then skinSetShoes(7, 9)
		elseif shoes == 16 then skinSetShoes(7, 13)
		elseif shoes == 17 then skinSetShoes(9, 3)
		elseif shoes == 18 then skinSetShoes(9, 6)
		elseif shoes == 19 then skinSetShoes(9, 7)
		elseif shoes == 20 then skinSetShoes(10, 0)
		elseif shoes == 21 then skinSetShoes(12, 0)
		elseif shoes == 22 then skinSetShoes(12, 2)
		elseif shoes == 23 then skinSetShoes(12, 13)
		elseif shoes == 24 then skinSetShoes(15, 0)
		elseif shoes == 25 then skinSetShoes(15, 1)
		elseif shoes == 26 then skinSetShoes(16, 0)
		elseif shoes == 27 then skinSetShoes(20, 0)
		elseif shoes == 28 then skinSetShoes(24, 0)
		elseif shoes == 29 then skinSetShoes(27, 0)
		elseif shoes == 30 then skinSetShoes(28, 0)
		elseif shoes == 31 then skinSetShoes(28, 1)
		elseif shoes == 32 then skinSetShoes(28, 3)
		elseif shoes == 33 then skinSetShoes(28, 2)
		elseif shoes == 34 then skinSetShoes(31, 2)
		elseif shoes == 35 then skinSetShoes(31, 4)
		elseif shoes == 36 then skinSetShoes(36, 0)
		elseif shoes == 37 then skinSetShoes(36, 3)
		elseif shoes == 38 then skinSetShoes(42, 0)
		elseif shoes == 39 then skinSetShoes(42, 1)
		elseif shoes == 40 then skinSetShoes(42, 7)
		elseif shoes == 41 then skinSetShoes(57, 0)
		elseif shoes == 42 then skinSetShoes(57, 3)
		elseif shoes == 43 then skinSetShoes(57, 8)
		elseif shoes == 44 then skinSetShoes(57, 9)
		elseif shoes == 45 then skinSetShoes(57, 10)
		elseif shoes == 46 then skinSetShoes(57, 11)
		elseif shoes == 47 then skinSetShoes(75, 4)
		elseif shoes == 48 then skinSetShoes(75, 7)
		elseif shoes == 49 then skinSetShoes(75, 8)
		elseif shoes == 50 then skinSetShoes(77, 0)
		end

		if watches == 0 then		skinSetWatches(-1, 0)
		elseif watches == 1 then	skinSetWatches(0, 0)
		elseif watches == 2 then	skinSetWatches(1, 0)
		elseif watches == 3 then	skinSetWatches(3, 0)
		elseif watches == 4 then	skinSetWatches(3, 2)
		elseif watches == 5 then	skinSetWatches(4, 0)
		elseif watches == 6 then	skinSetWatches(8, 0)
		elseif watches == 7 then	skinSetWatches(10, 0)
		end

		-- Unused yet
		-- These presets will be editable in V2 release
		Skin['makeup_1'] = 0
		Skin['makeup_2'] = 0
		Skin['makeup_3'] = 1
		Skin['makeup_4'] = 0
		Skin['lipstick_1'] = 0
		Skin['lipstick_2'] = 0
		Skin['lipstick_3'] = 1
		Skin['lipstick_4'] = 0
		Skin['mask_1'] = 0
		Skin['mask_2'] = 0

--		SetPedHeadOverlay       	(GetPlayerPed(-1), 4, 0, 0.0)   	-- Lipstick
--		SetPedHeadOverlay       	(GetPlayerPed(-1), 8, 0, 0.0) 		-- Makeup
--		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 4, 1, 0, 0)      -- Makeup Color
--		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 8, 1, 0, 0)      -- Lipstick Color
--		SetPedComponentVariation	(GetPlayerPed(-1), 1,  0,0, 2)    	-- Mask

		TriggerEvent('skinchanger:loadSkin', Skin)
	end
end)

-- Character rotation
RegisterNUICallback('rotateleftheading', function(data)
	local currentHeading = GetEntityHeading(GetPlayerPed(-1))
	heading = currentHeading+tonumber(data.value)
end)

RegisterNUICallback('rotaterightheading', function(data)
	local currentHeading = GetEntityHeading(GetPlayerPed(-1))
	heading = currentHeading-tonumber(data.value)
end)

-- Define which part of the body must be zoomed
RegisterNUICallback('zoom', function(data)
	zoom = data.zoom
end)


------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

function SkinCreator(enable)
	local ped = GetPlayerPed(-1)

	-- Disable Controls
	-- TODO: Reset controls when player confirm his character creation
	if enable == true then
		DisableControlAction(2, 14, true)
		DisableControlAction(2, 15, true)
		DisableControlAction(2, 16, true)
		DisableControlAction(2, 17, true)
		DisableControlAction(2, 30, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(2, 33, true)
		DisableControlAction(2, 34, true)
		DisableControlAction(2, 35, true)
		DisableControlAction(0, 25, true)
		DisableControlAction(0, 24, true)

--		if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
--			SendNUIMessage({type = "click"})
--		end

		-- Player
		SetPlayerInvincible(ped, true)

		-- Camera
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
		if(not DoesCamExist(cam)) then
			cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
			SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
			SetCamRot(cam, 0.0, 0.0, 0.0)
			SetCamActive(cam,  true)
			RenderScriptCams(true,  false,  0,  true,  true)
			SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
		end
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
		if zoom == "face" or zoom == "hair" then
			SetCamCoord(cam, x+0.2, y+0.5, z+0.7)
			SetCamRot(cam, 0.0, 0.0, 150.0)
		elseif zoom == "clothes" then
			SetCamCoord(cam, x+0.3, y+2.0, z+0.0)
			SetCamRot(cam, 0.0, 0.0, 170.0)
		end
	end
end

function ShowSkinCreator(enable)
	SendNUIMessage({
		openSkinCreator = enable
	})
end

function DeleteSkinCam()
	if cam ~= nil then
		SetCamActive(cam, false)
		RenderScriptCams(false, true, 500, true, true)
		cam = nil
	end
end

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		if isSkinCreatorOpened == true then
			SkinCreator(true)
			SetEntityHeading(GetPlayerPed(-1), heading)
			SetNuiFocus(true, true)
		else
			SkinCreator(false)
			DeleteSkinCam()
		end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('vueskincreator:show')
AddEventHandler('vueskincreator:show', function(data)
	Skin = {}

	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		Skin = skin

		if data.sex ~= nil and data.sex == "f" then
			Skin['sex'] = 1
		else
			Skin['sex'] = 0
		end

		isSkinCreatorOpened = true
		ShowSkinCreator(true)
	end)

end)

RegisterNetEvent('vueskincreator:hide')
AddEventHandler('vueskincreator:hide', function()
	ShowSkinCreator(false)
	isSkinCreatorOpened = false
	FreezeEntityPosition(PlayerPedId(), false)
	SetPlayerInvincible(PlayerPedId(), false)
	SetNuiFocus(false)
end)
