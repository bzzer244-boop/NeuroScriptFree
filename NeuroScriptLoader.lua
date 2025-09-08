--  🔑 NeuroScript Loader com Key System (Render + GitHub)
local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")
local player      = Players.LocalPlayer

-- ================= CONFIGURAÇÃO =================
-- ⚠️ Substitua pelo link da sua API no Render
local API_VALIDATE = "https://neurosistemkeys.onrender.com/validate"

-- Seu script hospedado no GitHub (Raw link)
local SCRIPT_URL   = "https://raw.githubusercontent.com/bzzer244-boop/NeuroScriptFree/refs/heads/main/NeuroScript.lua"
-- =================================================


-- Função compatível para HTTP (Executor + Studio)
local function httpGet(url)
    if syn and syn.request then
        return syn.request({Url = url, Method = "GET"})
    elseif http_request then
        return http_request({Url = url, Method = "GET"})
    elseif request then
        return request({Url = url, Method = "GET"})
    elseif fluxus and fluxus.request then
        return fluxus.request({Url = url, Method = "GET"})
    else
        -- fallback pro Studio (caso esteja testando lá)
        local ok, res = pcall(function()
            return {Success = true, Body = game:GetService("HttpService"):GetAsync(url)}
        end)
        if ok then return res else return {Success = false, Body = "Executor não suporta requests"} end
    end
end


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

        local res = httpGet(API_VALIDATE.."?key="..key.."&user="..player.UserId)

        if res and res.Success and res.Body then
            local ok, data = pcall(function()
                return HttpService:JSONDecode(res.Body)
            end)

            if ok and data.valid == true then
                status.Text = "✅ Key válida! Carregando..."
                task.wait(1)
                gui:Destroy()

                local scriptRes = httpGet(SCRIPT_URL)
                if scriptRes.Success and scriptRes.Body then
                    loadstring(scriptRes.Body)()
                else
                    warn("Erro ao baixar NeuroScript:", scriptRes.Body)
                    status.Text = "⚠️ Erro ao baixar script!"
                end
            else
                status.Text = "❌ Key inválida ou já usada!"
            end
        else
            status.Text = "⚠️ Erro de conexão!"
            warn("Detalhes:", res and res.Body or "Sem resposta")
        end
    end)
end

requestKey()
