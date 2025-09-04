local Services = require(`./Services`)

local Module = {}

function Module.Assert(Condition: (any), ErrorMessage: string, Level: number?): ()
	if not (Condition) then error(`Assert: {ErrorMessage}`, Level or 2) end
end

function Module.GetUnique()
	return Services.HttpService:GenerateGUID(false)
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

function Module.WaitForChildWhichIsA(Where: Instance, What: string, Recursive: boolean?, Timer: number?): Instance?
	if not Where or type(What) ~= "string" then
		return warn( `[{script}] {debug.info(1, `n`)} got incorrect data. Where: {Where} = {typeof(Where)}, What: {What} = {typeof(What)}`)
	else
		Timer = type(Timer) == "number" and Timer or 7
		local TimePassed = 0
		local Found = nil
		repeat
			Found = Where:FindFirstChildWhichIsA(What, Recursive)
			TimePassed += task.wait() 
		until Found or TimePassed >= Timer
		return Found
	end
end

return Module
