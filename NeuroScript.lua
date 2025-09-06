-- NeuroScript (LOCAL) — Use apenas em jogos que você controla.
-- Colocar em StarterPlayer > StarterPlayerScripts (LocalScript)

local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player     = Players.LocalPlayer

-- util
local function safeChar()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp  = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
    return char, hrp, hum
end

local function toast(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title="NeuroScript", Text=text, Duration=3})
    end)
end

-- GUI (mantive layout e logo/título)
local gui = Instance.new("ScreenGui")
gui.Name = "NeuroScriptGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UIS.TouchEnabled and UDim2.fromScale(0.9,0.9) or UDim2.new(0,460,0,460)
frame.BackgroundColor3 = Color3.fromRGB(10,15,35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- topbar (arrastável)
local bar = Instance.new("Frame", frame)
bar.Size = UDim2.new(1,0,0,48)
bar.BackgroundColor3 = Color3.fromRGB(15,20,50)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,16)

local logo = Instance.new("ImageLabel", bar)
logo.Size = UDim2.new(0,30,0,30)
logo.Position = UDim2.new(0,10,0.5,-15)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://131783094153867"

local title = Instance.new("TextLabel", bar)
title.Size = UDim2.new(1,-160,1,0)
title.Position = UDim2.new(0,50,0,0)
title.BackgroundTransparency = 1
title.Text = "🤖⚡ NeuroScript"
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left

-- minimize / close
local btnMin = Instance.new("TextButton", bar)
btnMin.Size = UDim2.new(0,36,0,36); btnMin.Position = UDim2.new(1,-80,0.5,-18)
btnMin.Text = "—"; btnMin.Font = Enum.Font.GothamBold; btnMin.TextSize = 22
btnMin.BackgroundColor3 = Color3.fromRGB(40,50,90); btnMin.TextColor3 = Color3.fromRGB(0,255,255)
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

local btnClose = Instance.new("TextButton", bar)
btnClose.Size = UDim2.new(0,36,0,36); btnClose.Position = UDim2.new(1,-36,0.5,-18)
btnClose.Text = "✖"; btnClose.Font = Enum.Font.GothamBold; btnClose.TextSize = 20
btnClose.BackgroundColor3 = Color3.fromRGB(40,50,90); btnClose.TextColor3 = Color3.fromRGB(0,255,255)
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1,0)

-- mini frame
local mini = Instance.new("Frame", gui)
mini.Name = "Mini"
mini.Size = UDim2.new(0, 260, 0, 64) -- um pouco maior pra caber melhor
mini.Position = UDim2.new(0, 20, 0, 100)
mini.BackgroundColor3 = Color3.fromRGB(15, 20, 50)
mini.Visible = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 16)

-- logo maior
local miniLogo = Instance.new("ImageLabel", mini)
miniLogo.Size = UDim2.new(0, 40, 0, 40) -- antes 28x28
miniLogo.Position = UDim2.new(0, 12, 0.5, -20)
miniLogo.BackgroundTransparency = 1
miniLogo.Image = "rbxassetid://131783094153867"

-- texto maior
local miniText = Instance.new("TextLabel", mini)
miniText.Size = UDim2.new(1, -60, 1, 0)
miniText.Position = UDim2.new(0, 56, 0, 0)
miniText.BackgroundTransparency = 1
miniText.Text = "🤖⚡ NeuroScript"
miniText.TextColor3 = Color3.fromRGB(0, 255, 255)
miniText.TextSize = 22 -- aumentei (padrão costuma ser 14)
miniText.Font = Enum.Font.GothamBold -- fonte mais destacada
miniText.TextXAlignment = Enum.TextXAlignment.Left


btnMin.MouseButton1Click:Connect(function()
    frame.Visible = false
    mini.Visible = true
end)
mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mini.Visible = false; frame.Visible = true
    end
end)
btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)

-- body
local body = Instance.new("Frame", frame)
body.Size = UDim2.new(1,-20,1,-58); body.Position = UDim2.new(0,10,0,56); body.BackgroundTransparency = 1

local function makeBtn(text, xScale, yScale, wScale, hScale)
    local b = Instance.new("TextButton", body)
    b.Size = UDim2.new(wScale or 0.48,0, hScale or 0.16,0)
    b.Position = UDim2.new(xScale,0,yScale,0)
    b.BackgroundColor3 = Color3.fromRGB(20,30,60)
    b.Text = text; b.TextColor3 = Color3.fromRGB(0,255,255)
    b.Font = Enum.Font.GothamBold; b.TextSize = 16
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local function makeBox(ph, xScale, yScale, wScale)
    local tb = Instance.new("TextBox", body)
    tb.Size = UDim2.new(wScale or 0.48,0,0.14,0)
    tb.Position = UDim2.new(xScale,0,yScale,0)
    tb.BackgroundColor3 = Color3.fromRGB(20,30,60)
    tb.PlaceholderText = ph; tb.Text = ph; tb.TextColor3 = Color3.fromRGB(255,255,255)
    tb.Font = Enum.Font.Gotham; tb.TextSize = 16; tb.ClearTextOnFocus = true
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)
    return tb
end

-- buttons + boxes (mantive posições similares)
local btnSpeed   = makeBtn("⚡ Speed: OFF",      0.00, 0.00)
local btnMode    = makeBtn("🛠 Modo: WalkSpeed", 0.52, 0.00)
local btnFly     = makeBtn("🕊 Fly: OFF",        0.00, 0.20)
local btnJump    = makeBtn("🦘 Jump: OFF",       0.52, 0.20)
local btnESP     = makeBtn("👥 ESP: OFF",        0.00, 0.40)

local speedBox   = makeBox("Speed (ex: 80)", 0.52, 0.40, 0.48)
local flyBox     = makeBox("Fly (ex: 100)",  0.00, 0.60, 0.48)
local jumpBox    = makeBox("Jump (ex: 70)",  0.52, 0.60, 0.48)

-- states
local speedOn = false
local speedMode = "WalkSpeed" -- "WalkSpeed" or "Velocity"
local targetSpeed = 80
local velConn = nil

local flying = false
local flySpeed = 100
local flyBV, flyBG, flyConn = nil, nil, nil

local jumpOn = false
local jumpPow = 70

local espOn = false
local espFolder = Instance.new("Folder", workspace); espFolder.Name = "Neuro_ESP"

-- drag manual (works on PC + touch)
do
    local dragging, dragStart, startPos = false, nil, nil
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- SPEED helpers
local function stopVelocityConn()
    if velConn then velConn:Disconnect() velConn = nil end
    -- try to restore vertical velocity if needed (no forced values here)
end

local function applySpeedState()
    local ok, hrp, hum = pcall(function() return safeChar() end)
    if not ok then return end
    local char, root, humanoid = safeChar()
    if speedOn then
        if speedMode == "WalkSpeed" then
            if humanoid then humanoid.WalkSpeed = targetSpeed end
            stopVelocityConn()
        elseif speedMode == "Velocity" then
            -- ensure we don't run multiple conns
            stopVelocityConn()
            velConn = RunService.RenderStepped:Connect(function()
                -- only apply when not flying, and when MoveDirection > 0
                local ok2, c, r, h = pcall(function() return safeChar() end)
                if not ok2 then return end
                if flying then return end
                local dir = h.MoveDirection
                if dir.Magnitude > 0.01 then
                    local current = r.AssemblyLinearVelocity
                    local horiz = dir.Unit * targetSpeed
                    -- preserve vertical velocity
                    r.AssemblyLinearVelocity = Vector3.new(horiz.X, current.Y, horiz.Z)
                end
            end)
        end
    else
        -- disabled: restore defaults and disconnect velocity
        if humanoid then humanoid.WalkSpeed = 16 end
        stopVelocityConn()
    end
    -- update button labels
    if speedOn then
        btnSpeed.Text = "⚡ Speed: ON ("..speedMode..")"
    else
        btnSpeed.Text = "⚡ Speed: OFF"
    end
    btnMode.Text = "🛠 Modo: "..speedMode
end

-- speed button (toggle on/off)
btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    applySpeedState()
end)

-- mode button (select WalkSpeed <-> Velocity)
btnMode.MouseButton1Click:Connect(function()
    speedMode = (speedMode == "WalkSpeed") and "Velocity" or "WalkSpeed"
    -- if currently enabled, reapply to switch behavior immediately
    if speedOn then
        applySpeedState()
    else
        btnMode.Text = "🛠 Modo: "..speedMode
    end
end)

-- input for speed value
speedBox.FocusLost:Connect(function(enter)
    if enter then
        local v = tonumber(speedBox.Text)
        if v and v > 0 and v <= 1500 then
            targetSpeed = v
            speedBox.Text = "Speed = "..v
            if speedOn and speedMode == "WalkSpeed" then
                local _,_,hum = safeChar(); if hum then hum.WalkSpeed = v end
            end
        else
            speedBox.Text = "Valor inválido!"
        end
    end
end)

-- FLY (keeps similar to older "body" style, mobile compatible)
local function startFly()
    local _, hrp, hum = safeChar()
    if not hrp then return end
    if flyBV then flyBV:Destroy() end
    if flyBG then flyBG:Destroy() end
    flyBV = Instance.new("BodyVelocity")
    flyBV.Name = "Neuro_FlyBV"
    flyBV.Parent = hrp
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.zero

    flyBG = Instance.new("BodyGyro")
    flyBG.Name = "Neuro_FlyBG"
    flyBG.Parent = hrp
    flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
    flyBG.P = 1e4
    flyBG.CFrame = hrp.CFrame

    flying = true
    if flyConn then flyConn:Disconnect() flyConn = nil end
    flyConn = RunService.RenderStepped:Connect(function()
        if not flying then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        -- keyboard
        if UIS.KeyboardEnabled then
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        else
            -- mobile: use humanoid.MoveDirection
            local _,_,h = safeChar()
            dir = h.MoveDirection
        end

        if dir.Magnitude > 0.01 then
            flyBV.Velocity = dir.Unit * flySpeed
        else
            flyBV.Velocity = Vector3.zero
        end

        if cam then flyBG.CFrame = cam.CFrame end
    end)
end

local function stopFly()
    flying = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBV then flyBV:Destroy(); flyBV = nil end
    if flyBG then flyBG:Destroy(); flyBG = nil end
end

btnFly.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        btnFly.Text = "🕊 Fly: OFF"
    else
        startFly()
        btnFly.Text = "🕊 Fly: ON"
    end
end)

flyBox.FocusLost:Connect(function(enter)
    if enter then
        local v = tonumber(flyBox.Text)
        if v and v > 0 and v <= 1500 then
            flySpeed = v
            flyBox.Text = "Fly = "..v
        else
            flyBox.Text = "Valor inválido!"
        end
    end
end)

-- JUMP
btnJump.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    btnJump.Text = jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
    local _,_,hum = safeChar()
    if jumpOn and hum then
        hum.UseJumpPower = true
        hum.JumpPower = jumpPow
    elseif hum then
        -- restore default jump power (common default ~50)
        hum.UseJumpPower = true
        hum.JumpPower = 50
    end
end)

jumpBox.FocusLost:Connect(function(enter)
    if enter then
        local v = tonumber(jumpBox.Text)
        if v and v > 0 and v <= 500 then
            jumpPow = v
            jumpBox.Text = "Jump = "..v
            if jumpOn then local _,_,hum = safeChar(); if hum then hum.JumpPower = v end end
        else
            jumpBox.Text = "Valor inválido!"
        end
    end
end)

-- ESP (developer/debugging)
local function makeESPFor(plr)
    if not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    if not head then return end
    if head:FindFirstChild("NeuroESP") then return end

    local bb = Instance.new("BillboardGui")
    bb.Name = "NeuroESP"
    bb.Size = UDim2.new(0,200,0,40)
    bb.StudsOffsetWorldSpace = Vector3.new(0,2.5,0)
    bb.AlwaysOnTop = true
    bb.Adornee = head
    bb.Parent = head

    local tl = Instance.new("TextLabel", bb)
    tl.Size = UDim2.new(1,0,1,0)
    tl.BackgroundTransparency = 1
    tl.Text = (plr.DisplayName ~= "" and plr.DisplayName) or plr.Name
    tl.TextColor3 = Color3.fromRGB(0,255,255)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 18
end

local function clearAllESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local tag = plr.Character.Head:FindFirstChild("NeuroESP")
            if tag then tag:Destroy() end
        end
    end
end

btnESP.MouseButton1Click:Connect(function()
    espOn = not espOn
    btnESP.Text = espOn and "👥 ESP: ON" or "👥 ESP: OFF"
    if espOn then
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                makeESPFor(plr)
                plr.CharacterAdded:Connect(function()
                    task.wait(0.2)
                    if espOn then makeESPFor(plr) end
                end)
            end
        end
    else
        clearAllESP()
    end
end)

-- reaplicar após respawn
player.CharacterAdded:Connect(function(char)
    task.wait(0.4)
    -- reapply speed if needed
    if speedOn then
        applySpeedState()
    end
    -- reapply jump
    if jumpOn then
        local _,_,hum = safeChar()
        if hum then hum.UseJumpPower = true; hum.JumpPower = jumpPow end
    end
    -- reapply fly
    if flying then
        stopFly(); startFly()
    end
    -- reapply ESP
    if espOn then
        task.wait(0.2)
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then makeESPFor(plr) end
        end
    end
end)

-- cleanup when gui destroyed (just in case)
gui.Destroying:Connect(function()
    stopVelocityConn()
    stopFly()
    clearAllESP()
end)

toast("NeuroScript carregado! Use com responsabilidade — apenas no seu próprio jogo.")
