local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Função para criar a interface
local function criarMenu()
    -- Deleta menus antigos para não bugar
    if player.PlayerGui:FindFirstChild("AdminMenu") then
        player.PlayerGui.AdminMenu:Destroy()
    end

    local sg = Instance.new("ScreenGui", player.PlayerGui)
    sg.Name = "AdminMenu"
    sg.ResetOnSpawn = false

    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0, 200, 0, 60)
    btn.Position = UDim2.new(0.5, -100, 0.4, 0) -- Meio da tela para você ver fácil
    btn.Text = "PUXAR MOEDAS AGORA"
    btn.BackgroundColor3 = Color3.fromRGB(255, 85, 0) -- Cor Laranja forte
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Active = true
    btn.Draggable = true -- Você pode arrastar ele se atrapalhar

    -- Lógica de Teleporte Direta
    btn.MouseButton1Click:Connect(function()
        local count = 0
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local myPos = character.HumanoidRootPart.CFrame
            
            for _, item in pairs(workspace:GetDescendants()) do
                if item.Name == "radioative coin" then
                    if item:IsA("BasePart") then
                        item.CFrame = myPos + Vector3.new(0, 3, 0)
                        count = count + 1
                    elseif item:IsA("Model") then
                        item:MoveTo(character.HumanoidRootPart.Position)
                        count = count + 1
                    end
                end
            end
            btn.Text = "Puxou: " .. count
            task.wait(1)
            btn.Text = "PUXAR MOEDAS AGORA"
        end
    end)
end

-- Executa a função
criarMenu()
print("Script Carregado com Sucesso!")
