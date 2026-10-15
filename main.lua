-- =================================================================
-- 💨⚡ SMOKE HUB - SISTEMA DE OTIMIZAÇÃO & ANTI-LAG
-- =================================================================

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SmokeHub = {}

-- -----------------------------------------------------------------
-- 1. REDUZIR MOVIMENTO (Estabiliza a câmera e movimentos)
-- -----------------------------------------------------------------
function SmokeHub.ReduzirMovimento()
    local Camera = workspace.CurrentCamera
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.CameraOffset = Vector3.new(0, 0, 0)
        end
    end
    
    Camera.FieldOfView = 70
    print("💨 [Smoke Hub]: Modo Reduzir Movimento Ativado")
end

-- -----------------------------------------------------------------
-- 2. MODO LEVE (Remove sombras globais e efeitos de luz)
-- -----------------------------------------------------------------
function SmokeHub.Leve()
    Lighting.GlobalShadows = false
    
    for _, efeito in pairs(Lighting:GetChildren()) do
        if efeito:IsA("PostEffect") or efeito:IsA("BlurEffect") or efeito:IsA("SunRaysEffect") then
            efeito.Enabled = false
        end
    end
    
    print("💨 [Smoke Hub]: Modo Leve Ativado")
end

-- -----------------------------------------------------------------
-- 3. MODO MÉDIO (Desativa partículas, fumaça e reflexos de água)
-- -----------------------------------------------------------------
function SmokeHub.Medio()
    SmokeHub.Leve()
    
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
    end
    
    for _, objeto in pairs(workspace:GetDescendants()) do
        if objeto:IsA("ParticleEmitter") or objeto:IsA("Smoke") or objeto:IsA("Fire") or objeto:IsA("Sparkles") then
            objeto.Enabled = false
        elseif objeto:IsA("BasePart") then
            objeto.CastShadow = false
        end
    end
    
    print("💨 [Smoke Hub]: Modo Médio Ativado")
end

-- -----------------------------------------------------------------
-- 4. MODO EXTREMO (Converte materiais para SmoothPlastic e remove texturas)
-- -----------------------------------------------------------------
function SmokeHub.Extremo()
    SmokeHub.Medio()
    SmokeHub.ReduzirMovimento()
    
    for _, objeto in pairs(workspace:GetDescendants()) do
        if objeto:IsA("BasePart") then
            objeto.Material = Enum.Material.SmoothPlastic
        elseif objeto:IsA("Decal") or objeto:IsA("Texture") then
            objeto.Transparency = 1
        end
    end
    
    print("💨 [Smoke Hub]: Modo Extremo Ativado")
end

-- =================================================================
-- EXEMPLO DE LIGAÇÃO COM OS BOTÕES DO SMOKE HUB
-- =================================================================
-- BotaoReduzirMovimento.MouseButton1Click:Connect(SmokeHub.ReduzirMovimento)
-- BotaoLeve.MouseButton1Click:Connect(SmokeHub.Leve)
-- BotaoMedio.MouseButton1Click:Connect(SmokeHub.Medio)
-- BotaoExtremo.MouseButton1Click:Connect(SmokeHub.Extremo)
