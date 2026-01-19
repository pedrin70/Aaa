local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Pega o jogador local de forma automática (funciona para quem executar)
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Nome da moeda exatamente como está no mapa
local ITEM_NAME = "radioative coin" 

-- 1. CRIAÇÃO DO EVENTO (Lado do Servidor/Cliente)
local event = ReplicatedStorage:FindFirstChild("TeleportCoinsEvent")
if not event then
    event = Instance.new("RemoteEvent", ReplicatedStorage)
    event.Name = "TeleportCoinsEvent"
end

-- 2. LÓGICA DE TELEPORTE (Rodando no Servidor)
-- Nota: Em alguns executores de celular, o OnServerEvent precisa ser definido assim:
if game:GetService("RunService"):IsServer() or not game.Loaded then
    event.OnServerEvent:Connect(function(p)
        -- Segurança básica: só você (ou admins)
        if p.Name == "babriel8080" then 
            local char = p.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            local pos = char.HumanoidRootPart.CFrame
            for _, item in pairs(workspace:GetDescendants()) do
                if item.Name == ITEM_NAME then
                    if item:IsA("BasePart") then
                        item.CFrame = pos + Vector3.new(0, 3, 0)
                    elseif item:IsA("Model") then
                        item:MoveTo(char.HumanoidRootPart.Position)
                    end
                end
            end
        end
    end)
end

-- 3. INTERFACE (GUI)
-- Remove menu antigo se existir para não acumular
local oldGui = player.PlayerGui:FindFirstChild("AdminMenu")
if oldGui then oldGui:Destroy() end

local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "AdminMenu"
sg.ResetOnSpawn = false

local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 180, 0, 45)
btn.Position = UDim2.new(0.5, -90, 0.2, 0) -- Perto do topo para não atrapalhar o analógico
btn.Text = "Puxar Moedas"
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 18

-- Arredondar cantos (fica mais bonito no celular)
local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(0, 10)

btn.MouseButton1Click:Connect(function()
    event:FireServer()
    btn.Text = "Enviado!"
    task.wait(1)
    btn.Text = "Puxar Moedas"
end)
