--!strict
-- One place to declare every RemoteEvent. This stops typos and "who made this remote?" confusion.
-- To add a remote: add its name to REMOTE_NAMES below. That's it.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local REMOTE_NAMES = {
	"ExampleRequest",
}

local FOLDER_NAME = "Remotes"

local Remotes = {}

local function getFolder(): Folder
	if RunService:IsServer() then
		local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME) :: Folder?
		if not folder then
			local newFolder = Instance.new("Folder")
			newFolder.Name = FOLDER_NAME
			for _, name in REMOTE_NAMES do
				local remote = Instance.new("RemoteEvent")
				remote.Name = name
				remote.Parent = newFolder
			end
			newFolder.Parent = ReplicatedStorage
			return newFolder
		end
		return folder
	end
	return ReplicatedStorage:WaitForChild(FOLDER_NAME) :: Folder
end

local function getRemote(name: string): RemoteEvent
	assert(table.find(REMOTE_NAMES, name), `Unknown remote "{name}". Add it to REMOTE_NAMES in Shared/Remotes.`)
	return getFolder():WaitForChild(name) :: RemoteEvent
end

-- Server
function Remotes.OnServer(name: string, handler: (player: Player, ...any) -> ())
	return getRemote(name).OnServerEvent:Connect(handler)
end

function Remotes.FireClient(name: string, player: Player, ...: any)
	getRemote(name):FireClient(player, ...)
end

function Remotes.FireAllClients(name: string, ...: any)
	getRemote(name):FireAllClients(...)
end

-- Client
function Remotes.FireServer(name: string, ...: any)
	getRemote(name):FireServer(...)
end

function Remotes.OnClient(name: string, handler: (...any) -> ())
	return getRemote(name).OnClientEvent:Connect(handler)
end

return Remotes
