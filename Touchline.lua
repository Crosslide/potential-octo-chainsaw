local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local normalSpeed = 0.2
local fasterSpeed = 0.5
local currentSpeed = normalSpeed
local isFast = false

-- Crear GUI botón para activar/desactivar velocidad rápida
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = screenGui
button.Text = "Velocidad normal"
button.Position = UDim2.new(0.05, 0, 0.4, 0)  -- Izquierda y un poco arriba
button.Size = UDim2.new(0, 140, 0, 50)

button.MouseButton1Click:Connect(function()
    isFast = not isFast
    if isFast then
        currentSpeed = fasterSpeed
        button.Text = "Velocidad rápida"
    else
        currentSpeed = normalSpeed
        button.Text = "Velocidad normal"
    end
end)

-- Mover con CFrame según dirección de joystick (Humanoid.MoveDirection)
RunService.RenderStepped:Connect(function()
    if root and humanoid then
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            local moveVector = Vector3.new(moveDir.X, 0, moveDir.Z).Unit
            root.CFrame = root.CFrame + moveVector * currentSpeed
        end
    end
end)

-- Actualizar referencias al respawnear
player.CharacterAdded:Connect(function(char)
    character = char
    root = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    isFast = false
    currentSpeed = normalSpeed
    button.Text = "Velocidad normal"
end)
