local TARGET_NAME = "babriel8080"
local ITEM_NAME = "radioative coin"

-- Aguarda o jogador entrar
local player = game.Players:FindFirstChild(TARGET_NAME) or game.Players.PlayerAdded:Wait()
if player.Name ~= TARGET_NAME then return end

-- Garante que o evento exista
local event = game.ReplicatedStorage:FindFirstChild("TeleportCoinsEvent")
if not event then
    event = Instance.new("RemoteEvent", game.ReplicatedStorage)
    event.Name = "TeleportCoinsEvent"
end

-- Lógica do Servidor (Só roda uma vez)
if game:GetService("RunService"):IsServer() then
    event.OnServerEvent:Connect(function(p)
        if p.Name == TARGET_NAME then
            local count = 0
            for _, item in pairs(workspace:GetDescendants()) do
                if item.Name == ITEM_NAME then
                    if item:IsA("BasePart") then
                        item.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                        count = + 1
                    elseif item:IsA("Model") then
                        item:MoveTo(p.Character.HumanoidRootPart.Position)
                        count = + 1
                    end
                end
            end
            print("Puxou " .. count .. " moedas.")
        end
    end)
end

-- Cria a interface (GUI)
local function createGui()
    local sg = Instance.new("ScreenGui")
    sg.Name = "AdminMenu"
    sg.Parent = player:WaitForChild("PlayerGui")
    sg.ResetOnSpawn = false

    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(0.5, -100, 0.8, 0)
    btn.Text = "Puxar Radioative Coins"
    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    btn.ZIndex = 10 -- Garante que fique na frente de tudo

    btn.MouseButton1Click:Connect(function()
        event:FireServer()
    end)
end

createGui()
