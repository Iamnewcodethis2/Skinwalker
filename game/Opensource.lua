-- Load Wizard UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
assert(Library, "Failed to load Wizard UI")

-- Create Window and Sections
local Window = Library:NewWindow("Skinwalkers | Version Hub | V1.0")
local AutoSection = Window:NewSection("Auto")
local ItemSection = Window:NewSection("Items")
local ESPSection = Window:NewSection("ESP")
local CreditsSection = Window:NewSection("Credits")
local TeleportSection = Window:NewSection("Teleport")

-- Settings default
getgenv().settings = {
	auto_shoot = true,
	auto_store = true
}

local player = game.Players.LocalPlayer or game:GetService("Players").LocalPlayer
local skin_walkers = workspace:WaitForChild("Runners"):WaitForChild("Skinwalkers")
local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
local shoot_remote = remotes and remotes:FindFirstChild("SniperShot")
local store_remote = remotes and remotes:FindFirstChild("Store")

local function killPlayer(mob)
	local head = mob:FindFirstChild("Head")
	if not head then return end
	if getgenv().settings.auto_shoot and shoot_remote then
		shoot_remote:FireServer(head.Position, head.Position, head)
	end
	if getgenv().settings.auto_store and store_remote then
		store_remote:FireServer(mob)
	end
end

local shootConnection
local storeConnection

local function disconnectConnection(conn)
	if conn then
		conn:Disconnect()
		conn = nil
	end
	return conn
end

-- Auto Shoot toggle
AutoSection:CreateToggle("Auto Shoot", function(state)
	getgenv().settings.auto_shoot = state
	if state then
		for _, mob in pairs(skin_walkers:GetChildren()) do
			killPlayer(mob)
		end
		shootConnection = skin_walkers.ChildAdded:Connect(function(mob)
			task.wait(0.2)
			killPlayer(mob)
		end)
	else
		shootConnection = disconnectConnection(shootConnection)
	end
end)

-- Lag-Free Auto Store toggle (no killPlayer)
AutoSection:CreateToggle("Auto Store", function(state)
	getgenv().settings.auto_store = state
	if state then
		for _, mob in pairs(skin_walkers:GetChildren()) do
			if store_remote then
				store_remote:FireServer(mob)
			end
		end
		storeConnection = skin_walkers.ChildAdded:Connect(function(mob)
			task.wait(0.2)
			if store_remote then
				store_remote:FireServer(mob)
			end
		end)
	else
		storeConnection = disconnectConnection(storeConnection)
	end
end)

-- Give tool function
local function giveTool(toolName, amount)
	local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
	if not assets then return end
	local tools = assets:FindFirstChild("Tools")
	if not tools then return end
	local tool = tools:FindFirstChild(toolName)
	if not tool then return end
	local clone = tool:Clone()
	if amount and clone:FindFirstChild("Amount") then
		clone.Amount.Value = amount
	end
	clone.Parent = player.Backpack
end

-- Item buttons
ItemSection:CreateButton("Get 999 Cola", function()
	giveTool("Cola", 999)
end)

ItemSection:CreateButton("Get Gatling", function()
	giveTool("Gatling")
end)

ItemSection:CreateButton("Get 999 Snapper", function()
	giveTool("Snapper", 999)
end)

ItemSection:CreateButton("Get 999 Turret", function()
	giveTool("Turret", 999)
end)

-- ESP toggle
local espEnabled = false
ESPSection:CreateToggle("Enable ESP", function(state)
	espEnabled = state
end)

local function createESP(target)
	if not target:IsA("Model") or target:FindFirstChild("ESP") then return end
	local head = target:FindFirstChild("Head")
	if not head then return end
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 100, 0, 20)
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.Parent = head
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "Skinwalker"
	label.TextColor3 = Color3.fromRGB(255, 0, 0)
	label.TextScaled = true
	label.Parent = billboard
end

for _, v in pairs(skin_walkers:GetChildren()) do
	if espEnabled then
		createESP(v)
	end
end

skin_walkers.ChildAdded:Connect(function(child)
	task.wait(0.1)
	if espEnabled then
		createESP(child)
	end
end)

skin_walkers.ChildRemoved:Connect(function(child)
	local head = child:FindFirstChild("Head")
	if head then
		local espGui = head:FindFirstChild("ESP")
		if espGui then
			espGui:Destroy()
		end
	end
end)

-- Teleport to Bank
TeleportSection:CreateButton("Tp To Bank", function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(-51.644474, 128.505463, 454.160614, 0, 0, 1, 0, 1, -0, -1, 0, 0)
	end
end)

-- Credits Section
CreditsSection:CreateButton("Inspired By: Mortalv2 (source code)", function()
	setclipboard("https://youtube.com/@mortalexploits?si=z00zhzpW0uSSdjnL")
end)

CreditsSection:CreateButton("Created & Edited: Maxwell (edited)", function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Notification",
		Text = "Hi :)",
		Duration = 5
	})
end)-- Load Wizard UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
assert(Library, "Failed to load Wizard UI")

-- Create Window and Sections
local Window = Library:NewWindow("Skinwalkers | Version Hub | V1.0")
local AutoSection = Window:NewSection("Auto")
local ItemSection = Window:NewSection("Items")
local ESPSection = Window:NewSection("ESP")
local CreditsSection = Window:NewSection("Credits")
local TeleportSection = Window:NewSection("Teleport")

-- Settings default
getgenv().settings = {
	auto_shoot = true,
	auto_store = true
}

local player = game.Players.LocalPlayer or game:GetService("Players").LocalPlayer
local skin_walkers = workspace:WaitForChild("Runners"):WaitForChild("Skinwalkers")
local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
local shoot_remote = remotes and remotes:FindFirstChild("SniperShot")
local store_remote = remotes and remotes:FindFirstChild("Store")

local function killPlayer(mob)
	local head = mob:FindFirstChild("Head")
	if not head then return end
	if getgenv().settings.auto_shoot and shoot_remote then
		shoot_remote:FireServer(head.Position, head.Position, head)
	end
	if getgenv().settings.auto_store and store_remote then
		store_remote:FireServer(mob)
	end
end

local shootConnection
local storeConnection

local function disconnectConnection(conn)
	if conn then
		conn:Disconnect()
		conn = nil
	end
	return conn
end

-- Auto Shoot toggle
AutoSection:CreateToggle("Auto Shoot", function(state)
	getgenv().settings.auto_shoot = state
	if state then
		for _, mob in pairs(skin_walkers:GetChildren()) do
			killPlayer(mob)
		end
		shootConnection = skin_walkers.ChildAdded:Connect(function(mob)
			task.wait(0.2)
			killPlayer(mob)
		end)
	else
		shootConnection = disconnectConnection(shootConnection)
	end
end)

-- Lag-Free Auto Store toggle (no killPlayer)
AutoSection:CreateToggle("Auto Store", function(state)
	getgenv().settings.auto_store = state
	if state then
		for _, mob in pairs(skin_walkers:GetChildren()) do
			if store_remote then
				store_remote:FireServer(mob)
			end
		end
		storeConnection = skin_walkers.ChildAdded:Connect(function(mob)
			task.wait(0.2)
			if store_remote then
				store_remote:FireServer(mob)
			end
		end)
	else
		storeConnection = disconnectConnection(storeConnection)
	end
end)

-- Give tool function
local function giveTool(toolName, amount)
	local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
	if not assets then return end
	local tools = assets:FindFirstChild("Tools")
	if not tools then return end
	local tool = tools:FindFirstChild(toolName)
	if not tool then return end
	local clone = tool:Clone()
	if amount and clone:FindFirstChild("Amount") then
		clone.Amount.Value = amount
	end
	clone.Parent = player.Backpack
end

-- Item buttons
ItemSection:CreateButton("Get 999 Cola", function()
	giveTool("Cola", 999)
end)

ItemSection:CreateButton("Get Gatling", function()
	giveTool("Gatling")
end)

ItemSection:CreateButton("Get 999 Snapper", function()
	giveTool("Snapper", 999)
end)

ItemSection:CreateButton("Get 999 Turret", function()
	giveTool("Turret", 999)
end)

-- ESP toggle
local espEnabled = false
ESPSection:CreateToggle("Enable ESP", function(state)
	espEnabled = state
end)

local function createESP(target)
	if not target:IsA("Model") or target:FindFirstChild("ESP") then return end
	local head = target:FindFirstChild("Head")
	if not head then return end
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP"
	billboard.Adornee = head
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 100, 0, 20)
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.Parent = head
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "Skinwalker"
	label.TextColor3 = Color3.fromRGB(255, 0, 0)
	label.TextScaled = true
	label.Parent = billboard
end

for _, v in pairs(skin_walkers:GetChildren()) do
	if espEnabled then
		createESP(v)
	end
end

skin_walkers.ChildAdded:Connect(function(child)
	task.wait(0.1)
	if espEnabled then
		createESP(child)
	end
end)

skin_walkers.ChildRemoved:Connect(function(child)
	local head = child:FindFirstChild("Head")
	if head then
		local espGui = head:FindFirstChild("ESP")
		if espGui then
			espGui:Destroy()
		end
	end
end)

-- Teleport to Bank
TeleportSection:CreateButton("Tp To Bank", function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(-51.644474, 128.505463, 454.160614, 0, 0, 1, 0, 1, -0, -1, 0, 0)
	end
end)

-- Credits Section
CreditsSection:CreateButton("Inspired By: Mortalv2 (source code)", function()
	setclipboard("https://youtube.com/@mortalexploits?si=z00zhzpW0uSSdjnL")
end)

CreditsSection:CreateButton("Created & Edited: Maxwell (edited)", function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Notification",
		Text = "Hi :)",
		Duration = 5
	})
end)
