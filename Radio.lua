local player = game.Players:FindFirstChild("babriel8080")
if not player then return end

-- Cria o Evento se não existir
local event = game.ReplicatedStorage:FindFirstChild("TeleportCoinsEvent") or Instance.new("RemoteEvent", game.ReplicatedStorage)
event.Name = "TeleportCoinsEvent"

-- Lógica do Servidor
event.OnServerEvent:Connect(function(p)
    if p.Name == "babriel8080" then
        for _, item in pairs(workspace:GetDescendants()) do
            if item.Name == "radioative coin" then
                if item:IsA("BasePart") then
                    item.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                elseif item:IsA("Model") then
                    item:MoveTo(p.Character.HumanoidRootPart.Position)
                end
            end
        end
    end
end)

-- Cria a Interface
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "AdminMenu"
sg.ResetOnSpawn = false

local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.8, 0) -- Fica na parte de baixo
btn.Text = "Puxar Radioative Coins"
btn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
btn.Draggable = true -- Você pode arrastar o botão

btn.MouseButton1Click:Connect(function()
    event:FireServer()
end)
