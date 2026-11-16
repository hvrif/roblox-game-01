--!strict
-- Example real service: tracks players joining/leaving and sets up leaderstats.
-- Delete or replace once your own systems exist.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("Shared").Config.GameConfig)

local PlayerService = {
	Name = "PlayerService",
}

local function onPlayerAdded(player: Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = GameConfig.StartingCoins
	coins.Parent = leaderstats

	leaderstats.Parent = player
end

function PlayerService:Init()
	Players.PlayerAdded:Connect(onPlayerAdded)
	-- Catch players who joined before this service loaded (common in Studio playtests).
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return PlayerService
