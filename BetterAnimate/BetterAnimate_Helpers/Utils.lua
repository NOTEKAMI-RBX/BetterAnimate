local Services = require(`./Services`)

local Module = {}

function Module.Assert(Condition: (any), ErrorMessage: string, Level: number?): ()
	if not (Condition) then error(`Assert: {ErrorMessage}`, Level or 2) end
end

function Module.GetUnique()
	return Services.HttpService:GenerateGUID(false)
end

function Module.IsNaN(Value)
	return Value ~= Value
end

function Module.CopyTableTo<From, To>(From: From, To: To): From & To
	for I, Value in From do
		if type(Value) == `table` and type(To[I]) == `table` then
			Module.CopyTableTo(Value, To[I])
		else
			To[I] = Value
		end
	end
	
	return To
end

function Module.DeepCopy<Table>(Table: Table): Table
	local Copy = {}
	
	for I, Value in Table do
		if type(Value) == "table" then
			Value = Module.DeepCopy(Value)
		end
		Copy[I] = Value
	end
	
	return Copy :: Table
end

function Module.GetTableLength(Table: {[any]: any}): number
	local Number = 0
	for _, _ in Table do
		Number += 1
	end
	return Number
end

function Module.Vector3Round(Vector: Vector3): Vector3
	return Vector3.new(math.round(Vector.X), math.round(Vector.Y), math.round(Vector.Z))
end

function Module.MaxDecimal(Number: number, Decimal: number): number
	return tonumber(string.format(`%.{Decimal}f`, Number)) :: number
end

return Module
