--  🔑 NeuroScript Loader com Key System (Replit + GitHub)

local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")
local player      = Players.LocalPlayer

-- ================= CONFIGURAÇÃO =================
-- Substitua pelo link público do seu Replit (⚠️ troque pelo seu!)
local API_VALIDATE = "https://neurosistemkeys.onrender.com/validate"
-- Endpoint opcional para você listar todas as keys
local API_KEYS     = "https://NeuroScriptKeySystem.bzzer244.repl.co/keys?admin=YOUR_SECRET_PASSWORD"

-- Seu script hospedado no GitHub (Raw link)
local SCRIPT_URL   = "https://raw.githubusercontent.com/bzzer244-boop/NeuroScriptFree/refs/heads/main/NeuroScript.lua"
-- =================================================

-- GUI para pedir a Key
local function requestKey()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "NeuroLoader"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 170)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1, -20, 0, 40)
    box.Position = UDim2.new(0, 10, 0, 20)
    box.PlaceholderText = "Digite sua key"
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(35,35,60)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 80)
    btn.Text = "Validar Key"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(45,45,85)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 1, -40)
    status.BackgroundTransparency = 1
    status.Text = "Aguardando key..."
    status.TextColor3 = Color3.fromRGB(200,200,200)
    status.Font = Enum.Font.Gotham
    status.TextSize = 16

    btn.MouseButton1Click:Connect(function()
        local key = box.Text
        status.Text = "⏳ Validando..."
        local success, response = pcall(function()
            return HttpService:GetAsync(API_VALIDATE.."?key="..key)
        end)

        if success and response == "VALID" then
            status.Text = "✅ Key válida! Carregando..."
            task.wait(1)
            gui:Destroy()
            local ok, code = pcall(function()
                return HttpService:GetAsync(SCRIPT_URL)
            end)
            if ok then
                loadstring(code)()
            else
                warn("Erro ao baixar NeuroScript:", code)
            end
        else
            status.Text = "❌ Key inválida!"
        end
    end)
end

requestKey()
