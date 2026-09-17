--[[
    Axiom Hub — Steal An Egg
    Autor: Lunny
    Discord: https://discord.gg/BDCajDWXj8
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local UserInputService   = game:GetService("UserInputService")
local TweenService       = game:GetService("TweenService")

local LP = Players.LocalPlayer
if not LP then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LP = Players.LocalPlayer
end

-- espera personagem vivo
while not (LP.Character
    and LP.Character:FindFirstChild("HumanoidRootPart")
    and LP.Character:FindFirstChildOfClass("Humanoid")
    and LP.Character:FindFirstChildOfClass("Humanoid").Health > 0) do
    task.wait(0.2)
end

local char = LP.Character
local hrp  = char:FindFirstChild("HumanoidRootPart")

-- ================= TEMA =================
local Theme = {
    bg      = Color3.fromRGB(13, 13, 16),
    rail    = Color3.fromRGB(19, 19, 23),
    card    = Color3.fromRGB(28, 28, 34),
    lift    = Color3.fromRGB(38, 38, 46),
    line    = Color3.fromRGB(50, 50, 60),
    text    = Color3.fromRGB(240, 240, 248),
    dim     = Color3.fromRGB(158, 158, 175),
    mute    = Color3.fromRGB(98, 98, 112),
    accent  = Color3.fromRGB(120, 175, 255),   -- azul
    accent2 = Color3.fromRGB(180, 120, 255),   -- roxo (mutação)
    ok      = Color3.fromRGB(70, 200, 120),
    off     = Color3.fromRGB(70, 70, 80),
}

local F = {
    title = Enum.Font.GothamBold,
    body  = Enum.Font.Gotham,
    mono  = Enum.Font.Code,
}

local DISCORD = "https://discord.gg/BDCajDWXj8"
local CREDITS = "Lunny"

-- ================= HELPERS =================
local function n(cls, props, parent)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    if parent then i.Parent = parent end
    return i
end

local function corner(i, r) n("UICorner", {CornerRadius = UDim.new(0, r or 8)}, i) end
local function stroke(i, c, t)
    n("UIStroke", {
        Color = c or Theme.line,
        Thickness = t or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, i)
end

-- ================= DADOS DO JOGO =================
local RARITIES  = {"Common","Uncommon","Rare","Epic","Legendary","Mythic",
                   "Cosmic","Secret","Eternal","Divine","Titan"}
local MUTATIONS = {"Golden","Rainbow","Galaxy","Crystal","Bloom"}
local BIOMES    = {"Forest","Desert","Lake","Jungle","Snow","Volcano",
                   "Prehistoric","Cosmic","Abyss Ocean","Cherry Blossom"}

local Filter = { rarity = {}, mutation = {}, biome = {} }
local AutoSteal = false

-- ================= LÓGICA DE OVO =================
local function scanEggs()
    local list = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local nm = obj.Name:lower()
            if nm:find("egg") or nm:find("ovo") then
                local p = obj:IsA("BasePart") and obj
                          or obj:FindFirstChildWhichIsA("BasePart")
                if p then list[#list + 1] = {obj = obj, part = p} end
            end
        end
    end
    return list
end

local function parseInfo(egg)
    local nm = egg.obj.Name
    local rar, mut = "Common", nil
    for _, r in ipairs(RARITIES)  do if nm:find(r) then rar = r break end end
    for _, m in ipairs(MUTATIONS) do if nm:find(m) then mut = m break end end
    return {name = nm, rarity = rar, mutation = mut}
end

local function matches(info)
    if next(Filter.rarity)   and not Filter.rarity[info.rarity]           then return false end
    if next(Filter.mutation) and (not info.mutation
        or not Filter.mutation[info.mutation])                            then return false end
    return true
end

-- ================= UI =================
local gui = n("ScreenGui", {
    Name = "AxiomHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 100,
}, (gethui and gethui()) or LP:WaitForChild("PlayerGui"))

pcall(function()
    if syn and syn.protect_gui then syn.protect_gui(gui) end
end)

local WIN_W, WIN_H = 320, 420
local win = n("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(WIN_W, WIN_H),
    BackgroundColor3 = Theme.bg,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true,
}, gui)
corner(win, 14)
stroke(win, Theme.line, 1)

-- sombra
local sh = n("Frame", {
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.6,
    Position = UDim2.fromOffset(6, 8),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    ZIndex = 0,
}, win)
corner(sh, 16)
win.ZIndex = 2

-- ---------- HEADER ----------
local header = n("Frame", {
    BackgroundColor3 = Theme.rail,
    Size = UDim2.new(1, 0, 0, 64),
    BorderSizePixel = 0,
    ZIndex = 3,
}, win)
corner(header, 14)

n("Frame", {
    BackgroundColor3 = Theme.rail,
    Position = UDim2.new(0, 0, 1, -16),
    Size = UDim2.new(1, 0, 0, 16),
    BorderSizePixel = 0,
    ZIndex = 3,
}, header)

-- Ícone A (estiloso)
local iconHolder = n("Frame", {
    BackgroundColor3 = Theme.accent,
    Position = UDim2.fromOffset(12, 14),
    Size = UDim2.fromOffset(36, 36),
    BorderSizePixel = 0,
    ZIndex = 4,
}, header)
corner(iconHolder, 10)
n("TextLabel", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Font = Enum.Font.GothamBlack,
    Text = "A",
    TextColor3 = Theme.bg,
    TextSize = 24,
    ZIndex = 5,
}, iconHolder)

n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(58, 14),
    Size = UDim2.new(1, -100, 0, 18),
    Font = F.title,
    Text = "AXIOM",
    TextColor3 = Theme.text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, header)

n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(58, 32),
    Size = UDim2.new(1, -100, 0, 14),
    Font = F.body,
    Text = "Steal An Egg",
    TextColor3 = Theme.mute,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, header)

-- botão Discord
local discordBtn = n("TextButton", {
    BackgroundColor3 = Theme.card,
    Position = UDim2.new(1, -88, 0, 16),
    Size = UDim2.fromOffset(34, 34),
    Text = "D",
    Font = F.title,
    TextColor3 = Theme.accent,
    TextSize = 16,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 4,
}, header)
corner(discordBtn, 10)
stroke(discordBtn, Theme.line, 1)

-- botão minimizar
local minBtn = n("TextButton", {
    BackgroundColor3 = Theme.card,
    Position = UDim2.new(1, -46, 0, 16),
    Size = UDim2.fromOffset(34, 34),
    Text = "—",
    Font = F.title,
    TextColor3 = Theme.dim,
    TextSize = 14,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 4,
}, header)
corner(minBtn, 10)
stroke(minBtn, Theme.line, 1)

local function hover(btn, normal, over)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12),
            {BackgroundColor3 = over}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12),
            {BackgroundColor3 = normal}):Play()
    end)
end
hover(discordBtn, Theme.card, Theme.lift)
hover(minBtn, Theme.card, Theme.lift)

-- toast
local function notify(msg)
    local box = n("TextLabel", {
        BackgroundColor3 = Theme.card,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -30),
        Size = UDim2.fromOffset(220, 30),
        Font = F.body,
        Text = msg,
        TextColor3 = Theme.text,
        TextSize = 12,
        BorderSizePixel = 0,
        ZIndex = 50,
    }, win)
    corner(box, 8)
    stroke(box, Theme.line, 1)
    task.delay(2, function()
        TweenService:Create(box, TweenInfo.new(0.3),
            {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        task.wait(0.35)
        box:Destroy()
    end)
end

discordBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(DISCORD) end
    pcall(function()
        game:GetService("GuiService"):OpenBrowserWindow(DISCORD)
    end)
    notify("Discord copiado!")
end)

minBtn.MouseButton1Click:Connect(function()
    win.Visible = false
    local reopen = n("TextButton", {
        Text = "A",
        Font = Enum.Font.GothamBlack,
        TextColor3 = Theme.bg,
        BackgroundColor3 = Theme.accent,
        Size = UDim2.fromOffset(44, 44),
        Position = UDim2.new(0, 20, 0.5, -22),
        TextSize = 22,
        BorderSizePixel = 0,
        ZIndex = 100,
        Draggable = true,
    }, gui)
    corner(reopen, 12)
    reopen.MouseButton1Click:Connect(function()
        win.Visible = true
        reopen:Destroy()
    end)
end)

-- ---------- CARD DO ALVO ----------
local card = n("Frame", {
    BackgroundColor3 = Theme.card,
    Position = UDim2.fromOffset(12, 74),
    Size = UDim2.new(1, -24, 0, 72),
    BorderSizePixel = 0,
    ZIndex = 3,
}, win)
corner(card, 10)
stroke(card, Theme.line, 1)

local eggIcon = n("Frame", {
    BackgroundColor3 = Theme.lift,
    Position = UDim2.fromOffset(10, 10),
    Size = UDim2.fromOffset(52, 52),
    BorderSizePixel = 0,
    ZIndex = 4,
}, card)
corner(eggIcon, 10)
n("TextLabel", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Text = "🥚",
    TextSize = 26,
    Font = F.body,
    ZIndex = 5,
}, eggIcon)

local nameLbl = n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(72, 14),
    Size = UDim2.new(1, -84, 0, 18),
    Font = F.title,
    Text = "Nenhum alvo",
    TextColor3 = Theme.text,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, card)

local mutLbl = n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(72, 34),
    Size = UDim2.new(1, -84, 0, 14),
    Font = F.body,
    Text = "—",
    TextColor3 = Theme.accent2,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, card)

local rarLbl = n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(72, 48),
    Size = UDim2.new(1, -84, 0, 14),
    Font = F.mono,
    Text = "—",
    TextColor3 = Theme.mute,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, card)

-- ---------- TOGGLE TELEGUIADO ----------
local tglFrame = n("Frame", {
    BackgroundColor3 = Theme.card,
    Position = UDim2.fromOffset(12, 154),
    Size = UDim2.new(1, -24, 0, 46),
    BorderSizePixel = 0,
    ZIndex = 3,
}, win)
corner(tglFrame, 10)
stroke(tglFrame, Theme.line, 1)

n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 8),
    Size = UDim2.new(1, -80, 0, 16),
    Font = F.title,
    Text = "TELEGUIADO",
    TextColor3 = Theme.text,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, tglFrame)

n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 24),
    Size = UDim2.new(1, -80, 0, 14),
    Font = F.body,
    Text = "Roubar o ovo mais próximo automaticamente",
    TextColor3 = Theme.mute,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, tglFrame)

local tglBg = n("Frame", {
    BackgroundColor3 = Theme.off,
    Position = UDim2.new(1, -62, 0.5, -12),
    Size = UDim2.fromOffset(48, 24),
    BorderSizePixel = 0,
    ZIndex = 4,
}, tglFrame)
corner(tglBg, 12)

local tglKnob = n("Frame", {
    BackgroundColor3 = Theme.text,
    Position = UDim2.fromOffset(3, 3),
    Size = UDim2.fromOffset(18, 18),
    BorderSizePixel = 0,
    ZIndex = 5,
}, tglBg)
corner(tglKnob, 9)

local tglBtn = n("TextButton", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Text = "",
    ZIndex = 6,
}, tglBg)

tglBtn.MouseButton1Click:Connect(function()
    AutoSteal = not AutoSteal
    TweenService:Create(tglBg, TweenInfo.new(0.15), {
        BackgroundColor3 = AutoSteal and Theme.ok or Theme.off
    }):Play()
    TweenService:Create(tglKnob, TweenInfo.new(0.15), {
        Position = AutoSteal
            and UDim2.fromOffset(27, 3)
            or  UDim2.fromOffset(3, 3)
    }):Play()
end)

-- ---------- FILTROS ----------
n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 210),
    Size = UDim2.new(1, -28, 0, 16),
    Font = F.title,
    Text = "FILTROS",
    TextColor3 = Theme.text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
}, win)

local tabs = n("Frame", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(12, 230),
    Size = UDim2.new(1, -24, 0, 28),
    ZIndex = 3,
}, win)
n("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabs)

local currentTab  = "Raridade"
local currentList = nil
local tabButtons  = {}

local function rebuildList(cat)
    currentTab = cat
    if currentList then currentList:Destroy() end

    currentList = n("ScrollingFrame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(12, 264),
        Size = UDim2.new(1, -24, 1, -300),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.line,
        BorderSizePixel = 0,
        ZIndex = 3,
    }, win)
    n("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, currentList)

    local list, data
    if cat == "Raridade" then list, data = RARITIES,  Filter.rarity
    elseif cat == "Mutação" then list, data = MUTATIONS, Filter.mutation
    else list, data = BIOMES, Filter.biome end

    for i, nm in ipairs(list) do
        local row = n("TextButton", {
            BackgroundColor3 = data[nm] and Theme.lift or Theme.card,
            Size = UDim2.new(1, 0, 0, 30),
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            LayoutOrder = i,
            ZIndex = 4,
        }, currentList)
        corner(row, 6)
        stroke(row, Theme.line, 1)

        local box = n("Frame", {
            BackgroundColor3 = data[nm] and Theme.accent or Theme.off,
            Position = UDim2.fromOffset(8, 8),
            Size = UDim2.fromOffset(14, 14),
            BorderSizePixel = 0,
            ZIndex = 5,
        }, row)
        corner(box, 4)

        local lbl = n("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(30, 0),
            Size = UDim2.new(1, -34, 1, 0),
            Font = F.body,
            Text = nm,
            TextColor3 = data[nm] and Theme.text or Theme.dim,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 5,
        }, row)

        row.MouseButton1Click:Connect(function()
            if data[nm] then
                data[nm] = nil
            else
                data[nm] = true
            end
            local on = data[nm] and true or false
            row.BackgroundColor3 = on and Theme.lift or Theme.card
            box.BackgroundColor3 = on and Theme.accent or Theme.off
            lbl.TextColor3       = on and Theme.text or Theme.dim
        end)
    end
end

local function buildTabs()
    for i, nm in ipairs({"Raridade", "Mutação", "Bioma"}) do
        local b = n("TextButton", {
            BackgroundColor3 = nm == currentTab and Theme.lift or Theme.card,
            Size = UDim2.fromOffset(84, 28),
            Text = nm,
            Font = F.body,
            TextColor3 = nm == currentTab and Theme.text or Theme.dim,
            TextSize = 11,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            LayoutOrder = i,
            ZIndex = 4,
        }, tabs)
        corner(b, 7)
        stroke(b, Theme.line, 1)
        tabButtons[nm] = b

        b.MouseButton1Click:Connect(function()
            for name, bb in pairs(tabButtons) do
                local active = name == nm
                bb.BackgroundColor3 = active and Theme.lift or Theme.card
                bb.TextColor3       = active and Theme.text or Theme.dim
            end
            rebuildList(nm)
        end)
    end
end
buildTabs()
rebuildList("Raridade")

-- ---------- FOOTER ----------
n("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 1, -22),
    Size = UDim2.new(1, 0, 0, 16),
    Font = F.body,
    Text = "Axiom Hub  •  Créditos: " .. CREDITS,
    TextColor3 = Theme.mute,
    TextSize = 10,
    ZIndex = 3,
}, win)

-- ================= LOOP DE ROUBO =================
task.spawn(function()
    while task.wait(0.35) do
        if not AutoSteal then
            nameLbl.Text = "Nenhum alvo"
            mutLbl.Text  = "—"
            rarLbl.Text  = "—"
            continue
        end

        -- garante personagem vivo
        if not char or not char.Parent or not hrp or not hrp.Parent then
            repeat task.wait(0.2)
            until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            char = LP.Character
            hrp  = char:FindFirstChild("HumanoidRootPart")
        end

        local eggs = scanEggs()
        local best, dist = nil, math.huge

        for _, e in ipairs(eggs) do
            local info = parseInfo(e)
            if matches(info) then
                local d = (e.part.Position - hrp.Position).Magnitude
                if d < dist then best, dist = e, d end
            end
        end

        if best then
            local info = parseInfo(best)
            nameLbl.Text = info.name
            mutLbl.Text  = info.mutation or "Sem mutação"
            rarLbl.Text  = info.rarity
            hrp.CFrame = best.part.CFrame + Vector3.new(0, 3, 0)
        else
            nameLbl.Text = "Nenhum ovo encontrado"
            mutLbl.Text  = "—"
            rarLbl.Text  = "—"
        end
    end
end)

-- ================= UNLOAD =================
if getgenv then
    getgenv().AxiomUnload = function()
        if gui then gui:Destroy() end
    end
end