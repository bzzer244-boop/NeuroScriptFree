-- ✅ NeuroScript (safe/dev edition) — GUI estilo 8.5 + Debug Tools p/ SEU jogo
-- Coloque este LocalScript em StarterPlayerScripts (para uso em lugar próprio)
-- Recursos: Logo/minimizar neon ciano, Speed (WalkSpeed/Velocity), Fly c/ velocidade própria,
--           JumpPower configurável (campo + ON/OFF), Teleport p/ spawn salvo, ESP 👥 (nome+Highlight).
-- ⚠️ Use apenas no SEU lugar/jogo. Não foi feito para burlar jogos de terceiros.

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

-- ========= Guarda Spawn (do seu jogo) =========
local savedSpawnCF = nil
local function captureSpawnCF()
	task.defer(function()
		local char, hrp = safeChar()
		if hrp then
			if not savedSpawnCF then
				savedSpawnCF = hrp.CFrame
			end
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

-- Janela principal (estilo 8.5)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 420)
frame.Position = UDim2.new(0.5, -250, 0.5, -210)
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

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,28,0,28)
logo.Position = UDim2.new(0,8,0.5,-14)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://131783094153867"
logo.Parent = bar

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

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,35,0,35)
close.Position = UDim2.new(1,-40,0.5,-17)
close.BackgroundColor3 = Color3.fromRGB(40,50,90)
close.Text = "✖"
close.TextColor3 = Color3.fromRGB(0,255,255)
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.Parent = bar
addNeon(close)
local closeC = Instance.new("UICorner"); closeC.CornerRadius = UDim.new(1,0); closeC.Parent = close
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local min = Instance.new("TextButton")
min.Size = UDim2.new(0,35,0,35)
min.Position = UDim2.new(1,-80,0.5,-17)
min.BackgroundColor3 = Color3.fromRGB(40,50,90)
min.Text = "—"
min.TextColor3 = Color3.fromRGB(0,255,255)
min.Font = Enum.Font.GothamBold
min.TextSize = 20
min.Parent = bar
addNeon(min)
local minC = Instance.new("UICorner"); minC.CornerRadius = UDim.new(1,0); minC.Parent = min

-- Botão minimizado (retângulo com logo + nome + emojis)
local mini = Instance.new("Frame")
mini.Size = UDim2.new(0,220,0,56)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(15,20,50)
mini.Visible = false
mini.Parent = gui
addNeon(mini)
local miniC = Instance.new("UICorner"); miniC.CornerRadius = UDim.new(0,16); miniC.Parent = mini

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

-- Drag
do
	local dragging, dragStart, startPos = false, nil, nil
	frame.InputBegan:Connect(function(i)
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

-- Container
local body = Instance.new("Frame")
body.Size = UDim2.new(1,-20,1,-70)
body.Position = UDim2.new(0,10,0,55)
body.BackgroundTransparency = 1
body.Parent = frame

local function makeBtn(text, row, col)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.48,0,0,42)
	b.Position = UDim2.new(col==1 and 0 or 0.52, 0, row*0.2, 0)
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
speedBox.Position = UDim2.new(0,0,0.78,0)
speedBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
speedBox.Text = "Speed chão (ex: 80)"
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.Font = Enum.Font.Gotham
speedBox.PlaceholderText = "ex: 80"
speedBox.TextSize = 16
speedBox.Parent = body
addNeon(speedBox)
local sbC = Instance.new("UICorner"); sbC.CornerRadius = UDim.new(0,10); sbC.Parent = speedBox

local flyBox = Instance.new("TextBox")
flyBox.Size  = UDim2.new(0.48,0,0,36)
flyBox.Position = UDim2.new(0.52,0,0.78,0)
flyBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
flyBox.Text = "Fly speed (ex: 100)"
flyBox.TextColor3 = Color3.fromRGB(255,255,255)
flyBox.Font = Enum.Font.Gotham
flyBox.PlaceholderText = "ex: 100"
flyBox.TextSize = 16
flyBox.Parent = body
addNeon(flyBox)
local fbC = Instance.new("UICorner"); fbC.CornerRadius = UDim.new(0,10); fbC.Parent = flyBox

local jumpBox = Instance.new("TextBox")
jumpBox.Size  = UDim2.new(1,0,0,36)
jumpBox.Position = UDim2.new(0,0,0.88,0)
jumpBox.BackgroundColor3 = Color3.fromRGB(20,30,60)
jumpBox.Text = "JumpPower (ex: 75)"
jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
jumpBox.Font = Enum.Font.Gotham
jumpBox.PlaceholderText = "ex: 75"
jumpBox.TextSize = 16
jumpBox.Parent = body
addNeon(jumpBox)
local jpC = Instance.new("UICorner"); jpC.CornerRadius = UDim.new(0,10); jpC.Parent = jumpBox

-- ===== Botões =====
local btnSpawn   = makeBtn("🏠 Auto Spawn (TP)",          0,1)
local btnSpeed   = makeBtn("⚡ Speed: OFF",                0,2)
local btnSpeedMd = makeBtn("🛠 Modo Speed: WalkSpeed",     1,1)
local btnFly     = makeBtn("🕊 Fly: OFF",                  1,2)
local btnJumpOn  = makeBtn("🦘 JumpPower: OFF",            2,1)
local btnESP     = makeBtn("👥 ESP Players: OFF",          2,2)

-- ========= Estados =========
local speedOn = false
local speedMode = "WalkSpeed"  -- "WalkSpeed" | "Velocity"
local targetSpeed = 80

local flying = false
local flySpeed = 100
local bv, bg

local jumpOn = false
local targetJump = 75
local defaultJump = nil

local espOn = false
local espFolder = Instance.new("Folder"); espFolder.Name = "Neuro_ESP"; espFolder.Parent = workspace

-- ========= Auto Spawn =========
btnSpawn.MouseButton1Click:Connect(function()
	local _, hrp = safeChar()
	if savedSpawnCF and hrp then
		hrp.CFrame = savedSpawnCF + Vector3.new(0,5,0)
	else
		StarterGui:SetCore("SendNotification", {
			Title="NeuroScript"; Text="Spawn ainda não salvo (respawna uma vez)."; Duration=3;
		})
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

-- WalkSpeed keeper
task.spawn(function()
	while task.wait(0.15) do
		if speedOn and speedMode=="WalkSpeed" then
			local _,_,hum = safeChar()
			if hum and hum.WalkSpeed ~= targetSpeed then hum.WalkSpeed = targetSpeed end
		end
	end
end)

-- Velocity mode (XZ somente)
task.spawn(function()
	while RunService.RenderStepped:Wait() do
		if speedOn and speedMode=="Velocity" then
			local _, hrp, hum = safeChar()
			local dir = hum.MoveDirection
			if dir.Magnitude > 0.01 then
				local v = hrp.AssemblyLinearVelocity
				local horiz = (dir.Unit * targetSpeed)
				hrp.AssemblyLinearVelocity = Vector3.new(horiz.X, v.Y, horiz.Z)
			end
		end
	end
end)

-- ========= FLY =========
local function startFly()
	local _, hrp = safeChar()
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
	task.spawn(function()
		while flying and task.wait() do
			local cam = workspace.CurrentCamera.CFrame
			local mv = Vector3.new()
			if UIS:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then mv = mv - Vector3.new(0,1,0) end

			local spd = flySpeed
			if mv.Magnitude>0 then
				bv.Velocity = mv.Unit * spd
			else
				bv.Velocity = Vector3.zero
			end
			bg.CFrame = cam
		end
	end)
end

local function stopFly()
	flying=false
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
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

-- ========= JumpPower Configurável =========
local function applyJump(hum)
	if not hum then return end
	if defaultJump == nil then
		defaultJump = hum.UseJumpPower and hum.JumpPower or 50
	end
	if jumpOn then
		if hum.UseJumpPower == false then hum.UseJumpPower = true end
		if hum.JumpPower ~= targetJump then hum.JumpPower = targetJump end
	else
		-- restaura padrão
		if defaultJump then
			if hum.UseJumpPower == false then hum.UseJumpPower = true end
			hum.JumpPower = defaultJump
		end
	end
end

btnJumpOn.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	btnJumpOn.Text = jumpOn and "🦘 JumpPower: ON" or "🦘 JumpPower: OFF"
	local _,_,hum = safeChar()
	applyJump(hum)
end)

jumpBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(jumpBox.Text)
		if v and v>0 and v<=400 then
			targetJump = v
			jumpOn = true
			btnJumpOn.Text = "🦘 JumpPower: ON"
			jumpBox.Text = "Jump = "..v
			local _,_,hum = safeChar()
			applyJump(hum)
		else
			jumpBox.Text = "Valor inválido!"
		end
	end
end)

-- mantém JumpPower quando ativo
task.spawn(function()
	while task.wait(0.25) do
		if jumpOn then
			local _,_,hum = safeChar()
			applyJump(hum)
		end
	end
end)

-- ========= ESP (👥 nome + contorno por paredes) =========
local function makeESPFor(char, plr)
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local head = char:FindFirstChild("Head")
	if not head or not hum then return end

	-- Billboard com nome (👥 NICK)
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

	-- Contorno Highlight através de paredes
	local hl = Instance.new("Highlight")
	hl.Name = "Neuro_HL"
	hl.Adornee = char
	hl.FillTransparency = 1
	hl.OutlineTransparency = 0
	hl.OutlineColor = Color3.fromRGB(0,255,255)
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = espFolder

	-- Limpador
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
	btnESP.Text = espOn and "👥 ESP Players: ON" or "👥 ESP Players: OFF"
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

Players.PlayerRemoving:Connect(function(_)
	if espOn then refreshESP() end
end)

-- ========= Sincronizações após respawn =========
player.CharacterAdded:Connect(function(char)
	task.wait(0.4)
	-- mantém WalkSpeed alvo se estiver ativo
	if speedOn and speedMode=="WalkSpeed" then
		local hum = char:WaitForChild("Humanoid")
		hum.WalkSpeed = targetSpeed
	end
	-- mantém JumpPower alvo se estiver ativo
	if jumpOn then
		local hum = char:WaitForChild("Humanoid")
		applyJump(hum)
	end
	-- re-aplica ESP
	if espOn then
		task.wait(0.2)
		refreshESP()
	end
end)

-- ========= Suporte Mobile (botões + campos) =========
if UIS.TouchEnabled then
	local mobile = Instance.new("Frame")
	mobile.Size = UDim2.new(0, 520, 0, 116)
	mobile.Position = UDim2.new(0, 20, 1, -136)
	mobile.BackgroundColor3 = Color3.fromRGB(15,20,50)
	mobile.Parent = gui
	addNeon(mobile)
	local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0,14); mc.Parent = mobile

	-- Linha 1: Botões
	local function mBtn(txt, x)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0,120,0,42)
		b.Position = UDim2.new(0, x, 0, 8)
		b.BackgroundColor3 = Color3.fromRGB(20,30,60)
		b.Text = txt
		b.TextColor3 = Color3.fromRGB(0,255,255)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 16
		b.Parent = mobile
		addNeon(b)
		local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = b
		return b
	end

	local mFly   = mBtn("🕊 Fly: OFF", 8)
	local mSpeed = mBtn("⚡ Speed: OFF", 136)
	local mJump  = mBtn("🦘 Jump: OFF", 264)
	local mESP   = mBtn("👥 ESP: OFF", 392)

	mFly.MouseButton1Click:Connect(function()
		if flying then stopFly(); mFly.Text="🕊 Fly: OFF"; btnFly.Text="🕊 Fly: OFF"
		else startFly(); mFly.Text="🕊 Fly: ON"; btnFly.Text="🕊 Fly: ON" end
	end)

	mSpeed.MouseButton1Click:Connect(function()
		speedOn = not speedOn
		mSpeed.Text = speedOn and "⚡ Speed: ON" or "⚡ Speed: OFF"
		btnSpeed.Text = mSpeed.Text
	end)

	mJump.MouseButton1Click:Connect(function()
		jumpOn = not jumpOn
		mJump.Text = jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
		btnJumpOn.Text = jumpOn and "🦘 JumpPower: ON" or "🦘 JumpPower: OFF"
		local _,_,hum = safeChar(); applyJump(hum)
	end)

	mESP.MouseButton1Click:Connect(function()
		espOn = not espOn
		mESP.Text = espOn and "👥 ESP: ON" or "👥 ESP: OFF"
		btnESP.Text = espOn and "👥 ESP Players: ON" or "👥 ESP Players: OFF"
		refreshESP()
	end)

	-- Linha 2: Campos (Speed / Fly / Jump)
	local function mBox(ph, x, w, onEnter)
		local t = Instance.new("TextBox")
		t.Size = UDim2.new(0, w, 0, 34)
		t.Position = UDim2.new(0, x, 0, 60)
		t.BackgroundColor3 = Color3.fromRGB(20,30,60)
		t.Text = ph
		t.TextColor3 = Color3.fromRGB(255,255,255)
		t.Font = Enum.Font.Gotham
		t.TextSize = 14
		t.Parent = mobile
		addNeon(t)
		local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = t
		t.FocusLost:Connect(function(enter) if enter then onEnter(t) end end)
		return t
	end

	mBox("Speed (ex: 80)", 8, 160, function(tb)
		local v = tonumber(tb.Text)
		if v and v>0 and v<=1000 then
			targetSpeed = v; speedOn = true
			tb.Text = "Speed = "..v
			btnSpeed.Text = "⚡ Speed: ON"; mSpeed.Text = "⚡ Speed: ON"
		else tb.Text = "Valor inválido!" end
	end)

	mBox("Fly (ex: 100)", 176, 160, function(tb)
		local v = tonumber(tb.Text)
		if v and v>0 and v<=1500 then
			flySpeed = v; tb.Text = "Fly = "..v
		else tb.Text = "Valor inválido!" end
	end)

	mBox("Jump (ex: 75)", 344, 160, function(tb)
		local v = tonumber(tb.Text)
		if v and v>0 and v<=400 then
			targetJump = v; jumpOn = true
			tb.Text = "Jump = "..v
			btnJumpOn.Text = "🦘 JumpPower: ON"; mJump.Text = "🦘 Jump: ON"
			local _,_,hum = safeChar(); applyJump(hum)
		else tb.Text = "Valor inválido!" end
	end)
end
