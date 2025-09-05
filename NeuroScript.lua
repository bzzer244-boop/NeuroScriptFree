-- ☀️ NeuroScript —  (Executores PC + Mobile) | PT-BR 
-- GUI quadrada, Speed/Modo, Fly (analógico no mobile), JumpPower, ESP, Spawn TP

-- ========= Serviços =========
local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player     = Players.LocalPlayer

-- ========= Util =========
local function safeChar()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp  = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
	local hum  = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
	return char, hrp, hum
end

local function addNeon(obj)
	local s = Instance.new("UIStroke")
	s.Thickness = 2
	s.Color = Color3.fromRGB(0,255,255)
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = obj
end

local function toast(t)
	pcall(function()
		StarterGui:SetCore("SendNotification", {Title="NeuroScript", Text=t, Duration=3})
	end)
end

-- ========= Spawn salvo =========
local savedSpawnCF = nil
local function captureSpawnCF()
	task.defer(function()
		local _, hrp = safeChar()
		if hrp and not savedSpawnCF then savedSpawnCF = hrp.CFrame end
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
gui.IgnoreGuiInset = false
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela quadrada (responsiva)
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UIS.TouchEnabled and UDim2.fromScale(0.9, 0.9) or UDim2.new(0, 460, 0, 460)
frame.BackgroundColor3 = Color3.fromRGB(10,15,35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
addNeon(frame)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)
local ar = Instance.new("UIAspectRatioConstraint")
ar.AspectRatio = 1
ar.Parent = frame

-- Topbar
local bar = Instance.new("Frame")
bar.Size = UDim2.new(1,0,0,48)
bar.BackgroundColor3 = Color3.fromRGB(15,20,50)
bar.BorderSizePixel = 0
bar.Parent = frame
addNeon(bar)
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,16)

-- Logo (ID Roblox)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,30,0,30)
logo.Position = UDim2.new(0,10,0.5,-15)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://131783094153867"
logo.Parent = bar
local logoAR = Instance.new("UIAspectRatioConstraint", logo); logoAR.AspectRatio = 1

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-150,1,0)
title.Position = UDim2.new(0,50,0,0)
title.BackgroundTransparency = 1
title.Text = "🤖⚡ NeuroScript — SCP"
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = bar

-- 🇧🇷
local flag = Instance.new("TextLabel")
flag.Size = UDim2.new(0,28,0,28)
flag.Position = UDim2.new(1,-120,0.5,-14)
flag.BackgroundTransparency = 1
flag.Text = "🇧🇷"
flag.TextScaled = true
flag.Parent = bar

-- Minimizar e Fechar
local btnMin = Instance.new("TextButton")
btnMin.Size = UDim2.new(0,36,0,36)
btnMin.Position = UDim2.new(1,-72,0.5,-18)
btnMin.BackgroundColor3 = Color3.fromRGB(40,50,90)
btnMin.Text = "—"
btnMin.TextColor3 = Color3.fromRGB(0,255,255)
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 22
btnMin.Parent = bar
addNeon(btnMin)
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(0,36,0,36)
btnClose.Position = UDim2.new(1,-36,0.5,-18)
btnClose.BackgroundColor3 = Color3.fromRGB(40,50,90)
btnClose.Text = "✖"
btnClose.TextColor3 = Color3.fromRGB(0,255,255)
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 20
btnClose.Parent = bar
addNeon(btnClose)
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1,0)

btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Botão minimizado (flutuante)
local mini = Instance.new("Frame")
mini.Name = "Mini"
mini.Visible = false
mini.Size = UDim2.new(0,220,0,56)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(15,20,50)
mini.Parent = gui
addNeon(mini)
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,16)
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
mini.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		mini.Visible=false; frame.Visible=true
	end
end)
btnMin.MouseButton1Click:Connect(function()
	frame.Visible=false
	mini.Visible=true
end)

-- Arrastar (PC + Mobile)
do
	local dragging, dragStart, startPos = false, nil, nil
	bar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = i.Position; startPos = frame.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

-- Corpo
local body = Instance.new("Frame")
body.Size = UDim2.new(1,-20,1,-58)
body.Position = UDim2.new(0,10,0,56)
body.BackgroundTransparency = 1
body.Parent = frame

local function makeBtn(text, xScale, yScale, wScale, hScale)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(wScale or 0.48, 0, hScale or 0.16, 0)
	b.Position = UDim2.new(xScale, 0, yScale, 0)
	b.BackgroundColor3 = Color3.fromRGB(20,30,60)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.AutoButtonColor = true
	b.Parent = body
	addNeon(b)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	return b
end

local function makeBox(ph, xScale, yScale, wScale)
	local tb = Instance.new("TextBox")
	tb.Size = UDim2.new(wScale or 0.48,0,0.14,0)
	tb.Position = UDim2.new(xScale,0,yScale,0)
	tb.BackgroundColor3 = Color3.fromRGB(20,30,60)
	tb.Text = ph
	tb.PlaceholderText = ph
	tb.TextColor3 = Color3.fromRGB(255,255,255)
	tb.Font = Enum.Font.Gotham
	tb.TextSize = 16
	tb.ClearTextOnFocus = true
	tb.Parent = body
	addNeon(tb)
	Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)
	return tb
end

-- ===== Botões principais =====
local btnSpawn   = makeBtn("🏠 Teleport Spawn", 0.00, 0.00)
local btnSpeed   = makeBtn("⚡ Speed: OFF",     0.52, 0.00)
local btnSpeedMd = makeBtn("🛠 Modo Speed: WalkSpeed", 0.00, 0.20, 0.48, 0.16)
local btnFly     = makeBtn("🕊 Fly: OFF",       0.52, 0.20)
local btnJump    = makeBtn("🦘 Jump: OFF",      0.00, 0.40)
local btnESP     = makeBtn("👥 ESP: OFF",       0.52, 0.40)

-- ===== Inputs =====
local speedBox = makeBox("Speed (ex: 80)", 0.00, 0.62, 0.48)
local flyBox   = makeBox("Fly (ex: 100)",  0.52, 0.62, 0.48)
local jumpBox  = makeBox("Jump (ex: 70)",  0.00, 0.80, 0.48)

-- ========= Estados =========
local speedOn = false
local speedMode = "WalkSpeed"   -- "WalkSpeed" | "Velocity"
local targetSpeed = 80

local flying = false
local flySpeed = 100
local bv, bg
local flyConn -- RenderStepped connection para fly

local jumpOn = false
local jumpPow = 70

local espOn = false
local espFolder = Instance.new("Folder"); espFolder.Name = "Neuro_ESP"; espFolder.Parent = workspace

-- ========= Teleport Spawn =========
btnSpawn.MouseButton1Click:Connect(function()
	local _, hrp = safeChar()
	if savedSpawnCF and hrp then
		hrp.CFrame = savedSpawnCF + Vector3.new(0,5,0)
	else
		toast("Spawn ainda não salvo (respawna uma vez).")
	end
end)

-- ========= SPEED =========
btnSpeed.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	btnSpeed.Text = speedOn and "⚡ Speed: ON" or "⚡ Speed: OFF"
end)

btnSpeedMd.MouseButton1Click:Connect(function()
	speedMode = (speedMode=="WalkSpeed") and "Velocity" or "WalkSpeed"
	btnSpeedMd.Text = "🛠 Modo Speed: "..speedMode
end)

speedBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(speedBox.Text)
		if v and v>0 and v<=1000 then
			targetSpeed = v
			speedOn = true
			btnSpeed.Text = "⚡ Speed: ON"
			speedBox.Text = "Speed = "..v
		else
			speedBox.Text = "Valor inválido!"
		end
	end
end)

-- WalkSpeed keeper (suave)
task.spawn(function()
	while task.wait(0.15) do
		if speedOn and speedMode=="WalkSpeed" then
			local _,_,hum = safeChar()
			if hum and hum.WalkSpeed ~= targetSpeed then
				hum.WalkSpeed = targetSpeed
			end
		end
	end
end)

-- Velocity mode (usa analógico no mobile)
RunService.RenderStepped:Connect(function()
	if speedOn and speedMode=="Velocity" then
		local _, hrp, hum = safeChar()
		local dir = hum.MoveDirection
		if dir.Magnitude > 0.01 then
			local v = hrp.AssemblyLinearVelocity
			local horiz = (dir.Unit * targetSpeed)
			hrp.AssemblyLinearVelocity = Vector3.new(horiz.X, v.Y, horiz.Z)
		end
	end
end)

-- ========= FLY =========
-- Botões subir/descer (apenas mobile)
local flyHUD = Instance.new("Frame")
flyHUD.Name = "FlyHUD"
flyHUD.Visible = false
flyHUD.Parent = gui
flyHUD.AnchorPoint = Vector2.new(1,1)
flyHUD.Position = UDim2.new(1,-12,1,-12)
flyHUD.Size = UDim2.new(0,120,0,120)
flyHUD.BackgroundTransparency = 1

local function makeCircle(txt, pos)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,54,0,54)
	b.Position = pos
	b.BackgroundColor3 = Color3.fromRGB(30,45,90)
	b.Text = txt
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 22
	b.Parent = flyHUD
	addNeon(b)
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	return b
end

local btnUp   = makeCircle("↑", UDim2.new(1,-56,0,0))
local btnDown = makeCircle("↓", UDim2.new(1,-56,0,62))

local upHeld, downHeld = false, false
btnUp.MouseButton1Down:Connect(function()   upHeld = true end)
btnUp.MouseButton1Up:Connect(function()     upHeld = false end)
btnDown.MouseButton1Down:Connect(function() downHeld = true end)
btnDown.MouseButton1Up:Connect(function()   downHeld = false end)

local function startFly()
	local _, hrp, hum = safeChar()

	bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.zero
	bv.MaxForce = Vector3.new(1e5,1e5,1e5)
	bv.Parent = hrp

	bg = Instance.new("BodyGyro")
	bg.CFrame = hrp.CFrame
	bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
	bg.P = 1e4
	bg.Parent = hrp

	flying = true
	if UIS.TouchEnabled then flyHUD.Visible = true end

	-- Evita conexões múltiplas
	if flyConn then flyConn:Disconnect() flyConn = nil end

	flyConn = RunService.RenderStepped:Connect(function()
		if not flying then return end
		local cam = workspace.CurrentCamera and workspace.CurrentCamera.CFrame or hrp.CFrame
		local mv = Vector3.new()

		-- PC (teclado)
		if UIS:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - Vector3.new(0,1,0) end

		-- Mobile (analógico MoveDirection + botões ↑/↓)
		if hum and hum.MoveDirection.Magnitude > 0 then
			-- usa direção horizontal do analógico
			local dir = hum.MoveDirection
			mv = Vector3.new(dir.X, mv.Y, dir.Z)
		end
		if upHeld   then mv = mv + Vector3.new(0,1,0) end
		if downHeld then mv = mv - Vector3.new(0,1,0) end

		if mv.Magnitude > 0 then
			bv.Velocity = mv.Unit * flySpeed
		else
			bv.Velocity = Vector3.zero
		end
		bg.CFrame = cam
	end)
end

local function stopFly()
	flying = false
	upHeld, downHeld = false, false
	if flyHUD then flyHUD.Visible = false end
	if flyConn then flyConn:Disconnect() flyConn = nil end
	if bv then bv:Destroy() bv = nil end
	if bg then bg:Destroy() bg = nil end
end

btnFly.MouseButton1Click:Connect(function()
	if flying then
		stopFly(); btnFly.Text="🕊 Fly: OFF"
	else
		startFly(); btnFly.Text="🕊 Fly: ON"
	end
end)

flyBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(flyBox.Text)
		if v and v>0 and v<=1500 then
			flySpeed = v
			flyBox.Text = "Fly = "..v
		else
			flyBox.Text = "Valor inválido!"
		end
	end
end)

-- ========= JUMP =========
btnJump.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	btnJump.Text = jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
	if jumpOn then
		local _,_,hum = safeChar()
		hum.UseJumpPower = true
		hum.JumpPower = jumpPow
	end
end)

jumpBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(jumpBox.Text)
		if v and v>0 and v<=500 then
			jumpPow = v
			jumpBox.Text = "Jump = "..v
			if jumpOn then local _,_,hum=safeChar(); hum.UseJumpPower=true; hum.JumpPower=v end
		else
			jumpBox.Text = "Valor inválido!"
		end
	end
end)

-- ========= ESP =========
local function makeESPFor(char, plr)
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end

	local bb = Instance.new("BillboardGui")
	bb.Name = "Neuro_BB"
	bb.Size = UDim2.new(0,200,0,40)
	bb.StudsOffsetWorldSpace = Vector3.new(0,3,0)
	bb.AlwaysOnTop = true
	bb.Adornee = head
	bb.Parent = espFolder

	local tl = Instance.new("TextLabel")
	tl.Size = UDim2.new(1,0,1,0)
	tl.BackgroundTransparency = 1
	tl.Text = "👥 "..(plr.DisplayName or plr.Name)
	tl.TextColor3 = Color3.fromRGB(0,255,255)
	tl.Font = Enum.Font.GothamBold
	tl.TextSize = 18
	tl.Parent = bb

	local hl = Instance.new("Highlight")
	hl.Name = "Neuro_HL"
	hl.Adornee = char
	hl.FillTransparency = 1
	hl.OutlineTransparency = 0
	hl.OutlineColor = Color3.fromRGB(0,255,255)
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = espFolder

	char.AncestryChanged:Connect(function(_, parent)
		if not parent then
			if bb then bb:Destroy() end
			if hl then hl:Destroy() end
		end
	end)
end

local function refreshESP()
	espFolder:ClearAllChildren()
	if not espOn then return end
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= player then
			local char = plr.Character
			if char then makeESPFor(char, plr) end
			plr.CharacterAdded:Connect(function(c) if espOn then task.wait(0.2); makeESPFor(c, plr) end end)
		end
	end
end

btnESP.MouseButton1Click:Connect(function()
	espOn = not espOn
	btnESP.Text = espOn and "👥 ESP: ON" or "👥 ESP: OFF"
	refreshESP()
end)

Players.PlayerAdded:Connect(function(plr)
	if espOn and plr ~= player then
		plr.CharacterAdded:Connect(function(c)
			task.wait(0.2)
			if espOn then makeESPFor(c, plr) end
		end)
	end
end)

Players.PlayerRemoving:Connect(function()
	if espOn then refreshESP() end
end)

-- ========= Pós-respawn =========
player.CharacterAdded:Connect(function(char)
	task.wait(0.4)
	if speedOn and speedMode=="WalkSpeed" then
		local hum = char:WaitForChild("Humanoid")
		hum.WalkSpeed = targetSpeed
	end
	if jumpOn then
		local hum = char:WaitForChild("Humanoid")
		hum.UseJumpPower = true
		hum.JumpPower = jumpPow
	end
	if espOn then
		task.wait(0.2)
		refreshESP()
	end
	-- Reaplica Fly se estava ligado (opcional: comente se não quiser)
	if flying then
		stopFly()
		startFly()
	end
end)
