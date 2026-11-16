--!strict
-- Client entry point. Loads every ModuleScript in ./Controllers, calls :Init() then :Start().
-- To add a client system (UI, input, effects), copy Controllers/_Template.luau.

local Controllers = script:WaitForChild("Controllers")

type Controller = {
	Name: string,
	Init: ((self: any) -> ())?,
	Start: ((self: any) -> ())?,
}

local loaded: { Controller } = {}

for _, module in Controllers:GetChildren() do
	if module:IsA("ModuleScript") and not string.match(module.Name, "^_") then
		local ok, result = pcall(require, module)
		if ok then
			table.insert(loaded, result :: Controller)
		else
			warn(`[Client] Failed to load controller {module.Name}: {result}`)
		end
	end
end

for _, controller in loaded do
	if controller.Init then
		controller:Init()
	end
end

for _, controller in loaded do
	if controller.Start then
		task.spawn(controller.Start, controller)
	end
end

print(`[Client] Started {#loaded} controller(s)`)
