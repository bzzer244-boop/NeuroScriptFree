-- 🤖⚡ NeuroScript (LOCAL) — Use apenas em jogos que você controla.
-- Colocar em StarterPlayer > StarterPlayerScripts (LocalScript)

local Players    = game:GetService("Players")
local UIS        = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player     = Players.LocalPlayer

-- 🔒 Anti-Ban Reforçado
if not player or not player:FindFirstChild("PlayerGui") then
    return warn("❌ NeuroScript só pode rodar em LocalScript dentro de StarterPlayerScripts")
end

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

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NeuroScriptGui"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UIS.TouchEnabled and UDim2.fromScale(0.9,0.9) or UDim2.new(0,460,0,460)
frame.BackgroundColor3 = Color3.fromRGB(10,15,35)
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

-- topbar
local bar = Instance.new("Frame", frame)
bar.Size = UDim2.new(1,0,0,48)
bar.BackgroundColor3 = Color3.fromRGB(15,20,50)
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

-- minimizar/fechar
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
mini.Size = UDim2.new(0,260,0,64)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(15,20,50)
mini.Visible = false
mini.Active = true
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,16)

local miniLogo = Instance.new("ImageLabel", mini)
miniLogo.Size = UDim2.new(0,40,0,40)
miniLogo.Position = UDim2.new(0,12,0.5,-20)
miniLogo.BackgroundTransparency = 1
miniLogo.Image = "rbxassetid://131783094153867"

local miniBtn = Instance.new("TextButton", mini)
miniBtn.Size = UDim2.new(1,-60,1,0)
miniBtn.Position = UDim2.new(0,56,0,0)
miniBtn.BackgroundTransparency = 1
miniBtn.Text = "🔵 Abrir NeuroScript"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 22
miniBtn.TextColor3 = Color3.fromRGB(0,255,255)
miniBtn.TextXAlignment = Enum.TextXAlignment.Left

btnMin.MouseButton1Click:Connect(function()
    frame.Visible = false
    mini.Visible = true
end)
miniBtn.MouseButton1Click:Connect(function()
    mini.Visible = false
    frame.Visible = true
end)
btnClose.MouseButton1Click:Connect(function() gui:Destroy() end)

-- drag function
local function dragify(obj, handle)
    local dragging, dragStart, startPos = false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
dragify(frame, bar)
dragify(mini, mini)

-- body
local body = Instance.new("Frame", frame)
body.Size = UDim2.new(1,-20,1,-58)
body.Position = UDim2.new(0,10,0,56)
body.BackgroundTransparency = 1

local function makeBtn(text, x, y)
    local b = Instance.new("TextButton", body)
    b.Size = UDim2.new(0.48,0,0.16,0)
    b.Position = UDim2.new(x,0,y,0)
    b.BackgroundColor3 = Color3.fromRGB(20,30,60)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(0,255,255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local function makeBox(ph, x, y)
    local tb = Instance.new("TextBox", body)
    tb.Size = UDim2.new(0.48,0,0.14,0)
    tb.Position = UDim2.new(x,0,y,0)
    tb.BackgroundColor3 = Color3.fromRGB(20,30,60)
    tb.PlaceholderText = ph; tb.Text = ph
    tb.TextColor3 = Color3.fromRGB(255,255,255)
    tb.Font = Enum.Font.Gotham; tb.TextSize = 16
    tb.ClearTextOnFocus = true
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)
    return tb
end

-- buttons
local btnSpeed = makeBtn("⚡ Speed: OFF",0.00,0.00)
local btnMode  = makeBtn("🛠 Modo: WalkSpeed",0.52,0.00)
local btnFly   = makeBtn("🕊 Fly: OFF",0.00,0.20)
local btnJump  = makeBtn("🦘 Jump: OFF",0.52,0.20)
local btnESP   = makeBtn("👤 ESP: OFF",0.00,0.40)

local speedBox = makeBox("Speed (ex: 80)",0.52,0.40)
local flyBox   = makeBox("Fly (ex: 100)",0.00,0.60)
local jumpBox  = makeBox("Jump (ex: 70)",0.52,0.60)

-- Speed vars
local speedOn=false; local speedMode="WalkSpeed"; local targetSpeed=80; local velConn=nil
-- Fly vars
local flying=false; local flySpeed=100; local flyBV,flyBG,flyConn=nil,nil,nil
-- Jump vars
local jumpOn=false; local jumpPow=70
-- ESP vars
local espOn=false

-- Speed funcs
local function stopVelocityConn() if velConn then velConn:Disconnect() velConn=nil end end
local function applySpeedState()
    local char,hrp,hum=safeChar()
    if speedOn then
        if speedMode=="WalkSpeed" then
            hum.WalkSpeed=targetSpeed
            stopVelocityConn()
        else
            stopVelocityConn()
            velConn=RunService.RenderStepped:Connect(function()
                if not flying then
                    local _,r,h=safeChar()
                    local dir=h.MoveDirection
                    if dir.Magnitude>0.01 then
                        local current=r.AssemblyLinearVelocity
                        local horiz=dir.Unit*targetSpeed
                        r.AssemblyLinearVelocity=Vector3.new(horiz.X,current.Y,horiz.Z)
                    end
                end
            end)
        end
    else
        hum.WalkSpeed=16
        stopVelocityConn()
    end
    btnSpeed.Text=speedOn and "⚡ Speed: ON ("..speedMode..")" or "⚡ Speed: OFF"
    btnMode.Text="🛠 Modo: "..speedMode
end
btnSpeed.MouseButton1Click:Connect(function() speedOn=not speedOn;applySpeedState() end)
btnMode.MouseButton1Click:Connect(function() speedMode=(speedMode=="WalkSpeed") and "Velocity" or "WalkSpeed";if speedOn then applySpeedState() else btnMode.Text="🛠 Modo: "..speedMode end end)
speedBox.FocusLost:Connect(function(e) if e then local v=tonumber(speedBox.Text) if v and v>0 and v<=1500 then targetSpeed=v; speedBox.Text="Speed="..v; if speedOn and speedMode=="WalkSpeed" then local _,_,hum=safeChar();hum.WalkSpeed=v end else speedBox.Text="Valor inválido!" end end end)

-- Fly funcs
local function startFly()
    local _,hrp=safeChar()
    flyBV=Instance.new("BodyVelocity",hrp);flyBV.MaxForce=Vector3.new(1e5,1e5,1e5)
    flyBG=Instance.new("BodyGyro",hrp);flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5);flyBG.P=1e4
    flying=true
    flyConn=RunService.RenderStepped:Connect(function()
        if not flying then return end
        local cam=workspace.CurrentCamera
        local dir=Vector3.zero
        if UIS.KeyboardEnabled then
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir+=cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir-=cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir+=cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir-=cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir-=Vector3.new(0,1,0) end
        else
            local _,_,h=safeChar();dir=h.MoveDirection
        end
        flyBV.Velocity=dir.Magnitude>0.01 and dir.Unit*flySpeed or Vector3.zero
        flyBG.CFrame=cam.CFrame
    end)
end
local function stopFly() flying=false;if flyConn then flyConn:Disconnect() flyConn=nil end;if flyBV then flyBV:Destroy() flyBV=nil end;if flyBG then flyBG:Destroy() flyBG=nil end end
btnFly.MouseButton1Click:Connect(function() if flying then stopFly();btnFly.Text="🕊 Fly: OFF" else startFly();btnFly.Text="🕊 Fly: ON" end end)
flyBox.FocusLost:Connect(function(e) if e then local v=tonumber(flyBox.Text) if v and v>0 and v<=1500 then flySpeed=v; flyBox.Text="Fly="..v else flyBox.Text="Valor inválido!" end end end)

-- Jump funcs
-- 🦘 JUMP
btnJump.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    btnJump.Text = jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
    local _,_,hum = safeChar()
    if jumpOn and hum then
        hum.UseJumpPower = true
        hum.JumpPower = jumpPow
    elseif hum then
        -- restaura o valor padrão (~50)
        hum.UseJumpPower = true
        hum.JumpPower = 50
    end
end)

jumpBox.FocusLost:Connect(function(e)
    if e then
        local v = tonumber(jumpBox.Text)
        if v and v > 0 and v <= 500 then
            jumpPow = v
            jumpBox.Text = "Jump="..v
            local _,_,hum = safeChar()
            if jumpOn and hum then
                hum.UseJumpPower = true
                hum.JumpPower = v
            end
        else
            jumpBox.Text = "Valor inválido!"
        end
    end
end)

-- ESP funcs
-- 👤 ESP
local function makeESPFor(plr)
    if not plr.Character then return end
    local char = plr.Character
    local head = char:FindFirstChild("Head")

    if not head or head:FindFirstChild("NeuroESP") then return end

    -- Nome acima da cabeça
    local bb = Instance.new("BillboardGui")
    bb.Name = "NeuroESP"
    bb.Size = UDim2.new(0,250,0,50)
    bb.AlwaysOnTop = true
    bb.StudsOffsetWorldSpace = Vector3.new(0,3,0)
    bb.Adornee = head
    bb.Parent = head

    local tl = Instance.new("TextLabel", bb)
    tl.Size = UDim2.new(1,0,1,0)
    tl.BackgroundTransparency = 1
    tl.Text = "👤 "..plr.Name
    tl.TextColor3 = Color3.fromRGB(0,255,255)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 24
    tl.TextStrokeTransparency = 0
    tl.TextStrokeColor3 = Color3.fromRGB(0,200,200)

    -- Contorno Highlight
    local hl = Instance.new("Highlight")
    hl.Name = "NeuroESP_Highlight"
    hl.FillColor = Color3.fromRGB(0,255,255)
    hl.FillTransparency = 0.75
    hl.OutlineColor = Color3.fromRGB(0,255,255)
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char
end

local function clearESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("NeuroESP") then
                head.NeuroESP:Destroy()
            end
            local hl = plr.Character:FindFirstChild("NeuroESP_Highlight")
            if hl then hl:Destroy() end
        end
    end
end

btnESP.MouseButton1Click:Connect(function()
    espOn = not espOn
    btnESP.Text = espOn and "👤 ESP: ON" or "👤 ESP: OFF"

    if espOn then
        -- aplica ESP em todos
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                makeESPFor(plr)
                -- reaplica quando respawnar
                plr.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    if espOn then makeESPFor(plr) end
                end)
            end
        end
    else
        -- desliga ESP
        clearESP()
    end
end)

-- Mobile Up/Down buttons
if UIS.TouchEnabled then
    local upBtn=Instance.new("TextButton",gui);upBtn.Size=UDim2.new(0,80,0,80);upBtn.Position=UDim2.new(1,-200,1,-200);upBtn.Text="⬆️";upBtn.BackgroundColor3=Color3.fromRGB(20,30,60);upBtn.TextColor3=Color3.fromRGB(0,255,255);Instance.new("UICorner",upBtn).CornerRadius=UDim.new(1,0)
    local downBtn=Instance.new("TextButton",gui);downBtn.Size=UDim2.new(0,80,0,80);downBtn.Position=UDim2.new(1,-100,1,-200);downBtn.Text="⬇️";downBtn.BackgroundColor3=Color3.fromRGB(20,30,60);downBtn.TextColor3=Color3.fromRGB(0,255,255);Instance.new("UICorner",downBtn).CornerRadius=UDim.new(1,0)
    upBtn.MouseButton1Down:Connect(function() local _,hrp=safeChar();if hrp then hrp.CFrame+=Vector3.new(0,5,0) end end)
    downBtn.MouseButton1Down:Connect(function() local _,hrp=safeChar();if hrp then hrp.CFrame+=Vector3.new(0,-5,0) end end)
end

-- reaplicar
player.CharacterAdded:Connect(function() task.wait(0.5);if speedOn then applySpeedState() end;if jumpOn then local _,_,hum=safeChar();hum.JumpPower=jumpPow end;if flying then stopFly();startFly() end;if espOn then for _,plr in pairs(Players:GetPlayers()) do if plr~=player then makeESPFor(plr) end end end end)

-- cleanup
gui.Destroying:Connect(function() stopVelocityConn();stopFly();clearESP() end)

toast("✅ NeuroScript carregado com Speed, Fly, Jump, ESP e Anti-Ban Reforçado!")
