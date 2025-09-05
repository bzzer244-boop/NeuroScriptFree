-- 🇧🇷✅ NeuroScript (Edição Segura/Dev) — GUI PC/Mobile
-- Coloque em StarterPlayerScripts (para jogos próprios/teste)

-- ========= Serviços =========
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- ========= Util =========
local function safeChar()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
	return char, hrp, hum
end

local function addNeon(obj)
	local s = Instance.new("UIStroke")
	s.Thickness = 2
	s.Color = Color3.fromRGB(0,255,255)
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = obj
end

-- ========= Spawn salvo =========
local savedSpawnCF = nil
local function captureSpawnCF()
	task.defer(function()
		local char, hrp = safeChar()
		if hrp and not savedSpawnCF then
			savedSpawnCF = hrp.CFrame
		end
	end)
end
player.CharacterAdded:Connect(function()
	task.wait(0.25)
	captureSpawnCF()
end)
if player.Character then captureSpawnCF() end

-- ========= GUI =========
local gui = Instance.new("ScreenGui")
gui.Name = "NeuroScriptGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela principal (quadrada)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 420)
frame.Position = UDim2.new(0.5, -210, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(10,15,35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
addNeon(frame)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,16)
corner.Parent = frame

-- Topbar
local bar = Instance.new("Frame")
bar.Size = UDim2.new(1,0,0,44)
bar.BackgroundColor3 = Color3.fromRGB(15,20,50)
bar.BorderSizePixel = 0
bar.Parent = frame
addNeon(bar)
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0,16)
barCorner.Parent = bar

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,28,0,28)
logo.Position = UDim2.new(0,8,0.5,-14)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://131783094153867" -- sua logo
logo.Parent = bar

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-140,1,0)
title.Position = UDim2.new(0,45,0,0)
title.BackgroundTransparency = 1
title.Text = "🤖⚡ NeuroScript — Dev Tools"
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = bar

-- Bandeira do Brasil
local flag = Instance.new("ImageLabel")
flag.Size = UDim2.new(0,28,0,28)
flag.Position = UDim2.new(1,-36,0.5,-14)
flag.BackgroundTransparency = 1
flag.Image = "rbxassetid://1095708" -- bandeira Brasil
flag.Parent = bar

-- Botão Fechar
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,35,0,35)
close.Position = UDim2.new(1,-80,0.5,-17)
close.BackgroundColor3 = Color3.fromRGB(40,50,90)
close.Text = "✖"
close.TextColor3 = Color3.fromRGB(0,255,255)
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.Parent = bar
addNeon(close)
local closeC = Instance.new("UICorner"); closeC.CornerRadius = UDim.new(1,0); closeC.Parent = close
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Botão Minimizar
local min = Instance.new("TextButton")
min.Size = UDim2.new(0,35,0,35)
min.Position = UDim2.new(1,-120,0.5,-17)
min.BackgroundColor3 = Color3.fromRGB(40,50,90)
min.Text = "—"
min.TextColor3 = Color3.fromRGB(0,255,255)
min.Font = Enum.Font.GothamBold
min.TextSize = 20
min.Parent = bar
addNeon(min)
local minC = Instance.new("UICorner"); minC.CornerRadius = UDim.new(1,0); minC.Parent = min

-- Botão reduzido
local mini = Instance.new("Frame")
mini.Size = UDim2.new(0,200,0,50)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(15,20,50)
mini.Visible = false
mini.Parent = gui
addNeon(mini)
local miniC = Instance.new("UICorner"); miniC.CornerRadius = UDim.new(0,12); miniC.Parent = mini

local miniLogo = Instance.new("ImageLabel")
miniLogo.Size = UDim2.new(0,28,0,28)
miniLogo.Position = UDim2.new(0,10,0.5,-14)
miniLogo.BackgroundTransparency = 1
miniLogo.Image = "rbxassetid://131783094153867"
miniLogo.Parent = mini

local miniT = Instance.new("TextLabel")
miniT.Size = UDim2.new(1,-46,1,0)
miniT.Position = UDim2.new(0,46,0,0)
miniT.BackgroundTransparency = 1
miniT.Text = "🤖⚡ NeuroScript"
miniT.TextColor3 = Color3.fromRGB(0,255,255)
miniT.Font = Enum.Font.GothamSemibold
miniT.TextSize = 20
miniT.TextXAlignment = Enum.TextXAlignment.Left
miniT.Parent = mini

min.MouseButton1Click:Connect(function() frame.Visible=false mini.Visible=true end)
mini.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then mini.Visible=false frame.Visible=true end
end)

-- Container
local body = Instance.new("Frame")
body.Size = UDim2.new(1,-20,1,-70)
body.Position = UDim2.new(0,10,0,55)
body.BackgroundTransparency = 1
body.Parent = frame

local function makeBtn(text, row, col)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.48,0,0,42)
	b.Position = UDim2.new(col==1 and 0 or 0.52, 0, row*0.18, 0)
	b.BackgroundColor3 = Color3.fromRGB(20,30,60)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 17
	b.Parent = body
	addNeon(b)
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = b
	b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(30,50,90) end)
	b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(20,30,60) end)
	return b
end

-- ===== Inputs =====
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.48,0,0,36)
speedBox.Position = UDim2.new(0,0,0.82,0)
speedBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
speedBox.Text = "Velocidade chão (ex: 80)"
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.Font = Enum.Font.Gotham
speedBox.PlaceholderText = "ex: 80"
speedBox.TextSize = 16
speedBox.Parent = body
addNeon(speedBox)
local sbC = Instance.new("UICorner"); sbC.CornerRadius = UDim.new(0,10); sbC.Parent = speedBox

local flyBox = Instance.new("TextBox")
flyBox.Size  = UDim2.new(0.48,0,0,36)
flyBox.Position = UDim2.new(0.52,0,0.82,0)
flyBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
flyBox.Text = "Velocidade Fly (ex: 100)"
flyBox.TextColor3 = Color3.fromRGB(255,255,255)
flyBox.Font = Enum.Font.Gotham
flyBox.PlaceholderText = "ex: 100"
flyBox.TextSize = 16
flyBox.Parent = body
addNeon(flyBox)
local fbC = Instance.new("UICorner"); fbC.CornerRadius = UDim.new(0,10); fbC.Parent = flyBox

local jumpBox = Instance.new("TextBox")
jumpBox.Size  = UDim2.new(0.48,0,0,36)
jumpBox.Position = UDim2.new(0,0,0.9,0)
jumpBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
jumpBox.Text = "Força do Pulo (ex: 70)"
jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
jumpBox.Font = Enum.Font.Gotham
jumpBox.PlaceholderText = "ex: 70"
jumpBox.TextSize = 16
jumpBox.Parent = body
addNeon(jumpBox)
local jbC = Instance.new("UICorner"); jbC.CornerRadius = UDim.new(0,10); jbC.Parent = jumpBox

-- ===== Botões =====
local btnSpawn   = makeBtn("🏠 Auto Spawn (TP)",    0,1)
local btnSpeed   = makeBtn("⚡ Velocidade: OFF",    0,2)
local btnSpeedMd = makeBtn("🛠 Modo Velocidade: WalkSpeed", 1,1)
local btnFly     = makeBtn("🕊 Fly: OFF",           1,2)
local btnESP     = makeBtn("👥 ESP Jogadores: OFF", 2,1)

-- ========= Estados =========
local speedOn = false
local speedMode = "WalkSpeed"
local targetSpeed = 80
local flying = false
local flySpeed = 100
local bv, bg
local jumpPower = 70
local espOn = false
local espFolder = Instance.new("Folder"); espFolder.Name = "Neuro_ESP"; espFolder.Parent = workspace

-- ========= Funções principais (speed, fly, jump, ESP) =========
-- (mesmo esquema que já te mandei antes, só ajustado)

-- ========= Inputs =========
speedBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(speedBox.Text)
		if v then targetSpeed=v; btnSpeed.Text="⚡ Velocidade: ON"; speedOn=true; end
	end
end)
flyBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(flyBox.Text)
		if v then flySpeed=v; flyBox.Text="Fly = "..v end
	end
end)
jumpBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(jumpBox.Text)
		if v then jumpPower=v; jumpBox.Text="Pulo = "..v end
	end
end)

-- (resto do código = manter o que já fizemos: speed loop, fly loop, ESP, etc.)
