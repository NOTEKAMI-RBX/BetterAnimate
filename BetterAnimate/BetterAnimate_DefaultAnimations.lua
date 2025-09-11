--!strict
--!native

--[[ EXAMPLE WHAT YOU CAN USE

	? -- Not necessary
	
	Idle = {
		Idle1 = (
		180426354 
			or
		`rbxassetid://180426354` 
			or 
		Instance.new(`Animation`))	
			or
		{
			[❗MUST HAVE ID OR INSTANCE❗]
			ID = 180426354 or `rbxassetid://180426354` ?
			Instance = Instance.new(`Animation`) ?
			Weight = 10 ?
			Index = any ?
		}
	}
]]

return {
	R6 = {
		Idle = 	{ -- "Random" idle animation
			Idle1 = { ID = 180435571, Weight = 80 },
			Idle2 = { ID = 180435792, Weight = 20 },
		},
		Walk = 		{ Walk1 =		180426354 }, 
		Run = 		{ Run1 =		180426354 },
		Swim = 		{ Swim1 =		180426354 },
		Swimidle = 	{ Swimidle1 =	180426354 }, 
		Jump = 		{ Jump1 =		125750702 }, 
		Fall = 		{ Fall1 =	 	180436148 }, 
		Climb =		{ Climb1 =		180436334 }, 
		Sit = 		{ Sit1 =		178130996 },	
		Toolnone = 	{ Toolnone1 = 	182393478 },
		Temp = 		{ Temp1 =		15609995579 }, -- r15 animation for r6
		--Wave = 		{ Wave1 =		{ ID = "128777973", Weight = 10 } },
		--Point = 	{ Point1 =		{ ID = "128853357", Weight = 10 } },
		--Dance = 	{ 
		--	Dance1 ={ ID = "182435998", Weight = 10 },
		--	Dance2 ={ ID = "182436842", Weight = 10 },
		--	Dance3 ={ ID = "182436935", Weight = 10 },
		--},
		--Laugh = 	{ Laugh1 =		{ ID = "129423131",   Weight = 10 } },
		--Cheer = 	{ Cheer1 =		{ ID = "129423030",   Weight = 10 } },
		--Emote =     { { } },
	},

	R15 = {
		Idle = 	{ -- "Random" idle animation
			Idle1 = { ID = 507766666, Weight = 20 },
			Idle2 = { ID = 507766951, Weight = 20 },
			Idle3 = { ID = 507766388, Weight = 80 }
		},
		Walk = 		{ Walk1 =		507777826 }, 
		Run = 		{ Run1 =		507767714 }, 
		Swim = 		{ Swim1 =		507784897 },
		Swimidle = 	{ Swimidle1 =	507785072 }, 
		Jump = 		{ Jump1 =		507765000 }, 
		Fall = 		{ Fall1 =	 	507767968 }, 
		Climb = 	{ Climb1 =		507765644 }, 
		Sit = 		{ Sit1 =		2506281703 },	
		Toolnone = 	{ Toolnone1 = 	507768375 },
		Temp = 		{ Temp1 =		27789359 }, -- r6 animation for r15
		--Wave = 		{ Wave1 =		{ ID = "507770239",  Weight = 10 } },
		--Point = 	{ Point1 =		{ ID = "507770453",  Weight = 10 } },
		--Dance = 	{
		--	Dance1 ={ ID = "507772104", Weight = 10 },
		--	Dance2 ={ ID = "507776879", Weight = 10 },
		--	Dance3 ={ ID = "507777623", Weight = 10 },
		--},
		--Laugh = 	{ Laugh1 =		{ ID = "507770818", Weight = 10 } },
		--Cheer = 	{ Cheer1 =		{ ID = "507770677", Weight = 10 } },
		--Emote =     { { } },
	},
}
