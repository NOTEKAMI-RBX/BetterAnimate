--!native
--!optimize 2

local Types = require(`./BetterAnimate_Types`)

local Module = {	
	
	FastConfig = {
		R6ClimbFix = true, -- For R6
		EmoteIngnoreEmotable = false,
		AnimationSpeedMultiplier = 1,
		AnimationPlayTransition = 0.1,
		AnimationStopTransition = 0.1,
		ToolAnimationPlayTransition = 0.1,
		ToolAnimationStopTransition = 0.1,
		WaitFallOnJump = 0.31,
		DefaultAnimationLength = 5,
		DefaultAnimationWeight = 10,
		AnimationPriority = Enum.AnimationPriority.Core,
		ToolAnimationPriority = Enum.AnimationPriority.Action,
		MoveDirection = nil,
		AssemblyLinearVelocity = nil,
		SetAnimationOnIdDifference = false,
		AlwaysUseCurrentTransition = true,
	},
	
	_Time = {
		Debug = 0.06,
		--AnimationStop = 0.1,
		--FallOnJump = 0.31,
		--Fall = 0.1,
		--AnimationTransition = 0.1,
	},
	
	_State = {
		Functions = {
			
			[Enum.HumanoidStateType.Jumping.Name] = function(self: Types.BetterAnimate)
				self._Time.Jumped = tick()
				self:PlayClassAnimation(`Jump`)
			end,

			[Enum.HumanoidStateType.Freefall.Name] = function(self: Types.BetterAnimate)
				if self._Time.Jumped then 
					if tick() - self._Time.Jumped >= (self.FastConfig.WaitFallOnJump or 0) then
						self:PlayClassAnimation(`Fall`)
					end
				else
					self:PlayClassAnimation(`Fall`)
				end
			end,

			[Enum.HumanoidStateType.GettingUp.Name] = function(self: Types.BetterAnimate) 
				self:StopClassAnimation()
			end,	

			[Enum.HumanoidStateType.FallingDown.Name] = function(self: Types.BetterAnimate) 
				self:StopClassAnimation()
			end,	

			[Enum.HumanoidStateType.PlatformStanding.Name] = function(self: Types.BetterAnimate)
				self:StopClassAnimation()
			end,

			[Enum.HumanoidStateType.Running.Name] = function(self: Types.BetterAnimate)
				local AssemblyLinearVelocityMagnitude = (self._AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
				local Speed = AssemblyLinearVelocityMagnitude * (self._MoveDirection or Vector3.zero).Magnitude
				local SpeedRange = self._Class.SpeedRange
				--print(Utils.MaxDecimal(AssemblyLinearVelocityMagnitude, 1), Speed)
				self._Speed = Speed
				--print(SpeedRange.Min, Speed)
				if Speed > -math.huge and SpeedRange.Min >= Speed then
					self:PlayClassAnimation(`Idle`, 0.2)
				elseif Speed > SpeedRange.Min and SpeedRange.Max >= Speed then
					self:PlayClassAnimation(`Walk`, 0.2)
				elseif Speed > SpeedRange.Max and math.huge >= Speed then
					self:PlayClassAnimation(`Run`, 0.2)
				else
					warn(`Over 9000!!!! {Speed}`) -- you broke something
				end
			end,

			[Enum.HumanoidStateType.Seated.Name] = function(self: Types.BetterAnimate)
				self:PlayClassAnimation(`Sit`, 0.3)
			end,

			[Enum.HumanoidStateType.Swimming.Name] = function(self: Types.BetterAnimate)
				if self._Speed > 3 then self:PlayClassAnimation(`Swim`, 0.4) return end
				self:PlayClassAnimation(`Swimidle`, 0.4)
			end,

			[Enum.HumanoidStateType.Climbing.Name] = function(self: Types.BetterAnimate)
				self:PlayClassAnimation(`Climb`, 0.2)
			end,

			[Enum.HumanoidStateType.None.Name] = function(self: Types.BetterAnimate)
				self:PlayClassAnimation(`Temp`)
				--self.ForceState = false
			end,
		},
	},

	_Class = { -- Class ~= State 
		Inverse = { -- When inverse animation work
			Walk = true, 
			Run = true, 
			Climb = true,
		},

		Emotable = { -- When emotes can be played
			Idle = true,
			Emote = true
		},

		AnimationSpeedAdjust = { -- Humanoid.WalkSpeed / AnimationSpeedAdjust = AnimationSpeed
			Walk = 9,
			Run = 16,
			Climb = 6, -- (Humanoid.RigType == Enum.HumanoidRigType.R15 and 4) or 12, -- R6 and R15 speed must be different (roblox's skill issue)
			Swim = 10,
		},
		
		DirectionAdjust = { 
			Swim = CFrame.Angles(math.rad(90), 0, 0), -- Fix for swim
		},
		
		SwitchIgnore = {
			Jump = true,
		},
		
		SpeedRange = NumberRange.new(
			0, 
			9
			--[[
				-math.huge - 0.4 == Idle
				0.4 - 9 == Walk
				9 - math.huge == Run
			]]
		),
		
		TimerMax = { -- Wait until play random animation from same class
			Idle = NumberRange.new(5, 8),
		},
		
		Timer = {
			Idle = 0,
		}
	},
	
	_Inverse = {
		Enabled = true,
		
		Directions = {
			BackwardRight = true, 
			BackwardLeft = true, 
			Backward = true,
			Down = true, -- For climb
		}
	},
	
	_Animation = {},
	
	_Events_Enabled = {
		NewMoveDirection = true,
		NewState = true,
		NewAnimation = true,
		KeyframeReached = true,
	},
}

return Module
