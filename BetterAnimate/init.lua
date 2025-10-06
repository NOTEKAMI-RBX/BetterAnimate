--!optimize 2

--[[
	Made by NOTEKAMI
	https://devforum.roblox.com/t/2871306	
	Version 1.3.1 [ NOTICE, I might forget sometimes to change the version numbers ]
	2025
]]

--Helpers
local Helpers_Folder = script:WaitForChild(`BetterAnimate_Helpers`)

local Trove = require(Helpers_Folder:WaitForChild(`Trove`)) -- Creating Trove for BetterAnimate
local Destroyer = require(Helpers_Folder:WaitForChild(`Destroyer`))
local Utils = require(Helpers_Folder:WaitForChild(`Utils`))
local Services = require(Helpers_Folder:WaitForChild(`Services`))
local Unlim_Bindable = require(Helpers_Folder:WaitForChild(`Unlim_Bindable`))
--

local LocalUtils = {}
local BetterAnimate = {}

type([[📝 TYPES 📝]])
export type Trove = typeof(Trove)
export type Destroyer = typeof(Destroyer) --Destroyer
export type LocalUtils = typeof(LocalUtils)
export type Unlim_Bindable = Unlim_Bindable.Unlim_Bindable
export type Unlim_Bindable_Start = typeof(Unlim_Bindable)
export type BetterAnimate = typeof(BetterAnimate) --BetterAnimate
export type BetterAnimate_AnimationClasses = "Walk" | "Run" | "Swim" | "Swimidle" | "Jump" | "Fall" | "Climb" | "Sit" | "Idle" | "Emote" | "Temp" --| string
export type BetterAnimate_Directions = "ForwardRight" | "ForwardLeft" | "BackwardRight" | "BackwardLeft" | "Right" | "Left" | "Backward" | "Forward" | "Up" | "Down" | "None"
export type BetterAnimate_EventNames = "NewMoveDirection" | "NewState" | "NewAnimation" | "KeyframeReached" | "MarkerReached"
export type BetterAnimate_AnimationData = {
	ID: number | string?,
	Instance: Animation?,
	Weight: number?,
	Index: string?,
}

Trove = Trove:Extend()

--Settings
local DefaultSettings = require(script:WaitForChild(`BetterAnimate_DefaultSettings`))
local PresetsTagIndex = `BetterAnimate_Presets`
local RNG = Random.new(os.clock())
local AnimationDataMeta = {}
--

do type([[ LOCAL UTILS ]])
	
	--[[
		Looking for ClassesPreset in modules (that have tag `BetterAnimate_Presets`)
		
		@return Module[Index]
		
	]]
	function LocalUtils.GetClassesPreset(Index: any): ({ [BetterAnimate_AnimationClasses]: { [any]: BetterAnimate_AnimationData | string | number | Animation } }?)
		for _, ModuleScript in Services.CollectionService:GetTagged(PresetsTagIndex) do
			--print(ModuleScript)
			if ModuleScript:IsA(`ModuleScript`) then
				local Module = require(ModuleScript)

				if Module[Index] then
					return Module[Index]
				end
			end
		end
		
		return
	end
	
	--Return name of MoveDirection
	function LocalUtils.GetMoveDirectionName(MoveDirection: Vector3): BetterAnimate_Directions
		return (MoveDirection.Z < 0 and MoveDirection.X > 0 and `ForwardRight`)
			or (MoveDirection.Z < 0 and MoveDirection.X < 0 and `ForwardLeft`)
			or (MoveDirection.Z < 0 and MoveDirection.X == 0 and `Forward`)
			or (MoveDirection.Z > 0 and MoveDirection.X == 0 and `Backward`)
			or (MoveDirection.Z > 0 and MoveDirection.X > 0 and `BackwardRight`)
			or (MoveDirection.Z > 0 and MoveDirection.X < 0 and `BackwardLeft`)
			or (MoveDirection.Z == 0 and MoveDirection.X > 0 and `Right`)
			or (MoveDirection.Z == 0 and MoveDirection.X < 0 and `Left`)
			or (MoveDirection.Y > 0 and `Up`)
			or (MoveDirection.Y < 0 and `Down`)
			or `None`
	end
	
	--[[ 
		If NumberRange it will return random value from range else number you gave
		@return number
	]]
	function LocalUtils.GetTime(Time: number | NumberRange): number
		return typeof(Time) == "NumberRange" and RNG:NextNumber(Time.Min, Time.Max) or Time
	end
	
	--[[
		Used to generate animation data	
	]]
	function LocalUtils.GetAnimationData(AnimationData: BetterAnimate_AnimationData | number | string | Instance, DefaultWeight: number?): BetterAnimate_AnimationData
		local Type = typeof(AnimationData)
		DefaultWeight = DefaultWeight or 1
		
		if Type == `table` then
			if getmetatable(AnimationData :: any) ~= AnimationDataMeta then
				local AnimationData = setmetatable(Utils.DeepCopy(AnimationData) :: BetterAnimate_AnimationData, AnimationDataMeta)
				local AnimationLink = `rbxassetid://{string.gsub(`{AnimationData.ID or (AnimationData.Instance and AnimationData.Instance.AnimationId) or ``}`, "%D", "")}`
				local Animation = Instance.new(`Animation`)
				Animation.Name = `{script}_AnimationFromTable_{math.random()}`
				Animation.AnimationId = AnimationLink
				--Animation.Parent = game:GetService(`Lighting`) -- Testing
				AnimationData.ID = AnimationLink
				AnimationData.Weight = AnimationData.Weight or DefaultWeight
				AnimationData.Instance = Animation
				return AnimationData
			else
				return AnimationData :: BetterAnimate_AnimationData
			end
			
		elseif Type == `number` then
			local AnimationLink = `rbxassetid://{AnimationData :: number}`
			local AnimationData = setmetatable({} :: BetterAnimate_AnimationData, AnimationDataMeta)
			local Animation = Instance.new(`Animation`)
			Animation.Name = `{script}_AnimationFromNumber_{math.random()}`
			Animation.AnimationId = AnimationLink
			--Animation.Parent = game:GetService(`Lighting`) -- Testing
			AnimationData.ID = AnimationLink
			AnimationData.Weight = DefaultWeight
			AnimationData.Instance = Animation
			return AnimationData
			
		elseif Type == `string` then
			local AnimationLink = `rbxassetid://{string.gsub(`{AnimationData :: string}`, "%D", "")}`
			local AnimationData = setmetatable({} :: BetterAnimate_AnimationData, AnimationDataMeta)
			local Animation = Instance.new(`Animation`)
			Animation.Name = `{script}_AnimationFromString_{math.random()}`
			Animation.AnimationId = AnimationLink
			--Animation.Parent = game:GetService(`Lighting`) -- Testing
			AnimationData.ID = AnimationLink
			AnimationData.Weight = DefaultWeight
			AnimationData.Instance = Animation
			return AnimationData
			
		elseif Type == `Instance` and (AnimationData :: Instance):IsA(`Animation`) then
			local AnimationLink = `rbxassetid://{string.gsub(`{(AnimationData :: Animation).AnimationId}`, "%D", "")}`
			local AnimationData = setmetatable({} :: BetterAnimate_AnimationData, AnimationDataMeta)
			local Animation = Instance.new(`Animation`)
			Animation.Name = `{script}_AnimationFromInstance_{math.random()}`
			Animation.AnimationId = AnimationLink
			--Animation.Parent = game:GetService(`Lighting`) -- Testing
			AnimationData.ID = AnimationLink
			AnimationData.Weight = DefaultWeight
			AnimationData.Instance = Animation
			return AnimationData
			
		else
			error(`[{script}] table or number or string or Instance expected, got {Type}`)
		end
	end
	
	--[[
		Fix center of mass (strange physics) for character	
	]]
	function LocalUtils.FixCenterOfMass(_PhysicalProperties: PhysicalProperties, Part: BasePart): ()
		Part.CustomPhysicalProperties = PhysicalProperties.new(
			_PhysicalProperties.Density - 0.01,
			_PhysicalProperties.Friction,
			_PhysicalProperties.Elasticity,
			_PhysicalProperties.FrictionWeight,
			_PhysicalProperties.ElasticityWeight
		)

		task.wait() -- Don't work without it

		Part.CustomPhysicalProperties = _PhysicalProperties
	end
	
	LocalUtils.SimpleStateWrapper = DefaultSettings.SimpleStateWrapper
end

do type([[ BETTERANIMATE ]])
	
	do type([[ FAKE TYPE CASTING ]])
		BetterAnimate.__index = BetterAnimate
		BetterAnimate.Trove = nil :: Trove -- If you want to attach something

		BetterAnimate.Events = nil :: {
			--[[Hiiii]]
			NewMoveDirection: Unlim_Bindable,
			NewState: Unlim_Bindable,
			NewAnimation: Unlim_Bindable,

			--[[KeyframeReached == MarkerReached]]
			KeyframeReached: Unlim_Bindable,
			MarkerReached: Unlim_Bindable,

			--[BetterAnimate_EventNames]: Unlim_Bindable,
		}

		BetterAnimate.FastConfig = nil :: { -- Like FFlag to fix something
			R6ClimbFix: boolean, -- For R6
			WaitFallOnJump: number,
			DefaultAnimationLength: number,
			DefaultAnimationWeight: number,	
			AnimationSpeedMultiplier: number,
			AnimationPlayTransition: number,
			AnimationStopTransition: number,
			AnimationPriority: Enum.AnimationPriority,
			ToolAnimationPlayTransition: number,
			ToolAnimationStopTransition: number,
			ToolAnimationPriority: Enum.AnimationPriority,
			MoveDirection: Vector3?,
			SetAnimationOnIdDifference: boolean?,
			AssemblyLinearVelocity: Vector3?, -- Moving speed
			AlwaysUseCurrentTransition: boolean?,
		}
		
		BetterAnimate._Speed = nil :: number
		BetterAnimate._AssemblyLinearVelocity = nil :: Vector3
		BetterAnimate._MoveDirection = nil :: Vector3
		BetterAnimate._PrimaryPart = nil :: BasePart
		BetterAnimate._Animator = nil :: AnimationController | Humanoid
		BetterAnimate._RigType = nil :: "R6" | "R15" | "Custom" --Enum.HumanoidRigType

		BetterAnimate._Time = nil :: {
			Debug: number,
			Jumped: number,
		}

		BetterAnimate._State = nil :: {
			Forced: string?,
			Current: string,

			Functions: {
				[string]: (BetterAnimate, State: string)-> ()
			}
		}

		BetterAnimate._Trove = nil :: {
			Main: Trove,
			Debug: Trove,
			Animation: Trove,
			Emote: Trove,
			Tool: Trove,
		}

		BetterAnimate._Events_Enabled = nil :: {
			[BetterAnimate_EventNames]: boolean,
		}

		BetterAnimate._Class = nil :: {
			Current: string?,
			Inverse:  { [BetterAnimate_AnimationClasses]: boolean },
			Emotable: { [BetterAnimate_AnimationClasses]: boolean },
			AnimationSpeedAdjust: { [BetterAnimate_AnimationClasses]: number },
			DirectionAdjust: { [BetterAnimate_AnimationClasses]: CFrame },
			--SwitchIgnore: { [BetterAnimate_AnimationClasses]: boolean },
			TimerMax: { [BetterAnimate_AnimationClasses]: number | NumberRange },
			Timer: { [BetterAnimate_AnimationClasses]: number | NumberRange },
			SpeedRange: NumberRange,
			Animations: { [BetterAnimate_AnimationClasses]: { [any]: BetterAnimate_AnimationData } }
		}

		BetterAnimate._Inverse = nil :: {
			Enabled: boolean,
			Directions: { [BetterAnimate_Directions]: boolean}
		}

		BetterAnimate._Animation = nil :: {
			Current: Animation?,
			CurrentTrack: AnimationTrack?,
			CurrentIndex: any?,
			CurrentSpeed: number?,
			DefaultLength: number,
			DefaultWeight: number,
			ToolPriority: Enum.AnimationPriority,
			Priority: Enum.AnimationPriority,
			KeyframeFunction: ()-> (),
			Emoting: boolean?,
		}
	end
	
	do type([[ PUBLIC METHODS ]])
		
		do type([[ GET METHODS ]])
			
			function BetterAnimate.GetMoveDirection(self: BetterAnimate): Vector3
				local PrimaryPart = self._PrimaryPart
				local MoveDirection = self.FastConfig.MoveDirection
					or
					(PrimaryPart.CFrame * (self._Class.DirectionAdjust[self._Class.Current] or CFrame.identity)):VectorToObjectSpace(PrimaryPart.AssemblyLinearVelocity)
				return --Utils.Vector3Round(
					Utils.IsNaN(MoveDirection.Unit) and Vector3.zero or MoveDirection.Unit
				--)
			end

			function BetterAnimate.GetInverse(self: BetterAnimate): number -- Наверное стоит запихнуть в Step GetMoveDirection и получать уже потом из self
				local MoveDirection = self:GetMoveDirection()
				local MoveDirectionName = LocalUtils.GetMoveDirectionName(Utils.Vector3Round(MoveDirection))
				if self._MoveDirection ~= MoveDirection and self._Events_Enabled["NewMoveDirection"] then
					local Event = self.Events["NewMoveDirection"]
					Event:Fires(MoveDirection, MoveDirectionName)
				end
				
				self._MoveDirection = MoveDirection

				return self._Inverse.Enabled 
					and self._Inverse.Directions[MoveDirectionName] 
					and self._Class.Inverse[self._Class.Current] 
					and -1 
					or 1
			end
			
			--[[
				GetRandomClassAnimation ¯\_(ツ)_/¯
			]]
			function BetterAnimate.GetRandomClassAnimation(self: BetterAnimate, Class: BetterAnimate_AnimationClasses): (BetterAnimate_AnimationData, any)
				local ClassAnimations = self._Class.Animations[Class]
				local TotalWeight = 0
				
				--print(Class, ClassAnimations)
				
				if ClassAnimations then
					
					for _, Table in ClassAnimations do
						TotalWeight += (Table.Weight or 0)
					end
					
				else
					warn(`[{script}] ClassAnimations of {Class} not found`)
				end
					
				if TotalWeight == 0 then
					ClassAnimations = self._Class.Animations["Temp"]

					for _, Table in (ClassAnimations or {}) do
						TotalWeight += (Table.Weight or 0)
					end

					if TotalWeight == 0 then
						return
					end

					--Utils.Assert(TotalWeight ~= 0, `[{script}] Temp animation is empty`) -- Temp must have animation and weight
				end
				
				local RandomWeight = RNG:NextNumber(1, TotalWeight)
				local Weight, Index = 0, 1
				
				for I, Table in ClassAnimations do
					Weight += (Table.Weight or 0)
					
					if RandomWeight <= Weight then
						Index = I
						break
					end
				end

				return ClassAnimations[Index], Index
			end
		end


		do type([[ SET METHODS ]])
			
			--[[ Enable debug ]]
			function BetterAnimate.SetDebugEnabled(self: BetterAnimate, Enabled: boolean?): BetterAnimate

				self._Trove.Debug:Clear(true)

				if Enabled then
					local PrimaryPart = self._PrimaryPart
					local Character = PrimaryPart.Parent :: Model
					print(`[{script}] Debug enabled for {PrimaryPart.Parent}`)

					local _, Size = Character:GetBoundingBox()

					local DebugBillboard = self._Trove.Debug:Clone(script.BetterAnimate_Debug)
					DebugBillboard.StudsOffset = Vector3.new(0, Size.Y / 2 + 1.5, 0)
					DebugBillboard.Enabled = true
					DebugBillboard.Parent = PrimaryPart

					local Main = DebugBillboard:FindFirstChild(`Main`)
					local Class = Main:FindFirstChild("Class")
					local Direction = Main:FindFirstChild("Direction")
					local ID = Main:FindFirstChild("ID")
					local Timer = Main:FindFirstChild("Timer")
					local Total = Main:FindFirstChild("Total")
					local Speed = Main:FindFirstChild("Speed")
					local State = Main:FindFirstChild("State")
					local AnimationSpeed = Main:FindFirstChild(`AnimationSpeed`)

					self._Trove.Debug:Add(task.defer(function()

						while task.wait(self._Time.Debug) do

							local ClassCurrent = self._Class.Current
							local AnimationTracks = #self._Animator:GetPlayingAnimationTracks()
							local MoveDirection = self._MoveDirection or Vector3.zero
							
							Class.Text = `Class: {ClassCurrent}`
							Direction.Text = `Direction: {Utils.MaxDecimal(MoveDirection.X, 1)}, {Utils.MaxDecimal(MoveDirection.Y, 1)}, {Utils.MaxDecimal(MoveDirection.Z, 1)},`
							ID.Text = `ID: {self._Animation.CurrentTrack and string.gsub(self._Animation.CurrentTrack.Animation.AnimationId, "%D", "") or nil}`
							Timer.Text = `Timer: {Utils.MaxDecimal(self._Class.Timer[ClassCurrent] or 0, 2)}`
							Total.Text = `Total: {AnimationTracks}`
							Speed.Text = `Speed: {Utils.MaxDecimal(self._Speed or 0, 2)}`
							State.Text = `State: {self._State.Current}`
							AnimationSpeed.Text = `AnimSpeed: {Utils.MaxDecimal(self._Animation.CurrentSpeed or 0, 2)}`
						end
					end))
				end

				return self
			end
			
			--[[
				Force State for one :Step()
				:SetForcedState("Jump")-> Play jump state function
			]]
			function BetterAnimate.SetForcedState(self: BetterAnimate, State: string): BetterAnimate

				local ForcedState

				repeat
					ForcedState = `{State}{math.random()}` -- 2147483647
				until self._State.Forced ~= ForcedState

				self._State.Forced = ForcedState
				
				return self
			end
			
			--[[
				Override current Preset animationes with new one

				:SetClassesPreset{
					Walk = {Walk1 = 123456},
					Run = {Run1 = 123456},
					...
				}
			]]
			function BetterAnimate.SetClassesPreset(self: BetterAnimate, Preset: {
					[BetterAnimate_AnimationClasses]: {
						[any]: BetterAnimate_AnimationData | string | number | Instance
					}
				}): BetterAnimate
				
				Utils.Assert(type(Preset) == `table`, `[{script}] Table expected, got {typeof(Preset)}`)
				
				for Class, ClassPreset in Preset do
					self:SetClassPreset(Class, ClassPreset)
				end
				
				return self
			end

			--[[
				Override current Preset animationes with new one

				:SetClassPreset{"Walk", {Walk1 = 123456})
			]]
			function BetterAnimate.SetClassPreset(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, ClassPreset: {
					[any]: BetterAnimate_AnimationData | string | number | Instance
				}): BetterAnimate
				
				Utils.Assert(type(ClassPreset) == `table`, `[{script}] Table expected, got {typeof(ClassPreset)}`)
				
				local ClassAnimations = self._Class.Animations[Class]
				if ClassAnimations then
					
					for I, AnimationData in ClassAnimations do
						self._Trove.Main:Remove(AnimationData.Instance, true)
						setmetatable(AnimationData, nil)
						ClassAnimations[I] = nil
					end
				end

				for I, AnimationData in ClassPreset do
					self:AddAnimation(Class, I, AnimationData)
				end
				
				return self
			end
			
			--[[
				Enable/Disable events from firing
			]]
			function BetterAnimate.SetEventEnabled(self: BetterAnimate, Name: BetterAnimate_EventNames, Enabled: boolean?): BetterAnimate
				self._Events_Enabled[Name] = Enabled == true

				return self
			end
			
			--[[
				Enable Inverse animations (Run, Walk, Climb, ...)
			]]
			function BetterAnimate.SetInverseEnabled(self: BetterAnimate, Enabled: boolean?): BetterAnimate
				self._Inverse.Enabled = Enabled == true
				
				return self
			end
			
			--[[
				Sets timer for how much AnimationTrack will play
				Example:
				(IdleTime = 7 IdleIndex = "Idle1") -> (IdleTime = 0 IdleIndex = "Idle1") -> (IdleTime = 7 IdleIndex = "Idle2")
				
			]]
			function BetterAnimate.SetClassTimer(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Timer: number): BetterAnimate
				Utils.Assert(type(Timer) == `number`, `[{script}] number expected, got {Timer}`)
				self._Class.TimerMax[Class] = Timer

				return self
			end
			
			--[[
				Sets max timer for how much AnimationTrack will play
				Example:
				MaxTime = 4
				(IdleTime = 4) -> (IdleTime = 0) -> (IdleTime = 4)
				
				MaxTime = 6
				(IdleTime = 6) -> (IdleTime = 0) -> (IdleTime = 6)
				
				MaxTime = NumberRange.new(2, 5)
				(IdleTime = RNG:NextNumber(MaxTime.Min, MaxTime.Max)) -> (IdleTime = 0) -> (IdleTime = RNG:NextNumber(MaxTime.Min, MaxTime.Max))
			]]
			function BetterAnimate.SetClassMaxTimer(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Timer: NumberRange | number?): BetterAnimate
				local Type = typeof(Timer)
				Utils.Assert(Type == `number` or Type == `NumberRange` or Timer == nil, `[{script}] NumberRange or number or nil expected, got {Timer}`)
				self._Class.TimerMax[Class] = Timer
				
				return self
			end
			
			--[[
				Set when Emotes (Emote class) can be played
				
				:SetClassEmotable("Idle", true) --> :PlayEmote(12345) will play Emote
				:SetClassEmotable("Idle", false) --> :PlayEmote(12345) will not play Emote
			]]
			function BetterAnimate.SetClassEmotable(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Emotable: boolean?): BetterAnimate
				self._Class.Emotable[Class] = Emotable == true
				
				return self
			end
			
			--[[
				Usually used to adjust speed for Classes like Run, Walk, Climb
				
				Adjust / MovingSpeed = AnimationSpeed
			]]
			function BetterAnimate.SetClassAnimationSpeedAdjust(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Adjust: number): BetterAnimate
				Utils.Assert(type(Adjust), `[{script}] number expected, got {Adjust}`)
				self._Class.AnimationSpeedAdjust[Class] = Adjust
				
				return self
			end
			
			--[[
				Вeterminate when :GetInverse() will return -1
			]]
			function BetterAnimate.SetInverseDirection(self: BetterAnimate, Direction: BetterAnimate_Directions, Inverse: boolean?): BetterAnimate
				self._Inverse.Directions[Direction] = Inverse == true
				
				return self
			end
			
			--[[
				Class that supports inverse mechanic
				Run, Walk, Climb, etc
			]]
			function BetterAnimate.SetClassInverse(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Inverse: boolean?): BetterAnimate
				self._Class.Inverse[Class] = Inverse == true
				
				return self
			end
			
			--[[
				local Range = NumberRange.new(0, 9)
				
				Idle: Speed > -math.huge and Speed <= Range.Min (0)
				Walk: Speed > Range.Min (0) and Speed <= Range.Max (9)
				Run: Speed > Range.Max (9) and Speed <= math.huge
			]]
			function BetterAnimate.SetRunningStateRange(self: BetterAnimate, Range: NumberRange): BetterAnimate
				Utils.Assert(typeof(Range) == `NumberRange`, `[{script}] NumberRange expected, got {Range}`)
				self._Class.SpeedRange = Range
				
				return self
			end
			
			--[[
				Override State function (logic for State animations) with your own
			]]
			function BetterAnimate.SetStateFunction(self: BetterAnimate, State: string, Function: (BetterAnimate_AnimationData, State: string)-> ()): BetterAnimate
				Utils.Assert(type(Function) == `function`, `[{script}] function expected, got {Function}`)
				self._State.Functions[State] = Function
				
				return self
			end
		end

		do type([[ ETC METHODS ]])
			--[[
				Сomplicated function, i don't recommend using it if you don't know how it works.
				Use :SetClassesPreset() or :SetClassPreset() instead
				
				This function is used to add/override/remove animation
			]]
			function BetterAnimate.AddAnimation(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Index: any?, AnimationData: BetterAnimate_AnimationData | string | number | Animation)

				local ClassAnimations = self._Class.Animations[Class]
				if not ClassAnimations then
					ClassAnimations = {}
					self._Class.Animations[Class] = ClassAnimations
				end

				if AnimationData then
					local AnimationData = LocalUtils.GetAnimationData(AnimationData, self.FastConfig.DefaultAnimationWeight) :: BetterAnimate_AnimationData
					local Index = Index or AnimationData.Index or Utils.GetUnique()

					self._Trove.Main:Add(AnimationData.Instance, function() setmetatable(AnimationData, nil) end)

					if ClassAnimations[Index] then
						self._Trove.Main:Remove(ClassAnimations[Index].Instance, true)
					end

					if AnimationData.ID ~= `rbxassetid://` and AnimationData.ID ~= `rbxassetid://0` then

						ClassAnimations[Index] = AnimationData

						if Index == self._Animation.CurrentIndex 
							or (Class == self._Class.Current and Utils.GetTableLength(ClassAnimations) == 0)
						then
							if self._Class.Timer[Class] then
								self._Class.Timer[Class] = 0
							end

							self:PlayClassAnimation(Class)
						end
					else
						ClassAnimations[Index] = nil
					end

					return Index
				elseif Index then
					ClassAnimations[Index] = nil
				else
					warn(`[{script}] AnimationData or Index expected, got`, Index, AnimationData)
				end

				return self
			end
			
			--[[
				PlayToolAnimation ¯\_(ツ)_/¯
			]]
			function BetterAnimate.PlayToolAnimation(self: BetterAnimate, AnimationData: BetterAnimate_AnimationData | string | number | Animation)
				self:StopToolAnimation()
				
				local AnimationData = AnimationData and LocalUtils.GetAnimationData(AnimationData, self.FastConfig.DefaultAnimationWeight) or self:GetRandomClassAnimation(`Toolnone`)
				local AnimationInstance = AnimationData.Instance
				local AnimationTrack = self._Animator:LoadAnimation(AnimationInstance) :: AnimationTrack --AnimationTable.AnimationTrack
				
				AnimationTrack.Priority = self.FastConfig.ToolAnimationPriority
				
				self._Trove.Tool:Add(AnimationInstance)
				self._Trove.Tool:Add(AnimationTrack.Ended:Connect(self._Animation.KeyframeFunction))
				self._Trove.Tool:Add(AnimationTrack.KeyframeReached:Connect(self._Animation.KeyframeFunction)) -- Roblox Deprecated this (bruh), but it works
				self._Trove.Tool:Add(function(ToolAnimationStopTransition) AnimationTrack:Stop(self.FastConfig.AlwaysUseCurrentTransition and self.FastConfig.ToolAnimationStopTransition or ToolAnimationStopTransition) end, self.FastConfig.ToolAnimationStopTransition)
				AnimationTrack:Play(self.FastConfig.ToolAnimationPlayTransition)
			end
			
			--[[
				StopToolAnimation ¯\_(ツ)_/¯
			]]
			function BetterAnimate.StopToolAnimation(self: BetterAnimate)
				self._Trove.Tool:Clear(true)
			end
			
			--[[
				PlayEmote ¯\_(ツ)_/¯
			]]
			function BetterAnimate.PlayEmote(self: BetterAnimate, AnimationData: BetterAnimate_AnimationData | string | number | Animation, TransitionTime: number?)
				self:StopEmote()

				local CurrentClass = self._Class.Current
				if self._Class.Emotable[CurrentClass] then
					self._Animation.Emoting = true
					
					local AnimationData = LocalUtils.GetAnimationData(AnimationData, self.FastConfig.DefaultAnimationWeight)
					local _, AnimationTrack, AnimationLenght = self:_SetAnimation(`Emote`, TransitionTime, AnimationData)
					self._Trove.Emote:Add(AnimationTrack.Ended:Connect(function()
						self:StopEmote()
					end))
					
					self._Trove.Emote:Add(AnimationData.Instance, function(AnimationStopTransition) 
						AnimationTrack:Stop(self.FastConfig.AlwaysUseCurrentTransition and self.FastConfig.AnimationStopTransition or AnimationStopTransition)
						--self:PlayClassAnimation(self._Class.Current)
						setmetatable(AnimationData, nil)
					end, self.FastConfig.AnimationStopTransition)
					
					return AnimationLenght
				end
			end
			
			--[[
				StopEmote ¯\_(ツ)_/¯
			]]
			function BetterAnimate.StopEmote(self: BetterAnimate)
				self._Animation.Emoting = false
				self._Trove.Emote:Clear(true)
			end
			
			--[[
				Play random Class animation
			]]
			function BetterAnimate.PlayClassAnimation(self: BetterAnimate, Class: BetterAnimate_AnimationClasses, TransitionTime: number?)

				local ClassTimerMax = self._Class.TimerMax
				local ClassTimer = self._Class.Timer
				local OldClass = self._Class.Current
				
				if not self._Animation.Emoting then
					
					if ClassTimerMax[Class] then

						if ClassTimer[Class] then
							if ClassTimer[Class] <= 0 or OldClass ~= Class then
								ClassTimer[Class] = LocalUtils.GetTime(ClassTimerMax[Class])
								return self:_SetAnimation(Class, TransitionTime, self:GetRandomClassAnimation(Class))
							--else
							--	local CurrentTrack = self._Animation.CurrentTrack
							--	return CurrentTrack and CurrentTrack.Length > 0 and CurrentTrack.Length or self._Animation.DefaultLength
							end
						else
							ClassTimer[Class] = LocalUtils.GetTime(ClassTimerMax[Class])
							return self:_SetAnimation(Class, TransitionTime, self:GetRandomClassAnimation(Class))
						end
					else
						return self:_SetAnimation(Class, TransitionTime, self:GetRandomClassAnimation(Class))
					end
				end
			end
			
			--[[
				Stop current class animation
			]]
			function BetterAnimate.StopClassAnimation(self: BetterAnimate): ()
				self._Trove.Animation:Clear(true)
			end
			
			--[[
				Step calculations
			]]
			function BetterAnimate.Step(self: BetterAnimate, Dt: number, StateNew: BetterAnimate_AnimationClasses): ()

				do -- Streaming & Died check
					if not self._PrimaryPart 
						or not self._PrimaryPart.Parent
						or not self._Animator
						or not self._Animator.Parent
						or not getmetatable(self.Trove)
					then
						return
					end
				end
				
				debug.profilebegin(`{script}_{debug.info(1, `n`)}`)

				local StateForced = self._State.Forced and string.gsub(self._State.Forced, "%d", "") or nil
				local StateOld = self._State.Current
				StateNew = StateForced or StateNew

				do -- Speed of character
					local AssemblyLinearVelocity = self.FastConfig.AssemblyLinearVelocity or self._PrimaryPart.AssemblyLinearVelocity
					self._AssemblyLinearVelocity = AssemblyLinearVelocity
					self._Speed = Utils.MaxDecimal(AssemblyLinearVelocity.Magnitude, 1)
				end

				do -- New state event
					if StateNew ~= StateOld and self._Events_Enabled["NewState"] then
						local Event = self.Events["NewState"]
						Event:Fires(StateNew)
						self._State.Current = StateNew
					end
				end

				do -- Forced state update
					if StateForced 
						and StateNew == StateForced
						and StateForced == string.gsub(self._State.Forced, "%d", "")
					then
						self._State.Forced = nil
					end
				end

				do -- Update classes timer
					local Timer = self._Class.Timer
					for I in Timer do
						Timer[I] -= Dt
					end
				end
				
				do -- State function
					local StateFunction = self._State.Functions[StateNew]
					if StateFunction then
						StateFunction(self, StateNew)
					end	
				end
				
				do -- Speed of animation
					local CurrentTrack = self._Animation.CurrentTrack
					local CurrentClass = self._Class.Current
					if CurrentTrack then
						local Inverse = self:GetInverse() 
						local AnimationSpeed = (self._Animation.Emoting and 1 * self.FastConfig.AnimationSpeedMultiplier) 
							or (
								(
									(self._Class.AnimationSpeedAdjust[CurrentClass] and self._Speed / self._Class.AnimationSpeedAdjust[CurrentClass])
									or
									1
								) 
								* self.FastConfig.AnimationSpeedMultiplier 
								* Inverse 
								/ (self.FastConfig.R6ClimbFix and CurrentClass == `Climb` and self._RigType == `R6` and 2 or 1)
							)
						--if math.sign(AnimationSpeed) ~= math.sign(self._Animation.CurrentSpeed or 0) then
						--	print(AnimationSpeed)
						--	CurrentTrack:AdjustSpeed(AnimationSpeed)
						--end

						self._Animation.CurrentSpeed = AnimationSpeed
						CurrentTrack:AdjustSpeed(AnimationSpeed)
					end
				end
				
				debug.profileend()
			end

			function BetterAnimate.Destroy(self: BetterAnimate)
				if getmetatable(self._Trove.Main) then
					self._Trove.Main:Destroy()	
				end

				setmetatable(self, nil)
			end
		end
	end
	
	do type([[ PRIVATE METHODS ]])
		
		do type([[ SET METHODS ]])
			
			--[[
				Main logic to play animation
			]]
			function BetterAnimate._SetAnimation(self: BetterAnimate, Class: --[[Just to be sure]] BetterAnimate_AnimationClasses?, TransitionTime: number, AnimationData: BetterAnimate_AnimationData, Index: any)

				if not AnimationData then
					return
				end

				local CurrentTrack = self._Animation.CurrentTrack
				local AnimationInstance = AnimationData.Instance
				
				TransitionTime = TransitionTime or self.FastConfig.AnimationPlayTransition
				self._Class.Current = Class
				self._Animation.CurrentIndex = Index
				
				local UpdateAnimation = false
				
				if self.FastConfig.SetAnimationOnIdDifference then
					UpdateAnimation = AnimationInstance.AnimationId ~= (self._Animation.Current and self._Animation.Current.AnimationId)
				else
					UpdateAnimation = AnimationInstance ~= self._Animation.Current
				end
				
				if UpdateAnimation 
					or 
					(CurrentTrack and not CurrentTrack.IsPlaying) 
				then
					--print(AnimationInstance, self._Animation.Current--[[, AnimationInstance.AnimationId, self._Animation.Current and self._Animation.Current.AnimationId]])
					--if CurrentTrack and not CurrentTrack.IsPlaying then
					--	CurrentTrack:Play(TransitionTime)
					--	self._Trove.Animation:Add(function(AnimationStopTransition) CurrentTrack:Stop(AnimationStopTransition) end, self.FastConfig.AnimationStopTransition)
					--else
						self:StopClassAnimation()
						--print(2)
						local AnimationTrack = self._Animator:LoadAnimation(AnimationInstance) :: AnimationTrack --AnimationTable.AnimationTrack
						AnimationTrack.Priority = self.FastConfig.AnimationPriority

						self._Animation.Current = AnimationInstance
						self._Animation.CurrentTrack = AnimationTrack
						CurrentTrack = AnimationTrack

						self._Trove.Animation:Add(AnimationTrack.Ended:Connect(self._Animation.KeyframeFunction))
						self._Trove.Animation:Add(AnimationTrack.KeyframeReached:Connect(self._Animation.KeyframeFunction)) -- Roblox Deprecated this (bruh), but it works
						self._Trove.Animation:Add(function(AnimationStopTransition) AnimationTrack:Stop(self.FastConfig.AlwaysUseCurrentTransition and self.FastConfig.AnimationStopTransition or AnimationStopTransition) end, self.FastConfig.AnimationStopTransition)
						AnimationTrack:Play(TransitionTime)

						if self._Events_Enabled["NewAnimation"] then
							local Event = self.Events["NewAnimation"]
							Event:Fires(Class, Index, AnimationData)
						end
					--end
				end

				return AnimationInstance, CurrentTrack, CurrentTrack and CurrentTrack.Length > 0 and CurrentTrack.Length or self.FastConfig.DefaultAnimationLength
			end
		end
		
		do type([[ ETC METHODS ]])
			--[[
				Detect animation Markers (Keyframes)
			]]
			function BetterAnimate._AnimationEvent(self: BetterAnimate, Keyframe: string?)
				if Keyframe then
					if self._Events_Enabled["KeyframeReached"] then
						local Event = self.Events["KeyframeReached"]
						Event:Fires(Keyframe)
					end
				end
			end
		end
	end
end

do type([[ ETC ]])
	Destroyer.AddTableDestroyMethod(`{script}`, function(Table)
		if getmetatable(Table) == BetterAnimate then
			return true, (Table :: BetterAnimate):Destroy()
		end
	end)
end

return {
	New = function(Character: Model)--: BetterAnimate
		local PrimaryPart = Character.PrimaryPart
		local Humanoid = Character:FindFirstChildWhichIsA(`Humanoid`, true)
		local AnimationController = Character:FindFirstChildWhichIsA(`AnimationController`, true)
		
		Utils.Assert(PrimaryPart, `[{script}] PrimaryPart expected, got nil for character {Character}`)
		Utils.Assert(AnimationController or Humanoid, `[{script}] AnimationController or Humanoid not found in {Character}`)
		
		local CharacterTrove = Trove:Extend()
		
		local preself = {} :: BetterAnimate
		preself.Trove = CharacterTrove:Extend()
		preself._PrimaryPart = PrimaryPart
		preself._Animator = AnimationController or Humanoid
		preself._RigType = (Humanoid and Humanoid.RigType.Name) or `Custom`
		
		local MarkerReached = CharacterTrove:Add(Unlim_Bindable.New())
		
		preself.Events = {
			NewMoveDirection = CharacterTrove:Add(Unlim_Bindable.New()),
			NewState = CharacterTrove:Add(Unlim_Bindable.New()),
			NewAnimation = CharacterTrove:Add(Unlim_Bindable.New()),
			KeyframeReached = MarkerReached,
			MarkerReached = MarkerReached,
		}
		
		preself._Trove = {
			Main = CharacterTrove,
			Debug = CharacterTrove:Extend(),
			Animation = CharacterTrove:Extend(),
			Emote = CharacterTrove:Extend(),
			Tool = CharacterTrove:Extend(),
		}
		
		local self = setmetatable(Utils.CopyTableTo(Utils.DeepCopy(DefaultSettings), preself), BetterAnimate)
		
		self._Animation.KeyframeFunction = function(...)
			self:_AnimationEvent(...)
		end
		
		self._Class.Animations = {}
		--CharacterTrove:Add(Character.DescendantAdded:Connect(function()
		--	self:FixCenterOfMass()
		--end))
		
		--CharacterTrove:Add(Character.DescendantRemoving:Connect(function()
		--	self:FixCenterOfMass()
		--end))
		
		return self
	end,
	
	GetMoveDirectionName = LocalUtils.GetMoveDirectionName,
	GetAnimationData = LocalUtils.GetAnimationData,
	GetClassesPreset = LocalUtils.GetClassesPreset,
	FixCenterOfMass = LocalUtils.FixCenterOfMass,
	LocalUtils = LocalUtils,
	PresetsTag = PresetsTagIndex,
}
