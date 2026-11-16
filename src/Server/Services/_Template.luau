--!strict
-- TEMPLATE: copy this file, rename it (e.g. InventoryService.luau), and delete the leading underscore.
-- Files starting with "_" are skipped by the loader.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = require(Shared.Remotes)

local TemplateService = {
	Name = "TemplateService",
}

function TemplateService:Init()
	-- Set up state and remote listeners here.
	-- ALWAYS validate what the client sends. Never trust it for currency, damage or rewards.
	Remotes.OnServer("ExampleRequest", function(player: Player, payload: any)
		if typeof(payload) ~= "string" or #payload > 50 then
			return
		end
		print(`[TemplateService] {player.Name} sent {payload}`)
	end)
end

function TemplateService:Start()
	-- Safe to use other services here.
end

return TemplateService
