--[[❗ Using BetterAnimate in StarterCharacterScripts or StarterPlayerScripts affects performance, please don`t do this in your project❗ 
In my case I did it for my own needs
]]


local Service_Players = game:GetService(`Players`)

local ModuleScript_BetterAnimate = script:WaitForChild(`BetterAnimate`)

local Types = require(ModuleScript_BetterAnimate:WaitForChild(`BetterAnimate_Types`))
--local DefaultAnimations = require(ModuleScript_BetterAnimate:WaitForChild(`BetterAnimate_DefaultAnimations`))
local BetterAnimate = require(ModuleScript_BetterAnimate)

local LocalPlayer = Service_Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildWhichIsA(`Humanoid`) :: Humanoid
local PrimaryPart = Character.PrimaryPart or Character:GetPropertyChangedSignal(`PrimaryPart`):Wait()-- and Character.PrimaryPart
PrimaryPart = Character.PrimaryPart

local _PhysicalProperties = PrimaryPart.CurrentPhysicalProperties

local MyAnimator = BetterAnimate.New(Character)
	:SetInverseEnabled(true)
	:SetClassesPreset(BetterAnimate.GetClassesPreset(Humanoid.RigType.Name))
	:SetDebugEnabled(true)

MyAnimator.FastConfig.R6ClimbFix = true

do -- Events
	local KeyframeEvent, DirectionEvent, AnimationEvent, StateEvent = MyAnimator.Events["KeyframeReached"], MyAnimator.Events["NewMoveDirection"], MyAnimator.Events["NewAnimation"], MyAnimator.Events["NewState"]
	
	KeyframeEvent:Connect(function(Keyframe: string)
		--print(`Keyframe reached {Keyframe}`)
	end)
	
	DirectionEvent:Connect(function(MoveDirection: Vector3, MoveDirectionName: Types.BetterAnimate_Directions)
		--print(`New MoveDirection {MoveDirection}`)
		if MoveDirection.Magnitude > 1 --[[you can change to 0 if you want]] then
			MyAnimator:StopEmote()
		end
	end)
	
	AnimationEvent:Connect(function(Class: string, Index: any, AnimationData: Types.BetterAnimate_AnimationData)
		--print(`New animation {Index}`)
	end)
	
	StateEvent:Connect(function(State: string)
		--print(`New state {State}`)
	end)
end

do -- Tool
	
	MyAnimator.Trove:Add(Character.ChildAdded:Connect(function(Descendant)
		if Descendant:IsA(`Tool`) then
			MyAnimator:PlayToolAnimation()
		end

		BetterAnimate.FixCenterOfMass(_PhysicalProperties, PrimaryPart)
	end))

	MyAnimator.Trove:Add(Character.ChildRemoved:Connect(function(Descendant)
		if Descendant:IsA(`Tool`) then
			MyAnimator:StopToolAnimation()
		end

		BetterAnimate.FixCenterOfMass(_PhysicalProperties, PrimaryPart)
	end))
end


do -- Some test
	
	MyAnimator.Trove:Add(script:GetAttributeChangedSignal(`Debug`):Connect(function()
		MyAnimator:SetDebugEnabled(script:GetAttribute(`Debug`))
	end))

	MyAnimator.Trove:Add(script:GetAttributeChangedSignal(`Emote`):Connect(function()
		if script:GetAttribute(`Emote`) then
			MyAnimator:PlayEmote(MyAnimator._RigType == `R6` and 182436842 or 15609995579)
		else
			MyAnimator:StopEmote()
		end
	end))
end

do -- Animations logic
	Humanoid.Died:Once(function()
		MyAnimator:Destroy()
	end)
	
	MyAnimator.Trove:Add(Humanoid.Jumping:Connect(function() -- Deffering, since we don't use Humanoid.StateChanged
		MyAnimator:SetForcedState(Enum.HumanoidStateType.Jumping.Name)
	end))
	
	MyAnimator.Trove:Add(task.defer(function()
		while true do
			MyAnimator:Step(task.wait(0.03), Humanoid:GetState().Name)
		end
	end))
end

do -- Roblox buildin PlayEmote
	local PlayEmote = script:FindFirstChild(`PlayEmote`)
	if PlayEmote and PlayEmote:IsA(`BindableFunction`) then
	
		PlayEmote.OnInvoke = function(Animation: string | Animation) --[You must to return true]]
			
			if typeof(Animation) == `Instance` then
				return true, MyAnimator:PlayEmote(Animation)
			else -- string
				--Im bored, write your own method on how to get these animations
			end
		end
	end
end