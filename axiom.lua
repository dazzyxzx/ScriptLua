-- Axiom Hub v2 - Steal An Egg
-- Creditos: Lunny
-- Discord: https://discord.gg/BDCajDWXj8

if not game:IsLoaded() then game.Loaded:Wait() end

local Players   = game:GetService("Players")
local Tween     = game:GetService("TweenService")
local RS        = game:GetService("ReplicatedStorage")
local RunSvc    = game:GetService("RunService")
local LP        = Players.LocalPlayer

while not (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")) do
    task.wait(0.2)
end
local char = LP.Character
local hrp  = char:FindFirstChild("HumanoidRootPart")

-- ================== PALETA ==================
local C = {
    bg     = Color3.fromRGB(14,14,18),
    card   = Color3.fromRGB(26,26,32),
    lift   = Color3.fromRGB(40,40,48),
    line   = Color3.fromRGB(55,55,65),
    txt    = Color3.fromRGB(240,240,248),
    dim    = Color3.fromRGB(150,150,170),
    mute   = Color3.fromRGB(95,95,110),
    accent = Color3.fromRGB(120,170,255),
    purple = Color3.fromRGB(190,130,255),
    ok     = Color3.fromRGB(70,200,120),
    off    = Color3.fromRGB(60,60,72),
    gold   = Color3.fromRGB(230,190,90),
}
local Ft = {b=Enum.Font.GothamBold, r=Enum.Font.Gotham, m=Enum.Font.Code}
local DISCORD_URL  = "https://discord.gg/BDCajDWXj8"
local DISCORD_ICON = "rbxassetid://18505728250"

-- ================== HELPERS ==================
local function n(cls, props, parent)
    local i = Instance.new(cls)
    for k,v in pairs(props or {}) do i[k]=v end
    if parent then i.Parent = parent end
    return i
end
local function cr(i,r) n("UICorner",{CornerRadius=UDim.new(0,r or 8)},i) end
local function st(i,c)
    n("UIStroke",{Color=c or C.line,Thickness=1,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border},i)
end
local function fmt(v)
    v = tonumber(v) or 0
    if v >= 1e9 then return string.format("%.1fB", v/1e9) end
    if v >= 1e6 then return string.format("%.1fM", v/1e6) end
    if v >= 1e3 then return string.format("%.1fK", v/1e3) end
    return tostring(math.floor(v))
end

-- ================== ASSET ITEMS (igual DiceHub) ==================
local AssetItems = nil
pcall(function()
    local shared = RS:WaitForChild("Shared", 5)
    local util   = shared and shared:WaitForChild("Util", 5)
    local ai     = util and util:WaitForChild("AssetItems", 5)
    if ai then AssetItems = require(ai) end
end)

local function resolveAsset(key)
    -- tenta pegar info real do AssetItems
    if not AssetItems then return nil end
    local assets = AssetItems.Assets or AssetItems
    if type(assets) ~= "table" then return nil end
    local a = assets[key]
    if type(a) == "table" then return a end
    -- se for string/número (referência), tenta de novo
    if type(a) == "string" then
        return assets[a]
    end
    return nil
end

-- ================== RARITY ==================
local RARITY_ORDER = {"Divine","Eternal","Secret","Cosmic","Mythic",
                      "Legendary","Epic","Rare","Uncommon","Common"}
local RAR_COLOR = {
    Divine    = Color3.fromRGB(244,63,94),
    Eternal   = Color3.fromRGB(217,70,239),
    Secret    = Color3.fromRGB(249,115,22),
    Cosmic    = Color3.fromRGB(6,182,212),
    Mythic    = Color3.fromRGB(139,92,246),
    Legendary = Color3.fromRGB(251,191,36),
    Epic      = Color3.fromRGB(168,85,247),
    Rare      = Color3.fromRGB(59,130,246),
    Uncommon  = Color3.fromRGB(34,197,94),
    Common    = Color3.fromRGB(148,163,184),
}

-- ================== SNAPSHOT / SCAN ==================
local AskSnapshot, ClientEggState
pcall(function()
    local p = RS:FindFirstChild("Packages")
    local net = (p and p:FindFirstChild("Networking")) or RS
    AskSnapshot = net:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot", true)
              or RS:FindFirstChild("AskFieldEggSnapshot", true)
end)
pcall(function()
    local cli = RS:FindFirstChild("Client")
    local es  = cli and cli:FindFirstChild("EggState")
    if es then ClientEggState = require(es) end
end)

local function scanEggs()
    local list, seen = {}, {}
    -- Remote
    if AskSnapshot then
        local ok, snap = pcall(function() return AskSnapshot:InvokeServer() end)
        if ok and type(snap) == "table" then
            local recs = snap.Records or snap
            for uid, rec in pairs(recs) do
                if type(rec) == "table" then
                    if not rec.Uid then rec.Uid = uid end
                    if rec.Uid and not seen[rec.Uid] then
                        seen[rec.Uid] = true
                        list[#list+1] = rec
                    end
                end
            end
        end
    end
    -- Client state
    if ClientEggState and ClientEggState.ReadFieldEggs then
        local ok, s = pcall(ClientEggState.ReadFieldEggs)
        if ok and type(s) == "table" then
            local recs = s.Records or s
            for uid, rec in pairs(recs) do
                if type(rec) == "table" and not seen[uid] then
                    if not rec.Uid then rec.Uid = uid end
                    seen[uid] = true
                    list[#list+1] = rec
                end
            end
        end
    end
    -- Slots físicos
    local slots = workspace:FindFirstChild("AreaEggSlotsClient")
    if slots then
        for _, slot in ipairs(slots:GetChildren()) do
            local uid = slot.Name
            if uid ~= "" and not seen[uid] then
                local ok, pivot = pcall(function() return slot:GetPivot() end)
                if ok and pivot.Position.X >= 530 then
                    seen[uid] = true
                    list[#list+1] = {
                        Uid = uid,
                        AssetCategory = slot:GetAttribute("Category"),
                        Rarity  = slot:GetAttribute("Rarity"),
                        Rank    = slot:GetAttribute("RarityRank"),
                        Income  = slot:GetAttribute("Income"),
                        Mutations = slot:GetAttribute("Mutations"),
                        AreaId  = slot:GetAttribute("AreaId"),
                        State   = "Slot",
                        PhysicalModel = slot,
                        Position = pivot.Position,
                    }
                end
            end
        end
    end
    return list
end

-- extrai nome/valor/mutação/ícone REAIS
local function eggData(egg)
    -- 1) tenta pegar AssetCategory como chave string (se for tabela, ignora)
    local catKey = egg.AssetCategory
    if type(catKey) ~= "string" then catKey = egg.Category or egg.Name or nil end

    local asset = catKey and resolveAsset(catKey) or nil

    local nome = catKey or egg.Uid or "Egg"
    local val  = tonumber(egg.Income) or 0
    local icon = nil

    if asset then
        nome = asset.DisplayName or asset.Name or nome
        val  = tonumber(asset.Income) or tonumber(asset.Value) or val
        -- ícone do asset
        icon = asset.Image or asset.Icon or asset.Thumbnail
        if icon and string.sub(icon,1,4) ~= "rbx" and string.sub(icon,1,3) ~= "htt" then
            icon = "rbxassetid://"..icon
        end
    end

    -- ícone do PhysicalModel (Decal/Texture)
    if not icon and egg.PhysicalModel then
        for _, d in ipairs(egg.PhysicalModel:GetDescendants()) do
            if d:IsA("Decal") and d.Texture ~= "" then icon = d.Texture; break end
            if d:IsA("Texture") and d.Texture ~= "" then icon = d.Texture; break end
        end
    end

    local rar = egg.Rarity
    if not rar and egg.Rank then
        rar = RARITY_ORDER[tonumber(egg.Rank)] or "Common"
    end
    rar = rar or "Common"
    if type(rar) == "number" then rar = RARITY_ORDER[rar] or "Common" end

    return {
        nome = nome,
        val  = val,
        rar  = rar,
        mut  = egg.Mutations,
        icon = icon,
        raw  = egg,
    }
end

-- ================== STEAL (via ProximityPrompt) ==================
local function firePrompts(model)
    if not model then return end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            pcall(function()
                d.RequiresLineOfSight = false
                d.HoldDuration = 0
                if fireproximityprompt then
                    fireproximityprompt(d, 0)
                    fireproximityprompt(d)
                end
            end)
        end
    end
end

-- ================== GLIDE (baseado no DiceHub) ==================
local function glideTo(targetPos, speed)
    speed = math.max(120, speed or 350)
    if not hrp then return end
    local dest = targetPos + Vector3.new(0, 3, 0)
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.AutoRotate = false end
    local timeout = os.clock() + 12
    while os.clock() < timeout do
        if not hrp or not hrp.Parent then return end
        local here = hrp.Position
        local dist = (dest - here).Magnitude
        if dist <= 6 then break end
        local dir = (dest - here).Unit
        local step = dir * math.min(speed * RunSvc.Heartbeat:Wait(), dist)
        hrp.CFrame = CFrame.lookAt(here + step, dest)
        hrp.AssemblyLinearVelocity = Vector3.zero
    end
    if hum then hum.AutoRotate = true end
end

-- ================== GUI ==================
local gui = n("ScreenGui",{
    Name = "AxiomHub", ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999,
}, LP:WaitForChild("PlayerGui"))

local W, H_COL, H_EXP = 260, 230, 370
local win = n("Frame",{
    AnchorPoint = Vector2.new(0.5,0.5),
    Position = UDim2.fromScale(0.5,0.5),
    Size = UDim2.fromOffset(W,H_COL),
    BackgroundColor3 = C.bg, BorderSizePixel = 0,
    Active = true, Draggable = true,
}, gui)
cr(win,12); st(win)
local sh = n("Frame",{
    BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.6,
    Position = UDim2.fromOffset(5,7), Size = UDim2.new(1,0,1,0),
    BorderSizePixel = 0, ZIndex = 0,
}, win)
cr(sh,14)

-- header
local hd = n("Frame",{
    BackgroundColor3 = C.card, Size = UDim2.new(1,0,0,44),
    BorderSizePixel = 0, ZIndex = 2,
}, win)
cr(hd,12)
n("Frame",{BackgroundColor3=C.card, Position=UDim2.new(0,0,1,-10),
    Size=UDim2.new(1,0,0,10), BorderSizePixel=0, ZIndex=2}, hd)

local aBox = n("Frame",{BackgroundColor3=C.accent,
    Position=UDim2.fromOffset(10,9), Size=UDim2.fromOffset(26,26),
    BorderSizePixel=0, ZIndex=3}, hd)
cr(aBox,8)
n("TextLabel",{BackgroundTransparency=1, Size=UDim2.fromScale(1,1),
    Font=Enum.Font.GothamBlack, Text="A", TextColor3=Color3.new(1,1,1),
    TextSize=17, ZIndex=4}, aBox)

n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(44,8),
    Size=UDim2.new(1,-110,0,16), Font=Ft.b, Text="AXIOM HUB",
    TextColor3=C.txt, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=3}, hd)
n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(44,24),
    Size=UDim2.new(1,-110,0,12), Font=Ft.m, Text="steal an egg",
    TextColor3=C.mute, TextSize=8, TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=3}, hd)

local dc = n("ImageButton",{BackgroundColor3=C.lift,
    Position=UDim2.new(1,-64,0,9), Size=UDim2.fromOffset(26,26),
    Image=DISCORD_ICON, AutoButtonColor=false, BorderSizePixel=0,
    ZIndex=3}, hd)
cr(dc,8)

local xb = n("TextButton",{BackgroundColor3=C.lift,
    Position=UDim2.new(1,-32,0,9), Size=UDim2.fromOffset(26,26),
    Text="x", Font=Ft.b, TextColor3=C.dim, TextSize=12,
    AutoButtonColor=false, BorderSizePixel=0, ZIndex=3}, hd)
cr(xb,8)

dc.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(DISCORD_URL) end
end)
xb.MouseButton1Click:Connect(function()
    win.Visible = false
    local r = n("TextButton",{Text="A", Font=Enum.Font.GothamBlack,
        TextColor3=Color3.new(1,1,1), BackgroundColor3=C.accent,
        Size=UDim2.fromOffset(40,40), Position=UDim2.new(0,16,0.5,-20),
        TextSize=20, BorderSizePixel=0, Draggable=true, ZIndex=200}, gui)
    cr(r,12)
    r.MouseButton1Click:Connect(function() win.Visible=true; r:Destroy() end)
end)

-- card principal
local main = n("Frame",{BackgroundColor3=C.card,
    Position=UDim2.fromOffset(10,54), Size=UDim2.new(1,-20,0,64),
    BorderSizePixel=0, ZIndex=2}, win)
cr(main,10); st(main)

local mi = n("ImageLabel",{BackgroundColor3=C.lift,
    Position=UDim2.fromOffset(10,10), Size=UDim2.fromOffset(44,44),
    Image="", ScaleType=Enum.ScaleType.Fit, BorderSizePixel=0,
    ZIndex=3}, main)
cr(mi,8)

n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(64,10),
    Size=UDim2.new(1,-140,0,10), Font=Ft.m, Text="MELHOR OVO",
    TextColor3=C.mute, TextSize=8, TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=3}, main)

local nameLbl = n("TextLabel",{BackgroundTransparency=1,
    Position=UDim2.fromOffset(64,22), Size=UDim2.new(1,-140,0,16),
    Font=Ft.b, Text="Nenhum ovo", TextColor3=C.txt, TextSize=13,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextTruncate=Enum.TextTruncate.AtEnd, ZIndex=3}, main)

local mutLbl = n("TextLabel",{BackgroundTransparency=1,
    Position=UDim2.fromOffset(64,40), Size=UDim2.new(1,-140,0,12),
    Font=Ft.r, Text="", TextColor3=C.purple, TextSize=9,
    TextXAlignment=Enum.TextXAlignment.Left, ZIndex=3}, main)

local valLbl = n("TextLabel",{AnchorPoint=Vector2.new(1,0),
    Position=UDim2.new(1,-30,0,18), Size=UDim2.fromOffset(80,18),
    BackgroundTransparency=1, Font=Ft.b, Text="0", TextColor3=C.ok,
    TextSize=15, TextXAlignment=Enum.TextXAlignment.Right, ZIndex=3}, main)

local arrow = n("TextButton",{BackgroundTransparency=1,
    AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,-8,0,6),
    Size=UDim2.fromOffset(20,18), Text="v", Font=Ft.b,
    TextColor3=C.dim, TextSize=12, AutoButtonColor=false, ZIndex=4}, main)

-- lista
local listF = n("Frame",{BackgroundColor3=C.card,
    Position=UDim2.fromOffset(10,124), Size=UDim2.new(1,-20,0,0),
    BorderSizePixel=0, ClipsDescendants=true, ZIndex=2}, win)
cr(listF,10); st(listF)
n("UIPadding",{PaddingTop=UDim.new(0,6), PaddingBottom=UDim.new(0,6)}, listF)
n("UIListLayout",{Padding=UDim.new(0,2), SortOrder=Enum.SortOrder.LayoutOrder}, listF)

-- toggle
local tg = n("Frame",{BackgroundColor3=C.card,
    Size=UDim2.new(1,-20,0,42), BorderSizePixel=0, ZIndex=2}, win)
cr(tg,10); st(tg)
n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(14,8),
    Size=UDim2.new(1,-70,0,14), Font=Ft.b, Text="TELEGUIADO",
    TextColor3=C.txt, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=3}, tg)
n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(14,23),
    Size=UDim2.new(1,-70,0,12), Font=Ft.r, Text="Auto steal",
    TextColor3=C.mute, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=3}, tg)

local tbg = n("Frame",{BackgroundColor3=C.off,
    Position=UDim2.new(1,-54,0.5,-11), Size=UDim2.fromOffset(44,22),
    BorderSizePixel=0, ZIndex=3}, tg)
cr(tbg,11)
local tk = n("Frame",{BackgroundColor3=Color3.new(1,1,1),
    Position=UDim2.fromOffset(3,3), Size=UDim2.fromOffset(16,16),
    BorderSizePixel=0, ZIndex=4}, tbg)
cr(tk,8)
local tb = n("TextButton",{BackgroundTransparency=1,
    Size=UDim2.fromScale(1,1), Text="", ZIndex=5}, tbg)

local Auto    = false
local Target  = nil    -- se nil, pega o top 1
tb.MouseButton1Click:Connect(function()
    Auto = not Auto
    Tween:Create(tbg,TweenInfo.new(0.15),
        {BackgroundColor3 = Auto and C.ok or C.off}):Play()
    Tween:Create(tk,TweenInfo.new(0.15),
        {Position = Auto and UDim2.fromOffset(25,3) or UDim2.fromOffset(3,3)}):Play()
end)

-- layout dinâmico
local Expanded = false
local function layout()
    local y = 54 + 64 + 6
    if Expanded then
        listF.Visible = true
        listF.Size = UDim2.new(1,-20,0,120)
        y = y + 120 + 6
    else
        listF.Visible = false
        listF.Size = UDim2.new(1,-20,0,0)
    end
    tg.Position = UDim2.fromOffset(10, y)
    win.Size = UDim2.fromOffset(W, Expanded and H_EXP or H_COL)
end

arrow.MouseButton1Click:Connect(function()
    Expanded = not Expanded
    arrow.Text = Expanded and "^" or "v"
    layout()
end)
layout()

-- render top 5 (com clique!)
local rowCache = {}
local function clearRows()
    for _, r in ipairs(rowCache) do
        if r and r.Parent then r:Destroy() end
    end
    rowCache = {}
end

local function addRow(idx, data, onClick)
    local row = n("TextButton",{
        BackgroundColor3 = C.card,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,22),
        Text = "", AutoButtonColor = false,
        LayoutOrder = idx, ZIndex = 3,
    }, listF)
    cr(row,5)
    rowCache[#rowCache+1] = row

    n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(0,4),
        Size=UDim2.fromOffset(16,14), Font=Ft.b, Text="#"..idx,
        TextColor3=idx==1 and C.gold or C.dim, TextSize=10,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=4}, row)

    local ico = n("ImageLabel",{BackgroundColor3=C.lift,
        Position=UDim2.fromOffset(18,1), Size=UDim2.fromOffset(20,20),
        Image=data.icon or "", ScaleType=Enum.ScaleType.Fit,
        BorderSizePixel=0, ZIndex=4}, row)
    cr(ico,5)

    n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(44,2),
        Size=UDim2.new(1,-110,0,12), Font=Ft.b, Text=data.nome,
        TextColor3=C.txt, TextSize=10, TextTruncate=Enum.TextTruncate.AtEnd,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=4}, row)

    local sub = data.rar .. (data.mut and (" - "..tostring(data.mut)) or "")
    n("TextLabel",{BackgroundTransparency=1, Position=UDim2.fromOffset(44,13),
        Size=UDim2.new(1,-110,0,10), Font=Ft.m, Text=sub,
        TextColor3=RAR_COLOR[data.rar] or C.mute, TextSize=8,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=4}, row)

    n("TextLabel",{AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,-4,0,5),
        Size=UDim2.fromOffset(60,14), BackgroundTransparency=1,
        Font=Ft.b, Text=fmt(data.val), TextColor3=C.ok, TextSize=11,
        TextXAlignment=Enum.TextXAlignment.Right, ZIndex=4}, row)

    -- clique
    row.MouseEnter:Connect(function()
        row.BackgroundTransparency = 0
        row.BackgroundColor3 = C.lift
    end)
    row.MouseLeave:Connect(function()
        row.BackgroundTransparency = 1
    end)
    row.MouseButton1Click:Connect(function()
        if onClick then onClick(data) end
    end)
end

-- ================== LOOP ==================
task.spawn(function()
    while task.wait(1) do
        if not char or not char.Parent then
            repeat task.wait(0.2)
            until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            char = LP.Character
            hrp  = char:FindFirstChild("HumanoidRootPart")
        end

        local eggs = scanEggs()
        -- monta dados
        local dados = {}
        for _, e in ipairs(eggs) do
            table.insert(dados, eggData(e))
        end
        table.sort(dados, function(a,b) return a.val > b.val end)

        -- top 1
        if #dados > 0 then
            local top = dados[1]
            nameLbl.Text = top.nome
            mutLbl.Text  = top.rar .. (top.mut and (" - "..tostring(top.mut)) or "")
            mutLbl.TextColor3 = RAR_COLOR[top.rar] or C.purple
            valLbl.Text  = fmt(top.val)
            if top.icon and top.icon ~= "" then mi.Image = top.icon end
            if not Target then Target = top.raw end
        else
            nameLbl.Text = "Nenhum ovo"
            mutLbl.Text  = ""
            valLbl.Text  = "0"
        end

        -- lista
        clearRows()
        for idx = 1, math.min(5, #dados) do
            addRow(idx, dados[idx], function(d)
                Target = d.raw
                Auto = true
                Tween:Create(tbg,TweenInfo.new(0.15),{BackgroundColor3=C.ok}):Play()
                Tween:Create(tk,TweenInfo.new(0.15),
                    {Position=UDim2.fromOffset(25,3)}):Play()
            end)
        end

        -- auto steal
        if Auto and Target then
            local pos = Target.Position
            if not pos and Target.PhysicalModel then
                pcall(function() pos = Target.PhysicalModel:GetPivot().Position end)
            end
            if pos then
                task.spawn(function()
                    glideTo(pos, 350)
                    firePrompts(Target.PhysicalModel)
                end)
            end
        end
    end
end)