-- ☀️ NeuroScript — (Executores PC + Mobile) | PT-BR
-- Fly (antigo, ajustado pro GUI novo), Speed, JumpPower, ESP, Anti-Detection.

-- ========= Serviços =========
local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local StarterGui   = game:GetService("StarterGui")
local ScriptContext= game:GetService("ScriptContext")
local player       = Players.LocalPlayer

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

-- ========= GUI =========
local gui = Instance.new("ScreenGui")
gui.Name = "NeuroScriptGui"
gui.IgnoreGuiInset = false
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela quadrada
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

-- Logo
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,30,0,30)
logo.Position = UDim2.new(0,10,0.5,-15)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://131783094153867"
logo.Parent = bar
local logoAR = Instance.new("UIAspectRatioConstraint", logo); logoAR.AspectRatio = 1

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-160,1,0)
title.Position = UDim2.new(0,50,0,0)
title.BackgroundTransparency = 1
title.Text = "🤖⚡ NeuroScript — SCP"
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = bar

-- Minimizar
local btnMin = Instance.new("TextButton")
btnMin.Size = UDim2.new(0,36,0,36)
btnMin.Position = UDim2.new(1,-80,0.5,-18)
btnMin.BackgroundColor3 = Color3.fromRGB(40,50,90)
btnMin.Text = "—"
btnMin.TextColor3 = Color3.fromRGB(0,255,255)
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 22
btnMin.Parent = bar
addNeon(btnMin)
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

-- Fechar
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

-- Mini GUI
local mini = Instance.new("Frame")
mini.Name = "Mini"
mini.Visible = false
mini.Size = UDim2.new(0,240,0,56)
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
local miniLogoAR = Instance.new("UIAspectRatioConstraint", miniLogo); miniLogoAR.AspectRatio = 1

local miniText = Instance.new("TextLabel")
miniText.Size = UDim2.new(1,-50,1,0)
miniText.Position = UDim2.new(0,46,0,0)
miniText.BackgroundTransparency = 1
miniText.Text = "🤖⚡ NeuroScript"
miniText.TextColor3 = Color3.fromRGB(0,255,255)
miniText.Font = Enum.Font.GothamSemibold
miniText.TextSize = 20
miniText.TextXAlignment = Enum.TextXAlignment.Left
miniText.Parent = mini

mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mini.Visible=false; frame.Visible=true
    end
end)
btnMin.MouseButton1Click:Connect(function()
    frame.Visible=false
    mini.Visible=true
end)

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

-- ===== Botões =====
local btnSpeed   = makeBtn("⚡ Speed: OFF",      0.00, 0.00)
local btnFly     = makeBtn("🕊 Fly: OFF",        0.52, 0.00)
local btnJump    = makeBtn("🦘 Jump: OFF",       0.00, 0.20)
local btnESP     = makeBtn("👥 ESP: OFF",        0.52, 0.20)
local btnAnti    = makeBtn("🔒 Anti-Detect: OFF",0.00, 0.40, 0.48, 0.16)

local speedBox   = makeBox("Speed (ex: 80)",    0.52, 0.40, 0.48)
local flyBox     = makeBox("Fly (ex: 100)",     0.00, 0.60, 0.48)
local jumpBox    = makeBox("Jump (ex: 70)",     0.52, 0.60, 0.48)

-- ========= Estados =========
local speedOn, targetSpeed = false, 80
local flying, flySpeed = false, 100
local jumpOn, jumpPow = false, 70
local espOn = false
local antiOn = false
local espFolder = Instance.new("Folder"); espFolder.Name = "Neuro_ESP"; espFolder.Parent = workspace

-- ========= SPEED =========
btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    btnSpeed.Text = speedOn and "⚡ Speed: ON" or "⚡ Speed: OFF"
    local _,_,hum = safeChar()
    hum.WalkSpeed = speedOn and targetSpeed or 16
end)
speedBox.FocusLost:Connect(function(enter)
    if enter then
        local v = tonumber(speedBox.Text)
        if v and v>0 and v<=1000 then
            targetSpeed = v
            speedBox.Text = "Speed = "..v
            if speedOn then local _,_,hum=safeChar(); hum.WalkSpeed=v end
        else
            speedBox.Text = "Valor inválido!"
        end
    end
end)

-- ========= FLY (antigo ajustado) =========
local bv, bg, flyConn
local function startFly()
    local _, hrp = safeChar()
    bv = Instance.new("BodyVelocity", hrp)
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bg = Instance.new("BodyGyro", hrp)
    bg.CFrame = hrp.CFrame
    bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    flying = true
    flyConn = RunService.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
        if UIS.TouchEnabled then
            local _,_,hum = safeChar()
            dir = hum.MoveDirection.Magnitude>0 and hum.MoveDirection or dir
        end
        bv.Velocity = dir.Magnitude>0 and dir.Unit*flySpeed or Vector3.zero
        bg.CFrame = cam.CFrame
    end)
end
local function stopFly()
    flying=false
    if flyConn then flyConn:Disconnect() end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end
btnFly.MouseButton1Click:Connect(function()
    if flying then stopFly(); btnFly.Text="🕊 Fly: OFF"
    else startFly(); btnFly.Text="🕊 Fly: ON" end
end)
flyBox.FocusLost:Connect(function(enter)
    if enter then
        local v=tonumber(flyBox.Text)
        if v and v>0 and v<=1500 then flySpeed=v; flyBox.Text="Fly = "..v else flyBox.Text="Valor inválido!" end
    end
end)

-- ========= JUMP =========
btnJump.MouseButton1Click:Connect(function()
    jumpOn=not jumpOn
    btnJump.Text=jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
    if jumpOn then local _,_,hum=safeChar(); hum.UseJumpPower=true; hum.JumpPower=jumpPow end
end)
jumpBox.FocusLost:Connect(function(enter)
    if enter then
        local v=tonumber(jumpBox.Text)
        if v and v>0 and v<=500 then jumpPow=v;jumpBox.Text="Jump = "..v; if jumpOn then local _,_,hum=safeChar();hum.JumpPower=v end
        else jumpBox.Text="Valor inválido!" end
    end
end)

-- ========= ESP =========
local function makeESPFor(char, plr)
    local head=char:FindFirstChild("Head"); if not head then return end
    local bb=Instance.new("BillboardGui"); bb.Name="Neuro_BB"; bb.Size=UDim2.new(0,200,0,40)
    bb.StudsOffsetWorldSpace=Vector3.new(0,3,0); bb.AlwaysOnTop=true; bb.Adornee=head; bb.Parent=espFolder
    local tl=Instance.new("TextLabel"); tl.Size=UDim2.new(1,0,1,0); tl.BackgroundTransparency=1
    tl.Text="👥 "..(plr.DisplayName or plr.Name); tl.TextColor3=Color3.fromRGB(0,255,255); tl.Font=Enum.Font.GothamBold; tl.TextSize=18; tl.Parent=bb
    local hl=Instance.new("Highlight"); hl.Adornee=char; hl.FillTransparency=1; hl.OutlineTransparency=0; hl.OutlineColor=Color3.fromRGB(0,255,255); hl.Parent=espFolder
    char.AncestryChanged:Connect(function(_,p) if not p then bb:Destroy(); hl:Destroy() end end)
end
btnESP.MouseButton1Click:Connect(function()
    espOn=not espOn; btnESP.Text=espOn and "👥 ESP: ON" or "👥 ESP: OFF"
    espFolder:ClearAllChildren()
    if espOn then
        for _,plr in ipairs(Players:GetPlayers()) do if plr~=player and plr.Character then makeESPFor(plr.Character,plr) end end
    end
end)

-- ========= Anti-Detection =========
btnAnti.MouseButton1Click:Connect(function()
    antiOn=not antiOn
    btnAnti.Text=antiOn and "🔒 Anti-Detect: ON" or "🔒 Anti-Detect: OFF"
    if antiOn then
        pcall(function() ScriptContext:SetTimeout(10) end)
        pcall(function() if player.Character then player.Character.Humanoid.BreakJointsOnDeath=false end end)
        debugId = nil
    end
end)

-- ========= Pós-respawn =========
player.CharacterAdded:Connect(function(char)
    task.wait(0.4)
    if speedOn then local hum=char:WaitForChild("Humanoid"); hum.WalkSpeed=targetSpeed end
    if jumpOn then local hum=char:WaitForChild("Humanoid"); hum.JumpPower=jumpPow end
    if espOn then task.wait(0.2); for _,plr in ipairs(Players:GetPlayers()) do if plr~=player and plr.Character then makeESPFor(plr.Character,plr) end end end
    if flying then stopFly(); startFly() end
end)

toast("NeuroScript carregado! 🚀 Fly, Speed, Jump, ESP e Anti-Detection prontos.")
