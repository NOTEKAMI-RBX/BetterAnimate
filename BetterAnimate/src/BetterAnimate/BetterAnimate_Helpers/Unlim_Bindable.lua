
--Types

--

--Modules
local Utils = require(`./Utils`)
local Destroyer = require(`./Destroyer`)
local Services = require(`./Services`)
--

--Types
export type DisconnectFunction = ()-> ()

export type Unlim_Bindable = {
	
	Connect: (self: Unlim_Bindable, Function: (...any)-> ())-> (string, DisconnectFunction),
	Once: (self: Unlim_Bindable, Function: (...any)-> ())-> (string, DisconnectFunction),
	Wait: (self: Unlim_Bindable)-> (...any),
	
	Disconnect: (self: Unlim_Bindable, Key: string)-> (),
	DisconnectAll: (self: Unlim_Bindable)-> (),
	
	Fire: (self: Unlim_Bindable, Key: string, ...any)-> (),
	Fires: (self: Unlim_Bindable, ...any)-> (),
	Invoke: (self: Unlim_Bindable, Key: string, ...any)-> (...any),
	
	Destroy: (self: Unlim_Bindable)-> (),
	
	__index: Unlim_Bindable
}
--

local Bindables = {}
local Bindable = {} :: Unlim_Bindable
Bindable.__index = Bindable

function Bindable:Connect(Function: (...any) -> ())
	local Key
	repeat
		Key = Utils.GetUnique()
	until not self.Connects[Key]
	
	self.Connects[Key] = Function
	return Key, function() self.Connects[Key] = nil end
end

function Bindable:Once(Function: (...any) -> ())
	local Key, DisconnectFunction
	Key, DisconnectFunction = self:Connect(function(...: any)
		--print(self)
		--print(getmetatable(self))
		if getmetatable(self) then
			DisconnectFunction()
			task.spawn(Function, ...)
		end
	end)
	
	return Key, DisconnectFunction
end

function Bindable:Disconnect(Key: string)
	self.Connects[Key] = nil
end

function Bindable:DisconnectAll()
	for Key in self.Connects do
		self.Connects[Key] = nil
	end
end

function Bindable:Wait()
	local This_Thread = coroutine.running()
	self:Once(function(...)
		--print(coroutine.status(This_Thread))
		local Status = coroutine.status(This_Thread)
		
		if Status == `normal` or `suspended` then
			pcall(task.spawn, This_Thread, ...)
			--task.defer(This_Thread, ...)
		else
			warn(`[Unlim_Bindable] {This_Thread} is {Status}`)
		end
		
	end)
	return coroutine.yield()
end

function Bindable:Fire(Key: string, ...: any)
	local Function = self.Connects[Key]
	if Function then
		task.spawn(Function, ...)
	else
		warn(`[Unlim_Bindable] Connect with key: {Key} don't exist {self.Identifier} \n {debug.traceback()}`)
	end
end

function Bindable:Fires(...: any)
	for _, Function in self.Connects do
		task.spawn(Function, ...)
	end
end

function Bindable:Invoke(Key: string, ...: any)
	local Function = self.Connects[Key]
	if not Function then return end
	return Function(...)
end

function Bindable:Destroy()
	self:DisconnectAll()
	Bindables[self.Identifier] = nil
	setmetatable(self, nil)
end

Destroyer.AddTableDestroyMethod(`{script}`, function(Table)
	if getmetatable(Table) == Bindable then
		return true, (Table :: Unlim_Bindable):Destroy()
	end
end)

return {
	New = function(Identifier: string?): Unlim_Bindable
		if not Identifier then
			Identifier = Utils.GetUnique()
			while Bindables[Identifier] do
				Identifier = Utils.GetUnique()
			end
		end

		Utils.Assert(typeof(Identifier) == "string", `[{script}]: Identifier must be a string type, got {typeof(Identifier)}`)
		if not Bindables[Identifier] then
			local self = setmetatable({
				Identifier = Identifier,
				Connects = {},
			}, Bindable)
			Bindables[Identifier] = self
			return self
		end

		return Bindables[Identifier]
	end,
}