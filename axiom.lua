local P = game:GetService("Players")
local Tween = game:GetService("TweenService")
local LP = P.LocalPlayer

if not game:IsLoaded() then game.Loaded:Wait() end
while not (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")) do task.wait(.2) end
local char, hrp = LP.Character, LP.Character:FindFirstChild("HumanoidRootPart")

local RAR = {"Common","Uncommon","Rare","Epic","Legendary","Mythic","Cosmic","Secret","Eternal","Divine","Titan"}
local MUT = {"Golden","Rainbow","Galaxy","Crystal","Bloom"}
local BIO = {"Forest","Desert","Lake","Jungle","Snow","Volcano","Prehistoric","Cosmic","Abyss Ocean","Cherry Blossom"}
local F   = {rar={}, mut={}, bio={}}
local Auto = false
local Expanded = false

local C = {
    bg=Color3.fromRGB(15,15,18), card=Color3.fromRGB(26,26,32), lift=Color3.fromRGB(38,38,46),
    line=Color3.fromRGB(52,52,62), txt=Color3.fromRGB(240,240,248), dim=Color3.fromRGB(150,150,170),
    mute=Color3.fromRGB(95,95,110), accent=Color3.fromRGB(120,170,255), purple=Color3.fromRGB(190,130,255),
    ok=Color3.fromRGB(70,200,120), off=Color3.fromRGB(60,60,72), gold=Color3.fromRGB(230,190,90),
}
local Ft = {b=Enum.Font.GothamBold, r=Enum.Font.Gotham, m=Enum.Font.Code}
local DEFAULT_EGG = "rbxassetid://128045385522109"
local DISCORD_URL = "https://discord.gg/BDCajDWXj8"

local function n(c,p,par) local i=Instance.new(c); for k,v in pairs(p or {}) do i[k]=v end; if par then i.Parent=par end; return i end
local function cr(i,r) n("UICorner",{CornerRadius=UDim.new(0,r or 8)},i) end
local function st(i,c) n("UIStroke",{Color=c or C.line,Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},i) end

local function fmt(v)
    if not v or v == 0 then return "?" end
    v = tonumber(v) or 0
    if v >= 1e9 then return string.format("%.1fB", v/1e9) end
    if v >= 1e6 then return string.format("%.1fM", v/1e6) end
    if v >= 1e3 then return string.format("%.1fK", v/1e3) end
    return tostring(math.floor(v))
end

local function getPart(o)
    if o:IsA("BasePart") then return o end
    return o:FindFirstChildWhichIsA("BasePart", true) or o.PrimaryPart
end

local function getIcon(o)
    local part = getPart(o)
    if part and part:IsA("BasePart") then
        local ok, tex = pcall(function() return part.TextureID end)
        if ok and tex and tex ~= "" then return tex end
    end
    for _, d in ipairs(o:GetDescendants()) do
        if (d:IsA("Decal") or d:IsA("Texture")) and d.Texture ~= "" then
            return d.Texture
        end
        if d:IsA("ImageLabel") and d.Image ~= "" then
            return d.Image
        end
    end
    return DEFAULT_EGG
end

local function getValue(o)
    local atts = {"Value","Price","SellValue","Worth","Coins","Money","Cash","Sell"}
    for _, a in ipairs(atts) do
        local v = o:GetAttribute(a)
        if type(v) == "number" then return v end
    end
    for _, c in ipairs(o:GetDescendants()) do
        if c:IsA("IntValue") or c:IsA("NumberValue") then
            local nm = c.Name:lower()
            if nm:find("val") or nm:find("price") or nm:find("worth") or nm:find("sell") then
                return c.Value
            end
        end
    end
    -- fallback por raridade
    local i = o.Name
    for idx, r in ipairs(RAR) do
        if i:find(r) then return idx * 100 end
    end
    return 0
end

local function isEgg(o)
    if not o or not o.Parent then return false end
    if not (o:IsA("Model") or o:IsA("BasePart")) then return false end
    local nm = o.Name:lower()
    if nm:find("conveyor") or nm:find("esteira") or nm:find("spawn") or nm:find("base") or nm:find("effect") then return false end
    local pr = o:FindFirstChildWhichIsA("ProximityPrompt", true)
    local at = o:GetAttribute("Rarity") or o:GetAttribute("EggName") or o:GetAttribute("Value") or o:GetAttribute("Price")
    return (pr or at or nm:find("egg") or nm:find("ovo")) and true or false
end

local function info(o)
    local r = o:GetAttribute("Rarity")
    local m = o:GetAttribute("Mutation")
    if not r then
        for _,x in ipairs(RAR) do if o.Name:find(x) then r=x break end end
        r = r or "Common"
    end
    if not m then
        for _,x in ipairs(MUT) do if o.Name:find(x) then m=x break end end
    end
    return {rar=r, mut=m, val=getValue(o)}
end

local function ok(o)
    local i = info(o)
    if next(F.rar) and not F.rar[i.rar]                then return false end
    if next(F.mut) and (not i.mut or not F.mut[i.mut]) then return false end
    return true
end

-- ========== GUI ==========
local gui = n("ScreenGui",{Name="AxiomHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=999}, LP:WaitForChild("PlayerGui"))

local W, H_COLLAPSED, H_EXPANDED = 260, 260, 400
local win = n("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),
    Size=UDim2.fromOffset(W,H_COLLAPSED),BackgroundColor3=C.bg,BorderSizePixel=0,Active=true,Draggable=true},gui)
cr(win,12); st(win)

-- HEADER
local hd = n("Frame",{BackgroundColor3=C.card,Size=UDim2.new(1,0,0,40),BorderSizePixel=0,ZIndex=2},win)
cr(hd,12)
n("Frame",{BackgroundColor3=C.card,Position=UDim2.new(0,0,1,-10),Size=UDim2.new(1,0,0,10),BorderSizePixel=0,ZIndex=2},hd)

local ic = n("Frame",{BackgroundColor3=C.accent,Position=UDim2.fromOffset(10,8),Size=UDim2.fromOffset(24,24),BorderSizePixel=0,ZIndex=3},hd)
cr(ic,7)
n("TextLabel",{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Font=Enum.Font.GothamBlack,
    Text="A",TextColor3=C.bg,TextSize=15,ZIndex=4},ic)

n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(40,8),Size=UDim2.new(1,-90,0,14),
    Font=Ft.b,Text="AXIOM",TextColor3=C.txt,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},hd)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(40,22),Size=UDim2.new(1,-90,0,10),
    Font=Ft.m,Text="steal an egg",TextColor3=C.mute,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},hd)

local dc = n("ImageButton",{BackgroundColor3=C.bg,Position=UDim2.new(1,-56,0,8),
    Size=UDim2.fromOffset(24,24),Image="rbxassetid://18505728250",ImageColor3=Color3.new(1,1,1),
    AutoButtonColor=false,BorderSizePixel=0,ZIndex=3},hd)
cr(dc,7); st(dc)
local xb = n("TextButton",{BackgroundColor3=C.bg,Position=UDim2.new(1,-28,0,8),Size=UDim2.fromOffset(24,24),
    Text="X",Font=Ft.b,TextColor3=C.dim,TextSize=14,AutoButtonColor=false,BorderSizePixel=0,ZIndex=3},hd)
cr(xb,7); st(xb)

local function hv(b,nr,ov)
    b.MouseEnter:Connect(function() Tween:Create(b,TweenInfo.new(.12),{BackgroundColor3=ov}):Play() end)
    b.MouseLeave:Connect(function() Tween:Create(b,TweenInfo.new(.12),{BackgroundColor3=nr}):Play() end)
end
hv(dc, C.bg, C.lift); hv(xb, C.bg, C.lift)
dc.MouseButton1Click:Connect(function() if setclipboard then setclipboard(DISCORD_URL) end end)
xb.MouseButton1Click:Connect(function()
    win.Visible=false
    local r=n("TextButton",{Text="A",Font=Enum.Font.GothamBlack,TextColor3=C.bg,BackgroundColor3=C.accent,
        Size=UDim2.fromOffset(38,38),Position=UDim2.new(0,15,.5,-19),TextSize=18,BorderSizePixel=0,
        Draggable=true,ZIndex=100},gui)
    cr(r,10)
    r.MouseButton1Click:Connect(function() win.Visible=true; r:Destroy() end)
end)

-- ========== CARD DO TOP 1 ==========
local mainCard = n("Frame",{BackgroundColor3=C.card,Position=UDim2.fromOffset(10,48),
    Size=UDim2.new(1,-20,0,56),BorderSizePixel=0,ZIndex=2},win)
cr(mainCard,10); st(mainCard)

local mainIcon = n("ImageLabel",{BackgroundColor3=C.lift,Position=UDim2.fromOffset(8,8),
    Size=UDim2.fromOffset(40,40),Image=DEFAULT_EGG,BackgroundTransparency=0,
    ScaleType=Enum.ScaleType.Fit,BorderSizePixel=0,ZIndex=3},mainCard)
cr(mainIcon,8)

local rankLbl = n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(56,8),
    Size=UDim2.new(1,-110,0,10),Font=Ft.m,Text="MELHOR OVO",TextColor3=C.gold,
    TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},mainCard)

local mainName = n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(56,18),
    Size=UDim2.new(1,-110,0,16),Font=Ft.b,Text="Nenhum ovo",TextColor3=C.txt,
    TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=3},mainCard)

local mainMut = n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(56,36),
    Size=UDim2.new(1,-110,0,12),Font=Ft.r,Text="—",TextColor3=C.purple,
    TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},mainCard)

local mainVal = n("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-30,0,8),
    Size=UDim2.fromOffset(80,20),BackgroundTransparency=1,Font=Ft.b,Text="?",
    TextColor3=C.ok,TextSize=16,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=3},mainCard)

local mainRar = n("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-30,0,30),
    Size=UDim2.fromOffset(80,14),BackgroundTransparency=1,Font=Ft.m,Text="",
    TextColor3=C.dim,TextSize=9,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=3},mainCard)

-- seta expandir
local arrowBtn = n("TextButton",{BackgroundTransparency=1,Position=UDim2.new(1,-26,0,18),
    Size=UDim2.fromOffset(18,20),Text="v",Font=Ft.b,TextColor3=C.dim,
    TextSize=12,AutoButtonColor=false,ZIndex=4},mainCard)

-- ========== LISTA TOP 5 ==========
local listFrame = n("Frame",{BackgroundColor3=C.card,Position=UDim2.fromOffset(10,110),
    Size=UDim2.new(1,-20,0,0),BorderSizePixel=0,ClipsDescendants=true,ZIndex=2},win)
cr(listFrame,10); st(listFrame)

local listHolder = n("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,1,0),ZIndex=3},listFrame)
n("UIListLayout",{Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder},listHolder)

-- ========== TOGGLE (posição dinâmica) ==========
local tg = n("Frame",{BackgroundColor3=C.card,Size=UDim2.new(1,-20,0,40),
    BorderSizePixel=0,ZIndex=2},win)
cr(tg,10); st(tg)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(12,7),Size=UDim2.new(1,-70,0,14),
    Font=Ft.b,Text="TELEGUIADO",TextColor3=C.txt,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},tg)
n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(12,22),Size=UDim2.new(1,-70,0,12),
    Font=Ft.r,Text="Roubar ovo mais proximo",TextColor3=C.mute,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=3},tg)

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

-- ========== FILTROS ==========
local filtLbl = n("TextLabel",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,12),
    Font=Ft.b,Text="FILTRO",TextColor3=C.txt,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=2},win)

local tabs = n("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,-20,0,20),ZIndex=2},win)
n("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder},tabs)

local curList, curTab, tbBtns = nil, "Raridade", {}
local function buildList(cat)
    curTab = cat
    if curList then curList:Destroy() end
    curList = n("ScrollingFrame",{BackgroundTransparency=1,
        Size=UDim2.new(1,-20,0,120),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ScrollBarThickness=3,ScrollBarImageColor3=C.line,BorderSizePixel=0,ZIndex=2},win)
    n("UIListLayout",{Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder},curList)
    local list,data = (cat=="Raridade" and RAR) or (cat=="Mutacao" and MUT) or BIO,
                      (cat=="Raridade" and F.rar) or (cat=="Mutacao" and F.mut) or F.bio
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
for i,v in ipairs({"Raridade","Mutacao","Bioma"}) do
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

-- ========== LAYOUT DINÂMICO ==========
local function layout()
    local y = 110
    if Expanded then
        listFrame.Visible = true
        listFrame.Size = UDim2.new(1,-20,0,130)
        y = y + 138
    else
        listFrame.Visible = false
        listFrame.Size = UDim2.new(1,-20,0,0)
    end
    tg.Position = UDim2.fromOffset(10, y)
    y = y + 48
    filtLbl.Position = UDim2.fromOffset(12, y)
    y = y + 16
    tabs.Position = UDim2.fromOffset(10, y)
    y = y + 26
    if curList then curList.Position = UDim2.fromOffset(10, y) end
    win.Size = UDim2.fromOffset(W, Expanded and H_EXPANDED or H_COLLAPSED)
end

arrowBtn.MouseButton1Click:Connect(function()
    Expanded = not Expanded
    arrowBtn.Text = Expanded and "^" or "v"
    layout()
end)

layout()

-- ========== RENDER LISTA TOP 5 ==========
local function renderTop()
    for _, c in ipairs(listHolder:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end

    local eggs = {}
    for _, o in ipairs(workspace:GetDescendants()) do
        if isEgg(o) and ok(o) then
            local i = info(o)
            eggs[#eggs+1] = {obj=o, info=i, dist=(getPart(o) and (getPart(o).Position - hrp.Position).Magnitude) or math.huge}
        end
    end
    table.sort(eggs, function(a,b) return a.info.val > b.info.val end)

    local top = math.min(5, #eggs)
    for idx = 1, top do
        local e = eggs[idx]
        local row = n("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),
            LayoutOrder=idx,ZIndex=3},listHolder)
        n("UIPadding",{PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6)},row)

        n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(0,5),Size=UDim2.fromOffset(14,14),
            Font=Ft.b,Text="#"..idx,TextColor3=(idx==1 and C.gold or C.dim),TextSize=10,
            TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},row)

        local icon = n("ImageLabel",{BackgroundColor3=C.lift,Position=UDim2.fromOffset(18,2),
            Size=UDim2.fromOffset(20,20),Image=getIcon(e.obj),ScaleType=Enum.ScaleType.Fit,
            BorderSizePixel=0,ZIndex=4},row)
        cr(icon,5)

        n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(44,2),Size=UDim2.new(1,-110,0,12),
            Font=Ft.b,Text=e.obj.Name,TextColor3=C.txt,TextSize=10,TextTruncate=Enum.TextTruncate.AtEnd,
            TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},row)

        local sub = e.info.mut and (e.info.mut.." • "..e.info.rar) or e.info.rar
        n("TextLabel",{BackgroundTransparency=1,Position=UDim2.fromOffset(44,13),Size=UDim2.new(1,-110,0,10),
            Font=Ft.m,Text=sub,TextColor3=(e.info.mut and C.purple or C.mute),TextSize=8,
            TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},row)

        n("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,6),Size=UDim2.fromOffset(60,14),
            BackgroundTransparency=1,Font=Ft.b,Text=fmt(e.info.val),TextColor3=C.ok,TextSize=12,
            TextXAlignment=Enum.TextXAlignment.Right,ZIndex=4},row)

        if idx < top then
            n("Frame",{BackgroundColor3=C.line,Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),
                BorderSizePixel=0,ZIndex=3},row)
        end
    end

    if top == 0 then
        n("TextLabel",{BackgroundTransparency=1,Size=UDim2.new(1,0,1,0),Font=Ft.r,
            Text="Nenhum ovo encontrado",TextColor3=C.mute,TextSize=10,ZIndex=4},listHolder)
    end

    -- atualiza card do top 1
    if top > 0 then
        local e = eggs[1]
        mainName.Text = e.obj.Name
        mainMut.Text  = e.info.mut or "sem mutacao"
        mainVal.Text  = fmt(e.info.val)
        mainRar.Text  = e.info.rar
        mainIcon.Image = getIcon(e.obj)
    else
        mainName.Text = "Nenhum ovo"; mainMut.Text="—"; mainVal.Text="?"; mainRar.Text=""
        mainIcon.Image = DEFAULT_EGG
    end
end

-- ========== LOOP ==========
task.spawn(function()
    while task.wait(0.8) do
        if not char or not char.Parent then
            repeat task.wait(.2) until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            char, hrp = LP.Character, LP.Character:FindFirstChild("HumanoidRootPart")
        end
        renderTop()

        if Auto then
            local best, bv = nil, -1
            for _, o in ipairs(workspace:GetDescendants()) do
                if isEgg(o) and ok(o) then
                    local i = info(o)
                    if i.val > bv then best, bv = o, i.val end
                end
            end
            if best then
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
            end
        end
    end
end)