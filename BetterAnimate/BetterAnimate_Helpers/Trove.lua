--local ModuleScript_BetterAnimate = `../BetterAnimate`
--local BetterAnimate = require("../../BetterAnimate")
--BetterAnimate.

local Serviecs = require(`./Services`)
local Destroyer = require(`./Destroyer`)
local Utils = require(`./Utils`)

export type Trove = {

	Extend: (self: Trove)-> Trove,
	InstanceNew: (self: Trove, ClassName: string)-> (Instance, ()->()),
	Clone: <_, Inst>(self: Trove, Inst)-> (Inst, ()->()),
	Connect: (self: Trove, Signal: RBXScriptSignal, Function: (any)->(), OnDestroy: ()->()?)-> (RBXScriptConnection, ()->()),
	Once: (self: Trove, Signal: RBXScriptSignal, Function: (any)->(), OnDestroy: ()->()?)-> (RBXScriptConnection, ()->()),
	BindToRenderStep: (self: Trove, Priority: Enum.RenderPriority | number, Function: (dt: number)->(), OnDestroy: ()->()?)-> (string, ()->()),
	Add: <_, Object>(self: Trove, Object, ...any)-> (Object, ()->()),
	Remove: (self: Trove, Object: any, Destroy: boolean?)-> boolean,
	AttachToInstance: (self: Trove, Inst: Instance)-> RBXScriptConnection,
	Clear:(self: Trove, Destroy: boolean?)-> (),
	Destroy: (self: Trove)-> (), -- Destroy == Clear(true) & setmetatable(self, nil)

	__index: Trove,
}

local Trove = {} :: Trove
Trove.__index = Trove

function Trove.New()
	local self = setmetatable({}, Trove)
	self.Objects = {}
	self.Cleaning = false
	--self.Name = Name
	--self.UniqueID = Serviecs.HttpService:GenerateGUID()
	return self
end

function Trove:Extend()
	return self:Add(Trove.New(
		--self.Name or Serviecs.HttpService:GenerateGUID()
		))
end

function Trove:InstanceNew(ClassName: string): Instance
	return self:Add(Instance.new(ClassName))
end

function Trove:Clone<Inst>(Inst): Inst
	return self:Add(Inst:Clone())
end

function Trove:BindToRenderStep(Priority: Enum.RenderPriority | number, Function: (dt: number)->(), OnDestroy: ()->()?)
	
	local Index = Serviecs.HttpService:GenerateGUID()
	Serviecs.RunService:BindToRenderStep(Index, Priority, Function)
	return self:Add(Index, function() 
		Serviecs.RunService:UnbindFromRenderStep(Index)
		if type(OnDestroy) == `function` then	
			OnDestroy()
		end
	end)
end

function Trove:Add<Object>(Object, ...: any): Object
	
	local CheckExist = self.Objects[Object]
	if CheckExist then
		return warn(`[Trove] Trying to add existing Object`, Object)
	else
		self.Objects[Object] = {...}
		return Object, function() self:Remove(Object) end
	end
end

function Trove:Remove(Object: any, Destroy: boolean?)
	
	local ObjectTable = self.Objects[Object]
	if ObjectTable then
		
		if Destroy then
			if type(Object) == "function" then
				Object(table.unpack(ObjectTable))
			else
				Destroyer.Destroy(Object)
				
				for _, Arg in ObjectTable do
					if type(Arg) == "function" then
						Arg()
					end
				end
			end
		end
		
		self.Objects[Object] = nil
		return true
	end
	
	return false, warn(`[{script}] Object not found: {Object}`)
end

function Trove:AttachToInstance(Inst: Instance)
	
	if not Inst then
		error(`Instance expected, got {Inst}`, 2)
	else
		return self:Add(Inst.Destroying:Connect(function() self:Destroy() end))
	end
end

function Trove:Clear(Destroy: boolean?)
	
	for Object, _ in self.Objects do
		self:Remove(Object, Destroy)
	end
end

function Trove:Destroy()
	
	self:Clear(true)
	setmetatable(self, nil)
end

Destroyer.AddTableDestroyMethod(`{script}`, function(Table)
	if getmetatable(Table) == Trove then
		Table:Destroy()
	end
end)

return Trove.New() :: Trove