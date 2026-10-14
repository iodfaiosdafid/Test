-- ⚠️ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) ⚠️

local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "1234",

    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "KZ HUB"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n⛔ Unauthorized Execution ⛔\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-- ════════════════════════════════════════════════════════════════
-- KZ HUB v9.8 — Silent Aim + RPG (Click/Swastika/Text/Spam) + GodMod + ESP
-- ════════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then repeat task.wait(0.1) until Players.LocalPlayer; player = Players.LocalPlayer end
if not player.Character then player.CharacterAdded:Wait() end

pcall(function()
    for _, v in ipairs(CoreGui:GetChildren()) do
        if v.Name == "KZHubNebula" or v.Name == "KZ_Downed" or v.Name == "KZ_GodModConfirm" then v:Destroy() end
    end
    local pg = player:FindFirstChildOfClass("PlayerGui")
    if pg then
        for _, v in ipairs(pg:GetChildren()) do
            if v.Name == "KZHubNebula" or v.Name == "KZ_Downed" or v.Name == "KZ_GodModConfirm" then v:Destroy() end
        end
    end
end)

_G.KZ = {}
_G.KZ.player = player
_G.KZ.Players = Players
_G.KZ.RunService = RunService
_G.KZ.UserInputService = UserInputService
_G.KZ.ReplicatedStorage = ReplicatedStorage
_G.KZ.TweenService = TweenService
_G.KZ.CoreGui = CoreGui
_G.KZ.StarterGui = StarterGui
_G.KZ.Lighting = Lighting
_G.KZ.HttpService = HttpService

_G.KZ.State = {
    fastShotEnabled=false, noRecoilEnabled=false, infiniteAmmoEnabled=false,
    hitboxEnabled=false, hitboxHeadSize=5,
    invisibleHitboxEnabled=false, invisibleHitboxSize=2.6,
    FovEnabled=false, FovValue=100, LowGraphicsEnabled=false,
    flyEnabled=false, flySpeed=400, flyKey="LeftControl",
    SC_Weapon="None", SC_Camo1="None", SC_Camo2="None",
    SC_Anim1=true, SC_Anim2=true,
    SC_Color1R=255, SC_Color1G=255, SC_Color1B=255,
    SC_Color2R=255, SC_Color2G=255, SC_Color2B=255,
    SC_UseColor1=false, SC_UseColor2=false,
    aimbotModuleActive=false,
    aimbotWhitelist={},
    TimeChangerEnabled=false, ClockHours=14, ClockMinutes=0,
    CurrentTheme="Turquoise", AccessoryColorName="Pink",
    AccessoryColor=Color3.fromRGB(255,105,180),
    KillStreakEnabled=true,
    KillStreakSounds={[2]="rbxassetid://116907610084760",[3]="rbxassetid://119830932835553",[4]="rbxassetid://125662494668382",[10]="rbxassetid://94052833273238"},
    KillStreakVolume=3, CurrentKillStreak=0,
    MenuToggleKey="Insert", HideGameUI=false, HideChat=false,
    CustomUserName=player.Name, CustomDisplayName=player.DisplayName,
    CustomNameEnabled=false, CustomNameColor=Color3.fromRGB(255,255,255),
    AccByIdInput="", AccByIdList={},
    BodyPartTarget="Head", BodyPartByIdInput="", BodyPartList={},
    ClothingTarget="T-Shirt", ClothingIdInput="",
    SkinPlayerAutoApply=false,
    TowersTPKey="T",
    SkinPlayerKey="K",
    RPG_Click=false, RPG_Swastika=false, RPG_Spam=false,
    RPG_Speed=0.1, RPG_Bursts=1, RPG_Range=4000,
    RPG_MinDistance=15,
    RPG_SwastikaSize=12, RPG_FireRate=0.01, RPG_Whitelist={},
    RPG_TextMode=false, RPG_TextInput="KZ HUB", RPG_TextSize=12,
}

_G.KZ.AccessoryColors = {
    Pink=Color3.fromRGB(255,105,180), Black=Color3.fromRGB(20,20,25), White=Color3.fromRGB(240,240,245),
    Blue=Color3.fromRGB(50,110,220), Turquoise=Color3.fromRGB(45,200,205), Purple=Color3.fromRGB(160,70,230),
}

_G.KZ.Themes = {
    Pink={bg=Color3.fromRGB(72,22,48),titlebar=Color3.fromRGB(58,16,38),contentBg=Color3.fromRGB(62,18,42),tabColor=Color3.fromRGB(199,64,121),tabColorHover=Color3.fromRGB(230,90,150),tabColorDark=Color3.fromRGB(140,42,85),accent=Color3.fromRGB(232,168,56),splash=Color3.fromRGB(58,16,38),text=Color3.fromRGB(240,235,230),subtext=Color3.fromRGB(200,175,185)},
    Green={bg=Color3.fromRGB(20,48,28),titlebar=Color3.fromRGB(14,36,20),contentBg=Color3.fromRGB(18,42,24),tabColor=Color3.fromRGB(55,145,75),tabColorHover=Color3.fromRGB(75,180,100),tabColorDark=Color3.fromRGB(35,100,52),accent=Color3.fromRGB(100,220,120),splash=Color3.fromRGB(14,36,20),text=Color3.fromRGB(240,240,235),subtext=Color3.fromRGB(180,210,190)},
    Cyan={bg=Color3.fromRGB(20,50,60),titlebar=Color3.fromRGB(14,38,48),contentBg=Color3.fromRGB(18,44,54),tabColor=Color3.fromRGB(55,150,185),tabColorHover=Color3.fromRGB(75,180,220),tabColorDark=Color3.fromRGB(38,105,130),accent=Color3.fromRGB(100,215,235),splash=Color3.fromRGB(14,38,48),text=Color3.fromRGB(240,240,245),subtext=Color3.fromRGB(180,210,225)},
    Turquoise={bg=Color3.fromRGB(15,55,58),titlebar=Color3.fromRGB(10,42,45),contentBg=Color3.fromRGB(13,48,51),tabColor=Color3.fromRGB(45,160,170),tabColorHover=Color3.fromRGB(65,190,200),tabColorDark=Color3.fromRGB(30,110,118),accent=Color3.fromRGB(110,225,235),splash=Color3.fromRGB(10,42,45),text=Color3.fromRGB(240,245,245),subtext=Color3.fromRGB(170,205,210)},
    Purple={bg=Color3.fromRGB(48,25,68),titlebar=Color3.fromRGB(36,18,52),contentBg=Color3.fromRGB(42,22,60),tabColor=Color3.fromRGB(130,60,190),tabColorHover=Color3.fromRGB(160,95,225),tabColorDark=Color3.fromRGB(90,42,135),accent=Color3.fromRGB(190,140,250),splash=Color3.fromRGB(36,18,52),text=Color3.fromRGB(240,235,245),subtext=Color3.fromRGB(200,185,220)},
    White={bg=Color3.fromRGB(230,232,238),titlebar=Color3.fromRGB(215,218,225),contentBg=Color3.fromRGB(222,225,232),tabColor=Color3.fromRGB(180,185,200),tabColorHover=Color3.fromRGB(200,205,220),tabColorDark=Color3.fromRGB(140,145,160),accent=Color3.fromRGB(60,130,220),splash=Color3.fromRGB(215,218,225),text=Color3.fromRGB(30,30,40),subtext=Color3.fromRGB(90,95,110)},
    Black={bg=Color3.fromRGB(18,18,22),titlebar=Color3.fromRGB(12,12,16),contentBg=Color3.fromRGB(15,15,20),tabColor=Color3.fromRGB(45,45,55),tabColorHover=Color3.fromRGB(65,65,80),tabColorDark=Color3.fromRGB(28,28,36),accent=Color3.fromRGB(130,130,150),splash=Color3.fromRGB(12,12,16),text=Color3.fromRGB(240,240,245),subtext=Color3.fromRGB(150,150,160)},
}
_G.KZ.C = {}
for k,v in pairs(_G.KZ.Themes.Turquoise) do _G.KZ.C[k]=v end
_G.KZ.C.toggleOff=Color3.fromRGB(95,78,68); _G.KZ.C.disabled=Color3.fromRGB(115,100,90)
_G.KZ.C.section=Color3.fromRGB(180,165,155); _G.KZ.C.closeRed=Color3.fromRGB(220,90,90)
_G.KZ.C.kzBlue=Color3.fromRGB(0,175,202); _G.KZ.C.kzGold=Color3.fromRGB(254,200,50)
_G.KZ.C.pink=Color3.fromRGB(255,105,180); _G.KZ.C.scrollbar=Color3.fromRGB(140,110,80)
_G.KZ.C.dropdown=Color3.fromRGB(35,26,22); _G.KZ.C.neon=Color3.fromRGB(255,215,0)
_G.KZ.C.neonRow=Color3.fromRGB(255,105,180); _G.KZ.C.neonRowHover=Color3.fromRGB(255,105,180)
_G.KZ.C.darkPink=Color3.fromRGB(120,20,60)

function _G.KZ.new(class, props)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k]=v end
    return o
end
function _G.KZ.corner(parent, r) return _G.KZ.new("UICorner", {CornerRadius=UDim.new(0,r or 8), Parent=parent}) end
function _G.KZ.findChildChain(root, ...)
    local node = root
    for _, name in ipairs({...}) do
        if not node then return nil end
        node = node:FindFirstChild(name)
    end
    return node
end
function _G.KZ.hasCustomFace(char)
    if not char then return false end
    local head = char:FindFirstChild("Head"); if not head then return false end
    local face = head:FindFirstChild("face")
    if not face or not face:IsA("Decal") then return false end
    local tex = tostring(face.Texture)
    return tex ~= "" and tex ~= "rbxasset://textures/face.png"
end

function _G.KZ.getWeaponList()
    local ReplicatedStorage = _G.KZ.ReplicatedStorage
    local player = _G.KZ.player
    local list = {"None"}
    local seen = { None = true }
    pcall(function()
        local configs = ReplicatedStorage:FindFirstChild("Configurations")
        if configs then
            local acsGuns = configs:FindFirstChild("ACS_Guns")
            if acsGuns then
                for _, gun in ipairs(acsGuns:GetChildren()) do
                    if not seen[gun.Name] then seen[gun.Name] = true; table.insert(list, gun.Name) end
                end
            end
        end
    end)
    local att = player:FindFirstChild("Attachments")
    if att then
        for _, weapon in ipairs(att:GetChildren()) do
            if not seen[weapon.Name] then seen[weapon.Name] = true; table.insert(list, weapon.Name) end
        end
    end
    table.sort(list)
    return list
end

-- TIME CHANGER
do
    local State = _G.KZ.State
    local Lighting = _G.KZ.Lighting
    local RunService = _G.KZ.RunService
    local savedClockTime = Lighting.ClockTime
    local function applyTime()
        if State.TimeChangerEnabled then
            Lighting.ClockTime = State.ClockHours + (State.ClockMinutes / 60)
        end
    end
    RunService.RenderStepped:Connect(applyTime)
    function _G.KZ.setTime(h, m)
        if h ~= nil then State.ClockHours = math.clamp(h, 0, 23) end
        if m ~= nil then State.ClockMinutes = math.clamp(m, 0, 59) end
        if State.TimeChangerEnabled then applyTime() end
    end
    function _G.KZ.applyTimeNow() applyTime() end
    function _G.KZ.disableTimeChanger()
        State.TimeChangerEnabled = false
        Lighting.ClockTime = savedClockTime
    end
end

-- FLY
do
    local State = _G.KZ.State
    local player = _G.KZ.player
    local RunService = _G.KZ.RunService
    local UserInputService = _G.KZ.UserInputService
    local new = _G.KZ.new
    local flyState = {active=false, bodyVelocity=nil, bodyGyro=nil, connection=nil, noclipConnection=nil, savedHeadSize=nil, savedHeadMesh=nil, savedAutoScaling=true, savedCollide=nil}
    _G.KZ.flyState = flyState
    local function enableFlyNoclip()
        if flyState.noclipConnection then flyState.noclipConnection:Disconnect() end
        flyState.savedCollide = {}
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    flyState.savedCollide[part] = part.CanCollide
                    part.CanCollide = false
                end
            end
        end
        flyState.noclipConnection = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if flyState.savedCollide and flyState.savedCollide[part] == nil then
                            flyState.savedCollide[part] = part.CanCollide
                        end
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    local function disableFlyNoclip()
        if flyState.noclipConnection then flyState.noclipConnection:Disconnect(); flyState.noclipConnection = nil end
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if flyState.savedCollide and flyState.savedCollide[part] ~= nil then
                        part.CanCollide = flyState.savedCollide[part]
                    end
                end
            end
        end
        flyState.savedCollide = nil
    end
    local function startFly()
        local char = player.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); local hum = char:FindFirstChild("Humanoid")
        if not root or not hum then return end
        local head = char:FindFirstChild("Head")
        flyState.savedHeadSize = head and head.Size or nil
        flyState.savedHeadMesh = nil
        if head then
            local m = head:FindFirstChildOfClass("SpecialMesh")
            if m then flyState.savedHeadMesh = m.Scale end
        end
        flyState.savedAutoScaling = hum.AutomaticScalingEnabled
        hum.AutomaticScalingEnabled = false
        if flyState.bodyVelocity then flyState.bodyVelocity:Destroy() end
        if flyState.bodyGyro then flyState.bodyGyro:Destroy() end
        flyState.bodyVelocity = new("BodyVelocity",{MaxForce=Vector3.new(1e9,1e9,1e9),Velocity=Vector3.new(0,0,0),Parent=root})
        flyState.bodyGyro = new("BodyGyro",{MaxTorque=Vector3.new(1e9,1e9,1e9),P=10000,CFrame=root.CFrame,Parent=root})
        hum.PlatformStand = true
        flyState.active = true
        enableFlyNoclip()
        if flyState.connection then flyState.connection:Disconnect() end
        flyState.connection = RunService.RenderStepped:Connect(function()
            if not flyState.active then return end
            local char = player.Character; if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart"); local hum = char:FindFirstChild("Humanoid")
            if not root or not hum or not flyState.bodyVelocity then return end
            local head = char:FindFirstChild("Head")
            if head and flyState.savedHeadSize and head.Size ~= flyState.savedHeadSize then head.Size = flyState.savedHeadSize end
            if head and flyState.savedHeadMesh then
                local m = head:FindFirstChildOfClass("SpecialMesh")
                if m and m.Scale ~= flyState.savedHeadMesh then m.Scale = flyState.savedHeadMesh end
            end
            local cam = workspace.CurrentCamera
            if flyState.bodyGyro then flyState.bodyGyro.CFrame = CFrame.new(root.Position, root.Position + cam.CFrame.LookVector) end
            local moveDir = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then moveDir = moveDir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveDir = moveDir - Vector3.new(0,1,0) end
            if moveDir.Magnitude > 0 then flyState.bodyVelocity.Velocity = moveDir.Unit * State.flySpeed
            else flyState.bodyVelocity.Velocity = Vector3.new(0,0,0) end
        end)
    end
    function _G.KZ.stopFly()
        if flyState.bodyVelocity then flyState.bodyVelocity:Destroy(); flyState.bodyVelocity = nil end
        if flyState.bodyGyro then flyState.bodyGyro:Destroy(); flyState.bodyGyro = nil end
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.AutomaticScalingEnabled = flyState.savedAutoScaling
            end
            local head = char:FindFirstChild("Head")
            if head and flyState.savedHeadSize then
                head.Size = flyState.savedHeadSize
                if flyState.savedHeadMesh then
                    local m = head:FindFirstChildOfClass("SpecialMesh")
                    if m then m.Scale = flyState.savedHeadMesh end
                end
            end
        end
        if flyState.connection then flyState.connection:Disconnect(); flyState.connection = nil end
        flyState.active = false
        flyState.savedHeadSize = nil
        flyState.savedHeadMesh = nil
        disableFlyNoclip()
    end
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if not State.flyEnabled then return end
        if input.KeyCode.Name == State.flyKey then
            if flyState.active then _G.KZ.stopFly() else startFly() end
        end
    end)
    RunService.Stepped:Connect(function() if not State.flyEnabled and flyState.active then _G.KZ.stopFly() end end)
end

-- FAST SHOT
do
    local ReplicatedStorage = _G.KZ.ReplicatedStorage
    local TweenService = _G.KZ.TweenService
    function _G.KZ.toggleFastShot(enabled)
        if enabled then
            pcall(function()
                local guns = { "Remington MSR", "M1903 Springfield", "M40 Sniper", "AWP", "Kar98K" }
                for _, gunName in pairs(guns) do
                    local configPath = ReplicatedStorage.Configurations.ACS_Guns:FindFirstChild(gunName)
                    if configPath then
                        local anim = require(configPath.Animations); local set = require(configPath.Settings)
                        anim.EquipAnim = function(_, _, p4)
                            TweenService:Create(p4[2], TweenInfo.new(0), { C1 = CFrame.new(-0.875, -0.2, -1.25) * CFrame.Angles(-1.0471975511965976, 0, 0) }):Play()
                            TweenService:Create(p4[3], TweenInfo.new(0), { C1 = CFrame.new(1.2, -0.05, -1.65) * CFrame.Angles(-1.5707963267948966, 0.6108652381980153, -0.4363323129985824) }):Play()
                            if p4[5]:FindFirstChild("Handle") then
                                TweenService:Create(p4[2], TweenInfo.new(0), {C1 = set.RightPos}):Play()
                                TweenService:Create(p4[3], TweenInfo.new(0), {C1 = set.LeftPos}):Play()
                            end
                        end
                    end
                end
            end)
        end
    end
end

-- HITBOX
do
    local State = _G.KZ.State
    local Players = _G.KZ.Players
    local player = _G.KZ.player
    local new = _G.KZ.new
    local hasCustomFace = _G.KZ.hasCustomFace

    local function fixHead(char)
        if not char or not char:IsA("Model") then return end
        if hasCustomFace(char) then return end
        local h = char:WaitForChild("Head", 5)
        if not h or not h:IsA("BasePart") then return end
        local HeadSize = State.hitboxHeadSize
        h.Size = Vector3.new(HeadSize, HeadSize, HeadSize)
        h.CanCollide = false; h.Transparency = 0.01; h.Massless = true
        local m = h:FindFirstChildOfClass("SpecialMesh")
        if not m then m = new("SpecialMesh",{Parent=h}) end
        local s = 1.25 / HeadSize
        m.Scale = Vector3.new(s,s,s); m.MeshType = Enum.MeshType.Head
        for _, a in ipairs(char:GetChildren()) do
            if a:IsA("Accessory") then
                local han = a:FindFirstChild("Handle")
                if han then han.CanTouch=false; han.CanQuery=false
                    local att = han:FindFirstChildOfClass("Attachment"); if att then att.Position = Vector3.new(0,0,0) end
                end
            end
        end
    end
    _G.KZ.fixHead = fixHead
    local function startFixingPlayer(p)
        if p == player then return end
        p.CharacterAdded:Connect(function(char) task.wait(0.1); if State.hitboxEnabled then pcall(function() fixHead(char) end) end end)
        if p.Character and State.hitboxEnabled then pcall(function() fixHead(p.Character) end) end
    end
    for _, p in ipairs(Players:GetPlayers()) do startFixingPlayer(p) end
    Players.PlayerAdded:Connect(function(p) startFixingPlayer(p) end)
    task.spawn(function() while true do if State.hitboxEnabled then for _, p in ipairs(Players:GetPlayers()) do if p ~= player and p.Character then pcall(function() fixHead(p.Character) end) end end end task.wait(0.5) end end)

    local activeHeads = {}
    local function fixBigHead(char)
        if not char or not char:IsA("Model") then return end
        local h = char:FindFirstChild("Head")
        if not h or not h:IsA("BasePart") then return end
        local headKey = tostring(char)
        activeHeads[headKey] = true
        local originalMesh = h:FindFirstChildOfClass("SpecialMesh")
        local originalScale = originalMesh and originalMesh.Scale or Vector3.new(1, 1, 1)
        local originalMeshType = originalMesh and originalMesh.MeshType or Enum.MeshType.Head
        local originalTransparency = h.Transparency
        local HeadSize = State.invisibleHitboxSize or 2.6
        h.Size = Vector3.new(HeadSize, HeadSize, HeadSize)
        h.CanCollide = false
        h.Transparency = originalTransparency
        h.Massless = true
        local m = h:FindFirstChildOfClass("SpecialMesh")
        if not m then
            m = Instance.new("SpecialMesh", h)
            m.MeshType = originalMeshType
        end
        if originalMesh then
            m.TextureID = originalMesh.TextureID
            m.MeshId = originalMesh.MeshId
            m.VertexColor = originalMesh.VertexColor
        end
        local baseSize = 1.25
        local scaleFactor = baseSize / HeadSize
        m.Scale = originalScale * scaleFactor
        if originalMeshType == Enum.MeshType.Head then
            m.Scale = Vector3.new(scaleFactor, scaleFactor, scaleFactor)
        end
        for _, a in ipairs(char:GetChildren()) do
            if a:IsA("Accessory") then
                local han = a:FindFirstChild("Handle")
                if han then
                    han.CanTouch = false
                    han.CanQuery = false
                    local att = han:FindFirstChildOfClass("Attachment")
                    if att then att.Position = Vector3.new(0, 0, 0) end
                end
            end
        end
    end

    local invisibleHitboxLoopActive = false
    function _G.KZ.enableInvisibleHitbox()
        if invisibleHitboxLoopActive then return end
        invisibleHitboxLoopActive = true
        task.spawn(function()
            while invisibleHitboxLoopActive and State.invisibleHitboxEnabled do
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                        pcall(function() fixBigHead(p.Character) end)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
    function _G.KZ.disableInvisibleHitbox() invisibleHitboxLoopActive = false end
end

-- NO RECOIL + AMMO
do
    local State = _G.KZ.State
    local ReplicatedStorage = _G.KZ.ReplicatedStorage
    local player = _G.KZ.player
    local noRecoilActive = false
    local patchedModules = {}
    local RECOIL_KEYWORDS = { "recoil", "kickback", "kick", "aimpunch", "punch", "spread", "inacc", "bloom", "scatter", "dispersion", "deviation", "sway", "shake" }
    local HARD_BLACKLIST = { "anim", "id", "name", "type", "rate", "firerate", "damage", "range", "ammo", "mag", "clip", "reload", "model", "handle", "sound", "sensitivity", "fov", "zoom", "crosshair", "cross", "optic", "sight", "gui", "hud", "view" }
    local function hasBlacklist(key)
        local n = tostring(key):lower()
        for _, kw in ipairs(HARD_BLACKLIST) do if n:find(kw) then return true end end
        return false
    end
    local function isRecoilKey(key)
        if hasBlacklist(key) then return false end
        local n = tostring(key):lower()
        for _, kw in ipairs(RECOIL_KEYWORDS) do if n:find(kw) then return true end end
        return false
    end
    local function zeroRecoilTable(tbl, depth, visited)
        if type(tbl) ~= "table" then return end
        depth = depth or 1; if depth > 6 then return end
        visited = visited or {}
        if visited[tbl] then return end
        visited[tbl] = true
        for k, v in pairs(tbl) do
            if type(v) == "number" and isRecoilKey(k) then tbl[k] = 0
            elseif type(v) == "table" then zeroRecoilTable(v, depth + 1, visited) end
        end
    end
    local SNIPER_NAMES = { "AWP", "Remington MSR", "M40 Sniper", "RemingtonMSR", "M40" }
    local function patchSniper(gunName)
        if patchedModules[gunName] then return end
        local configs = ReplicatedStorage:FindFirstChild("Configurations"); if not configs then return end
        local acsGuns = configs:FindFirstChild("ACS_Guns"); if not acsGuns then return end
        local gunFolder = acsGuns:FindFirstChild(gunName)
        if not gunFolder then patchedModules[gunName] = true; return end
        for _, modName in ipairs({"Settings", "Config"}) do
            local mod = gunFolder:FindFirstChild(modName)
            if mod and mod:IsA("ModuleScript") then
                local ok, m = pcall(require, mod)
                if ok and type(m) == "table" then zeroRecoilTable(m, 1) end
            end
        end
        patchedModules[gunName] = true
    end
    function _G.KZ.enableNoRecoil()
        if noRecoilActive then return end
        noRecoilActive = true
        for _, name in ipairs(SNIPER_NAMES) do pcall(function() patchSniper(name) end) end
    end
    function _G.KZ.disableNoRecoil()
        if not noRecoilActive then return end
        noRecoilActive = false; patchedModules = {}
    end
    local infiniteAmmoActive = false
    local function refillAmmo(tool)
        if not tool or not tool:IsA("Tool") then return end
        pcall(function()
            tool:SetAttribute("Ammo", math.huge); tool:SetAttribute("MaxAmmo", math.huge)
            tool:SetAttribute("Clip", math.huge); tool:SetAttribute("Magazine", math.huge)
            for _, obj in ipairs(tool:GetDescendants()) do
                if obj:IsA("NumberValue") then
                    local n = obj.Name:lower()
                    if n:find("ammo") or n:find("clip") or n:find("mag") then obj.Value = 9999 end
                end
            end
        end)
    end
    local function applyInfiniteAmmoAll()
        pcall(function()
            local bp = player:FindFirstChildOfClass("Backpack")
            if bp then for _, tool in ipairs(bp:GetChildren()) do if tool:IsA("Tool") then refillAmmo(tool) end end end
            if player.Character then for _, tool in ipairs(player.Character:GetChildren()) do if tool:IsA("Tool") then refillAmmo(tool) end end end
        end)
    end
    function _G.KZ.enableInfiniteAmmo()
        if infiniteAmmoActive then return end
        infiniteAmmoActive = true; applyInfiniteAmmoAll()
        task.spawn(function() while infiniteAmmoActive do pcall(applyInfiniteAmmoAll); task.wait(0.1) end end)
    end
    function _G.KZ.disableInfiniteAmmo() infiniteAmmoActive = false end
end

-- AIMBOT
do
    local State = _G.KZ.State
    local Players = _G.KZ.Players
    local player = _G.KZ.player
    local RunService = _G.KZ.RunService
    local UserInputService = _G.KZ.UserInputService
    local aimbot = { active=false, aiming=false, character=nil, humanoidRootPart=nil, lastShotTime=0, shootInterval=0.15, maxDistance=300, connections={} }
    local function isWhitelisted(targetPlayer)
        local list = State.aimbotWhitelist
        if not list or #list == 0 then return false end
        local tName = targetPlayer.Name:lower()
        local tDisp = targetPlayer.DisplayName:lower()
        for _, entry in ipairs(list) do
            local e = entry:lower():gsub("^@", "")
            if e == tName or e == tDisp then return true end
        end
        return false
    end
    _G.KZ.isWhitelisted = isWhitelisted

    function _G.KZ.getServerPlayers()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then table.insert(list, p.Name) end
        end
        table.sort(list)
        if #list == 0 then table.insert(list, "— никого —") end
        return list
    end

    local function getNearestEnemy()
        local nearest, minDist = nil, math.huge
        local camera = workspace.CurrentCamera
        local root = aimbot.humanoidRootPart; if not root then return nil end
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player and not isWhitelisted(otherPlayer) then
                local otherChar = otherPlayer.Character
                if otherChar and otherChar:FindFirstChild("Head") and otherChar:FindFirstChild("Humanoid") and otherChar.Humanoid.Health > 0 then
                    local head = otherChar.Head
                    local distance = (head.Position - root.Position).Magnitude
                    local _, onScreen = camera:WorldToViewportPoint(head.Position)
                    if onScreen and distance < aimbot.maxDistance and distance < minDist then
                        minDist = distance; nearest = otherPlayer
                    end
                end
            end
        end
        return nearest
    end
    local function shoot()
        local char = aimbot.character; if not char then return false end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool and tool:IsA("Tool") then tool:Activate(); return true end
        return false
    end
    local function autoAim()
        if not aimbot.active or not aimbot.aiming then return end
        local enemy = getNearestEnemy()
        if enemy then
            local head = enemy.Character.Head
            local camera = workspace.CurrentCamera
            camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position)
            if tick() - aimbot.lastShotTime >= aimbot.shootInterval then
                if shoot() then aimbot.lastShotTime = tick() end
            end
        end
    end
    local function onAimbotCharAdded(newChar)
        aimbot.character = newChar
        aimbot.humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    end
    function _G.KZ.startAimbotModule()
        if aimbot.active then return end
        aimbot.active = true; aimbot.aiming = true
        aimbot.character = player.Character or player.CharacterAdded:Wait()
        aimbot.humanoidRootPart = aimbot.character:WaitForChild("HumanoidRootPart")
        table.insert(aimbot.connections, player.CharacterAdded:Connect(onAimbotCharAdded))
        table.insert(aimbot.connections, UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.Z then aimbot.aiming = not aimbot.aiming end
        end))
        table.insert(aimbot.connections, RunService.RenderStepped:Connect(autoAim))
    end
    function _G.KZ.stopAimbotModule()
        if not aimbot.active then return end
        aimbot.active = false; aimbot.aiming = false
        for _, conn in ipairs(aimbot.connections) do pcall(function() conn:Disconnect() end) end
        aimbot.connections = {}
        aimbot.character = nil; aimbot.humanoidRootPart = nil
    end
    function _G.KZ.addToAimbotWhitelist(name)
        if not name or name == "" then return false end
        name = name:gsub("^%s+", ""):gsub("%s+$", "")
        if name == "" then return false end
        for _, e in ipairs(State.aimbotWhitelist) do
            if e:lower() == name:lower() then return false end
        end
        table.insert(State.aimbotWhitelist, name)
        print("[KZ Hub] Добавлен в whitelist: " .. name)
        return true
    end
    function _G.KZ.removeFromAimbotWhitelist(name)
        if not name or name == "" then return false end
        for i = #State.aimbotWhitelist, 1, -1 do
            if State.aimbotWhitelist[i]:lower() == name:lower() then
                table.remove(State.aimbotWhitelist, i)
                print("[KZ Hub] Удалён из whitelist: " .. name)
                return true
            end
        end
        return false
    end
    function _G.KZ.clearAimbotWhitelist()
        State.aimbotWhitelist = {}
        print("[KZ Hub] Whitelist очищен")
    end
    function _G.KZ.getAimbotWhitelistString()
        if #State.aimbotWhitelist == 0 then return "— пусто —" end
        return table.concat(State.aimbotWhitelist, ", ")
    end
end

-- SILENT AIM — БЕЗ ХУКОВ
do
    local SilentAimSettings = {
        Enabled = false,
        TeamCheck = false,
        TargetPart = "Head",
        FOVRadius = 130,
        FOVVisible = false,
        AutoClick = true,
        LMBEnabled = true,
        RMBEnabled = true,
    }
    _G.KZ.SilentAim = SilentAimSettings

    local Players = _G.KZ.Players
    local LocalPlayer = _G.KZ.player
    local RunService = _G.KZ.RunService
    local UserInputService = _G.KZ.UserInputService

    local isLeftMouseDown = false
    local isRightMouseDown = false
    local autoClickConnection = nil
    local lastTargetScan = 0
    local cachedTarget = nil

    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 100
    fov_circle.Radius = SilentAimSettings.FOVRadius
    fov_circle.Filled = false
    fov_circle.Visible = false
    fov_circle.ZIndex = 999
    fov_circle.Transparency = 1
    fov_circle.Color = Color3.fromRGB(110, 225, 235)

    local function getClosestPlayer()
        local now = tick()
        if now - lastTargetScan < 0.05 then return cachedTarget end
        lastTargetScan = now

        local closestPlayer = nil
        local shortestDistance = math.huge
        local mousePosition = UserInputService:GetMouseLocation()
        local cam = workspace.CurrentCamera
        if not cam then return nil end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if not (SilentAimSettings.TeamCheck and p.Team == LocalPlayer.Team) then
                    local char = p.Character
                    if char then
                        local part = char:FindFirstChild(SilentAimSettings.TargetPart) or char:FindFirstChild("Head")
                        if part then
                            local pos, onScreen = cam:WorldToViewportPoint(part.Position)
                            if onScreen and pos.Z > 0 then
                                local sp = Vector2.new(pos.X, pos.Y)
                                local distance = (sp - mousePosition).Magnitude
                                if distance < shortestDistance and distance <= SilentAimSettings.FOVRadius then
                                    closestPlayer = p
                                    shortestDistance = distance
                                end
                            end
                        end
                    end
                end
            end
        end
        cachedTarget = closestPlayer
        return closestPlayer
    end

    local function snapCameraToTarget()
        local target = getClosestPlayer()
        if target and target.Character then
            local part = target.Character:FindFirstChild(SilentAimSettings.TargetPart) or target.Character:FindFirstChild("Head")
            if part then
                local cam = workspace.CurrentCamera
                if cam then
                    cam.CFrame = CFrame.new(cam.CFrame.Position, part.Position)
                    return true
                end
            end
        end
        return false
    end

    local function fireClick()
        pcall(function()
            if type(mouse1click) == "function" then
                mouse1click()
            elseif type(mouse1down) == "function" and type(mouse1up) == "function" then
                mouse1down(); mouse1up()
            end
        end)
    end

    local function autoClick()
        if autoClickConnection then
            autoClickConnection:Disconnect()
        end
        autoClickConnection = RunService.Heartbeat:Connect(function()
            if not SilentAimSettings.Enabled or not SilentAimSettings.AutoClick then return end
            if not (isLeftMouseDown or isRightMouseDown) then
                autoClickConnection:Disconnect()
                return
            end
            local cam = workspace.CurrentCamera
            if not cam then return end
            local savedCFrame = cam.CFrame
            snapCameraToTarget()
            fireClick()
            cam.CFrame = savedCFrame
        end)
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if not SilentAimSettings.Enabled then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if SilentAimSettings.LMBEnabled and not isLeftMouseDown then
                isLeftMouseDown = true
                local cam = workspace.CurrentCamera
                if cam then
                    local savedCFrame = cam.CFrame
                    snapCameraToTarget()
                    task.spawn(function()
                        RunService.Heartbeat:Wait()
                        cam.CFrame = savedCFrame
                    end)
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            if SilentAimSettings.RMBEnabled and not isRightMouseDown then
                isRightMouseDown = true
                autoClick()
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isLeftMouseDown = false
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            isRightMouseDown = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if SilentAimSettings.FOVVisible and SilentAimSettings.Enabled then
            fov_circle.Visible = true
            fov_circle.Radius = SilentAimSettings.FOVRadius
            fov_circle.Position = UserInputService:GetMouseLocation()
        else
            fov_circle.Visible = false
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightAlt then
            SilentAimSettings.Enabled = not SilentAimSettings.Enabled
            print("[KZ Hub] Silent Aim: " .. tostring(SilentAimSettings.Enabled))
        end
    end)
end

-- ESP
do
    local Players = _G.KZ.Players
    local LocalPlayer = _G.KZ.player
    local RunService = _G.KZ.RunService
    local Workspace = workspace

    local ESP_Settings = {
        Enabled = false,
        Box = false,
        Tracers = false,
        Thickness = 1,
        Transparency = 1,
        TeamCheck = false,
    }
    _G.KZ.ESP = ESP_Settings

    local ESP_Data = {}

    local function Create3DBox()
        local lines = {}
        for i = 1, 12 do
            local line = Drawing.new("Line")
            line.Visible = false
            line.Transparency = 1
            line.Thickness = ESP_Settings.Thickness
            lines[i] = line
        end
        return lines
    end

    local function CreateTracer()
        local line = Drawing.new("Line")
        line.Visible = false
        line.Transparency = 1
        line.Thickness = ESP_Settings.Thickness
        return line
    end

    local function AddPlayer(p)
        if p == LocalPlayer then return end
        if ESP_Data[p] then return end
        ESP_Data[p] = {
            Box = Create3DBox(),
            Tracer = CreateTracer()
        }
    end

    for _, p in pairs(Players:GetPlayers()) do AddPlayer(p) end
    Players.PlayerAdded:Connect(AddPlayer)
    Players.PlayerRemoving:Connect(function(p)
        if ESP_Data[p] then
            for _, l in pairs(ESP_Data[p].Box) do pcall(function() l:Remove() end) end
            pcall(function() ESP_Data[p].Tracer:Remove() end)
            ESP_Data[p] = nil
        end
    end)

    RunService.RenderStepped:Connect(function()
        local cam = Workspace.CurrentCamera
        if not cam then return end

        for player, obj in pairs(ESP_Data) do
            if player and player ~= LocalPlayer then
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")

                local isTeammate = ESP_Settings.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team

                if ESP_Settings.Enabled and char and root and humanoid and humanoid.Health > 0 and not isTeammate then
                    local color = (player.Team and player.Team.TeamColor) and player.Team.TeamColor.Color or Color3.new(1,1,1)
                    local pos, onScreen = cam:WorldToViewportPoint(root.Position)

                    if onScreen and pos.Z > 0 then
                        if ESP_Settings.Box then
                            local size = Vector3.new(4, 6, 4)
                            local cf = root.CFrame
                            local corners = {
                                cf * CFrame.new(-size.X/2, size.Y/2, -size.X/2),
                                cf * CFrame.new(size.X/2, size.Y/2, -size.X/2),
                                cf * CFrame.new(size.X/2, -size.Y/2, -size.X/2),
                                cf * CFrame.new(-size.X/2, -size.Y/2, -size.X/2),
                                cf * CFrame.new(-size.X/2, size.Y/2, size.X/2),
                                cf * CFrame.new(size.X/2, size.Y/2, size.X/2),
                                cf * CFrame.new(size.X/2, -size.Y/2, size.X/2),
                                cf * CFrame.new(-size.X/2, -size.Y/2, size.X/2)
                            }
                            local p = {}
                            for i, corner in ipairs(corners) do
                                p[i] = cam:WorldToViewportPoint(corner.Position)
                            end
                            local connections = {
                                {1,2},{2,3},{3,4},{4,1},
                                {5,6},{6,7},{7,8},{8,5},
                                {1,5},{2,6},{3,7},{4,8}
                            }
                            for i, conn in ipairs(connections) do
                                local line = obj.Box[i]
                                if line then
                                    line.From = Vector2.new(p[conn[1]].X, p[conn[1]].Y)
                                    line.To = Vector2.new(p[conn[2]].X, p[conn[2]].Y)
                                    line.Color = color
                                    line.Thickness = ESP_Settings.Thickness
                                    line.Transparency = ESP_Settings.Transparency
                                    line.Visible = true
                                end
                            end
                            for i = #connections + 1, 12 do
                                if obj.Box[i] then obj.Box[i].Visible = false end
                            end
                        else
                            for _, line in pairs(obj.Box) do line.Visible = false end
                        end

                        if ESP_Settings.Tracers then
                            obj.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                            obj.Tracer.To = Vector2.new(pos.X, pos.Y)
                            obj.Tracer.Color = color
                            obj.Tracer.Thickness = ESP_Settings.Thickness
                            obj.Tracer.Transparency = ESP_Settings.Transparency
                            obj.Tracer.Visible = true
                        else
                            obj.Tracer.Visible = false
                        end
                    else
                        for _, line in pairs(obj.Box) do line.Visible = false end
                        obj.Tracer.Visible = false
                    end
                else
                    for _, line in pairs(obj.Box) do line.Visible = false end
                    obj.Tracer.Visible = false
                end
            end
        end
    end)
end

-- SKIN CHANGER + PRESETS
do
    local State = _G.KZ.State
    local player = _G.KZ.player
    local HttpService = _G.KZ.HttpService
    local findChildChain = _G.KZ.findChildChain
    function _G.KZ.scGetSkins()
        local list = {"None"}
        local seen = { None = true }
        local pg = player:FindFirstChildOfClass("PlayerGui"); if not pg then return list end
        local frame = findChildChain(pg, "UI", "Container", "Screen", "GunSkins", "Menu", "Body", "Main", "Index", "Frame")
        if not frame then return list end
        for _, row in ipairs(frame:GetChildren()) do
            if row.Name == "SingleRow" then
                for _, btn in ipairs(row:GetChildren()) do
                    if btn:IsA("ImageButton") and not seen[btn.Name] then
                        seen[btn.Name] = true
                        table.insert(list, btn.Name)
                    end
                end
            end
        end
        table.sort(list)
        return list
    end
    local PRESETS_FILE = "KZHub_SkinPresets.json"
    local SkinPresets = {}
    local selectedPreset = "None"
    _G.KZ.getSelectedPreset = function() return selectedPreset end
    _G.KZ.setSelectedPreset = function(v) selectedPreset = v end
    local function saveSkinPresetsToFile()
        pcall(function() if writefile then writefile(PRESETS_FILE, HttpService:JSONEncode(SkinPresets)) end end)
    end
    local function loadSkinPresetsFromFile()
        pcall(function()
            if isfile and isfile(PRESETS_FILE) and readfile then
                local data = readfile(PRESETS_FILE)
                if data and data ~= "" then
                    local ok, tbl = pcall(function() return HttpService:JSONDecode(data) end)
                    if ok and type(tbl) == "table" then SkinPresets = tbl end
                end
            end
        end)
    end
    function _G.KZ.savePresetForWeapon(weaponName)
        if not weaponName or weaponName == "" or weaponName == "None" then return false end
        SkinPresets[weaponName] = {
            camo1=State.SC_Camo1, camo2=State.SC_Camo2, anim1=State.SC_Anim1, anim2=State.SC_Anim2,
            useC1=State.SC_UseColor1, useC2=State.SC_UseColor2,
            c1r=State.SC_Color1R, c1g=State.SC_Color1G, c1b=State.SC_Color1B,
            c2r=State.SC_Color2R, c2g=State.SC_Color2G, c2b=State.SC_Color2B,
        }
        saveSkinPresetsToFile()
        return true
    end
    local function applyPresetToWeaponObject(weapon, preset)
        if not weapon or not preset then return false end
        weapon:SetAttribute("Camo1", (preset.camo1 and preset.camo1 ~= "None") and preset.camo1 or nil)
        weapon:SetAttribute("Camo2", (preset.camo2 and preset.camo2 ~= "None") and preset.camo2 or nil)
        weapon:SetAttribute("Camo1Animated", preset.anim1 ~= false)
        weapon:SetAttribute("Camo2Animated", preset.anim2 ~= false)
        if preset.useC1 then weapon:SetAttribute("Camo1Color", Color3.fromRGB(preset.c1r or 255, preset.c1g or 255, preset.c1b or 255)) else weapon:SetAttribute("Camo1Color", nil) end
        if preset.useC2 then weapon:SetAttribute("Camo2Color", Color3.fromRGB(preset.c2r or 255, preset.c2g or 255, preset.c2b or 255)) else weapon:SetAttribute("Camo2Color", nil) end
        return true
    end
    function _G.KZ.applyPresetForWeapon(weaponName)
        local p = SkinPresets[weaponName]; if not p then return false end
        local att = player:FindFirstChild("Attachments"); if not att then return false end
        local weapon = att:FindFirstChild(weaponName); if not weapon then return false end
        return applyPresetToWeaponObject(weapon, p)
    end
    function _G.KZ.loadPresetIntoState(weaponName)
        local p = SkinPresets[weaponName]; if not p then return end
        State.SC_Camo1 = p.camo1 or "None"; State.SC_Camo2 = p.camo2 or "None"
        State.SC_Anim1 = p.anim1 ~= false; State.SC_Anim2 = p.anim2 ~= false
        State.SC_UseColor1 = p.useC1 == true; State.SC_UseColor2 = p.useC2 == true
        State.SC_Color1R = p.c1r or 255; State.SC_Color1G = p.c1g or 255; State.SC_Color1B = p.c1b or 255
        State.SC_Color2R = p.c2r or 255; State.SC_Color2G = p.c2g or 255; State.SC_Color2B = p.c2b or 255
    end
    function _G.KZ.deletePreset(weaponName)
        if SkinPresets[weaponName] then SkinPresets[weaponName] = nil; saveSkinPresetsToFile() end
    end
    function _G.KZ.getPresetNames()
        local names = {}
        for k, _ in pairs(SkinPresets) do table.insert(names, k) end
        table.sort(names)
        if #names == 0 then table.insert(names, "— пусто —") end
        return names
    end
    loadSkinPresetsFromFile()
    function _G.KZ.scApply()
        if State.SC_Weapon == "" or State.SC_Weapon == "None" then return end
        if SkinPresets[State.SC_Weapon] then
            if _G.KZ.applyPresetForWeapon(State.SC_Weapon) then return end
        end
        local att = player:FindFirstChild("Attachments"); if not att then return end
        local weapon = att:FindFirstChild(State.SC_Weapon); if not weapon then return end
        weapon:SetAttribute("Camo1", (State.SC_Camo1 ~= "None") and State.SC_Camo1 or nil)
        weapon:SetAttribute("Camo2", (State.SC_Camo2 ~= "None") and State.SC_Camo2 or nil)
        weapon:SetAttribute("Camo1Animated", State.SC_Anim1)
        weapon:SetAttribute("Camo2Animated", State.SC_Anim2)
        if State.SC_UseColor1 then weapon:SetAttribute("Camo1Color", Color3.fromRGB(State.SC_Color1R, State.SC_Color1G, State.SC_Color1B)) else weapon:SetAttribute("Camo1Color", nil) end
        if State.SC_UseColor2 then weapon:SetAttribute("Camo2Color", Color3.fromRGB(State.SC_Color2R, State.SC_Color2G, State.SC_Color2B)) else weapon:SetAttribute("Camo2Color", nil) end
    end
    function _G.KZ.scReset()
        if State.SC_Weapon == "" or State.SC_Weapon == "None" then return end
        local att = player:FindFirstChild("Attachments")
        local weapon = att and att:FindFirstChild(State.SC_Weapon)
        if weapon then
            weapon:SetAttribute("Camo1", nil); weapon:SetAttribute("Camo2", nil)
            weapon:SetAttribute("Camo1Color", nil); weapon:SetAttribute("Camo2Color", nil)
        end
    end
end

-- VISUAL ACCESSORIES
do
    local State = _G.KZ.State
    local player = _G.KZ.player
    local new = _G.KZ.new
    local accessoryFolder = nil; local currentAccessoryName = nil
    _G.KZ.getCurrentAccessoryName = function() return currentAccessoryName end
    _G.KZ.setCurrentAccessoryName = function(v) currentAccessoryName = v end
    local function ensureFolder()
        local char = player.Character; if not char then return nil end
        if not accessoryFolder or not accessoryFolder.Parent or accessoryFolder.Parent ~= char then
            if accessoryFolder then pcall(function() accessoryFolder:Destroy() end) end
            accessoryFolder = new("Folder",{Name="KZ_Accessories",Parent=char})
        end
        return accessoryFolder
    end
    function _G.KZ.removeAccessory()
        if accessoryFolder then for _, c in ipairs(accessoryFolder:GetChildren()) do c:Destroy() end end
        currentAccessoryName = nil
    end
    local function createHat(config)
        local char = player.Character; if not char then return end
        _G.KZ.removeAccessory(); if not ensureFolder() then return end
        local ap = char:FindFirstChild(config.attachTo or "Head"); if not ap then return end
        for i, pd in ipairs(config.parts) do
            local part = new("Part",{Name="KZ_Acc_"..i,Size=pd.size or Vector3.new(1,1,1),Color=State.AccessoryColor,Material=Enum.Material.Neon,Transparency=0.55,Anchored=false,CanCollide=false,Massless=true,CastShadow=false})
            if pd.shape == "Ball" then part.Shape = Enum.PartType.Ball end
            if pd.meshId then new("SpecialMesh",{MeshType=Enum.MeshType.FileMesh,MeshId=pd.meshId,Scale=pd.meshScale or Vector3.new(1,1,1),Parent=part}) end
            new("Weld",{Part0=ap,Part1=part,C0=CFrame.new(pd.offset or Vector3.new(0,1,0)),Parent=part})
            new("Highlight",{FillColor=State.AccessoryColor,FillTransparency=0.55,OutlineColor=State.AccessoryColor,OutlineTransparency=0.5,Parent=part})
            part.Parent = accessoryFolder
        end
    end
    local function createAngelWings()
        local char = player.Character; if not char then return end
        _G.KZ.removeAccessory(); if not ensureFolder() then return end
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        if not root then return end
        local SCALE = 1.4
        for side = -1, 1, 2 do for row = 1, 3 do
            local fc = 9 + row * 2
            local rowZ = 0.55 - (row - 1) * 0.1; local rlm = 1 - (row - 1) * 0.13; local rym = 1 - (row - 1) * 0.07
            for i = 1, fc do
                local t = (i - 1) / (fc - 1); local alpha = math.rad(t * 70)
                local len = (1.9 + t * 2.4) * SCALE * rlm
                if t > 0.88 then len = len * 0.72 end
                local f = new("Part",{Size=Vector3.new(0.08*SCALE,len,0.28*SCALE),Color=State.AccessoryColor,Material=Enum.Material.Neon,Transparency=0.55,CanCollide=false,Massless=true,Anchored=false,CastShadow=false})
                local dx = math.sin(alpha) * side; local dy = -math.cos(alpha)
                local xB = side * (0.55 + t * 2.1); local yB = 1.35 * rym - t * 0.25; local zB = rowZ + t * 0.12
                local cx = xB + dx * len / 2; local cy = yB + dy * len / 2
                local phi = math.pi + alpha * side; local bl = math.rad(10 + t * 15)
                new("Weld",{Part0=root,Part1=f,C0=CFrame.new(cx,cy,zB)*CFrame.Angles(bl,0,phi),Parent=f})
                f.Parent = accessoryFolder
            end
        end end
    end
    local AccessoriesList = {
        ChinaHat = {attachTo="Head", parts={{meshId="rbxassetid://1033714", meshScale=Vector3.new(1.7,1.1,1.7), offset=Vector3.new(0,0.9,0)}}},
        AngelWings = {custom=true}
    }
    function _G.KZ.equipAccessory(key)
        local config = AccessoriesList[key]; if not config then return end
        if currentAccessoryName == key then _G.KZ.removeAccessory(); return end
        if key == "AngelWings" then createAngelWings(); currentAccessoryName = key
        else createHat(config); currentAccessoryName = key end
    end
    function _G.KZ.refreshAccessoryColor()
        if currentAccessoryName then
            local n = currentAccessoryName
            currentAccessoryName = nil
            task.wait(0.05)
            pcall(function() _G.KZ.equipAccessory(n) end)
        end
    end
    player.CharacterAdded:Connect(function(newChar)
        State.CurrentKillStreak = 0
        task.wait(1)
        if currentAccessoryName then
            local n = currentAccessoryName
            currentAccessoryName = nil
            pcall(function() _G.KZ.equipAccessory(n) end)
        end
    end)
end

-- ID UTILS
do
    function _G.KZ.extractId(str)
        if not str then return nil end
        local s = tostring(str)
        s = s:gsub("rbxassetid://", ""):gsub("rbxasset://", "")
        s = s:gsub("https://", ""):gsub("http://", ""):gsub("www%.", "")
        s = s:gsub("roblox%.com/catalog/", ""):gsub("roblox%.com/library/", "")
        local numStr = s:match("%d%d%d+")
        if not numStr then warn("[KZ Hub] Нет ID в '" .. s .. "'") return nil end
        return tonumber(numStr)
    end
    local function fetchAssetXml(id)
        local urls = {
            "https://assetdelivery.roblox.com/v1/asset/?id=" .. id,
            "https://assetdelivery.roblox.com/v1/asset?id=" .. id,
            "https://www.roblox.com/asset/?id=" .. id,
        }
        for _, url in ipairs(urls) do
            local ok, res = pcall(function() return game:HttpGet(url, true) end)
            if ok and type(res) == "string" and #res > 0 then
                local trimmed = res:gsub("^%s+", ""):gsub("%s+$", "")
                if trimmed:sub(1, 1) == "<" then return trimmed end
            end
        end
        return nil
    end
    function _G.KZ.tryLoadAsset(id)
        local ok1, res1 = pcall(function() return game:GetObjects("rbxassetid://" .. tostring(id)) end)
        if ok1 and type(res1) == "table" and #res1 > 0 then return res1[1], "GetObjects" end
        local xml = fetchAssetXml(id)
        if xml then
            local ok2, res2 = pcall(function() return game:GetService("InsertService"):LoadLocalAsset(xml) end)
            if ok2 and res2 then return res2, "LoadLocalAsset" end
        end
        return nil, "все способы не сработали"
    end
    function _G.KZ.extractHandle(model)
        for _, c in ipairs(model:GetDescendants()) do
            if c:IsA("Script") or c:IsA("LocalScript") or c:IsA("ModuleScript") or c:IsA("Humanoid") or c:IsA("Animator") or c:IsA("Sound") or c:IsA("ParticleEmitter") or c:IsA("Fire") or c:IsA("Smoke") or c:IsA("Trail") then
                pcall(function() c:Destroy() end)
            end
        end
        local handle
        if model:IsA("BasePart") then handle = model
        else
            handle = model:FindFirstChild("Handle", true)
            if not handle or not handle:IsA("BasePart") then
                for _, c in ipairs(model:GetDescendants()) do
                    if c:IsA("BasePart") then handle = c break end
                end
            end
        end
        return handle
    end
    function _G.KZ.sanitize(inst)
        if not inst then return end
        inst.Anchored = false; inst.CanCollide = false; inst.CanQuery = false
        inst.CanTouch = false; inst.Massless = true; inst.CastShadow = false
        for _, c in ipairs(inst:GetDescendants()) do
            if c:IsA("Script") or c:IsA("LocalScript") or c:IsA("ModuleScript")
               or c:IsA("Highlight") or c:IsA("ParticleEmitter") or c:IsA("Fire")
               or c:IsA("Smoke") or c:IsA("Sparkles") or c:IsA("Trail")
               or c:IsA("Beam") or c:IsA("Sound")
               or c:IsA("PointLight") or c:IsA("SpotLight") or c:IsA("SurfaceLight")
               or c:IsA("Motor6D") or c:IsA("HingeConstraint")
               or c:IsA("RopeConstraint") or c:IsA("RodConstraint")
               or c:IsA("SpringConstraint") or c:IsA("AlignPosition")
               or c:IsA("AlignOrientation") or c:IsA("BallSocketConstraint")
               or c:IsA("Humanoid") or c:IsA("Animator") then
                pcall(function() c:Destroy() end)
            end
        end
    end
end

-- FOV + LOW GRAPHICS + GAME UI HIDER
do
    local State = _G.KZ.State
    local player = _G.KZ.player
    local RunService = _G.KZ.RunService
    local StarterGui = _G.KZ.StarterGui
    local defaultFov = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or 70
    _G.KZ.defaultFov = defaultFov
    RunService.RenderStepped:Connect(function()
        if not State.FovEnabled then return end
        local cam = workspace.CurrentCamera; if not cam then return end
        if cam.FieldOfView ~= State.FovValue then cam.FieldOfView = State.FovValue end
    end)
    function _G.KZ.enableLowGraphics()
        pcall(function()
            _G.Settings = {Players={["Ignore Me"]=true,["Ignore Others"]=true},Meshes={Destroy=false,LowDetail=true},Images={Invisible=true,LowDetail=false,Destroy=false},["No Particles"]=true,["No Camera Effects"]=true,["No Explosions"]=true,["No Clothes"]=true,["Low Water Graphics"]=true,["No Shadows"]=true,["Low Rendering"]=true,["Low Quality Parts"]=true}
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
        end)
    end
    local function toggleGameUI()
        pcall(function()
            local pg = player:FindFirstChildOfClass("PlayerGui"); if not pg then return end
            local UI = pg:FindFirstChild("UI"); if not UI then return end
            local Container = UI:FindFirstChild("Container"); if not Container then return end
            local HUD = Container:FindFirstChild("HUD"); if not HUD then return end
            local hide = State.HideGameUI
            for _, child in ipairs(HUD:GetChildren()) do
                if child:IsA("GuiObject") then
                    if child.Name == "Map" or child.Name == "Menu" or child.Name == "Topbar" then child.Visible = not hide end
                end
            end
        end)
    end
    function _G.KZ.applyGameUI() toggleGameUI() end
    function _G.KZ.applyChat()
        pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not State.HideChat) end)
    end
    task.spawn(function() while true do if State.HideGameUI then toggleGameUI() end task.wait(0.5) end end)
end

-- M5WARE RPG TOOLS + GodMod Confirm
do
    local State = _G.KZ.State
    local player = _G.KZ.player
    local Players = _G.KZ.Players
    local ReplicatedStorage = _G.KZ.ReplicatedStorage
    local RunService = _G.KZ.RunService
    local StarterGui = _G.KZ.StarterGui
    local CoreGui = _G.KZ.CoreGui
    local Mouse = player:GetMouse()
    local Workspace = workspace

    local HitRemote = nil
    local rCnt = 0
    local mouseHeld = false
    local lastFireTime = 0
    local lastSwastikaTime = 0
    local lastSpamTime = 0

    local function InitRemotes()
        local rocketSystem = ReplicatedStorage:FindFirstChild("RocketSystem")
        if rocketSystem then
            local events = rocketSystem:FindFirstChild("Events")
            if events then
                HitRemote = events:FindFirstChild("RocketHit")
            end
        end
    end
    InitRemotes()
    _G.KZ.initM5Remotes = InitRemotes

    function _G.KZ.isRPGWhitelisted(targetPlayer)
        local list = State.RPG_Whitelist
        if not list or #list == 0 then return false end
        local tName = targetPlayer.Name:lower()
        local tDisp = targetPlayer.DisplayName:lower()
        for _, entry in ipairs(list) do
            local e = entry:lower():gsub("^@", "")
            if e == tName or e == tDisp then return true end
        end
        return false
    end

    function _G.KZ.addToRPGWhitelist(name)
        if not name or name == "" then return false end
        name = name:gsub("^%s+", ""):gsub("%s+$", "")
        if name == "" then return false end
        for _, e in ipairs(State.RPG_Whitelist) do
            if e:lower() == name:lower() then return false end
        end
        table.insert(State.RPG_Whitelist, name)
        print("[KZ Hub] RPG: добавлен в whitelist: " .. name)
        return true
    end

    function _G.KZ.removeFromRPGWhitelist(name)
        if not name or name == "" then return false end
        for i = #State.RPG_Whitelist, 1, -1 do
            if State.RPG_Whitelist[i]:lower() == name:lower() then
                table.remove(State.RPG_Whitelist, i)
                print("[KZ Hub] RPG: удалён из whitelist: " .. name)
                return true
            end
        end
        return false
    end

    function _G.KZ.clearRPGWhitelist()
        State.RPG_Whitelist = {}
        print("[KZ Hub] RPG: whitelist очищен")
    end

    function _G.KZ.getRPGWhitelistString()
        if #State.RPG_Whitelist == 0 then return "— пусто —" end
        return table.concat(State.RPG_Whitelist, ", ")
    end

    local WEAPON_KEYWORDS = {
        RPG = {"rpg", "ракетница", "rocket", "launcher", "гранатомёт", "базука", "rpg-7", "rpg7"},
        Stinger = {"stinger", "fim-92", "fim92", "стингер"},
        Javelin = {"javelin", "джавелин", "fgm-148", "fgm148"},
    }
    local function matches(name, kwList)
        name = name:lower()
        for _, kw in ipairs(kwList) do
            if name:find(kw, 1, true) then return true end
        end
        return false
    end
    local function FindWeapon()
        local char = player.Character
        if char then
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, kwList in pairs(WEAPON_KEYWORDS) do
                        if matches(tool.Name, kwList) then return tool end
                    end
                end
            end
        end
        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, kwList in pairs(WEAPON_KEYWORDS) do
                        if matches(tool.Name, kwList) then return tool end
                    end
                end
            end
        end
        return nil
    end

    local function UniversalBlast(pos, hitPart)
        local tool = FindWeapon()
        if not tool then return false end
        if not HitRemote then
            InitRemotes()
            if not HitRemote then return false end
        end
        local args = {
            Normal = Vector3.new(0, 1, 0),
            HitPart = hitPart or Workspace.Terrain,
            Label = "RocketHit_" .. tostring(math.random(1000000, 9999999)),
            Player = player,
            Position = pos,
            Vehicle = tool,
            Weapon = tool,
        }
        rCnt = rCnt + 1
        return pcall(function() HitRemote:FireServer(args) end)
    end
    _G.KZ.m5_UniversalBlast = UniversalBlast

    local function GetTargetPos()
        return Mouse.Hit.p, Mouse.Target
    end

    local function FireClick()
        if not State.RPG_Click or not mouseHeld then return end
        local now = tick()
        if now - lastFireTime < State.RPG_Speed then return end
        lastFireTime = now
        local targetPos, hitPart = GetTargetPos()
        if not targetPos then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local dist = (targetPos - root.Position).Magnitude
        if dist < State.RPG_MinDistance then return end
        if dist > State.RPG_Range then return end
        for i = 1, State.RPG_Bursts do
            UniversalBlast(targetPos, hitPart)
            if i < State.RPG_Bursts then task.wait(State.RPG_FireRate) end
        end
    end

    local FONT_5x7 = {
        ["A"]={"01110","10001","10001","11111","10001","10001","10001"},
        ["B"]={"11110","10001","10001","11110","10001","10001","11110"},
        ["C"]={"01110","10001","10000","10000","10000","10001","01110"},
        ["D"]={"11110","10001","10001","10001","10001","10001","11110"},
        ["E"]={"11111","10000","10000","11110","10000","10000","11111"},
        ["F"]={"11111","10000","10000","11110","10000","10000","10000"},
        ["G"]={"01110","10001","10000","10111","10001","10001","01111"},
        ["H"]={"10001","10001","10001","11111","10001","10001","10001"},
        ["I"]={"11111","00100","00100","00100","00100","00100","11111"},
        ["J"]={"00111","00010","00010","00010","00010","10010","01100"},
        ["K"]={"10001","10010","10100","11000","10100","10010","10001"},
        ["L"]={"10000","10000","10000","10000","10000","10000","11111"},
        ["M"]={"10001","11011","10101","10101","10001","10001","10001"},
        ["N"]={"10001","10001","11001","10101","10011","10001","10001"},
        ["O"]={"01110","10001","10001","10001","10001","10001","01110"},
        ["P"]={"11110","10001","10001","11110","10000","10000","10000"},
        ["Q"]={"01110","10001","10001","10001","10101","10010","01101"},
        ["R"]={"11110","10001","10001","11110","10100","10010","10001"},
        ["S"]={"01111","10000","10000","01110","00001","00001","11110"},
        ["T"]={"11111","00100","00100","00100","00100","00100","00100"},
        ["U"]={"10001","10001","10001","10001","10001","10001","01110"},
        ["V"]={"10001","10001","10001","10001","10001","01010","00100"},
        ["W"]={"10001","10001","10001","10101","10101","10101","01010"},
        ["X"]={"10001","10001","01010","00100","01010","10001","10001"},
        ["Y"]={"10001","10001","01010","00100","00100","00100","00100"},
        ["Z"]={"11111","00001","00010","00100","01000","10000","11111"},
        ["0"]={"01110","10001","10011","10101","11001","10001","01110"},
        ["1"]={"00100","01100","00100","00100","00100","00100","01110"},
        ["2"]={"01110","10001","00001","00010","00100","01000","11111"},
        ["3"]={"11111","00010","00100","00010","00001","10001","01110"},
        ["4"]={"00010","00110","01010","10010","11111","00010","00010"},
        ["5"]={"11111","10000","11110","00001","00001","10001","01110"},
        ["6"]={"00110","01000","10000","11110","10001","10001","01110"},
        ["7"]={"11111","00001","00010","00100","01000","01000","01000"},
        ["8"]={"01110","10001","10001","01110","10001","10001","01110"},
        ["9"]={"01110","10001","10001","01111","00001","00010","01100"},
        [" "]={"00000","00000","00000","00000","00000","00000","00000"},
        ["!"]={"00100","00100","00100","00100","00100","00000","00100"},
        ["?"]={"01110","10001","00001","00010","00100","00000","00100"},
        ["-"]={"00000","00000","00000","11111","00000","00000","00000"},
        ["."]={"00000","00000","00000","00000","00000","00000","00100"},
        [":"]={"00000","00100","00000","00000","00000","00100","00000"},
        [","]={"00000","00000","00000","00000","00000","00100","01000"},
        ["/"]={"00001","00010","00010","00100","01000","01000","10000"},
        ["+"]={"00000","00100","00100","11111","00100","00100","00000"},
        ["*"]={"00000","10101","01110","11111","01110","10101","00000"},
        ["_"]={"00000","00000","00000","00000","00000","00000","11111"},
        ["="]={"00000","00000","11111","00000","11111","00000","00000"},
        ["@"]={"01110","10001","10111","10101","10111","10000","01110"},
        ["#"]={"01010","01010","11111","01010","11111","01010","01010"},
        ["("]={"00010","00100","01000","01000","01000","00100","00010"},
        [")"]={"01000","00100","00010","00010","00010","00100","01000"},
        ["["]={"01110","01000","01000","01000","01000","01000","01110"},
        ["]"]={"01110","00010","00010","00010","00010","00010","01110"},
        ["А"]={"01110","10001","10001","11111","10001","10001","10001"},
        ["Б"]={"11111","10000","10000","11110","10001","10001","11110"},
        ["В"]={"11110","10001","10001","11110","10001","10001","11110"},
        ["Г"]={"11111","10000","10000","10000","10000","10000","10000"},
        ["Д"]={"00111","01001","01001","01001","01001","11111","10001"},
        ["Е"]={"11111","10000","10000","11110","10000","10000","11111"},
        ["Ё"]={"01010","00000","11111","10000","11110","10000","11111"},
        ["Ж"]={"10101","10101","10101","11111","10101","10101","10101"},
        ["З"]={"01110","10001","00001","00110","00001","10001","01110"},
        ["И"]={"10001","10001","10011","10101","11001","10001","10001"},
        ["Й"]={"01010","00100","10011","10101","11001","10001","10001"},
        ["К"]={"10001","10010","10100","11000","10100","10010","10001"},
        ["Л"]={"00111","01001","01001","01001","01001","01001","10001"},
        ["М"]={"10001","11011","10101","10101","10001","10001","10001"},
        ["Н"]={"10001","10001","10001","11111","10001","10001","10001"},
        ["О"]={"01110","10001","10001","10001","10001","10001","01110"},
        ["П"]={"11111","10001","10001","10001","10001","10001","10001"},
        ["Р"]={"11110","10001","10001","11110","10000","10000","10000"},
        ["С"]={"01110","10001","10000","10000","10000","10001","01110"},
        ["Т"]={"11111","00100","00100","00100","00100","00100","00100"},
        ["У"]={"10001","10001","10001","01111","00001","00010","01100"},
        ["Ф"]={"00100","01110","10101","10101","10101","01110","00100"},
        ["Х"]={"10001","10001","01010","00100","01010","10001","10001"},
        ["Ц"]={"10001","10001","10001","10001","10001","11111","00001"},
        ["Ч"]={"10001","10001","10001","01111","00001","00001","00001"},
        ["Ш"]={"10101","10101","10101","10101","10101","10101","11111"},
        ["Щ"]={"10101","10101","10101","10101","10101","11111","00001"},
        ["Ъ"]={"11100","00100","00100","11110","00101","00101","11110"},
        ["Ы"]={"10001","10001","10001","11101","10011","10011","11101"},
        ["Ь"]={"10000","10000","10000","11110","10001","10001","11110"},
        ["Э"]={"01110","10001","00001","00111","00001","10001","01110"},
        ["Ю"]={"10010","10101","10101","11101","10101","10101","10010"},
        ["Я"]={"01111","10001","10001","01111","00101","01001","10001"},
    }

    local function getTextOffsets(text)
        local offsets = {}
        if not text or text == "" then return offsets end
        local chars = {}
        local i = 1
        while i <= #text do
            local b = text:byte(i)
            if b and b < 128 then
                table.insert(chars, text:sub(i, i))
                i = i + 1
            else
                table.insert(chars, text:sub(i, i+1))
                i = i + 2
            end
        end
        local letters = {}
        for _, c in ipairs(chars) do
            local up = c:upper()
            if FONT_5x7[up] then
                table.insert(letters, FONT_5x7[up])
            else
                table.insert(letters, FONT_5x7[" "])
            end
        end
        local lw, lh, sp = 5, 7, 1
        local totalWidth = #letters * (lw + sp) - sp
        local startH = -math.floor(totalWidth / 2)
        for li, letter in ipairs(letters) do
            local baseH = startH + (li - 1) * (lw + sp)
            for row = 1, lh do
                local rowStr = letter[row]
                if rowStr then
                    for col = 1, lw do
                        if rowStr:sub(col, col) == "1" then
                            local h = baseH + (col - 1)
                            local v = -(row - 4)
                            table.insert(offsets, {h = h, v = v})
                        end
                    end
                end
            end
        end
        return offsets
    end

    local swastikaOffsets = {}
    for v = -3, 3 do table.insert(swastikaOffsets, {h = 0, v = v}) end
    for h = -3, -1 do table.insert(swastikaOffsets, {h = h, v = 0}) end
    for h = 1, 3 do table.insert(swastikaOffsets, {h = h, v = 0}) end
    for h = 1, 3 do table.insert(swastikaOffsets, {h = h, v = 3}) end
    for v = -3, -1 do table.insert(swastikaOffsets, {h = 3, v = v}) end
    for h = -3, -1 do table.insert(swastikaOffsets, {h = h, v = -3}) end
    for v = 1, 3 do table.insert(swastikaOffsets, {h = -3, v = v}) end

    local function FireSwastika()
        if not State.RPG_Swastika or not mouseHeld then return end
        local now = tick()
        if now - lastSwastikaTime < State.RPG_Speed then return end
        lastSwastikaTime = now
        local targetPos, hitPart = GetTargetPos()
        if not targetPos then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local dist = (targetPos - root.Position).Magnitude
        if dist < State.RPG_MinDistance then return end
        if dist > State.RPG_Range then return end
        local dir = (targetPos - root.Position).Unit
        local up = Vector3.new(0, 1, 0)
        local right = dir:Cross(up).Unit
        for _, offset in ipairs(swastikaOffsets) do
            local finalPos = targetPos + (right * offset.h * State.RPG_SwastikaSize + up * offset.v * State.RPG_SwastikaSize)
            for j = 1, State.RPG_Bursts do
                UniversalBlast(finalPos, hitPart)
                if j < State.RPG_Bursts then task.wait(State.RPG_FireRate) end
            end
        end
    end

    local function FireText()
        if not State.RPG_TextMode or not mouseHeld then return end
        local now = tick()
        if now - lastSwastikaTime < State.RPG_Speed then return end
        lastSwastikaTime = now
        local targetPos, hitPart = GetTargetPos()
        if not targetPos then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local dist = (targetPos - root.Position).Magnitude
        if dist < State.RPG_MinDistance then return end
        if dist > State.RPG_Range then return end
        local dir = (targetPos - root.Position).Unit
        local up = Vector3.new(0, 1, 0)
        local right = dir:Cross(up).Unit
        local textOffsets = getTextOffsets(State.RPG_TextInput)
        local textSize = State.RPG_TextSize
        for _, offset in ipairs(textOffsets) do
            local finalPos = targetPos + (right * offset.h * textSize + up * offset.v * textSize)
            UniversalBlast(finalPos, hitPart)
            if State.RPG_FireRate > 0 then task.wait(State.RPG_FireRate) end
        end
    end

    local function FireSpam()
        if not State.RPG_Spam then return end
        local now = tick()
        if now - lastSpamTime < State.RPG_Speed then return end
        lastSpamTime = now
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                if not _G.KZ.isRPGWhitelisted(p) then
                    task.spawn(function()
                        local char = p.Character
                        if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                            local head = char.Head
                            local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            if myRoot then
                                local dist = (head.Position - myRoot.Position).Magnitude
                                if dist >= State.RPG_MinDistance and dist <= State.RPG_Range then
                                    for i = 1, State.RPG_Bursts do
                                        UniversalBlast(head.Position, head)
                                        if i < State.RPG_Bursts then task.wait(State.RPG_FireRate) end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end
    end

    local GodModActive = false
    local TargetCoords = Vector3.new(-770, 301, -750)

    local function showGodModConfirm()
        local TweenService = _G.KZ.TweenService
        local new = _G.KZ.new
        local corner = _G.KZ.corner

        if CoreGui:FindFirstChild("KZ_GodModConfirm") then
            CoreGui.KZ_GodModConfirm:Destroy()
        end

        local gui = new("ScreenGui", {Name="KZ_GodModConfirm", ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling, IgnoreGuiInset=true, DisplayOrder=10000})
        pcall(function() gui.Parent = CoreGui end)
        if not gui.Parent then gui.Parent = player:WaitForChild("PlayerGui") end

        local overlay = new("Frame", {Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(0,0,0), BackgroundTransparency=0.5, BorderSizePixel=0, Parent=gui})

        local box = new("Frame", {Size=UDim2.new(0,360,0,180), Position=UDim2.new(0.5,-180,0.5,-90), BackgroundColor3=Color3.fromRGB(20,20,28), BorderSizePixel=0, Parent=gui})
        corner(box, 12)
        new("UIStroke", {Color=Color3.fromRGB(220,90,90), Thickness=2, Parent=box})

        local title = new("TextLabel", {Size=UDim2.new(1,0,0,40), Position=UDim2.new(0,0,0,15), BackgroundTransparency=1, Text="АКТИВИРОВАТЬ GODMODE?", TextColor3=Color3.fromRGB(240,90,90), Font=Enum.Font.GothamBold, TextSize=16, Parent=box})
        local desc = new("TextLabel", {Size=UDim2.new(1,-30,0,60), Position=UDim2.new(0,15,0,60), BackgroundTransparency=1, Text="Это сбросит камеру, обнулит персонажа и телепортирует вас на (-770, 301, -750). Продолжить?", TextColor3=Color3.fromRGB(220,220,220), Font=Enum.Font.Gotham, TextSize=12, TextWrapped=true, Parent=box})

        local yesBtn = new("TextButton", {Size=UDim2.new(0,150,0,40), Position=UDim2.new(0,20,1,-55), BackgroundColor3=Color3.fromRGB(200,60,60), Text="ДА", TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamBold, TextSize=14, BorderSizePixel=0, Parent=box})
        corner(yesBtn, 8)
        local noBtn = new("TextButton", {Size=UDim2.new(0,150,0,40), Position=UDim2.new(1,-170,1,-55), BackgroundColor3=Color3.fromRGB(60,60,70), Text="НЕТ", TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamBold, TextSize=14, BorderSizePixel=0, Parent=box})
        corner(noBtn, 8)

        yesBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
            _G.KZ.ExecuteGodMod()
        end)
        noBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
    end

    function _G.KZ.ExecuteGodMod()
        if GodModActive then return end
        GodModActive = true

        local cam = workspace.CurrentCamera
        if cam then cam:Destroy() end
        task.wait(0.1)
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        workspace.CurrentCamera.FieldOfView = 70

        pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
        player.TeamColor = BrickColor.new("Really red")
        player.Neutral = false

        local function NukeUI()
            local pgui = player:FindFirstChild("PlayerGui")
            if not pgui then return end
            local vpSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
            if not vpSize then return end
            for _, gui in pairs(pgui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "m5wareGodMod" and gui.Name ~= "KZHubNebula" and gui.Name ~= "KZ_Downed" and gui.Name ~= "KZ_GodModConfirm" then
                    for _, obj in pairs(gui:GetDescendants()) do
                        if obj:IsA("GuiObject") then
                            local posX = obj.AbsolutePosition.X / vpSize.X
                            if (posX < 0.25 or posX > 0.75) and obj.Name ~= "Visuals" then
                                obj.Visible = false
                            end
                        end
                    end
                end
            end
        end
        NukeUI()

        local function FinalProcess(character)
            local root = character:WaitForChild("HumanoidRootPart", 15)
            if root then
                task.wait(3)
                root.CFrame = CFrame.new(TargetCoords)
                task.wait(20)
                GodModActive = false
            end
        end

        player.CharacterAdded:Connect(FinalProcess)
        task.wait(0.5)
        if player.Character then player.Character:BreakJoints() end

        task.spawn(function()
            while GodModActive do
                NukeUI()
                task.wait(5)
            end
        end)
    end

    function _G.KZ.RunGodMod()
        showGodModConfirm()
    end

    task.spawn(function()
        while true do
            FireClick()
            FireSwastika()
            FireText()
            task.wait()
        end
    end)
    task.spawn(function()
        while true do
            if State.RPG_Spam then FireSpam() end
            task.wait(0.05)
        end
    end)
    Mouse.Button1Down:Connect(function() mouseHeld = true end)
    Mouse.Button1Up:Connect(function() mouseHeld = false end)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        InitRemotes()
    end)
end

-- GUI + UI POPULATION
do
    local State = _G.KZ.State
    local C = _G.KZ.C
    local Themes = _G.KZ.Themes
    local player = _G.KZ.player
    local TweenService = _G.KZ.TweenService
    local UserInputService = _G.KZ.UserInputService
    local CoreGui = _G.KZ.CoreGui
    local new = _G.KZ.new
    local corner = _G.KZ.corner
    local AccessoryColors = _G.KZ.AccessoryColors

    local gui = new("ScreenGui",{Name="KZHubNebula",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true})
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = player:WaitForChild("PlayerGui") end

    local ThemeRefs = { bg={}, titlebar={}, contentBg={}, tab={}, text={}, subtext={} }
    local function reg(el, role) table.insert(ThemeRefs[role], el) end

    local splash = new("Frame",{Name="Splash",Size=UDim2.new(0,420,0,2),Position=UDim2.new(0.5,-210,0.5,-1),BackgroundColor3=C.splash,BorderSizePixel=0,ZIndex=50,Parent=gui})
    corner(splash, 12)
    new("UIStroke",{Color=Color3.fromRGB(70,52,43),Thickness=1.5,Parent=splash})
    local splashTitle = new("TextLabel",{Size=UDim2.new(1,-40,0,30),Position=UDim2.new(0,20,0,22),BackgroundTransparency=1,Text="KZ HUB",TextColor3=Color3.fromRGB(240,235,230),Font=Enum.Font.GothamBold,TextSize=20,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=51,Parent=splash})
    local splashAuthor = new("TextLabel",{Size=UDim2.new(1,-40,0,20),Position=UDim2.new(0,20,0,52),BackgroundTransparency=1,Text="by Demchenko11, K1s1k and Hehedio2",TextColor3=Color3.fromRGB(240,235,230),Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=51,Parent=splash})
    TweenService:Create(splash, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size=UDim2.new(0,420,0,110),Position=UDim2.new(0.5,-210,0.5,-55)}):Play()
    task.delay(0.3, function()
        TweenService:Create(splashTitle, TweenInfo.new(0.3), {TextTransparency=0}):Play()
        TweenService:Create(splashAuthor, TweenInfo.new(0.3), {TextTransparency=0}):Play()
    end)

    local FIXED_W, FIXED_H = 540, 470
    local main = new("Frame",{Name="Main",Size=UDim2.new(0,FIXED_W,0,FIXED_H),Position=UDim2.new(0.5,-FIXED_W/2,0.5,-FIXED_H/2),BackgroundColor3=C.bg,BorderSizePixel=0,Visible=false,Parent=gui})
    corner(main, 14)
    new("UIStroke",{Color=Color3.fromRGB(70,52,43),Thickness=1.5,Parent=main})
    reg(main, "bg")
    local titleBar = new("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=C.titlebar,BorderSizePixel=0,Parent=main})
    corner(titleBar, 14)
    local titleLabel = new("TextLabel",{Size=UDim2.new(0,400,1,0),Position=UDim2.new(0,18,0,0),BackgroundTransparency=1,Text="KZ Hub  |  by Demchenko11, K1s1k and Hehedio2  |  v9.8",TextColor3=C.text,Font=Enum.Font.GothamBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Parent=titleBar})
    reg(titleBar, "titlebar"); reg(titleLabel, "text")
    local iconsFrame = new("Frame",{Size=UDim2.new(0,130,1,0),Position=UDim2.new(1,-130,0,0),BackgroundTransparency=1,Parent=titleBar})

    local UI_SCALE = Instance.new("UIScale")
    UI_SCALE.Scale = 1
    UI_SCALE.Parent = main

    do
        local dragging = false
        local dragStart, startPos
        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true; dragStart = input.Position; startPos = main.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if not dragging then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
    end

    local animating = false
    local basePosition = UDim2.new(0.5, -FIXED_W/2, 0.5, -FIXED_H/2)
    local HIDDEN_OFFSET_Y = -600
    local HIDDEN_OFFSET_X = -120

    local function animateOpen()
        if animating then return end
        animating = true
        main.Visible = true; main.BackgroundTransparency = 0; main.Rotation = 0
        UI_SCALE.Scale = 0.55
        main.Position = UDim2.new(basePosition.X.Scale, basePosition.X.Offset + HIDDEN_OFFSET_X, basePosition.Y.Scale, basePosition.Y.Offset + HIDDEN_OFFSET_Y)
        TweenService:Create(main, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = basePosition}):Play()
        TweenService:Create(UI_SCALE, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Scale = 1}):Play()
        task.delay(0.6, function() animating = false end)
    end

    local function animateClose()
        if animating then return end
        animating = true
        TweenService:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(basePosition.X.Scale, basePosition.X.Offset + HIDDEN_OFFSET_X, basePosition.Y.Scale, basePosition.Y.Offset + HIDDEN_OFFSET_Y)}):Play()
        TweenService:Create(UI_SCALE, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.55}):Play()
        task.delay(0.32, function() main.Visible = false; gui.Enabled = false; animating = false end)
    end

    local function toggleMenu()
        if gui.Enabled then animateClose() else gui.Enabled = true; animateOpen() end
    end

    local function makeIcon(xOff, sym, col, cb)
        local b = new("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,xOff,0.5,-15),BackgroundColor3=C.tabColor,Text=sym,TextColor3=col or C.text,Font=Enum.Font.GothamBold,TextSize=16,BorderSizePixel=0,AutoButtonColor=false,Parent=iconsFrame})
        corner(b, 8)
        if cb then b.MouseButton1Click:Connect(cb) end
        reg(b, "tab"); return b
    end
    local iconX = makeIcon(-36, "X", C.closeRed, function() animateClose() end)

    local tabBar = new("ScrollingFrame",{Size=UDim2.new(1,-28,0,42),Position=UDim2.new(0,14,0,56),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollBarImageTransparency=1,ScrollingDirection=Enum.ScrollingDirection.X,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,ClipsDescendants=true,ElasticBehavior=Enum.ElasticBehavior.Never,Parent=main})
    new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=tabBar})

    local tabs={}; local tabFrames={}; local currentTab=nil
    local contentHolder = new("Frame",{Size=UDim2.new(1,-28,1,-128),Position=UDim2.new(0,14,0,108),BackgroundColor3=C.contentBg,BackgroundTransparency=0,BorderSizePixel=0,ClipsDescendants=true,Parent=main})
    corner(contentHolder, 10)
    reg(contentHolder, "contentBg")

    local function createTab(name, icon, order)
        local btn = new("TextButton",{Size=UDim2.new(0,122,1,0),BackgroundColor3=C.tabColor,BackgroundTransparency=0.15,Text="",BorderSizePixel=0,LayoutOrder=order,AutoButtonColor=false,Parent=tabBar,ZIndex=2})
        corner(btn, 10)
        local il = new("TextLabel",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,6,0.5,-7),BackgroundTransparency=1,Text=icon,TextColor3=C.subtext,Font=Enum.Font.GothamBold,TextSize=11,Parent=btn,ZIndex=2})
        local nl = new("TextLabel",{Size=UDim2.new(1,-22,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,Text=name,TextColor3=C.text,Font=Enum.Font.GothamMedium,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=btn,ZIndex=2})
        local content = new("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=6,ScrollBarImageColor3=C.scrollbar,ScrollBarImageTransparency=0.3,ScrollingDirection=Enum.ScrollingDirection.Y,ClipsDescendants=true,Visible=false,Parent=contentHolder,ZIndex=2})
        new("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=content})
        new("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,12),PaddingLeft=UDim.new(0,14),PaddingRight=UDim.new(0,18),Parent=content})
        btn.MouseButton1Click:Connect(function()
            for n, f in pairs(tabFrames) do
                f.Visible = false
                tabs[n].Button.BackgroundColor3 = C.tabColor
                tabs[n].Button.BackgroundTransparency = 0.15
                tabs[n].Icon.TextColor3 = C.subtext
                tabs[n].Name.TextColor3 = C.text
            end
            btn.BackgroundColor3 = C.accent; btn.BackgroundTransparency = 0
            il.TextColor3 = C.bg; nl.TextColor3 = C.bg
            content.Visible = true; content.CanvasPosition = Vector2.new(0, 0)
            currentTab = name
        end)
        tabs[name] = {Button=btn, Icon=il, Name=nl, Content=content}
        tabFrames[name] = content
        reg(btn, "tab"); reg(nl, "text"); reg(il, "subtext")
        return content
    end

    local function addSubTabs(parentContent, tabsList)
        local outerWrap = new("Frame", {Size=UDim2.new(1,-8,0,36),BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=-1000000,ClipsDescendants=false,Parent=parentContent,ZIndex=3})
        local stripe = new("ScrollingFrame", {Size=UDim2.new(0,0,1,0),Position=UDim2.new(0.5,0,0,0),AnchorPoint=Vector2.new(0.5,0),BackgroundColor3=C.tabColorDark,BackgroundTransparency=0.4,BorderSizePixel=0,ScrollBarThickness=0,ScrollBarImageTransparency=1,ScrollingDirection=Enum.ScrollingDirection.X,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,ScrollingEnabled=true,ElasticBehavior=Enum.ElasticBehavior.Never,ClipsDescendants=true,Parent=outerWrap,ZIndex=3})
        corner(stripe, 8)
        local inner = new("Frame", {Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,BorderSizePixel=0,Parent=stripe,ZIndex=4})
        new("UIListLayout", {FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=inner})
        new("UIPadding", {PaddingLeft=UDim.new(0,4),PaddingRight=UDim.new(0,4),Parent=inner})

        local function updateCanvas()
            local w = inner.AbsoluteSize.X
            if w > 0 then
                stripe.CanvasSize = UDim2.new(0, w, 0, 0)
            end
            local contentW = w
            local outerW = outerWrap.AbsoluteSize.X
            if outerW > 0 and contentW > 0 then
                stripe.Size = UDim2.new(0, math.min(contentW, outerW), 1, 0)
            end
        end
        inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() task.defer(updateCanvas) end)
        outerWrap:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() task.defer(updateCanvas) end)
        task.spawn(function() task.wait(0.1); updateCanvas() end)

        local subTabHolder = new("Frame", {Size=UDim2.new(1,-8,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=-999999,Parent=parentContent,ZIndex=3})
        new("UIListLayout", {Padding=UDim.new(0,0),SortOrder=Enum.SortOrder.LayoutOrder,Parent=subTabHolder})
        local subContents = {}; local subButtons = {}
        local function selectSub(name)
            for n, c in pairs(subContents) do c.Visible = (n == name) end
            for n, b in pairs(subButtons) do
                if n == name then b.BackgroundColor3 = C.accent; b.TextColor3 = C.bg
                else b.BackgroundColor3 = C.tabColor; b.TextColor3 = C.text end
            end
        end
        for i, cfg in ipairs(tabsList) do
            local btn = new("TextButton", {Size=UDim2.new(0,80,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=C.tabColor,BackgroundTransparency=0,Text=cfg.name,TextColor3=C.text,Font=Enum.Font.GothamBold,TextSize=11,BorderSizePixel=0,AutoButtonColor=false,LayoutOrder=i,Parent=inner,ZIndex=4})
            corner(btn, 6)
            new("UIPadding", {PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),Parent=btn})
            btn.MouseButton1Click:Connect(function() selectSub(cfg.name) end)
            subButtons[cfg.name] = btn
            reg(btn, "tab"); reg(btn, "text")
            local content = new("Frame", {Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=i,Visible=false,Parent=subTabHolder,ZIndex=3})
            new("UIListLayout", {Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=content})
            new("UIPadding", {PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,12),PaddingLeft=UDim.new(0,4),PaddingRight=UDim.new(0,4),Parent=content})
            subContents[cfg.name] = content
        end
        if #tabsList > 0 then selectSub(tabsList[1].name) end
        return subContents
    end

    local sectionOrder, rowOrder = 0, 0
    local function addSection(parent, title)
        sectionOrder = sectionOrder + 1
        return new("Frame",{Size=UDim2.new(1,-8,0,0),BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=sectionOrder*100,Parent=parent,ZIndex=3})
    end
    local function addRow(parent, title, subtext)
        rowOrder = rowOrder + 1
        local r = new("Frame",{Size=UDim2.new(1,-8,0,subtext and 52 or 42),BackgroundColor3=C.tabColor,BackgroundTransparency=0.15,BorderSizePixel=0,LayoutOrder=rowOrder,Parent=parent,ZIndex=3})
        corner(r, 10)
        local tl = new("TextLabel",{Size=UDim2.new(0.6,-20,0,20),Position=UDim2.new(0,14,0,subtext and 6 or 11),BackgroundTransparency=1,Text=title,TextColor3=C.text,Font=Enum.Font.GothamMedium,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Parent=r,ZIndex=3})
        reg(tl, "text")
        if subtext then
            local sl = new("TextLabel",{Size=UDim2.new(0.7,-20,0,14),Position=UDim2.new(0,14,0,28),BackgroundTransparency=1,Text=subtext,TextColor3=C.subtext,Font=Enum.Font.Gotham,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,Parent=r,ZIndex=3})
            reg(sl, "subtext")
        end
        reg(r, "tab"); return r
    end
    local function addToggle(parent, title, subtext, default, callback)
        local state = default or false
        local r = addRow(parent, title, subtext)
        local track = new("Frame", {Size=UDim2.new(0,40,0,22),Position=UDim2.new(1,-54,0.5,-11),BackgroundColor3=state and C.neon or C.toggleOff,BorderSizePixel=0,Parent=r,ZIndex=3})
        corner(track, 11)
        local knob = new("Frame", {Size=UDim2.new(0,18,0,18),Position=state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9),BackgroundColor3=state and Color3.fromRGB(255,250,220) or C.text,BorderSizePixel=0,Parent=track,ZIndex=3})
        corner(knob, 9)
        local btn = new("TextButton", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", Parent=track, ZIndex=4 })
        btn.MouseButton1Click:Connect(function()
            state = not state
            TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3=state and C.neon or C.toggleOff}):Play()
            TweenService:Create(knob, TweenInfo.new(0.15), {Position=state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9), BackgroundColor3=state and Color3.fromRGB(255,250,220) or C.text}):Play()
            if callback then pcall(callback, state) end
        end)
        return r
    end
    local function addButton(parent, title, subtext, callback, disabled)
        local r = addRow(parent, title, subtext)
        if not disabled then
            local btn = new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=r,ZIndex=4})
            btn.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
        end
        return r
    end
    local function addKeybind(parent, title, defaultKey, callback)
        local r = addRow(parent, title)
        local key = defaultKey or "Z"
        local box = new("TextButton",{Size=UDim2.new(0,60,0,24),Position=UDim2.new(1,-74,0.5,-12),BackgroundColor3=C.tabColorDark,Text=key,TextColor3=C.text,Font=Enum.Font.GothamBold,TextSize=12,BorderSizePixel=0,AutoButtonColor=false,Parent=r,ZIndex=4})
        corner(box, 6); reg(box, "tab"); reg(box, "text")
        box.MouseButton1Click:Connect(function()
            box.Text = "..."
            local conn
            conn = UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    key = input.KeyCode.Name; box.Text = key; conn:Disconnect()
                    if callback then pcall(callback, key) end
                end
            end)
        end)
        return r
    end
    local function addInput(parent, title, placeholder, default, callback)
        local r = addRow(parent, title)
        local box = new("TextBox",{Size=UDim2.new(0,120,0,24),Position=UDim2.new(1,-134,0.5,-12),BackgroundColor3=C.tabColorDark,Text=tostring(default or ""),PlaceholderText=placeholder or "",PlaceholderColor3=C.subtext,TextColor3=C.text,Font=Enum.Font.Gotham,TextSize=12,ClearTextOnFocus=false,BorderSizePixel=0,Parent=r,ZIndex=4})
        corner(box, 6); reg(box, "tab"); reg(box, "text")
        box.FocusLost:Connect(function(enter) if enter and callback then callback(box.Text) end end)
        return r
    end
    local function addSlider(parent, title, min, max, default, isFloat, callback)
        local r = addRow(parent, title, nil); r.Size = UDim2.new(1,-8,0,60)
        local value = default or min
        local display = new("TextLabel",{Size=UDim2.new(0,60,0,20),Position=UDim2.new(1,-74,0,6),BackgroundTransparency=1,Text=isFloat and string.format("%.2f", value) or tostring(math.floor(value)),TextColor3=C.neon,Font=Enum.Font.GothamBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Right,Parent=r,ZIndex=3})
        local bar = new("Frame",{Size=UDim2.new(1,-28,0,8),Position=UDim2.new(0,14,0,38),BackgroundColor3=C.bg,BorderSizePixel=0,Parent=r,ZIndex=3})
        corner(bar, 4)
        local fill = new("Frame",{Size=UDim2.new((value-min)/(max-min),0,1,0),BackgroundColor3=C.neon,BorderSizePixel=0,Parent=bar,ZIndex=3})
        corner(fill, 4)
        local btn = new("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=bar,ZIndex=4})
        local dragging = false
        local function update(x)
            local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local v = min + (max - min) * rel
            if isFloat then v = math.floor(v * 100) / 100 else v = math.floor(v) end
            fill.Size = UDim2.new(rel, 0, 1, 0)
            display.Text = isFloat and string.format("%.2f", v) or tostring(v)
            if callback then pcall(callback, v) end
        end
        btn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; update(input.Position.X) end end)
        UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input.Position.X) end end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
        return r
    end
    local function addColorWheel(parent, title, initialColor, callback)
        local r = addRow(parent, title, nil); r.Size = UDim2.new(1,-8,0,175)
        local currentHue, currentSat, currentVal = 0, 1, 1
        if initialColor then currentHue, currentSat, currentVal = Color3.toHSV(initialColor) end
        local previewBox = new("Frame", {Size=UDim2.new(0,36,0,22),Position=UDim2.new(1,-50,0,10),BackgroundColor3=initialColor or Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=r,ZIndex=4})
        corner(previewBox, 6)
        local wheelSize = 120
        local wheelFrame = new("Frame", {Size=UDim2.new(0,wheelSize,0,wheelSize),Position=UDim2.new(0,14,0,42),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=r,ZIndex=4})
        corner(wheelFrame, wheelSize/2)
        local pixelSize = 3
        local pixels = math.floor(wheelSize / pixelSize)
        local wheelRadius = (pixels - 1) / 2
        for y = 0, pixels - 1 do
            for x = 0, pixels - 1 do
                local dx = x - wheelRadius; local dy = y - wheelRadius
                local dist = math.sqrt(dx*dx + dy*dy)
                if dist <= wheelRadius then
                    local sat = math.clamp(dist / wheelRadius, 0, 1)
                    local angle = math.atan2(dy, dx)
                    local hue = angle / (math.pi * 2)
                    if hue < 0 then hue = hue + 1 end
                    new("Frame", {Size=UDim2.new(0,pixelSize,0,pixelSize),Position=UDim2.new(0,x*pixelSize,0,y*pixelSize),BackgroundColor3=Color3.fromHSV(hue, sat, 1),BorderSizePixel=0,Parent=wheelFrame,ZIndex=4})
                end
            end
        end
        local picker = new("Frame", {Size=UDim2.new(0,10,0,10),AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=wheelFrame,ZIndex=6})
        corner(picker, 5)
        new("UIStroke", {Color=Color3.fromRGB(0,0,0), Thickness=1.5, Parent=picker})
        local initAngle = currentHue * math.pi * 2
        local initDist = currentSat * (wheelSize/2)
        picker.Position = UDim2.new(0.5, math.cos(initAngle)*initDist, 0.5, math.sin(initAngle)*initDist)
        local valBarHeight = 120
        local valBarFrame = new("Frame", {Size=UDim2.new(0,20,0,valBarHeight),Position=UDim2.new(0,wheelSize+35,0,42),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=r,ZIndex=4})
        corner(valBarFrame, 6)
        local valGradient = new("UIGradient", {Rotation=90,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromHSV(currentHue,currentSat,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}),Parent=valBarFrame})
        local valSlider = new("Frame", {Size=UDim2.new(1,4,0,6),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,1-currentVal,0),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=valBarFrame,ZIndex=6})
        corner(valSlider, 3)
        new("UIStroke", {Color=Color3.fromRGB(0,0,0), Thickness=1, Parent=valSlider})
        local function notifyColor()
            local color = Color3.fromHSV(currentHue, currentSat, currentVal)
            previewBox.BackgroundColor3 = color
            valGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromHSV(currentHue,currentSat,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))})
            if callback then callback(color) end
        end
        local wheelBtn = new("TextButton", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", Parent=wheelFrame, ZIndex=7})
        local wheelDragging = false
        local function updateWheel(px, py)
            local relX = px - wheelFrame.AbsolutePosition.X - wheelSize/2
            local relY = py - wheelFrame.AbsolutePosition.Y - wheelSize/2
            local dist = math.sqrt(relX*relX + relY*relY)
            local maxDist = wheelSize/2
            local radius = math.min(dist/maxDist, 1)
            local angle = math.atan2(relY, relX)
            local hue = angle / (math.pi*2)
            if hue < 0 then hue = hue + 1 end
            currentHue = hue; currentSat = radius
            picker.Position = UDim2.new(0.5, math.cos(angle)*(radius*maxDist), 0.5, math.sin(angle)*(radius*maxDist))
            notifyColor()
        end
        wheelBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then wheelDragging = true updateWheel(input.Position.X, input.Position.Y) end end)
        local valBtn = new("TextButton", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="", Parent=valBarFrame, ZIndex=7})
        local valDragging = false
        local function updateVal(py)
            local relY = math.clamp((py - valBarFrame.AbsolutePosition.Y)/valBarHeight, 0, 1)
            currentVal = 1 - relY
            valSlider.Position = UDim2.new(0.5, 0, relY, 0)
            notifyColor()
        end
        valBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then valDragging = true updateVal(input.Position.Y) end end)
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if wheelDragging then updateWheel(input.Position.X, input.Position.Y) end
                if valDragging then updateVal(input.Position.Y) end
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then wheelDragging = false; valDragging = false end
        end)
        return r
    end
    local function addDropdown(parent, title, getValues, getCurrent, setValue, colorMap)
        local r = addRow(parent, title)
        local current = getCurrent()
        local box = new("TextButton", {Size=UDim2.new(0,140,0,26),Position=UDim2.new(1,-154,0.5,-13),BackgroundColor3=C.tabColorDark,Text=tostring(current or "None"),TextColor3=C.text,Font=Enum.Font.Gotham,TextSize=12,BorderSizePixel=0,TextTruncate=Enum.TextTruncate.AtEnd,AutoButtonColor=false,Parent=r,ZIndex=4})
        corner(box, 6); reg(box, "tab"); reg(box, "text")
        local panel = nil; local closeConn = nil
        local function closePanel()
            if panel then panel:Destroy(); panel = nil end
            if closeConn then closeConn:Disconnect(); closeConn = nil end
        end
        box.MouseButton1Click:Connect(function()
            if panel then closePanel(); return end
            panel = new("ScrollingFrame", {Size=UDim2.new(0,260,0,220),BackgroundColor3=C.dropdown,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=4,ScrollBarImageColor3=C.scrollbar,ZIndex=9,Parent=contentHolder})
            corner(panel, 8)
            new("UIListLayout", {Padding=UDim.new(0,4), SortOrder=Enum.SortOrder.LayoutOrder, Parent=panel})
            new("UIPadding", {PaddingTop=UDim.new(0,6), PaddingBottom=UDim.new(0,6), PaddingLeft=UDim.new(0,4), PaddingRight=UDim.new(0,4), Parent=panel})
            for i, name in ipairs(getValues()) do
                local itemColor = (colorMap and colorMap[name]) or C.tabColor
                local item = new("TextButton", {Size=UDim2.new(1,-8,0,24),BackgroundColor3=itemColor,Text="  "..name,TextColor3=C.text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,BorderSizePixel=0,LayoutOrder=i,Parent=panel,ZIndex=10})
                corner(item, 5)
                item.MouseButton1Click:Connect(function() setValue(name); box.Text = name; closePanel() end)
            end
            task.delay(0.05, function()
                closeConn = UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then closePanel() end
                end)
            end)
        end)
        return r
    end
    local function applyTheme(themeName)
        local t = Themes[themeName]; if not t then return end
        State.CurrentTheme = themeName
        for k, v in pairs(t) do C[k] = v end
        for _, el in ipairs(ThemeRefs.bg) do pcall(function() el.BackgroundColor3 = t.bg end) end
        for _, el in ipairs(ThemeRefs.titlebar) do pcall(function() el.BackgroundColor3 = t.titlebar end) end
        for _, el in ipairs(ThemeRefs.contentBg) do pcall(function() el.BackgroundColor3 = t.contentBg end) end
        for _, el in ipairs(ThemeRefs.text) do pcall(function() el.TextColor3 = t.text end) end
        for _, el in ipairs(ThemeRefs.subtext) do pcall(function() el.TextColor3 = t.subtext end) end
    end

    local hitboxTab = createTab("Hitbox", "🎯", 1)
    local gunTab = createTab("Guns", "🔫", 2)
    local skinsTab = createTab("Skins", "💎", 3)
    local aimbotTab = createTab("Aimbot", "🎯", 4)
    local visualTab = createTab("Visuals", "🎨", 5)
    local flyTab = createTab("Fly", "🪂", 6)
    local otherTab = createTab("Others", "⚡", 7)
    local uiTab = createTab("UI", "🎨", 8)
    local rpgTab = createTab("RPG", "💥", 9)

    local hitboxSubs = addSubTabs(hitboxTab, {{name = "Hitbox"}, {name = "Невидимый"}})
    local skinsSubs = addSubTabs(skinsTab, {{name = "Skin"}, {name = "Пресеты"}})
    local aimbotSubs = addSubTabs(aimbotTab, {{name = "Аимбот"}, {name = "Silent Aim"}, {name = "Whitelist"}})
    local visualSubs = addSubTabs(visualTab, {
        {name = "ESP"}, {name = "Время"}, {name = "Звуки"},
    })
    local otherSubs = addSubTabs(otherTab, {{name = "Скрипты"}, {name = "ТП"}, {name = "FOV"}})
    local uiSubs = addSubTabs(uiTab, {{name = "Меню"}, {name = "Игровое UI"}, {name = "Темы"}})

    -- SKIN PLAYER
    do
        local SKIN_COLOR = Color3.fromRGB(20, 20, 20)
        local RIGHT_ARM_COLOR = Color3.fromRGB(120, 120, 120)
        local TAG = "SkinPlayer_"
        local ACCESSORIES = {
            { id = 77302733250920,  name = "Hair",         attachTo = "Head",     position = Vector3.new(0, -1.8, 0),    scale = Vector3.new(1,1,1) },
            { id = 119218738346881, name = "Hat",          attachTo = "Head",     position = Vector3.new(0, -0.3, 0),    scale = Vector3.new(1,1,1) },
            { id = 124188369590846, name = "RosesLeftArm", attachTo = "Left Arm", position = Vector3.new(0.1, -0.45, 0), scale = Vector3.new(1,1,1) },
        }
        local PANTS_ID = 11162779515
        local KORBLOX_RIGHT = 139607718
        local KORBLOX_LEFT = 139607673
        local cache = { acc = {}, pants = nil, korbloxR = nil, korbloxL = nil }
        local function loadAsset(id)
            local ok, objs = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
            if ok then return objs end
            return nil
        end
        local function preload()
            for _, cfg in ipairs(ACCESSORIES) do
                local objs = loadAsset(cfg.id)
                if objs then for _, o in ipairs(objs) do if o:IsA("Accessory") then cache.acc[cfg.id] = o break end end end
            end
            local p = loadAsset(PANTS_ID)
            if p then for _, o in ipairs(p) do if o:IsA("Pants") then cache.pants = o break end end end
            local kr = loadAsset(KORBLOX_RIGHT)
            if kr then for _, o in ipairs(kr) do if o:IsA("Folder") and o.Name == "R15ArtistIntent" then cache.korbloxR = o break end end end
            local kl = loadAsset(KORBLOX_LEFT)
            if kl then for _, o in ipairs(kl) do if o:IsA("Folder") and o.Name == "R15ArtistIntent" then cache.korbloxL = o break end end end
        end
        local function resolveAttach(char, name)
            if name == "Left Arm" then return char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("LeftLowerArm") end
            return char:FindFirstChild(name)
        end
        local function applyAccessory(char, cfg)
            local cached = cache.acc[cfg.id]; if not cached then return end
            local acc = cached:Clone(); acc.Name = TAG .. cfg.name
            local handle = acc:FindFirstChild("Handle")
            if handle and handle:IsA("BasePart") then
                handle.CanCollide = false; handle.Massless = true
                local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle:FindFirstChildOfClass("Mesh")
                if mesh then mesh.Scale = cfg.scale end
                local att = handle:FindFirstChildOfClass("Attachment")
                local base = att and att.CFrame or CFrame.new()
                local target = resolveAttach(char, cfg.attachTo)
                if target then new("Weld", { Part0 = target, Part1 = handle, C0 = base * CFrame.new(cfg.position), Parent = handle }) end
            end
            acc.Parent = char
        end
        local function applySkin(char)
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and not part:FindFirstAncestorOfClass("Accessory") then
                    local n = part.Name:lower()
                    if n:find("right") and n:find("arm") then part.Color = RIGHT_ARM_COLOR
                    elseif n:find("head") or n:find("torso") or n:find("arm") or n:find("leg") or n == "humanoidrootpart" then part.Color = SKIN_COLOR end
                end
            end
            local head = char:FindFirstChild("Head")
            if head then
                head.Transparency = 1
                local face = head:FindFirstChildOfClass("Decal")
                if face and face.Name == "face" then face:Destroy() end
            end
            for _, c in ipairs(char:GetChildren()) do if c:IsA("Shirt") or c:IsA("ShirtGraphic") then c:Destroy() end end
        end
        local function applyPants(char)
            if not cache.pants then return end
            for _, c in ipairs(char:GetChildren()) do if c:IsA("Pants") then c:Destroy() end end
            cache.pants:Clone().Parent = char
        end
        local function applyKorblox(char, folder, side)
            if not folder then return end
            local upper = folder:FindFirstChild(side .. "UpperLeg")
            local target = char:FindFirstChild(side .. " Leg") or char:FindFirstChild(side .. "Leg")
            if not target or not upper then return end
            for _, c in ipairs(target:GetChildren()) do if c:IsA("SpecialMesh") then c:Destroy() end end
            new("SpecialMesh", {MeshId = upper.MeshId, TextureId = upper.TextureID or "", Scale = Vector3.new(1,1,1), Offset = Vector3.new(0,0.75,0), Parent = target})
        end
        local function applyFullOutfit(char)
            if not char then return end
            char:WaitForChild("Head", 5); task.wait(0.3)
            for _, c in ipairs(char:GetChildren()) do if c:IsA("Accessory") then c:Destroy() end end
            task.wait(0.1); applySkin(char); task.wait(0.1)
            for _, cfg in ipairs(ACCESSORIES) do applyAccessory(char, cfg); task.wait(0.1) end
            applyPants(char); task.wait(0.1)
            applyKorblox(char, cache.korbloxR, "Right"); applyKorblox(char, cache.korbloxL, "Left")
            task.wait(0.1); applySkin(char)
        end
        _G.KZ.applySkinPlayerHotkey = function()
            preload()
            local char = _G.KZ.player.Character
            if char then applyFullOutfit(char) end
        end
        local skinTab = createTab("Skin Player", "👤", 10)
        addSection(skinTab, "Summer Outfit")
        addButton(skinTab, "Применить образ", "Чёрная кожа + серая рука + розы + Korblox", function() _G.KZ.applySkinPlayerHotkey() end)
        addKeybind(skinTab, "Кейбинд на образ", "K", function(k) State.SkinPlayerKey = k end)
        addButton(skinTab, "Снять образ", "Убирает аксессуары и штаны", function()
            local char = _G.KZ.player.Character; if not char then return end
            for _, c in ipairs(char:GetChildren()) do if c:IsA("Accessory") and c.Name:sub(1, #TAG) == TAG then c:Destroy() end end
            for _, c in ipairs(char:GetChildren()) do if c:IsA("Pants") then c:Destroy() end end
        end)
        addToggle(skinTab, "Авто-применение", "Применять образ при респавне", false, function(v) State.SkinPlayerAutoApply = v end)
        _G.KZ.player.CharacterAdded:Connect(function(char)
            if State.SkinPlayerAutoApply then task.wait(1); preload(); applyFullOutfit(char) end
        end)
    end

    -- HITBOX
    addSection(hitboxSubs["Hitbox"], "Hitbox")
    addToggle(hitboxSubs["Hitbox"], "Enable Hitbox", "Только на игроков БЕЗ кастомного лица", false, function(v)
        State.hitboxEnabled = v
        if v then for _, p in ipairs(_G.KZ.Players:GetPlayers()) do if p ~= player and p.Character then pcall(function() _G.KZ.fixHead(p.Character) end) end end end
    end)
    addSlider(hitboxSubs["Hitbox"], "Hitbox Size", 0.5, 10, 5, true, function(v) State.hitboxHeadSize = v end)
    addSection(hitboxSubs["Невидимый"], "Invisible Hitbox")
    addToggle(hitboxSubs["Невидимый"], "Enable Invisible Hitbox", "Раздувает голову ВСЕМ игрокам", false, function(v)
        State.invisibleHitboxEnabled = v
        if v then _G.KZ.enableInvisibleHitbox() else _G.KZ.disableInvisibleHitbox() end
    end)
    addSlider(hitboxSubs["Невидимый"], "Invisible Hitbox Size", 1.25, 10, 2.6, true, function(v) State.invisibleHitboxSize = v end)

    -- GUNS
    addSection(gunTab, "Gun Settings")
    addToggle(gunTab, "Fast Shot", "Ускоряет анимацию", false, function(v) _G.KZ.toggleFastShot(v) end)
    addToggle(gunTab, "No Recoil", "Убирает отдачу AWP / MSR / M40", false, function(v) if v then _G.KZ.enableNoRecoil() else _G.KZ.disableNoRecoil() end end)
    addToggle(gunTab, "Infinity Ammo", "Бесконечные патроны", false, function(v) if v then _G.KZ.enableInfiniteAmmo() else _G.KZ.disableInfiniteAmmo() end end)

    -- SKINS
    addSection(skinsSubs["Skin"], "Skin Changer")
    addDropdown(skinsSubs["Skin"], "Оружие", _G.KZ.getWeaponList, function() return State.SC_Weapon end, function(v) State.SC_Weapon = v end)
    addInput(skinsSubs["Skin"], "Camo 1", "Введите название", State.SC_Camo1, function(v) State.SC_Camo1 = v end)
    addDropdown(skinsSubs["Skin"], "Primary Camo", _G.KZ.scGetSkins, function() return State.SC_Camo1 end, function(v) State.SC_Camo1 = v end)
    addInput(skinsSubs["Skin"], "Camo 2", "Введите название", State.SC_Camo2, function(v) State.SC_Camo2 = v end)
    addDropdown(skinsSubs["Skin"], "Secondary Camo", _G.KZ.scGetSkins, function() return State.SC_Camo2 end, function(v) State.SC_Camo2 = v end)
    addToggle(skinsSubs["Skin"], "Animate Camo 1", "Анимация камо 1", true, function(v) State.SC_Anim1 = v end)
    addToggle(skinsSubs["Skin"], "Animate Camo 2", "Анимация камо 2", true, function(v) State.SC_Anim2 = v end)
    addToggle(skinsSubs["Skin"], "Use Custom Color 1", "Свой цвет Camo 1", false, function(v) State.SC_UseColor1 = v end)
    addColorWheel(skinsSubs["Skin"], "Camo 1 Color", Color3.fromRGB(State.SC_Color1R, State.SC_Color1G, State.SC_Color1B), function(c)
        State.SC_Color1R = math.floor(c.R*255); State.SC_Color1G = math.floor(c.G*255); State.SC_Color1B = math.floor(c.B*255)
    end)
    addToggle(skinsSubs["Skin"], "Use Custom Color 2", "Свой цвет Camo 2", false, function(v) State.SC_UseColor2 = v end)
    addColorWheel(skinsSubs["Skin"], "Camo 2 Color", Color3.fromRGB(State.SC_Color2R, State.SC_Color2G, State.SC_Color2B), function(c)
        State.SC_Color2R = math.floor(c.R*255); State.SC_Color2G = math.floor(c.G*255); State.SC_Color2B = math.floor(c.B*255)
    end)
    addButton(skinsSubs["Skin"], "Применить скин", nil, function() _G.KZ.scApply() end)
    addButton(skinsSubs["Skin"], "Сбросить скины", nil, function() _G.KZ.scReset() end)
    addSection(skinsSubs["Пресеты"], "Skin Presets")
    addButton(skinsSubs["Пресеты"], "Сохранить скин", "Берёт имя из поля 'Оружие'", function()
        if _G.KZ.savePresetForWeapon(State.SC_Weapon) then _G.KZ.setSelectedPreset(State.SC_Weapon) end
    end)
    addDropdown(skinsSubs["Пресеты"], "Сохранённый скин", _G.KZ.getPresetNames, function() return _G.KZ.getSelectedPreset() end, function(v)
        _G.KZ.setSelectedPreset(v)
        if v and v ~= "— пусто —" then _G.KZ.loadPresetIntoState(v); _G.KZ.applyPresetForWeapon(v); State.SC_Weapon = v end
    end)
    addButton(skinsSubs["Пресеты"], "Применить выбранный", nil, function()
        local sp = _G.KZ.getSelectedPreset()
        if sp and sp ~= "None" and sp ~= "— пусто —" then _G.KZ.applyPresetForWeapon(sp); State.SC_Weapon = sp end
    end)
    addButton(skinsSubs["Пресеты"], "Удалить выбранный", nil, function()
        local sp = _G.KZ.getSelectedPreset()
        if sp and sp ~= "None" and sp ~= "— пусто —" then _G.KZ.deletePreset(sp); _G.KZ.setSelectedPreset("None") end
    end)

    -- AIMBOT
    addSection(aimbotSubs["Аимбот"], "Авто-прицел")
    addToggle(aimbotSubs["Аимбот"], "Включить аимбот", "Нажми Z для переключения прицеливания", false, function(v)
        State.aimbotModuleActive = v
        if v then _G.KZ.startAimbotModule() else _G.KZ.stopAimbotModule() end
    end)
    addButton(aimbotSubs["Аимбот"], "Клавиша Z — вкл/выкл", nil, function() end, true)

    -- SILENT AIM UI
    addSection(aimbotSubs["Silent Aim"], "Silent Aim")
    addToggle(aimbotSubs["Silent Aim"], "Enable Silent Aim", "RightAlt тоже вкл/выкл", false, function(v)
        _G.KZ.SilentAim.Enabled = v
    end)
    addToggle(aimbotSubs["Silent Aim"], "Team Check", "Игнорировать свою команду", false, function(v)
        _G.KZ.SilentAim.TeamCheck = v
    end)
    addDropdown(aimbotSubs["Silent Aim"], "Target Part",
        function() return {"Head", "HumanoidRootPart", "UpperTorso", "Torso", "LeftUpperArm", "RightUpperArm"} end,
        function() return _G.KZ.SilentAim.TargetPart end,
        function(v) _G.KZ.SilentAim.TargetPart = v end)
    addSection(aimbotSubs["Silent Aim"], "Кнопки мыши")
    addToggle(aimbotSubs["Silent Aim"], "Работать на ЛКМ", "Стрельба через левую кнопку", true, function(v)
        _G.KZ.SilentAim.LMBEnabled = v
    end)
    addToggle(aimbotSubs["Silent Aim"], "Работать на ПКМ", "Авто-клик через правую кнопку", true, function(v)
        _G.KZ.SilentAim.RMBEnabled = v
    end)
    addToggle(aimbotSubs["Silent Aim"], "Auto Click", "Автоматически стреляет пока держишь кнопку", true, function(v)
        _G.KZ.SilentAim.AutoClick = v
    end)
    addSection(aimbotSubs["Silent Aim"], "FOV / Визуал")
    addToggle(aimbotSubs["Silent Aim"], "Показывать FOV круг", nil, false, function(v)
        _G.KZ.SilentAim.FOVVisible = v
    end)
    addSlider(aimbotSubs["Silent Aim"], "FOV Radius", 20, 470, 130, false, function(v)
        _G.KZ.SilentAim.FOVRadius = v
    end)

    -- WHITELIST
    addSection(aimbotSubs["Whitelist"], "Whitelist (кого игнорировать)")
    local wlSelected = "None"
    local wlStatusRow = new("Frame", {Size=UDim2.new(1,-8,0,36),BackgroundColor3=C.tabColor,BackgroundTransparency=0.15,BorderSizePixel=0,LayoutOrder=rowOrder+1,Parent=aimbotSubs["Whitelist"],ZIndex=3})
    corner(wlStatusRow, 10)
    rowOrder = rowOrder + 1
    reg(wlStatusRow, "tab")
    local wlStatus = new("TextLabel",{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text="Whitelist: — пусто —",TextColor3=C.neon,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=wlStatusRow,ZIndex=4})
    reg(wlStatus, "text")
    local function refreshWhitelistLabel() wlStatus.Text = "Whitelist: " .. _G.KZ.getAimbotWhitelistString() end
    refreshWhitelistLabel()
    addDropdown(aimbotSubs["Whitelist"], "Игрок на сервере", _G.KZ.getServerPlayers, function() return wlSelected end, function(v) wlSelected = v end)
    addButton(aimbotSubs["Whitelist"], "Добавить выбранного", "Берёт игрока из списка выше", function()
        if wlSelected and wlSelected ~= "None" and wlSelected ~= "— никого —" then
            if _G.KZ.addToAimbotWhitelist(wlSelected) then refreshWhitelistLabel() end
        end
    end)
    addButton(aimbotSubs["Whitelist"], "Убрать выбранного", "Берёт игрока из списка выше", function()
        if wlSelected and wlSelected ~= "None" and wlSelected ~= "— никого —" then
            if _G.KZ.removeFromAimbotWhitelist(wlSelected) then refreshWhitelistLabel() end
        end
    end)
    addButton(aimbotSubs["Whitelist"], "Очистить whitelist", nil, function()
        _G.KZ.clearAimbotWhitelist(); refreshWhitelistLabel()
    end)
    addButton(aimbotSubs["Whitelist"], "Обновить список игроков", "Открой дропдаун заново", function()
        refreshWhitelistLabel()
    end)

    -- VISUALS — ESP
    addSection(visualSubs["ESP"], "ESP")
    addToggle(visualSubs["ESP"], "ESP Enabled", "Включить/выключить ESP", false, function(v)
        _G.KZ.ESP.Enabled = v
    end)
    addToggle(visualSubs["ESP"], "ESP 3D Box", "Рисует 3D бокс вокруг игрока", false, function(v)
        _G.KZ.ESP.Box = v
    end)
    addToggle(visualSubs["ESP"], "ESP Tracers", "Линии от низа экрана к игроку", false, function(v)
        _G.KZ.ESP.Tracers = v
    end)
    addToggle(visualSubs["ESP"], "ESP Team Check", "Не показывать союзников", false, function(v)
        _G.KZ.ESP.TeamCheck = v
    end)
    addSlider(visualSubs["ESP"], "ESP Thickness", 1, 5, 1, false, function(v)
        _G.KZ.ESP.Thickness = v
    end)
    addSlider(visualSubs["ESP"], "ESP Transparency", 0, 1, 1, true, function(v)
        _G.KZ.ESP.Transparency = v
    end)

    addSection(visualSubs["Время"], "Time Changer")
    addToggle(visualSubs["Время"], "Enable Time Changer", "Фиксирует время", false, function(v)
        State.TimeChangerEnabled = v
        if v then _G.KZ.applyTimeNow() else _G.KZ.disableTimeChanger() end
    end)
    addSlider(visualSubs["Время"], "Clock Hours", 0, 23, 14, false, function(v) _G.KZ.setTime(v, nil) end)
    addSlider(visualSubs["Время"], "Clock Minutes", 0, 59, 0, false, function(v) _G.KZ.setTime(nil, v) end)

    addSection(visualSubs["Звуки"], "Kill Streak Sounds")
    addToggle(visualSubs["Звуки"], "Звуки килл-стрика", "Звук при ноках за жизнь: 2 / 3 / 4 / 10", true, function(v) State.KillStreakEnabled = v end)
    addInput(visualSubs["Звуки"], "ID за 2 нока", "rbxassetid://...", State.KillStreakSounds[2], function(v)
        if v and v ~= "" then if not v:find("rbxassetid://") and tonumber(v) then v = "rbxassetid://" .. v end; State.KillStreakSounds[2] = v end
    end)
    addInput(visualSubs["Звуки"], "ID за 3 нока", "rbxassetid://...", State.KillStreakSounds[3], function(v)
        if v and v ~= "" then if not v:find("rbxassetid://") and tonumber(v) then v = "rbxassetid://" .. v end; State.KillStreakSounds[3] = v end
    end)
    addInput(visualSubs["Звуки"], "ID за 4 нока", "rbxassetid://...", State.KillStreakSounds[4], function(v)
        if v and v ~= "" then if not v:find("rbxassetid://") and tonumber(v) then v = "rbxassetid://" .. v end; State.KillStreakSounds[4] = v end
    end)
    addInput(visualSubs["Звуки"], "ID за 10 ноков", "rbxassetid://...", State.KillStreakSounds[10], function(v)
        if v and v ~= "" then if not v:find("rbxassetid://") and tonumber(v) then v = "rbxassetid://" .. v end; State.KillStreakSounds[10] = v end
    end)
    addSlider(visualSubs["Звуки"], "Громкость", 0, 10, 3, true, function(v) State.KillStreakVolume = v end)
    addSection(visualSubs["Звуки"], "Performance")
    addToggle(visualSubs["Звуки"], "Low Graphics (FPS Boost)", "Снижает качество графики", false, function(v) if v then _G.KZ.enableLowGraphics() end end)

    -- FLY
    addSection(flyTab, "Полёт")
    addToggle(flyTab, "Enable Fly", "CTRL — взлёт/посадка", false, function(v)
        State.flyEnabled = v
        if not v and _G.KZ.flyState.active then _G.KZ.stopFly() end
    end)
    addSlider(flyTab, "Fly Speed", 50, 800, 400, false, function(v) State.flySpeed = v end)
    addKeybind(flyTab, "Fly Keybind", "LeftControl", function(k) State.flyKey = k end)

    -- RPG TAB
    addSection(rpgTab, "RPG Функции")
    addToggle(rpgTab, "RPG Click", "Стрельба ракетами по ЛКМ в точку курсора", false, function(v)
        State.RPG_Click = v
        if v and _G.KZ.initM5Remotes then _G.KZ.initM5Remotes() end
    end)
    addToggle(rpgTab, "RPG Spam", "Авто-спам ракетами по всем игрокам в радиусе", false, function(v)
        State.RPG_Spam = v
        if v and _G.KZ.initM5Remotes then _G.KZ.initM5Remotes() end
    end)
    addToggle(rpgTab, "Swastika Mode", "Раскладка ракет в форме свастики по ЛКМ", false, function(v)
        State.RPG_Swastika = v
        if v and _G.KZ.initM5Remotes then _G.KZ.initM5Remotes() end
    end)
    addToggle(rpgTab, "Text Mode", "Писать текст ракетами в точку курсора по ЛКМ", false, function(v)
        State.RPG_TextMode = v
        if v and _G.KZ.initM5Remotes then _G.KZ.initM5Remotes() end
    end)

    addSection(rpgTab, "Текст")
    addInput(rpgTab, "Текст", "KZ HUB", State.RPG_TextInput, function(v)
        State.RPG_TextInput = v
    end)
    addSlider(rpgTab, "Text Size (размер пикселя)", 3, 30, State.RPG_TextSize, false, function(v)
        State.RPG_TextSize = math.floor(v)
    end)

    addSection(rpgTab, "Настройки")
    addSlider(rpgTab, "Speed (задержка между выстрелами)", 0.01, 1, State.RPG_Speed, true, function(v) State.RPG_Speed = v end)
    addSlider(rpgTab, "Bursts (ракет за залп)", 1, 20, State.RPG_Bursts, false, function(v) State.RPG_Bursts = math.floor(v) end)
    addSlider(rpgTab, "Range", 100, 10000, State.RPG_Range, false, function(v) State.RPG_Range = math.floor(v) end)
    addSlider(rpgTab, "Min Distance", 0, 100, State.RPG_MinDistance, false, function(v) State.RPG_MinDistance = math.floor(v) end)
    addSlider(rpgTab, "Swastika Size", 5, 30, State.RPG_SwastikaSize, false, function(v) State.RPG_SwastikaSize = math.floor(v) end)
    addSlider(rpgTab, "FireRate (сек между вызовами)", 0.001, 0.5, State.RPG_FireRate, true, function(v) State.RPG_FireRate = v end)

    addSection(rpgTab, "Разное")
    addButton(rpgTab, "Обновить Remotes", "Переинициализация RocketHit", function()
        if _G.KZ.initM5Remotes then _G.KZ.initM5Remotes() end
    end)

    -- RPG WHITELIST
    addSection(rpgTab, "RPG Whitelist (кого игнорировать)")
    local rpgWlSelected = "None"
    local rpgWlStatusRow = new("Frame", {Size=UDim2.new(1,-8,0,36),BackgroundColor3=C.tabColor,BackgroundTransparency=0.15,BorderSizePixel=0,LayoutOrder=rowOrder+1,Parent=rpgTab,ZIndex=3})
    corner(rpgWlStatusRow, 10)
    rowOrder = rowOrder + 1
    reg(rpgWlStatusRow, "tab")
    local rpgWlStatus = new("TextLabel",{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text="Whitelist: — пусто —",TextColor3=C.neon,Font=Enum.Font.GothamMedium,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=rpgWlStatusRow,ZIndex=4})
    reg(rpgWlStatus, "text")
    local function refreshRPGWhitelistLabel() rpgWlStatus.Text = "Whitelist: " .. _G.KZ.getRPGWhitelistString() end
    refreshRPGWhitelistLabel()
    addDropdown(rpgTab, "Игрок на сервере", _G.KZ.getServerPlayers, function() return rpgWlSelected end, function(v) rpgWlSelected = v end)
    addButton(rpgTab, "Добавить выбранного", "Берёт игрока из списка выше", function()
        if rpgWlSelected and rpgWlSelected ~= "None" and rpgWlSelected ~= "— никого —" then
            if _G.KZ.addToRPGWhitelist(rpgWlSelected) then refreshRPGWhitelistLabel() end
        end
    end)
    addButton(rpgTab, "Убрать выбранного", "Берёт игрока из списка выше", function()
        if rpgWlSelected and rpgWlSelected ~= "None" and rpgWlSelected ~= "— никого —" then
            if _G.KZ.removeFromRPGWhitelist(rpgWlSelected) then refreshRPGWhitelistLabel() end
        end
    end)
    addButton(rpgTab, "Очистить whitelist", nil, function()
        _G.KZ.clearRPGWhitelist(); refreshRPGWhitelistLabel()
    end)
    addButton(rpgTab, "Обновить список игроков", "Открой дропдаун заново", function()
        refreshRPGWhitelistLabel()
    end)

    addSection(rpgTab, "GodMode")
    addButton(rpgTab, "GodMode (с подтверждением)", "Сброс камеры + ТП на (-770, 301, -750)", function()
        if _G.KZ.RunGodMod then _G.KZ.RunGodMod() end
    end)

    -- OTHER
    addSection(otherSubs["Скрипты"], "Скрипты")
    addButton(otherSubs["Скрипты"], "Fast Up", "Убирает задержку удержания", function() pcall(function() game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p) p.HoldDuration = 0 end) end) end)
    addButton(otherSubs["Скрипты"], "Infinity Yield", "Загружает IY", function() pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end) end)
    addButton(otherSubs["Скрипты"], "Freecam", "Shift+P — включить/выключить", function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/GX6MytJm"))()
            print("[KZ Hub] Freecam загружен. Нажми Shift+P")
        end)
    end)
    addSection(otherSubs["ТП"], "Телепорты")
    local function teleportToTowers()
        local char = player.Character
        if char then pcall(function() char:PivotTo(CFrame.new(-785.45, 1000.37, -445.58)) end) end
    end
    addButton(otherSubs["ТП"], "Телепорт на Towers", "Моментальный ТП", teleportToTowers)
    addKeybind(otherSubs["ТП"], "Кейбинд на ТП Towers", "T", function(k) State.TowersTPKey = k end)
    addSection(otherSubs["FOV"], "FOV")
    addToggle(otherSubs["FOV"], "Enable FOV", "Меняет угол обзора", false, function(v)
        State.FovEnabled = v
        if not v then local cam = workspace.CurrentCamera; if cam then cam.FieldOfView = _G.KZ.defaultFov end end
    end)
    addSlider(otherSubs["FOV"], "FOV Value", 40, 160, 100, false, function(v) State.FovValue = v end)

    -- UI
    addSection(uiSubs["Меню"], "Меню")
    addKeybind(uiSubs["Меню"], "Клавиша открытия меню", "Insert", function(k) State.MenuToggleKey = k end)
    addButton(uiSubs["Меню"], "Reset Keybind", "Вернуть Insert", function() State.MenuToggleKey = "Insert" end)
    addSection(uiSubs["Игровое UI"], "Внутриигровое UI")
    addToggle(uiSubs["Игровое UI"], "Скрыть игровое UI", "Прячет Map, Menu, Topbar в HUD", false, function(v) State.HideGameUI = v; _G.KZ.applyGameUI() end)
    addToggle(uiSubs["Игровое UI"], "Скрыть чат", "Только чат", false, function(v) State.HideChat = v; _G.KZ.applyChat() end)
    addButton(uiSubs["Игровое UI"], "Скрыть всё (UI + чат)", nil, function()
        State.HideGameUI = true; State.HideChat = true; _G.KZ.applyGameUI(); _G.KZ.applyChat()
    end)
    addButton(uiSubs["Игровое UI"], "Вернуть всё", nil, function()
        State.HideGameUI = false; State.HideChat = false; _G.KZ.applyGameUI(); _G.KZ.applyChat()
    end)
    addSection(uiSubs["Темы"], "Темы оформления")
    local themeColorMap = {
        Pink=Themes.Pink.tabColor, Green=Themes.Green.tabColor, Cyan=Themes.Cyan.tabColor,
        Turquoise=Themes.Turquoise.tabColor, Purple=Themes.Purple.tabColor,
        White=Themes.White.tabColor, Black=Themes.Black.tabColor,
    }
    addDropdown(uiSubs["Темы"], "Theme",
        function() return {"Pink","Green","Cyan","Turquoise","Purple","White","Black"} end,
        function() return State.CurrentTheme end,
        function(v) applyTheme(v) end,
        themeColorMap)

    do
        local first = tabs["Hitbox"]
        first.Button.BackgroundColor3 = C.accent; first.Button.BackgroundTransparency = 0
        first.Icon.TextColor3 = C.bg; first.Name.TextColor3 = C.bg
        first.Content.Visible = true; currentTab = "Hitbox"
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if input.KeyCode.Name == State.MenuToggleKey then toggleMenu() end
        if State.TowersTPKey and input.KeyCode.Name == State.TowersTPKey then
            local char = player.Character
            if char then pcall(function() char:PivotTo(CFrame.new(-785.45, 1000.37, -445.58)) end) end
        end
        if State.SkinPlayerKey and input.KeyCode.Name == State.SkinPlayerKey then
            pcall(function() if _G.KZ.applySkinPlayerHotkey then _G.KZ.applySkinPlayerHotkey() end end)
        end
    end)

    player.CharacterAdded:Connect(function(newChar)
        State.CurrentKillStreak = 0
        task.wait(1)
        if _G.KZ.getCurrentAccessoryName() then
            local n = _G.KZ.getCurrentAccessoryName()
            _G.KZ.setCurrentAccessoryName(nil)
            pcall(function() _G.KZ.equipAccessory(n) end)
        end
        task.wait(1.2)
        if State.HideGameUI or State.HideChat then _G.KZ.applyGameUI(); _G.KZ.applyChat() end
    end)

    gui.Enabled = true
    main.Visible = false

    task.delay(2.5, function()
        TweenService:Create(splashTitle, TweenInfo.new(0.2), {TextTransparency=1}):Play()
        TweenService:Create(splashAuthor, TweenInfo.new(0.2), {TextTransparency=1}):Play()
        task.wait(0.15)
        local out = TweenService:Create(splash, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size=UDim2.new(0,420,0,2), Position=UDim2.new(0.5,-210,0.5,-1)})
        out:Play()
        out.Completed:Connect(function() splash:Destroy(); animateOpen() end)
    end)
end

-- KILL REWARD
do
    local State = _G.KZ.State
    local Players = _G.KZ.Players
    local player = _G.KZ.player
    local RunService = _G.KZ.RunService
    local UserInputService = _G.KZ.UserInputService
    local TweenService = _G.KZ.TweenService
    local CoreGui = _G.KZ.CoreGui
    local new = _G.KZ.new

    local DownedGui = new("ScreenGui", {Name="KZ_Downed", ResetOnSpawn=false, ZIndexBehavior=Enum.ZIndexBehavior.Sibling, IgnoreGuiInset=true, DisplayOrder=999})
    pcall(function() DownedGui.Parent = CoreGui end)
    if not DownedGui.Parent then DownedGui.Parent = player:WaitForChild("PlayerGui") end
    local killStack = new("Frame", {Size=UDim2.new(0,500,1,0), Position=UDim2.new(0.5,-250,0,0), BackgroundTransparency=1, Parent=DownedGui})
    new("UIListLayout", {FillDirection=Enum.FillDirection.Vertical, HorizontalAlignment=Enum.HorizontalAlignment.Center, VerticalAlignment=Enum.VerticalAlignment.Center, Padding=UDim.new(0,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=killStack})

    local killCounter = 0
    local downedCounter = 0
    local SHOT_HISTORY_MAX = 12
    local SHOT_MAX_AGE = 1.2
    local HIT_DOT_THRESHOLD = 0.95
    local shotHistory = {}
    local damageOwner = setmetatable({}, { __mode = "k" })
    local lastHP = setmetatable({}, { __mode = "k" })
    local firedState = setmetatable({}, { __mode = "k" })
    local downedNotified = setmetatable({}, { __mode = "k" })
    local lastShotByUsTime = 0

    local function recordShot()
        local cam = workspace.CurrentCamera; if not cam then return end
        table.insert(shotHistory, {t=tick(), origin=cam.CFrame.Position, dir=cam.CFrame.LookVector})
        while #shotHistory > SHOT_HISTORY_MAX do table.remove(shotHistory, 1) end
        lastShotByUsTime = tick()
    end
    local function targetWasHitByUs(char)
        local hrp = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        local now = tick()
        for _, shot in ipairs(shotHistory) do
            if (now - shot.t) <= SHOT_MAX_AGE then
                local toTarget = hrp.Position - shot.origin
                if toTarget.Magnitude > 0.01 and toTarget.Unit:Dot(shot.dir) >= HIT_DOT_THRESHOLD then return true end
            end
        end
        return false
    end
    local ATTACKER_ATTRS = {
        "LastAttacker", "LastDamager", "LastDamageSource", "Killer", "KilledBy",
        "DamageSource", "Attacker", "LastHit", "HitBy", "LastDamagedBy",
        "Owner", "KillerName", "LastDamageBy", "LastAttackerName",
        "DamageOwner", "LastHitBy", "LastPlayerDamage", "KillerUserId"
    }
    local function tryResolveAttacker(v)
        if v == nil then return nil end
        if typeof(v) == "Instance" and v:IsA("Player") then return v end
        if type(v) == "number" then
            for _, p in ipairs(Players:GetPlayers()) do if p.UserId == v then return p end end
        end
        if type(v) == "string" then
            local lv = v:lower()
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == lv or p.DisplayName:lower() == lv then return p end
            end
            local num = tonumber(v)
            if num then for _, p in ipairs(Players:GetPlayers()) do if p.UserId == num then return p end end end
        end
        return nil
    end
    local function getAttackerFromAttrs(char, hum)
        for _, attrName in ipairs(ATTACKER_ATTRS) do
            local v1 = hum and hum:GetAttribute(attrName)
            local v2 = char:GetAttribute(attrName)
            local resolved = tryResolveAttacker(v1) or tryResolveAttacker(v2)
            if resolved then return resolved end
        end
        return nil
    end
    local function playStreakSound(id)
        if not State.KillStreakEnabled or not id or id == "" then return end
        pcall(function()
            local snd = Instance.new("Sound")
            snd.SoundId = id; snd.Volume = State.KillStreakVolume or 3
            snd.Parent = workspace; snd:Play()
            task.delay(10, function() if snd then snd:Destroy() end end)
        end)
    end
    local function updateDownStreak()
        State.CurrentKillStreak = (State.CurrentKillStreak or 0) + 1
        local id = State.KillStreakSounds[State.CurrentKillStreak]
        if id then playStreakSound(id) end
    end
    local STREAK_ANIM_TIME = 2.0
    local END_OFFSET_X = 320
    local END_OFFSET_Y = -220
    local SCALE_START = 0.6
    local SCALE_END = 2.4
    local FADE_START = 0.8
    local function showStreakNotification(text, color, strokeColor, order)
        local holder = new("Frame", {Size=UDim2.new(0,500,0,110), BackgroundTransparency=1, LayoutOrder=order, Parent=killStack})
        local label = new("TextLabel", {
            Size = UDim2.new(1,0,1,0), AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0), BackgroundTransparency = 1,
            Text = text, Font = Enum.Font.GothamBlack, TextSize = 56,
            TextColor3 = color, TextStrokeTransparency = 1, TextStrokeColor3 = strokeColor,
            Rotation = -8, TextTransparency = 1, Parent = holder
        })
        local scale = new("UIScale", {Scale = SCALE_START, Parent = label})
        TweenService:Create(label, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        TweenService:Create(label, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextStrokeTransparency = 0.3}):Play()
        local startTime = tick()
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not label.Parent then if conn then conn:Disconnect() end return end
            local elapsed = tick() - startTime
            local t = math.clamp(elapsed / STREAK_ANIM_TIME, 0, 1)
            scale.Scale = SCALE_START + (SCALE_END - SCALE_START) * t
            label.Position = UDim2.new(0.5, t * END_OFFSET_X, 0.5, t * END_OFFSET_Y)
            if t > FADE_START then
                local fadeT = (t - FADE_START) / (1 - FADE_START)
                label.TextTransparency = fadeT
                label.TextStrokeTransparency = 0.3 + fadeT * 0.7
            end
            if elapsed >= STREAK_ANIM_TIME then
                if conn then conn:Disconnect() end
                holder:Destroy()
            end
        end)
    end
    local function showDownedNotification()
        downedCounter = downedCounter + 1
        updateDownStreak()
        showStreakNotification("DOWNED", Color3.fromRGB(220,50,50), Color3.fromRGB(80,0,0), downedCounter)
    end
    local function showKillReward()
        killCounter = killCounter + 1
        showStreakNotification("+$1,000 KILL", Color3.fromRGB(80,230,90), Color3.fromRGB(0,60,0), killCounter)
    end
    local function classifyAttacker(plr, char, hum)
        local attacker = getAttackerFromAttrs(char, hum)
        if attacker == player then return "us" end
        if attacker and attacker ~= player then return "other" end
        local info = damageOwner[hum]
        if info and (tick() - info.time) < 1.0 then
            if info.attacker == "us" then return "us" end
            if info.attacker == "other" then return "other" end
        end
        if (tick() - lastShotByUsTime) <= SHOT_MAX_AGE and targetWasHitByUs(char) then return "us" end
        return nil
    end
    local DOWNED_ATTRS = {"Downed","Knocked","IsDowned","IsKnocked","KO","Down","Ragdoll","Incapacitated","DownedState"}
    local function isDowned(plr, char, hum)
        if not plr or not char or not hum then return false end
        if plr == player then return false end
        if hum.Health <= 0 then return false end
        for _, attr in ipairs(DOWNED_ATTRS) do
            local v1 = hum:GetAttribute(attr); local v2 = char:GetAttribute(attr)
            if v1 == true or v2 == true then return true end
            if type(v1) == "number" and v1 > 0 and attr:lower():find("down") then return true end
            if type(v2) == "number" and v2 > 0 and attr:lower():find("down") then return true end
        end
        local st = hum:GetState()
        if st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown or st == Enum.HumanoidStateType.Physics then return true end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and hum.Health > 0 and hum.Health < hum.MaxHealth then
            if hrp.CFrame.UpVector.Y < 0.4 then return true end
        end
        return false
    end
    local function checkDowned(plr, char, hum)
        if not hum or firedState[hum] then return end
        if not isDowned(plr, char, hum) then return end
        if classifyAttacker(plr, char, hum) ~= "us" then return end
        if not downedNotified[hum] then
            downedNotified[hum] = true
            showDownedNotification()
        end
    end
    local function checkKilled(plr, char, hum)
        if not hum or firedState[hum] then return end
        if hum.Health > 0 then return end
        if classifyAttacker(plr, char, hum) ~= "us" then return end
        firedState[hum] = true
        showKillReward()
    end
    local function onHealthChanged(plr, char, hum, newHealth)
        local oldHealth = lastHP[hum] or newHealth
        lastHP[hum] = newHealth
        if newHealth < oldHealth then
            local attacker = getAttackerFromAttrs(char, hum)
            if attacker == player then
                damageOwner[hum] = {attacker = "us", time = tick()}
            elseif attacker and attacker ~= player then
                damageOwner[hum] = {attacker = "other", time = tick()}
            elseif (tick() - lastShotByUsTime) <= SHOT_MAX_AGE and targetWasHitByUs(char) then
                damageOwner[hum] = {attacker = "us", time = tick()}
            else
                damageOwner[hum] = {attacker = "other", time = tick()}
            end
        end
        if newHealth <= 0 then checkKilled(plr, char, hum) else checkDowned(plr, char, hum) end
    end
    local function hookDownedChar(char)
        if not char then return end
        local hum = char:WaitForChild("Humanoid", 5); if not hum then return end
        local plr = Players:GetPlayerFromCharacter(char)
        if not plr or plr == player then return end
        lastHP[hum] = hum.Health
        damageOwner[hum] = nil; firedState[hum] = nil; downedNotified[hum] = nil
        hum.Died:Connect(function() checkKilled(plr, char, hum) end)
        hum.HealthChanged:Connect(function(newHealth) onHealthChanged(plr, char, hum, newHealth) end)
        hum.StateChanged:Connect(function() checkDowned(plr, char, hum) end)
        task.spawn(function()
            while char.Parent and hum.Parent do
                if hum.Health > 0 then checkDowned(plr, char, hum) end
                task.wait(0.15)
            end
        end)
    end
    local function hookTool(tool)
        if not tool or not tool:IsA("Tool") then return end
        if tool:GetAttribute("KZ_ShotHooked_V17") then return end
        tool:SetAttribute("KZ_ShotHooked_V17", true)
        tool.Activated:Connect(recordShot)
    end
    task.spawn(function()
        while true do
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then hookTool(tool) end
            end
            local bp = player:FindFirstChildOfClass("Backpack")
            if bp then for _, t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then hookTool(t) end end end
            task.wait(0.3)
        end
    end)
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Tool") then recordShot() end
        end
    end)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            if p.Character then hookDownedChar(p.Character) end
            p.CharacterAdded:Connect(hookDownedChar)
        end
    end
    Players.PlayerAdded:Connect(function(p)
        if p == player then return end
        p.CharacterAdded:Connect(hookDownedChar)
    end)
    _G.KZ_ShowDowned = showDownedNotification
    _G.KZ_ShowKillReward = showKillReward
end

print("KZ HUB v9.8 — Silent Aim + RPG (Click/Swastika/Text/Spam) + GodMod + ESP")
