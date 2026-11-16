--!strict
-- TEMPLATE: copy, rename (e.g. ShopController.luau), and remove the leading underscore.
-- Client code is for UI, input, camera and effects. Game rules and rewards live on the server.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage:WaitForChild("Shared").Remotes)

local TemplateController = {
	Name = "TemplateController",
}

function TemplateController:Init()
	-- Set up UI references and input bindings here.
end

function TemplateController:Start()
	-- Example: ask the server to do something. The server decides if it's allowed.
	Remotes.FireServer("ExampleRequest", "hello")
end

return TemplateController
