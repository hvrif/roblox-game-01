--!strict
-- Server entry point. You should rarely need to edit this file.
-- It loads every ModuleScript in ./Services, calls :Init() on all of them, then :Start() on all of them.
-- To add a system, create a new file in ./Services (copy _Template.luau).

local Services = script:WaitForChild("Services")

type Service = {
	Name: string,
	Init: ((self: any) -> ())?,
	Start: ((self: any) -> ())?,
}

local loaded: { Service } = {}

for _, module in Services:GetChildren() do
	if module:IsA("ModuleScript") and not string.match(module.Name, "^_") then
		local ok, result = pcall(require, module)
		if ok then
			table.insert(loaded, result :: Service)
		else
			warn(`[Server] Failed to load service {module.Name}: {result}`)
		end
	end
end

-- Init: set up state, connect remotes. Do NOT call other services here.
for _, service in loaded do
	if service.Init then
		service:Init()
	end
end

-- Start: safe to talk to other services now.
for _, service in loaded do
	if service.Start then
		task.spawn(service.Start, service)
	end
end

print(`[Server] Started {#loaded} service(s)`)
