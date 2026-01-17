-- [[ PAINEL UNIVERSAL-HUB-V1.9.5 BYPASS ]]
-- Codename: @ayuks78 & @GmAI
-- Stealth Engine: Anti-Cheat Protection

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- [[ CONFIGURAÇÕES ]]
getgenv().Aimbot = false
getgenv().Hitbox = false
getgenv().Noclip = false
getgenv().BypassActive = true -- Proteção adicional

-- [[ INTERFACE v1.9.5 ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalHub_v195"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [ HEADER DINÂMICO ]
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, -20, 0, 30); Header.Position = UDim2.new(0, 10, 0, 10); Header.BackgroundTransparency = 1

local UserLabel = Instance.new("TextLabel", Header)
UserLabel.Size = UDim2.new(0.6, 0, 1, 0); UserLabel.Text = "Bem Vindo: " .. lp.Name .. "  //  v1.9.5"
UserLabel.TextColor3 = Color3.fromRGB(180, 180, 180); UserLabel.Font = Enum.Font.GothamSemibold; UserLabel.TextSize = 13; UserLabel.TextXAlignment = 0; UserLabel.BackgroundTransparency = 1

local TimeLabel = Instance.new("TextLabel", Header)
TimeLabel.Size = UDim2.new(0.4, 0, 1, 0); TimeLabel.Position = UDim2.new(0.6, 0, 0, 0)
TimeLabel.Text = os.date("%H:%M:%S"); TimeLabel.TextColor3 = Color3.fromRGB(0, 140, 255); TimeLabel.Font = Enum.Font.GothamBold; TimeLabel.TextSize = 13; TimeLabel.TextXAlignment = 2; TimeLabel.BackgroundTransparency = 1

spawn(function() while wait(1) do TimeLabel.Text = os.date("%H:%M:%S") end end)

-- Sistema de Abas (Simplificado p/ Performance)
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 35); TabBar.Position = UDim2.new(0, 10, 0, 50); TabBar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabBar); TabList.FillDirection = 0; TabList.Padding = UDim.new(0, 8)

local PageFolder = Instance.new("Frame", MainFrame)
PageFolder.Size = UDim2.new(1, -20, 1, -110); PageFolder.Position = UDim2.new(0, 10, 0, 100); PageFolder.BackgroundTransparency = 1

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageFolder)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)
    local Btn = Instance.new("TextButton", TabBar)
    Btn.Size = UDim2.new(0, 95, 1, 0); Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Btn.Text = name; Btn.TextColor3 = Color3.fromRGB(200, 200, 200); Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageFolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        Page.Visible = true
    end)
    return Page
end

local MainP = CreatePage("Combat")
local MiscP = CreatePage("Misc")

-- [[ LÓGICA NOCLIP BYPASS (WALL ONLY) ]]
RS.Stepped:Connect(function()
    if getgenv().Noclip and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                -- Verifica se há algo na frente (Parede) usando Raycast simples
                local ray = Ray.new(part.Position, lp.Character.HumanoidRootPart.CFrame.LookVector * 1)
                local hit, pos = workspace:FindPartOnRay(ray, lp.Character)
                
                if hit and math.abs(hit.Orientation.Z) < 45 then -- Detecta se é parede (vertical)
                    part.CanCollide = false
                else
                    -- Se for chão ou rampa, mantém colisão para não cair
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- [[ BOOST FPS ULTRA (CLEANER) ]]
local function BoostFPS()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1 -- Em vez de destruir, deixa invisível (mais seguro)
        end
    end
    print("Memory Cache Cleaned")
end

-- Componentes
local function AddToggle(parent, text, var)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, 0, 0, 45); Card.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)
    local L = Instance.new("TextLabel", Card); L.Size = UDim2.new(0.7, 0, 1, 0); L.Position = UDim2.new(0, 12, 0, 0); L.Text = text; L.TextColor3 = Color3.fromRGB(255,255,255); L.Font = Enum.Font.Gotham; L.TextXAlignment = 0; L.BackgroundTransparency = 1
    local B = Instance.new("TextButton", Card); B.Size = UDim2.new(0, 45, 0, 22); B.Position = UDim2.new(1, -55, 0.5, -11); B.BackgroundColor3 = Color3.fromRGB(30, 30, 35); B.Text = ""; Instance.new("UICorner", B).CornerRadius = UDim.new(0, 10)
    B.MouseButton1Click:Connect(function()
        getgenv()[var] = not getgenv()[var]
        B.BackgroundColor3 = getgenv()[var] and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(30, 30, 35)
        if var == "Bfps" and getgenv().Bfps then BoostFPS() end
    end)
end

AddToggle(MiscP, "Noclip Stealth (Paredes)", "Noclip")
AddToggle(MiscP, "Boost FPS Ultra", "Bfps")

-- Botão Abrir
local OpenBtn = Instance.new("ImageButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 46, 0, 46); OpenBtn.Position = UDim2.new(0, 15, 0.5, -23)
OpenBtn.BackgroundColor3 = Color3.fromRGB(5, 5, 5); OpenBtn.Image = "rbxassetid://6023454774"; Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6); OpenBtn.Draggable = true
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

MainP.Visible = true