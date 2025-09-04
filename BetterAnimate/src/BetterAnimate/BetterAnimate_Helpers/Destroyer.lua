local Module = {
	TableMethods = {},
}

Module.CleanMethods = {
	["table"] = function(Table: {any})
		
		for _, Function in Module.TableMethods do
			if Function(Table) then
				return
			end
		end
	end,
	
	thread = function(Thread: thread)
		task.cancel(Thread)
	end,
	
	["function"] = function(Function: (any)->(any))
		
	end,
	
	instance = function(Inst: Instance)
		--if Inst then 
			Inst:Destroy()
		--end
	end,
	
	rbxscriptconnection = function(Connect: RBXScriptConnection)
		if Connect and Connect.Connected then
			Connect:Disconnect()
		end
	end,
}

function Module.Destroy(Any: any)
	local Destroy = Module.CleanMethods[string.lower(typeof(Any))]
	if Destroy then
		Destroy(Any)
	end
end

function Module.AddTableDestroyMethod(Index: any, Function: (Table: {[any]: any})-> ())
	Module.TableMethods[Index] = Function
end

return Module
