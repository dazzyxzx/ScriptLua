--[[ Axiom Hub • Steal An Egg • Créditos: Lunny • discord.gg/BDCajDWXj8 ]]
if not game:IsLoaded() then game.Loaded:Wait() end

local P     = game:GetService("Players")
local Tween = game:GetService("TweenService")
local LP    = P.LocalPlayer

while not (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")) do task.wait(.2) end
local char, hrp = LP.Character, LP.Character:FindFirstChild("HumanoidRootPart")

-- ========= LISTAS DO KIRAHUB =========
local RAR = {"Common","Uncommon","Rare","Epic","Legendary","Mythic","Cosmic","Secret","Eternal","Divine","Titan"}
local MUT = {"Golden","Rainbow","Galaxy","Crystal","Bloom"}
local BIO = {"Forest","Desert","Lake","Jungle","Snow","Volcano","Prehistoric","Cosmic","Abyss Ocean","Cherry Blossom"}
local F   = {rar={}, mut={}, bio={}}
local Auto = false

-- ========= PALETA =========
local C = {
    bg=Color3.fromRGB(15,15,18), card=Color3.fromRGB(26,26,32), lift=Color3.fromRGB(38,38,46),
    line=Color3.fromRGB(52,52,62), txt=Color3.fromRGB(240,240,248), dim=Color3.fromRGB(150,150,170),
    mute=Color3.fromRGB(95,95,110), accent=Color3.fromRGB(120,170,255), purple=Color3.fromRGB(190,130,255),
    ok=Color3.fromRGB(70,200,120), off=Color3.fromRGB(60,60,72),
}
local Ft = {b=Enum.Font.GothamBold, r=Enum.Font.Gotham, m=Enum.Font.Code}
local DISCORD_URL = "https://discord.gg/BDCajDWXj8"
local DISCORD_ICON = "rbxassetid://18505728250"

local function n(c,p,par) local i=Instance.new(c); for k,v in pairs(p or {}) do i[k]=v end; if par then i.Parent=par end; return i end
local function cr(i,r) n("UICorner",{CornerRadius=UDim.new(0,r or 8)},i) end
local function st(i,c) n("UIStroke",{Color=c or C.line,Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},i) end

-- ========= DETECÇÃO DE OVO =========
local function getPart(o)
    if o:IsA("BasePart") then return o end
    return o:FindFirstChildWhichIsA("BasePart", true) or o.PrimaryPart
end

local function isEgg(o)
    if not o or not o.Parent then return false end
    if not (o:IsA("Model") or o:IsA("BasePart")) then return false end
    local nm = o.Name:lower()
    if nm:find("conveyor") or nm:find("esteira") or nm:find("spawn") or nm:find("base") then return false end
    local pr = o:FindFirstChildWhichIsA("ProximityPrompt", true)
    local at = o:GetAttribute("Rarity") or o:GetAttribute("EggName") or o:GetAttribute("Value")
    return (pr or at or nm:find("egg") or nm:find("ovo")) and true or false
end

local function info(o)
    local r = o:GetAttribute("Rarity")
    local m = o:GetAttribute("Mutation")
    local v = o:GetAttribute("Value") or o:GetAttribute("Price")
    if not r then
        for _,x in ipairs(RAR) do if o.Name:find(x) then r=x break end end
        r = r or "Common"
    end
    if not m then
        for _,x in ipairs(MUT) do if o.Name:find(x) then m=x break end end
    end
    return {rar=r, mut=m, val=v}
end

local function ok(o)
    local i = info(o)
    if next(F.rar) and not F.rar[i.rar]                  then return false end
    if next(F.mut) and (not i.mut or not F.mut[i.mut])   then return false end
    return true
end

-- ========= GUI =========
local gui = n("ScreenGui",{Name="AxiomHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=999},
    (gethui and gethui()) or LP:WaitForChild("PlayerGui"))
pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)

local W,H = 240, 230
local win = n("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(W,H),BackgroundColor3=C.bg,BorderSizePixel=0,Active=true,Draggable=true},gui)
cr(win,12); st(win)
n("Frame",{BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.65,Position=UDim2.fromOffset(5,7),
    Size=UDim2.new(1,0,1,0),ZIndex=0,BorderSizePixel=0},win); cr(win.Shadow or win:FindFirstChildOfClass("Frame") or win,14)

-- ---- HEADER ----
local hd = n("Frame",{BackgroundColor3=C.card,Size=UDim2.new(1,0,0,40),BorderSizePixel=0,ZIndex=2},win)
cr(hd,12)
n("Frame",{BackgroundColor3=C.card,Position=UDim2.new(0,0,1,-10),Size=UDim2.new(1,0,0,10),
    BorderSizePixel=0,ZIndex=2},hd)

-- ícone "A"
local ic = n("Frame",{BackgroundColor3=C.accent,Position=UDim2.fromOffset(10,8),Size=UDim2.fromOffset(24,24),
    BorderSizePixel=0,ZIndex=3},hd)
cr(ic,7)
n("TextLabel",{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Font=Enum.Font.GothamBlack,
    Text="A",TextColor3=C.bg,TextSize=15,ZIndex=4},ic)

n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(40,8),Size=UDim2.new(1,-90,0,14),
    Font=Ft.b,Text="AXIOM",TextColor3=C.txt,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},hd)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(40,22),Size=UDim2.new(1,-90,0,10),
    Font=Ft.m,Text="steal an egg",TextColor3=C.mute,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},hd)

-- ícone Discord (asset oficial)
local dc = n("ImageButton",{BackgroundColor3=C.bg,Position=UDim2.new(1,-56,0,8),
    Size=UDim2.fromOffset(24,24),Image=DISCORD_ICON,ImageColor3=Color3.new(1,1,1),
    AutoButtonColor=false,BorderSizePixel=0,ZIndex=3},hd)
cr(dc,7); st(dc)
-- botão fechar
local xb = n("TextButton",{BackgroundColor3=C.bg,Position=UDim2.new(1,-28,0,8),Size=UDim2.fromOffset(24,24),
    Text="×",Font=Ft.b,TextColor3=C.dim,TextSize=14,AutoButtonColor=false,BorderSizePixel=0,ZIndex=3},hd)
cr(xb,7); st(xb)

local function hv(b,nr,ov)
    b.MouseEnter:Connect(function() Tween:Create(b,TweenInfo.new(.12),{BackgroundColor3=ov}):Play() end)
    b.MouseLeave:Connect(function() Tween:Create(b,TweenInfo.new(.12),{BackgroundColor3=nr}):Play() end)
end
hv(dc, C.bg, C.lift)
hv(xb, C.bg, C.lift)

dc.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(DISCORD_URL) end
    pcall(function() game:GetService("GuiService"):OpenBrowserWindow(DISCORD_URL) end)
end)
xb.MouseButton1Click:Connect(function()
    win.Visible=false
    local r=n("TextButton",{Text="A",Font=Enum.Font.GothamBlack,TextColor3=C.bg,BackgroundColor3=C.accent,
        Size=UDim2.fromOffset(38,38),Position=UDim2.new(0,15,.5,-19),TextSize=18,BorderSizePixel=0,
        Draggable=true,ZIndex=100},gui)
    cr(r,10)
    r.MouseButton1Click:Connect(function() win.Visible=true; r:Destroy() end)
end)

-- ---- CARD DE ALVO (igual Lennon) ----
local cd = n("Frame",{BackgroundColor3=C.card,Position=UDim2.fromOffset(10,48),Size=UDim2.new(1,-20,0,58),
    BorderSizePixel=0,ZIndex=2},win)
cr(cd,10); st(cd)

local eggIcon = n("Frame",{BackgroundColor3=C.lift,Position=UDim2.fromOffset(8,8),Size=UDim2.fromOffset(42,42),
    BorderSizePixel=0,ZIndex=3},cd)
cr(eggIcon,10)
n("TextLabel",{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Text="🥚",TextSize=20,Font=Ft.r,ZIndex=4},eggIcon)

n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(58,8),Size=UDim2.new(1,-66,0,10),
    Font=Ft.m,Text="MELHOR OVO",TextColor3=C.mute,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},cd)
local nmL = n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(58,18),Size=UDim2.new(1,-66,0,16),
    Font=Ft.b,Text="Nenhum alvo",TextColor3=C.txt,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},cd)
local mutL = n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(58,36),Size=UDim2.new(1,-66,0,12),
    Font=Ft.r,Text="—",TextColor3=C.purple,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},cd)
local valL = n("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-10,0,10),Size=UDim2.fromOffset(90,14),
    BackgroundTransparency=1,Font=Ft.b,Text="",TextColor3=C.ok,TextSize=12,
    TextXAlignment=Enum.TextXAlignment.Right,ZIndex=3},cd)
local rarL = n("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-10,0,30),Size=UDim2.fromOffset(90,14),
    BackgroundTransparency=1,Font=Ft.m,Text="",TextColor3=C.dim,TextSize=10,
    TextXAlignment=Enum.TextXAlignment.Right,ZIndex=3},cd)

-- ---- TOGGLE TELEGUIADO ----
local tg = n("Frame",{BackgroundColor3=C.card,Position=UDim2.fromOffset(10,114),Size=UDim2.new(1,-20,0,40),
    BorderSizePixel=0,ZIndex=2},win)
cr(tg,10); st(tg)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(12,7),Size=UDim2.new(1,-70,0,14),
    Font=Ft.b,Text="TELEGUIADO",TextColor3=C.txt,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},tg)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(12,22),Size=UDim2.new(1,-70,0,12),
    Font=Ft.r,Text="Roubar ovo mais próximo",TextColor3=C.mute,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},tg)

local tbg = n("Frame",{BackgroundColor3=C.off,Position=UDim2.new(1,-52,.5,-11),Size=UDim2.fromOffset(42,22),
    BorderSizePixel=0,ZIndex=3},tg)
cr(tbg,11)
local tk = n("Frame",{BackgroundColor3=C.txt,Position=UDim2.fromOffset(3,3),Size=UDim2.fromOffset(16,16),
    BorderSizePixel=0,ZIndex=4},tbg)
cr(tk,8)
local tb = n("TextButton",{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Text="",ZIndex=5},tbg)
tb.MouseButton1Click:Connect(function()
    Auto = not Auto
    Tween:Create(tbg,TweenInfo.new(.15),{BackgroundColor3=Auto and C.ok or C.off}):Play()
    Tween:Create(tk,TweenInfo.new(.15),{Position=Auto and UDim2.fromOffset(23,3) or UDim2.fromOffset(3,3)}):Play()
end)

-- ---- FILTROS ----
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(12,162),Size=UDim2.new(1,0,0,12),
    Font=Ft.b,Text="FILTRO",TextColor3=C.txt,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=2},win)

local tabs = n("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(10,178),Size=UDim2.new(1,-20,0,20),
    ZIndex=2},win)
n("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4),
    SortOrder=Enum.SortOrder.LayoutOrder},tabs)

local curList, curTab, tbBtns = nil, "Raridade", {}
local function buildList(cat)
    curTab = cat
    if curList then curList:Destroy() end
    curList = n("ScrollingFrame",{BackgroundTransparency=1,Position=UDim2.fromOffset(10,202),
        Size=UDim2.new(1,-20,1,-208),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ScrollBarThickness=3,ScrollBarImageColor3=C.line,BorderSizePixel=0,ZIndex=2},win)
    n("UIListLayout",{Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder},curList)
    local list,data = (cat=="Raridade" and RAR) or (cat=="Mutação" and MUT) or BIO,
                      (cat=="Raridade" and F.rar) or (cat=="Mutação" and F.mut) or F.bio
    for i,v in ipairs(list) do
        local r = n("TextButton",{BackgroundColor3=data[v] and C.lift or C.card,Size=UDim2.new(1,0,0,22),
            Text="",AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=i,ZIndex=3},curList)
        cr(r,5); st(r)
        local bx = n("Frame",{BackgroundColor3=data[v] and C.accent or C.off,Position=UDim2.fromOffset(6,5),
            Size=UDim2.fromOffset(12,12),BorderSizePixel=0,ZIndex=4},r)
        cr(bx,4)
        n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(24,0),Size=UDim2.new(1,-28,1,0),
            Font=Ft.r,Text=v,TextColor3=data[v] and C.txt or C.dim,TextSize=10,
            TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},r)
        r.MouseButton1Click:Connect(function()
            data[v] = not data[v] and true or nil
            local on = data[v] and true or false
            r.BackgroundColor3 = on and C.lift or C.card
            bx.BackgroundColor3 = on and C.accent or C.off
        end)
    end
end
for i,v in ipairs({"Raridade","Mutação","Bioma"}) do
    local b = n("TextButton",{BackgroundColor3=v==curTab and C.lift or C.card,Size=UDim2.fromOffset(66,20),
        Text=v,Font=Ft.r,TextColor3=v==curTab and C.txt or C.dim,TextSize=9,
        AutoButtonColor=false,BorderSizePixel=0,LayoutOrder=i,ZIndex=3},tabs)
    cr(b,5); st(b); tbBtns[v]=b
    b.MouseButton1Click:Connect(function()
        for k,bb in pairs(tbBtns) do
            local a=k==v; bb.BackgroundColor3=a and C.lift or C.card; bb.TextColor3=a and C.txt or C.dim
        end
        buildList(v)
    end)
end
buildList("Raridade")

-- ---- FOOTER ----
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.new(0,0,1,-13),Size=UDim2.new(1,0,0,10),
    Font=Ft.m,Text="Lunny  •  discord.gg/BDCajDWXj8",TextColor3=C.mute,TextSize=8,ZIndex=2},win)

-- ========= LOOP DE STEAL =========
task.spawn(function()
    while task.wait(.3) do
        if not Auto then nmL.Text="Nenhum alvo"; mutL.Text="—"; valL.Text=""; rarL.Text=""; continue end
        if not char or not char.Parent then
            repeat task.wait(.2) until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            char, hrp = LP.Character, LP.Character:FindFirstChild("HumanoidRootPart")
        end

        local best, d = nil, math.huge
        for _, o in ipairs(workspace:GetDescendants()) do
            if isEgg(o) and ok(o) then
                local p = getPart(o)
                if p then
                    local dd = (p.Position - hrp.Position).Magnitude
                    if dd < d then best, d = o, dd end
                end
            end
        end

        if best then
            local i = info(best)
            nmL.Text  = best.Name
            mutL.Text = i.mut or "sem mutação"
            valL.Text = i.val and tostring(i.val) or ""
            rarL.Text = i.rar

            local p = getPart(best)
            if p then
                hrp.CFrame = p.CFrame + Vector3.new(0, 3, 0)
                local pr = best:FindFirstChildWhichIsA("ProximityPrompt", true)
                if pr then
                    pcall(function()
                        if fireproximityprompt then fireproximityprompt(pr)
                        else pr:InputHoldBegin(); task.wait(.1); pr:InputHoldEnd() end
                    end)
                end
            end
        else
            nmL.Text = "Nenhum ovo"; mutL.Text="—"; valL.Text=""; rarL.Text=""
        end
    end
end)

getgenv().AxiomUnload = function() gui:Destroy() endme.card,
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