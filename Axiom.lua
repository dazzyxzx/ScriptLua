local e=game:GetService("Players")
local r=game:GetService("Workspace")
local y=game:GetService("RunService")
local u=game:GetService("TweenService")
local w=game:GetService("UserInputService")
local j=game:GetService("ReplicatedStorage")
local k=game:GetService("ProximityPromptService")
local a=game:GetService("HttpService")
local TeleportService=game:GetService("TeleportService")
local o=e.LocalPlayer
local Window=nil
local currentLang="EN"
local executorCheckCaller=typeof(checkcaller)=="function" and checkcaller or function() return false end
local safeNewCClosure=typeof(newcclosure)=="function" and newcclosure or function(fn) return fn end
local V=game:GetService("ProximityPromptService")
pcall(function(...)
    V.PromptButtonHoldBegan:Connect(function(e,...)
        pcall(function(...)
            if typeof(fireproximityprompt)=="function" then
                fireproximityprompt(e)
            end
        end)
    end)
end)
local H=function(...) end
local t=function(...) end
local s=nil
pcall(function(...) s=require((j:WaitForChild("Client",5)):WaitForChild("EggState",5)) end)
if not s then pcall(function(...) s=require(j.Client.EggState) end) end
local p=nil
pcall(function(...) p=require(((j:WaitForChild("Shared",5)):WaitForChild("Util",5)):WaitForChild("AssetItems",5)) end)
if not p then pcall(function(...) p=require(j.Shared.Util.AssetItems) end) end
local B=nil
pcall(function(...) B=require((j:WaitForChild("Shared",5)):WaitForChild("Remotes",5)) end)
if not B then pcall(function(...) B=require(j.Shared.Remotes) end) end
local function J(e,r,...)
    local y=(j:FindFirstChild("Packages")and j.Packages:FindFirstChild("Networking"))or j:FindFirstChild("Network")or j
    local u=y:FindFirstChild(e)or j:FindFirstChild(e)
    if u then return u end
    local w=y:FindFirstChild(e,true)or j:FindFirstChild(e,true)
    if w then return w end
    if r then
        local e=y:FindFirstChild(r)or j:FindFirstChild(r)
        if e then return e end
        local u=y:FindFirstChild(r,true)or j:FindFirstChild(r,true)
        if u then return u end
    end
    local k=string.match(e,"[^/]+$")
    if k then
        local e=y:FindFirstChild(k,true)or j:FindFirstChild(k,true)
        if e then return e end
    end
    return nil
end

local K=J("RF/EggWorld/AskPlaceEgg","AskPlaceEgg")
local c=J("RF/EggWorld/AskLiveSnapshot","AskLiveSnapshot")
local v=J("RF/Homestead/AskState","RF/Plots/AskState")or J("AskState")
local i=J("RF/EggWorld/AskFieldEggCarry","AskFieldEggCarry")
local R=J("RF/EggWorld/AskFieldEggSnapshot","AskFieldEggSnapshot")or J("Eggs: RequestAreaEggSnapshot","RequestAreaEggSnapshot")
local g=J("RF/EggWorld/AskHatch","AskHatch")or J("Eggs: RequestHatchEgg")
local Q=J("RF/EggWorld/AskFinishHatch","AskFinishHatch")or J("Eggs: RequestCompleteHatchEgg")
local P=J("RE/GuardPatrol/ForestStrike","ForestStrike")or(B and(B.GuardPatrol and B.GuardPatrol.ForestStrike))
local N=J("SpeedTollOffer","RE/GuardPatrol/SpeedTollOffer")or(B and(B.GuardPatrol and B.GuardPatrol.SpeedTollOffer))
local U=J("RF/Treadmill/AskDoff","AskDoff")
local l=J("RF/Treadmill/AskDon","AskDon")or J("RF/Treadmill/AskMount","AskMount")
local D=J("RF/Treadmill/AskTierRaise","Treadmills: RequestUpgrade","AskTierRaise")
local C=J("RF/Trailwear/AskPurchase","Trailwear: RequestPurchase","AskPurchase")
local q=J("RF/Trailwear/AskChoose","Trailwear: RequestEquip","AskChoose")
local n=J("RF/Trailwear/AskDoff","Trailwear: RequestUnequip","AskDoff")
H(string.format("[RemoteCheck] Carry: %s | Snapshot: %s | Place: %s | Hatch: %s | FinishHatch: %s | Strike: %s | Toll: %s | Doff: %s",tostring(i~=nil),tostring(R~=nil),tostring(K~=nil),tostring(g~=nil),tostring(Q~=nil),tostring(P~=nil),tostring(N~=nil),tostring(U~=nil)))

local f={["Light Dark"]=1300,["LightDark"]=1300;["Titan Temple"]=1100,["Cherry Blossom"]=1000,["Cosmic"]=900;["Prehistoric"]=800;["Abyss Ocean"]=700,["Volcano"]=600;["Snow"]=500,["Jungle"]=400;["Desert"]=300,["Lake"]=200;["Forest"]=100}
local M={"Light Dark";"Titan Temple";"Cherry Blossom","Cosmic";"Prehistoric","Abyss Ocean";"Volcano";"Snow","Jungle","Desert","Lake";"Forest"}
local I={["Light Dark"]=420,["LightDark"]=420;["Titan Temple"]=380,["Cherry Blossom"]=330,["Cosmic"]=280;["Prehistoric"]=240,["Abyss Ocean"]=200;["Volcano"]=180;["Snow"]=160,["Jungle"]=140;["Desert"]=130,["Lake"]=125,["Forest"]=125}
local L=-360
local E=525
local b=620
local A=130
local S=CFrame.new(4773.7587890625,70.392112731934,-315.73501586914)

local Z="AxiomHub_FlightSpeed.txt"
local z="AxiomHub_EggSelectConfig.json"
local d={["Light Dark"]=Color3.fromRGB(168,85,247),["Titan Temple"]=Color3.fromRGB(245,158,11);["Cherry Blossom"]=Color3.fromRGB(236,72,153);["Cosmic"]=Color3.fromRGB(6,182,212),["Prehistoric"]=Color3.fromRGB(16,185,129),["Abyss Ocean"]=Color3.fromRGB(59,130,246);["Volcano"]=Color3.fromRGB(239,68,68),["Snow"]=Color3.fromRGB(147,197,253),["Jungle"]=Color3.fromRGB(34,197,94),["Desert"]=Color3.fromRGB(234,179,8),["Lake"]=Color3.fromRGB(20,184,166),["Forest"]=Color3.fromRGB(22,163,74)}

local X={"Divine","Eternal","Secret";"Cosmic","Mythic","Legendary";"Epic";"Rare";"Uncommon";"Common"}
local G={["Divine"]=Color3.fromRGB(244,63,94);["Eternal"]=Color3.fromRGB(217,70,239),["Secret"]=Color3.fromRGB(249,115,22),["Cosmic"]=Color3.fromRGB(6,182,212),["Mythic"]=Color3.fromRGB(139,92,246),["Legendary"]=Color3.fromRGB(251,191,36);["Epic"]=Color3.fromRGB(168,85,247);["Rare"]=Color3.fromRGB(59,130,246);["Uncommon"]=Color3.fromRGB(34,197,94),["Common"]=Color3.fromRGB(148,163,184)}
local F={["Divine"]=6;["Eternal"]=5;["Secret"]=4,["Cosmic"]=3;["Mythic"]=2;["Legendary"]=1,["Epic"]=0.5,["Rare"]=0.3,["Uncommon"]=0.1;["Common"]=0}
local h
local function O(...)
    local e=600
    pcall(function(...)
        local r=false
        if isfile then r=isfile(Z)
        elseif readfile then
            local e,y=pcall(readfile,Z)
            r=e and(y~=nil)
        end
        if r and readfile then
            local r=readfile(Z)
            local u=tonumber(r)
            if u and(u>=100 and u<=1000)then e=math.floor(u) end
        end
    end)
    return e
end
local function Y(e,...)
    pcall(function(...)
        if writefile then
            local y=math.clamp(math.floor(tonumber(e)or 600),100,1000)
            writefile(Z,tostring(y))
        end
    end)
end
local function T(...)
    local e=nil
    pcall(function(...)
        local r=false
        if isfile then r=isfile(z)
        elseif readfile then
            local e,y=pcall(readfile,z)
            r=e and(y~=nil)
        end
        if r and(readfile and a)then
            local r=readfile(z)
            if r and r~="" then
                local u=a:JSONDecode(r)
                if type(u)=="table" then e=u end
            end
        end
    end)
    local r={["Light Dark"]=true,["Titan Temple"]=true,["Cherry Blossom"]=true;["Cosmic"]=false;["Prehistoric"]=false,["Abyss Ocean"]=false;["Volcano"]=false,["Snow"]=false;["Jungle"]=false,["Desert"]=false;["Lake"]=false,["Forest"]=false}
    local y={["Divine"]=true,["Eternal"]=true,["Secret"]=true,["Cosmic"]=true,["Mythic"]=true;["Legendary"]=false,["Epic"]=false,["Rare"]=false;["Uncommon"]=false;["Common"]=false}
    if type(e)~="table" then
        e={["selectedZones"]=r;["selectedRarities"]=y,["alwaysCollectSecretPlus"]=true,["minRarityTier"]=2;["autoTreadmill"]=true;["autoUpgradeTreadmill"]=true,["autoBuyTrails"]=true;["hideNotEnoughMoney"]=true;["performanceMode"]=false,["disable3D"]=false,["antiAFK"]=true,["language"]="EN"}
    else
        if type(e.selectedZones)~="table" then e.selectedZones=r end
        if type(e.selectedRarities)~="table" then
            e.selectedRarities=y
        else
            for r,w in ipairs(X)do
                if e.selectedRarities[w]==nil then e.selectedRarities[w]=(y[w]==true) end
            end
        end
        if e.alwaysCollectSecretPlus==nil then e.alwaysCollectSecretPlus=true end
        if e.minRarityTier==nil then e.minRarityTier=2 end
        if e.autoTreadmill==nil then e.autoTreadmill=true end
        if e.autoUpgradeTreadmill==nil then e.autoUpgradeTreadmill=true end
        if e.autoBuyTrails==nil then e.autoBuyTrails=true end
        if e.hideNotEnoughMoney==nil then e.hideNotEnoughMoney=true end
        if e.performanceMode==nil then e.performanceMode=false end
        if e.disable3D==nil then e.disable3D=false end
        if e.antiAFK==nil then e.antiAFK=true end
        if e.language and((e.language=="EN" or e.language=="TH"))then currentLang=e.language end
    end
    return e
end
local function x(...)
    pcall(function(...)
        if writefile and(a and h)then
            local r={["selectedZones"]=h.selectedZones or{};["selectedRarities"]=h.selectedRarities or{};["alwaysCollectSecretPlus"]=(h.alwaysCollectSecretPlus~=false),["minRarityTier"]=h.minRarityTier or 2,["autoTreadmill"]=(h.autoTreadmill==true);["autoUpgradeTreadmill"]=(h.autoUpgradeTreadmill==true),["autoBuyTrails"]=(h.autoBuyTrails==true);["hideNotEnoughMoney"]=(h.hideNotEnoughMoney==true);["performanceMode"]=(h.performanceMode==true);["disable3D"]=(h.disable3D==true);["antiAFK"]=(h.antiAFK==true);["language"]=currentLang or "EN"}
            local y=a:JSONEncode(r)
            writefile(z,y)
        end
    end)
end
local W=T()
h={["godmode"]=true,["autoGlide"]=true,["autoHatch"]=true;["autoPlaceEvery5"]=false;["batchStealCount"]=0,["isBatchPlacing"]=false,["isHatching"]=false;["autoFarmLoop"]=false,["pureTweenFarm"]=false;["glidingToTarget"]=false;["securingEgg"]=false,["glideSpeed"]=O();["selectedZones"]=W.selectedZones;["selectedRarities"]=W.selectedRarities;["alwaysCollectSecretPlus"]=W.alwaysCollectSecretPlus,["minRarityTier"]=W.minRarityTier,["autoTreadmill"]=(W.autoTreadmill~=false);["autoUpgradeTreadmill"]=(W.autoUpgradeTreadmill~=false),["autoBuyTrails"]=(W.autoBuyTrails~=false),["hideNotEnoughMoney"]=true;["performanceMode"]=(W.performanceMode==true),["disable3D"]=(W.disable3D==true),["antiAFK"]=(W.antiAFK~=false),["onTreadmill"]=false,["lastTreadmillMount"]=0,["laneZ"]=-360,["swapped"]=false;["teleporting"]=false,["isReturning"]=false;["delivering"]=false,["holdingEggForGuard"]=false,["currentTargetModel"]=nil,["targetPosition"]=nil;["stateTime"]=os.clock(),["statusText"]="Ready",["bestEggInfo"]="Scanning...";["gui"]=nil;["alive"]=true,["plot"]=nil;["pen"]=nil,["origin"]=nil;["tread"]=nil}
local m
local e4
local r4
local y4
local u4
local w4
local j4
local k4
local a4
local o4
local V4
local H4
local t4
local s4
local p4
local B4
local J4
local K4
local c4
local v4
local i4
local R4
local g4
local Q4
local P4
local N4
local U4
local l4
local D4
local C4
local q4
local n4
local f4
local M4
local I4
local L4
local E4
local b4
local A4
local S4
local Z4
local z4
local d4
local X4={}
local G4=0
local F4=nil
local h4
local O4=0
local Y4="NONE"
local T4
local x4=nil
local W4=nil
pcall(function(...)
    local e=game:GetService("Lighting");
    (e:GetPropertyChangedSignal("ClockTime")):Connect(function(...) X4={}G4=0 end)
end)
pcall(function(...)
    local function e(e,...)
        if e:IsA("RemoteEvent")then
            local y=string.lower(e.Name)
            if string.find(y,"reset")or string.find(y,"night")or string.find(y,"spawn")or string.find(y,"countdown")then
                pcall(function(...) e.OnClientEvent:Connect(function(...) X4={}G4=0 end) end)
            end
        end
    end
    for y,u in ipairs(j:GetDescendants())do e(u)end
    j.DescendantAdded:Connect(e)
end)
m=function(e,...)
    if not e or not e:IsA("Tool")then return false end
    local r=string.lower(e.Name)
    if string.find(r,"sword")or string.find(r,"radar")or string.find(r,"basket")or string.find(r,"punch")then return false end
    if e:GetAttribute("EggUid")or e:GetAttribute("UID")or string.find(r,"egg")or e:GetAttribute("Category")or e:GetAttribute("ItemType")=="Egg"then return true end
    return false
end
e4=function(...)
    local e=o.Character
    if e then
        for e,y in ipairs(e:GetChildren())do
            if m(y)then
                local e=y:GetAttribute("UID")or y:GetAttribute("EggUid")
                return y,e or y.Name
            end
        end
    end
    return nil,nil
end
r4=function(...)
    local e=o:FindFirstChild("Backpack")
    if e then
        for e,y in ipairs(e:GetChildren())do
            if m(y)then
                local e=y:GetAttribute("UID")or y:GetAttribute("EggUid")
                return y,e or y.Name
            end
        end
    end
    return nil,nil
end
y4=function(...)
    local e=0
    local r=o:FindFirstChild("Backpack")
    if r then
        for r,y in ipairs(r:GetChildren())do
            if m(y)then e=e+1 end
        end
    end
    local y=o.Character
    if y then
        for r,y in ipairs(y:GetChildren())do
            if m(y)then e=e+1 end
        end
    end
    return e
end
u4=function(e,...)
    if not e and not((h.pureTweenFarm or h.autoFarmLoop or h.teleporting))then return end
    local r=o.Character
    local y=r and r:FindFirstChildOfClass("Humanoid")
    local u=o:FindFirstChild("Backpack")
    if y then pcall(function(...) y:UnequipTools() end) end
    if r and u then
        for e,r in ipairs(r:GetChildren())do
            if r:IsA("Tool")then pcall(function(...) r.Parent=u end) end
        end
    end
end
w4=function(e,...)
    if((h.pureTweenFarm or h.autoFarmLoop))and not h.holdingEggForGuard then
        local e=e4()
        if e then
            pcall(u4)
            return false
        end
    end
    local r,y=e4()
    if r then
        if e then
            if y==e or not y then return true end
        else
            return true
        end
    end
    local u=o.Character
    local w=u and u:FindFirstChild("HumanoidRootPart")
    if w and w.Position.X<=(E+15)then return false end
    if s and s.ReadFieldEggs then
        local r,y=pcall(s.ReadFieldEggs)
        if r and(y and y.Records)then
            for r,y in ipairs(y.Records)do
                if((y.State=="Carried" or y.State==2))and((y.CarrierUserId==o.UserId or y.Carrier==o.UserId))then
                    if e then
                        if y.Uid==e then return true end
                    else
                        return true
                    end
                end
            end
        end
    end
    return false
end
j4=function(e,...)
    local r,y=e4()
    if r then
        if not e or y==e or not y then return true end
    end
    local u=o:FindFirstChild("Backpack")
    if u then
        for r,y in ipairs(u:GetChildren())do
            if m(y)then
                local r=y:GetAttribute("UID")or y:GetAttribute("EggUid")
                if not e or r==e or y.Name==tostring(e)then return true end
            end
        end
    end
    if e and(s and s.ReadFieldEggs)then
        local r,y=pcall(s.ReadFieldEggs)
        if r and(y and y.Records)then
            for r,y in ipairs(y.Records)do
                if y.Uid==e then
                    if(y.State=="Carried" or y.State==2)then
                        local e=y.CarrierUserId or y.Carrier
                        if e==o.UserId then return true end
                    end
                end
            end
        end
    end
    return false
end
local m4=false
local function ek(...)
    if m4 then return end
    local e=R or j:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot",true)or j:FindFirstChild("AskFieldEggSnapshot",true)or j:FindFirstChild("Eggs: RequestAreaEggSnapshot",true)
    if not e or not e:IsA("RemoteFunction")then return end
    m4=true
    task.spawn(function(...)
        local r,y=pcall(function(...) return e:InvokeServer() end)
        if r and type(y)=="table"then
            local e={}
            local r=y.Records or y
            if type(r)=="table"then
                for r,y in pairs(r)do
                    if type(y)=="table"then
                        if not y.Uid and type(r)=="string"then y.Uid=r end
                        table.insert(e,y)
                    end
                end
            end
            if#e>0 then
                F4=e
                G4=os.clock()
            end
        end
        m4=false
    end)
end
task.spawn(function(...)
    while true do
        task.wait(1.5)
        pcall(ek)
    end
end)
function h4(e,...)
    local y=os.clock()
    if e or(y-G4>=1.5)or not F4 then ek() end
    local u=((F4 and#F4>0))and F4 or nil
    local w=nil
    if s and s.ReadFieldEggs then
        local e,r=pcall(s.ReadFieldEggs)
        if e and type(r)=="table"then
            local e={}
            local y=r.Records or r
            if type(y)=="table"then
                for r,y in pairs(y)do
                    if type(y)=="table"then
                        if not y.Uid and type(r)=="string"then y.Uid=r end
                        table.insert(e,y)
                    end
                end
            end
            if#e>0 then w=e end
        end
    end
    local j={}
    local k={}
    if u then
        for e,r in ipairs(u)do
            if r.Uid then
                k[r.Uid]=true
                table.insert(j,r)
            end
        end
    end
    if w then
        for e,r in ipairs(w)do
            if r.Uid and not k[r.Uid]then
                k[r.Uid]=true
                table.insert(j,r)
            end
        end
    end
    local a=r:FindFirstChild("AreaEggSlotsClient")
    if a then
        for e,r in ipairs(a:GetChildren())do
            local y=r.Name
            if y and y~=""then
                local e=r:GetPivot()
                local u=e.Position
                if u.X>=530 and not string.find(tostring(y),"FirstArea")then
                    if not k[y]then
                        k[y]=true
                        local u=r:GetAttribute("Category")or r:GetAttribute("AssetCategory")or r.Name
                        local w=r:GetAttribute("AreaId")or r:GetAttribute("Area")
                        local a=r:GetAttribute("Rarity")or r:GetAttribute("RarityTier")
                        local V=r:GetAttribute("RarityRank")or r:GetAttribute("Rank")
                        local H=r:GetAttribute("Income")or r:GetAttribute("EarningRate")
                        local t=r:GetAttribute("Scale")or r:GetAttribute("AssetScale")or 1
                        local s=r:GetAttribute("Mutations")or r:GetAttribute("Mutation")
                        table.insert(j,{["Uid"]=y,["AssetCategory"]=u,["AreaId"]=w;["Rarity"]=a,["Rank"]=V,["Income"]=H,["BoundsCFrame"]=e;["BottomCFrame"]=e,["CFrame"]=e;["State"]="Slot";["AssetScale"]=t,["Mutations"]=s,["PhysicalModel"]=r})
                    else
                        for u,w in ipairs(j)do
                            if w.Uid==y then
                                w.PhysicalModel=r
                                if not w.BoundsCFrame then w.BoundsCFrame=e end
                                if not w.AreaId or w.AreaId=="" or w.AreaId=="Unknown"then
                                    w.AreaId=r:GetAttribute("AreaId")or r:GetAttribute("Area")
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    return j
end
k4=function(e,...)
    if not e then return false,"NoUid" end
    local y=h4(false)
    if y and#y>0 then
        for r,y in ipairs(y)do
            if y.Uid==e then
                if(y.State=="Carried" or y.State==2)then
                    local e=y.CarrierUserId or y.Carrier
                    if e and e==o.UserId then return true,"CarriedBySelf"
                    else return false,"CarriedByOther" end
                end
                if(y.State=="Slot" or y.State=="Dropped" or y.State=="GuardCarried" or y.State==1)then return true,"Available" end
                local e=y.CarrierUserId or y.Carrier
                if e then
                    if e==o.UserId then return true,"CarriedBySelf"
                    else return false,"CarriedByOther" end
                end
                return true,"Available"
            end
        end
    end
    local u=r:FindFirstChild("AreaEggSlotsClient")
    if u then
        for r,y in ipairs(u:GetChildren())do
            if y.Name==tostring(e)or y:GetAttribute("UID")==e or y:GetAttribute("Uid")==e then return true,"Available" end
        end
    end
    return true,"Unchecked"
end
a4=function(...)
    local e,r=e4()
    if not r then
        local e,y=r4()
        r=y
    end
    if not r then return false end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs)
        if e and(u and u.Records)then
            for e,u in ipairs(u.Records)do
                if u.Uid==r then
                    local e=tostring(u.AreaId or"")
                    if e=="Lake"or string.find(string.lower(e),"lake")~=nil then return true end
                end
            end
        end
    end
    if string.find(string.lower(tostring(r)),"lake")~=nil then return true end
    return false
end
o4=function(...)
    local e,r=e4()
    if not r then
        local e,y=r4()
        r=y
    end
    if not r then return h.glideSpeed or 350 end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs)
        if e and(u and u.Records)then
            for e,u in ipairs(u.Records)do
                if u.Uid==r and u.AreaId then return I[u.AreaId]or h.glideSpeed or 350 end
            end
        end
    end
    return h.glideSpeed or 350
end
V4=function(e,y,...)
    y=y or 8
    local u=Instance.new("Part")
    u.Name="SafetyFloorPad_AntiVoid"
    u.Size=Vector3.new(28,1.5,28)
    u.Position=e-Vector3.new(0,3.2,0)
    u.Anchored=true
    u.Transparency=1
    u.CanCollide=true
    u.Parent=r
    task.delay(y,function(...)
        pcall(function(...) u:Destroy() end)
    end)
    return u
end
H4=function(e,...)
    if P and e then
        pcall(function(...)
            local r=o.Character
            local y=r and r:FindFirstChild("HumanoidRootPart")
            local u=y and(y.CFrame*CFrame.new(0,0,-3))or CFrame.new()
            if P:IsA("RemoteFunction")then
                P:InvokeServer({["EggUid"]=e,["GuardCFrame"]=u})
            else
                P:FireServer({["EggUid"]=e;["GuardCFrame"]=u})
            end
        end)
    end
end
if typeof(hookmetamethod)=="function"and not _G._DesyncAntiRagdollHooked then
    _G._DesyncAntiRagdollHooked=true
    local e
    e=hookmetamethod(game,"__newindex",safeNewCClosure(function(r,y,u,...)
        if not executorCheckCaller()and typeof(r)=="Instance"then
            if r:IsA("Motor6D")and(y=="Enabled"and u==false)then return nil end
            if r:IsA("Humanoid")then
                if y=="PlatformStand"and u==true then return nil end
                if y=="Sit"and(u==true and((h.pureTweenFarm or h.autoFarmLoop or h.isReturning or h.glidingToTarget)))then return nil end
            end
        end
        return e(r,y,u)
    end))
end
S4=function(e,...)
    e=e or o.Character
    if not e then return end
    local r=e:FindFirstChild("HumanoidRootPart")
    local y=e:FindFirstChild("Torso")or e:FindFirstChild("UpperTorso")or r
    if not y then return end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA("BallSocketConstraint")or r:IsA("HingeConstraint")or r:IsA("NoCollisionConstraint")then
            pcall(function(...) r:Destroy() end)
        end
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA("Motor6D")and(r.Part0 and r.Part1)then
            r.Enabled=true
            local e="RigidJointWeld_"..r.Name
            local y=r.Part1:FindFirstChild(e)
            if not y then
                local y=Instance.new("WeldConstraint")
                y.Name=e
                y.Part0=r.Part0
                y.Part1=r.Part1
                y.Parent=r.Part1
            end
        end
    end
end
Z4=function(e,...)
    if h and h.onTreadmill then return end
    e=e or o.Character
    if not e then return end
    local r=e:FindFirstChildOfClass("Humanoid")
    if r then
        r:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        r:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        r:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        r:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        r:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        if r.PlatformStand then r.PlatformStand=false end
        if r.Sit then r.Sit=false end
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA("LocalScript")and((string.find(string.lower(r.Name),"ragdoll")or string.find(string.lower(r.Name),"fall")))then
            r.Disabled=true
        end
    end
    S4(e)
end
z4=function(e,...)
    if not e then return end
    Z4(e)
    for e,y in ipairs(e:GetDescendants())do
        if y:IsA("Motor6D")then
            (y:GetPropertyChangedSignal("Enabled")):Connect(function(...)
                if not y.Enabled then y.Enabled=true end
            end)
        end
    end
    e.DescendantAdded:Connect(function(y,...)
        if y:IsA("BallSocketConstraint")or y:IsA("HingeConstraint")or y:IsA("NoCollisionConstraint")then
            task.defer(function(...)
                pcall(function(...) y:Destroy() end)
                Z4(e)
            end)
        elseif y:IsA("LocalScript")and((string.find(string.lower(y.Name),"ragdoll")or string.find(string.lower(y.Name),"fall")))then
            y.Disabled=true
        end
    end)
    e.ChildAdded:Connect(function(e,...)
        if e:IsA("Tool")and(((h.pureTweenFarm or h.autoFarmLoop))and not h.holdingEggForGuard)then
            task.defer(function(...) u4() end)
        end
    end)
end
C4=function(...)
    if h then h.onTreadmill=false end
    local e=o.Character
    local r=e and e:FindFirstChildOfClass("Humanoid")
    local y=e and e:FindFirstChild("HumanoidRootPart")
    if U then
        task.spawn(function(...) pcall(function(...) U:InvokeServer() end) end)
    end
    if r then
        pcall(function(...)
            for r,y in ipairs(r:GetPlayingAnimationTracks())do
                local u=y.Animation
                local w=u and u.AnimationId or""
                if string.find(w,"10921259953")or string.find(string.lower(y.Name),"treadmill")or string.find(string.lower(y.Name),"run")then
                    y:Stop(0)
                end
            end
            r.PlatformStand=false
            r.Sit=false
            r:SetStateEnabled(Enum.HumanoidStateType.Running,true)
            r:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
            r:ChangeState(Enum.HumanoidStateType.Running)
        end)
    end
    local u=o:FindFirstChild("PlayerGui")
    if u then
        local e=u:FindFirstChild("SpeedGainAnimation")
        if e then pcall(function(...) e:Destroy() end) end
    end
    if y then
        y.AssemblyLinearVelocity=Vector3.zero
        y.AssemblyAngularVelocity=Vector3.zero
    end
    Z4(e)
end
local rk=0
local yk=false
E4=function(...)
    local e=o:FindFirstChild("PlayerGui")
    if not e then return false end
    local r=false
    pcall(function(...)
        for e,u in ipairs(e:GetChildren())do
            if u:IsA("ScreenGui")and u.Enabled then
                for e,u in ipairs(u:GetDescendants())do
                    if((u:IsA("TextButton")or u:IsA("ImageButton")))and u.Visible then
                        local e=(u:IsA("TextButton")and u.Text)or u.Name
                        local w=string.lower(e or"")
                        if string.find(w,"get out")or string.find(w,"treadmill")or string.find(w,"doff")or string.find(w,"leave")or string.find(w,"exit")then
                            if typeof(firesignal)=="function"and u.Activated then
                                pcall(firesignal,u.Activated)
                            elseif typeof(firesignal)=="function"and u.MouseButton1Click then
                                pcall(firesignal,u.MouseButton1Click)
                            elseif typeof(getconnections)=="function"then
                                local e=getconnections(u.MouseButton1Click)or getconnections(u.Activated)or{}
                                for e,r in ipairs(e)do
                                    pcall(function(...) r:Fire() end)
                                    break
                                end
                            end
                            r=true
                            break
                        end
                    end
                end
                if r then break end
            end
        end
    end)
    return r
end
L4=function(...)
    local e=o.Character
    local r=e and e:FindFirstChild("HumanoidRootPart")
    if not r then return false end
    local y=(typeof(I4)=="function")and I4()or nil
    if y then
        local e=y.Position+Vector3.new(0,1.8,0)
        local u=((r.Position-e)).Magnitude
        if u>6 then
            if h then h.onTreadmill=false end
            return false
        end
    else
        if r.Position.X>535 then
            if h then h.onTreadmill=false end
            return false
        end
    end
    if h and h.onTreadmill then return true end
    local u=e and e:FindFirstChildOfClass("Humanoid")
    if u then
        for e,r in ipairs(u:GetPlayingAnimationTracks())do
            local y=r.Animation
            local u=y and y.AnimationId or""
            local w=string.lower(r.Name or"")
            if string.find(u,"10921259953")or string.find(w,"treadmill")or string.find(w,"run")then return true end
        end
    end
    local w=o:FindFirstChild("PlayerGui")
    if w and w:FindFirstChild("SpeedGainAnimation")then return true end
    return false
end
M4=function(...)
    if yk then return end
    if os.clock()-rk<0.8 then
        if h then h.onTreadmill=false end
        return
    end
    yk=true
    rk=os.clock()
    if h then h.onTreadmill=false end
    E4()
    if U then pcall(function(...) U:InvokeServer() end) end
    local e=o.Character
    local r=e and e:FindFirstChildOfClass("Humanoid")
    local y=e and e:FindFirstChild("HumanoidRootPart")
    if r then
        pcall(function(...)
            for r,y in ipairs(r:GetPlayingAnimationTracks())do
                local u=y.Animation
                local w=u and u.AnimationId or""
                local j=string.lower(y.Name or"")
                if string.find(w,"10921259953")or string.find(j,"treadmill")or string.find(j,"run")then
                    y:Stop(0)
                end
            end
            r.PlatformStand=false
            r.Sit=false
            r:SetStateEnabled(Enum.HumanoidStateType.Running,true)
            r:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
            r:ChangeState(Enum.HumanoidStateType.Running)
        end)
    end
    local u=o:FindFirstChild("PlayerGui")
    if u then
        local e=u:FindFirstChild("SpeedGainAnimation")
        if e then pcall(function(...) e:Destroy() end) end
    end
    if y then
        y.AssemblyLinearVelocity=Vector3.zero
        y.AssemblyAngularVelocity=Vector3.zero
    end
    Z4(e)
    task.wait(0.15)
    yk=false
end
q4=M4
n4=function(...)
    pcall(function(...)
        local e=r:FindFirstChild("Plots")
        if e then
            local r=h and h.plot
            if not r and t4 then r=select(1,t4()) end
            for e,u in ipairs(e:GetChildren())do
                local w=(r~=nil and u==r)
                local j=u:FindFirstChild("TreadmillBottom")
                if j and j:IsA("BasePart")then
                    if w and(h and h.autoTreadmill)then
                        j.CanTouch=true
                        j.CanCollide=true
                    else
                        j.CanTouch=false
                        j.CanCollide=false
                    end
                end
                local k=u:FindFirstChild("TreadmillUpgrade")
                if k then
                    for e,r in ipairs(k:GetDescendants())do
                        if r:IsA("BasePart")then
                            if w and(h and h.autoTreadmill)then
                                r.CanTouch=true
                            else
                                r.CanTouch=false
                                r.CanCollide=false
                            end
                        end
                    end
                end
            end
        end
    end)
end
n4()
r.DescendantAdded:Connect(function(e,...)
    pcall(function(...)
        local r=(e.Name=="TreadmillBottom"and e:IsA("BasePart"))
        local y=(e.Name=="TreadmillUpgrade"and e:IsA("Model"))
        if r or y then
            local y=h and h.plot
            if not y and t4 then y=select(1,t4()) end
            local w=y and e:IsDescendantOf(y)
            if w and(h and h.autoTreadmill)then
                if r then
                    e.CanTouch=true
                    e.CanCollide=true
                else
                    for e,r in ipairs(e:GetDescendants())do
                        if r:IsA("BasePart")then r.CanTouch=true end
                    end
                end
            else
                if r then
                    e.CanTouch=false
                    e.CanCollide=false
                else
                    for e,r in ipairs(e:GetDescendants())do
                        if r:IsA("BasePart")then
                            r.CanTouch=false
                            r.CanCollide=false
                        end
                    end
                end
            end
        end
    end)
end)
D4=function(...)
    h.onTreadmill=false
    h.teleporting=false
    h.glidingToTarget=false
    h.securingEgg=false
    h.isReturning=false
    h.delivering=false
    h.holdingEggForGuard=false
    h.currentTargetModel=nil
    h.targetPosition=nil
    h.stateTime=os.clock()
    local e=o.Character
    local r=e and e:FindFirstChild("HumanoidRootPart")
    if r then
        pcall(function(...)
            r.Anchored=false
            r.AssemblyLinearVelocity=Vector3.zero
            r.AssemblyAngularVelocity=Vector3.zero
        end)
    end
    pcall(function(...) if C4 then C4() end end)
    pcall(function(...) if Z4 and e then Z4(e) end end)
    pcall(function(...)
        if u4 and((h.pureTweenFarm or h.autoFarmLoop))then u4() end
    end)
end
d4=function(e,y,...)
    if e then
        for e,r in ipairs(e:GetDescendants())do
            if r:IsA("ProximityPrompt")then
                pcall(function(...)
                    r.RequiresLineOfSight=false
                    r.HoldDuration=0
                    if typeof(fireproximityprompt)=="function"then
                        fireproximityprompt(r,0)
                        fireproximityprompt(r)
                    end
                end)
            end
        end
    end
    local u=r:FindFirstChild("AreaEggSlotsClient")
    if u and y then
        for e,r in ipairs(u:GetChildren())do
            local u=r:FindFirstChildWhichIsA("BasePart")or r.PrimaryPart
            if u and((u.Position-y)).Magnitude<=18 then
                for e,r in ipairs(r:GetDescendants())do
                    if r:IsA("ProximityPrompt")then
                        pcall(function(...)
                            r.RequiresLineOfSight=false
                            r.HoldDuration=0
                            if typeof(fireproximityprompt)=="function"then
                                fireproximityprompt(r,0)
                                fireproximityprompt(r)
                            end
                        end)
                    end
                end
            end
        end
    end
end
b4=function(e,...)
    h.godmode=e
    local r=o.Character
    if not r then return end
    local y=r:FindFirstChildOfClass("Humanoid")
    if y then
        y:SetStateEnabled(Enum.HumanoidStateType.Dead,not e)
        if e and y.Health<100 then y.Health=100 end
    end
    for r,y in ipairs(r:GetDescendants())do
        if y:IsA("BasePart")then
            if e then
                y.CanTouch=false
                y.CanCollide=false
            end
        end
    end
    Z4(r)
end
local function enableDesyncGodmode() b4(true) end
local function disableDesyncGodmode() b4(false) end
A4=function(...)
    local e=o.Character
    local y=e and e:FindFirstChildOfClass("Humanoid")
    if not e or not y then return false end
    pcall(function(...)
        y.BreakJointsOnDeath=false
        local w=y:Clone()
        w.Parent=e
        y:Destroy()
        local j=w:FindFirstChildOfClass("Animator")
        if not j then
            j=Instance.new("Animator")
            j.Parent=w
        end
        r.CurrentCamera.CameraSubject=w
        local k=e:FindFirstChild("Animate")
        if k and k:IsA("LocalScript")then
            k.Disabled=true
            task.defer(function(...)
                task.wait(0.05)
                k.Disabled=false
            end)
        end
        w:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        w:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        w:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        w:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        w.JumpPower=math.max(50,w.JumpPower)
        w.JumpHeight=math.max(7.2,w.JumpHeight)
        w:ChangeState(Enum.HumanoidStateType.Running)
    end)
    h.swapped=true
    if h.godmode then b4(true) end
    z4(e)
    return true
end
t4=function(...)
    if h.plot and(h.plot.Parent and(h.pen and(h.origin and h.plotVerified)))then
        return h.plot,h.pen,h.origin
    end
    local e=r:FindFirstChild("Plots")
    if not e then return nil,nil,nil end
    local y=o.UserId
    local u=o.Name
    local w=o.DisplayName
    local j=nil
    local k=false
    if v then
        local r,w=pcall(function(...) return v:InvokeServer() end)
        if r and(type(w)=="table"and type(w.OwnersBySlot)=="table")then
            for r,w in pairs(w.OwnersBySlot)do
                if w==y or tostring(w)==tostring(y)or w==u then
                    j=e:FindFirstChild(tostring(r))
                    if j then
                        k=true
                        break
                    end
                end
            end
        end
    end
    if not j and c then
        local r,u=pcall(function(...) return c:InvokeServer() end)
        if r and type(u)=="table"then
            for r,u in pairs(u)do
                if type(u)=="table"and((u.OwnerUserId==y or tostring(u.OwnerUserId)==tostring(y)))then
                    local y=u.Slot or r
                    j=e:FindFirstChild(tostring(y))or e:FindFirstChild(tostring(r))
                    if j then
                        k=true
                        break
                    end
                end
            end
        end
    end
    if not j then
        for e,r in ipairs(e:GetChildren())do
            local a=r:GetAttribute("Owner")or r:GetAttribute("OwnerUserId")or r:GetAttribute("UserId")or r:GetAttribute("OwnerId")or r:GetAttribute("Player")
            if a and((a==y or tostring(a)==tostring(y)or a==u or tostring(a)==u or a==w))then
                j=r
                k=true
                break
            end
            for e,a in ipairs({"Owner","OwnerUserId","OwnerId";"UserId";"Player";"PlayerName"})do
                local o=r:FindFirstChild(a)
                if o and((o.Value==y or tostring(o.Value)==tostring(y)or o.Value==u or o.Value==w))then
                    j=r
                    k=true
                    break
                end
            end
            if j then break end
        end
    end
    if not j then
        for e,r in ipairs(e:GetChildren())do
            for e,y in ipairs(r:GetDescendants())do
                if y:IsA("TextLabel")and y.Text~=""then
                    local e=string.lower(y.Text)
                    if string.find(e,string.lower(u),1,true)or(w and string.find(e,string.lower(w),1,true))then
                        j=r
                        k=true
                        break
                    end
                end
            end
            if j then break end
        end
    end
    if not j then
        local r=o.Character
        local y=r and r:FindFirstChild("HumanoidRootPart")
        if y and y.Position.X<=(E+30)then
            local r=nil
            local u=999999
            for e,w in ipairs(e:GetChildren())do
                local j=w:FindFirstChild("CenterPoint")or w.PrimaryPart or w:FindFirstChildWhichIsA("BasePart")
                if j then
                    local e=((y.Position-j.Position)).Magnitude
                    if e<u then
                        u=e
                        r=w
                    end
                end
            end
            if r and u<160 then j=r end
        end
    end
    if not j then j=e:FindFirstChild("2")or e:FindFirstChild("1")or(e:GetChildren())[1] end
    if not j then return nil,nil,nil end
    h.plot=j
    h.plotVerified=k
    h.origin=j:FindFirstChild("CenterPoint")
    local a=j:FindFirstChild("ToUpdate")
    h.pen=(a and a:FindFirstChild("PetArea"))or j:FindFirstChild("PetArea")
    h.tread=j:FindFirstChild("TreadmillBottom")
    if not h.pen and a then
        for e,r in ipairs(a:GetChildren())do
            if r:IsA("BasePart")and string.find(string.lower(r.Name),"pet")then
                h.pen=r
                break
            end
        end
    end
    if not h.origin then h.origin=j:FindFirstChild("CenterPoint")or h.pen or j.PrimaryPart end
    if not h.pen then h.pen=h.origin end
    return h.plot,h.pen,h.origin
end
s4=function(...)
    local e,r,y=t4()
    if r then return r.Position+Vector3.new(0,3.5,0) end
    if y then return y.Position+Vector3.new(0,3.5,0) end
    return Vector3.new(464.7,71.7,-304)
end
p4=function(e,...)
    local r,y,u=t4()
    if not y then return nil end
    local w=y.Size
    local j=math.max(4,w.X/2-5)
    local k=math.max(4,w.Z/2-5)
    for r=1,60,1 do
        local u=math.random(-math.floor(j),math.floor(j))
        local o=math.random(-math.floor(k),math.floor(k))
        local V=y.CFrame*CFrame.new(u,w.Y/2+1,o)
        local H=true
        for e,r in ipairs(e)do
            if((r-V.Position)).Magnitude<5.5 then
                H=false
                break
            end
        end
        if H then return V end
    end
    return y.CFrame*CFrame.new(math.random(-8,8),w.Y/2+1,math.random(-8,8))
end
B4=function(...)
    local e,r,y=t4()
    if not y or not K then return 0 end
    local u=0
    local w={}
    if c then
        local e,r=pcall(function(...) return c:InvokeServer() end)
        if e and type(r)=="table"then
            local e={}
            for r,y in pairs(r)do
                if type(y)=="table"and y.OwnerUserId==o.UserId then
                    for r,y in pairs(y.Records or{})do e[r]=y end
                end
            end
            for e,r in pairs(e)do
                if r.Placement and r.Placement.LocalCFrame then
                    w[#w+1]=((y.CFrame*r.Placement.LocalCFrame)).Position
                else
                    local r=p4(w)
                    if r then
                        local j=y.CFrame:ToObjectSpace(r)
                        local k,a=pcall(function(...) return K:InvokeServer({["Uid"]=e;["LocalCFrame"]=j}) end)
                        if k and a then
                            u=u+1
                            w[#w+1]=r.Position
                        end
                    end
                end
            end
        end
    end
    local j={}
    local k=o.Character
    if k then
        for e,r in ipairs(k:GetChildren())do
            if m(r)then table.insert(j,r) end
        end
    end
    local a=o:FindFirstChild("Backpack")
    if a then
        for e,r in ipairs(a:GetChildren())do
            if m(r)then table.insert(j,r) end
        end
    end
    for e,r in ipairs(j)do
        if not h.alive then break end
        local j=r:GetAttribute("UID")or r:GetAttribute("EggUid")or r.Name
        local k=p4(w)
        if k then
            local e=y.CFrame:ToObjectSpace(k)
            local r,a=pcall(function(...) return K:InvokeServer({["Uid"]=j,["LocalCFrame"]=e}) end)
            if r and a~=false then
                u=u+1
                w[#w+1]=k.Position
                H(string.format("[PlaceEgg] Placed egg %s from inventory",tostring(j)))
            end
            task.wait(0.04)
        end
    end
    return u
end
J4=function(e,...)
    if(not e and not h.autoHatch)or not g or not Q or not c then return 0 end
    if h.isHatching then return 0 end
    h.isHatching=true
    local y,u=pcall(function(...) return c:InvokeServer() end)
    if not y or type(u)~="table"then return 0 end
    local w={}
    for e,r in pairs(u)do
        if type(r)=="table"and r.OwnerUserId==o.UserId then
            for e,r in pairs(r.Records or{})do w[e]=r end
        end
    end
    local j={}
    local k=r:GetServerTimeNow()
    for e,r in pairs(w)do
        if not h.alive then break end
        if r.Placement then
            local y=nil
            if s then
                local r=s.IsReadyToHatch or s.IsLocalEggReady
                if r then
                    local u,w=pcall(r,e)
                    if u and type(w)=="boolean"then y=w end
                end
            end
            if y==nil then
                local e=r.Placement.PlacedAt or r.Placement.Time or 0
                local u=30
                if p and(p.Assets and p.Assets[r.AssetCategory])then
                    local e=p.Assets[r.AssetCategory]
                    u=(e and(e.Egg and e.Egg.GrowthTime))or 30
                end
                local w=u/math.max(0.01,r.GrowthSpeedMultiplier or 1)
                y=(k-e)>=w
            end
            if y then table.insert(j,{["uid"]=e;["category"]=r.AssetCategory or"Egg"}) end
        end
    end
    if#j==0 then
        h.isHatching=false
        return 0
    end
    H(string.format("[AutoHatch] Found %d eggs ready to hatch! Starting hatch sequence...",#j))
    h.statusText=string.format("[Hatch] Hatching %d ready eggs...",#j)
    local a=0
    for e,r in ipairs(j)do
        task.spawn(function(...)
            local e,y=pcall(function(...)
                if g:IsA("RemoteFunction")then return g:InvokeServer(r.uid)
                else
                    g:FireServer(r.uid)
                    return true
                end
            end)
            if e and y~=false then
                task.wait(0.9)
                local e,y=pcall(function(...)
                    if Q:IsA("RemoteFunction")then return Q:InvokeServer(r.uid)
                    else
                        Q:FireServer(r.uid)
                        return true
                    end
                end)
                if e and y~=false then
                    a=a+1
                    h.hatched=((h.hatched or 0))+1
                    H(string.format("[+] [AutoHatch] Hatched %s (UID: %s) -> Total Hatched: %d",r.category,tostring(r.uid),h.hatched))
                end
            end
        end)
        task.wait(0.04)
    end
    task.wait(0.95)
    h.isHatching=false
    H(string.format("[AutoHatch] Finished! Hatched %d eggs.",a))
    return a
end
i4=function(...)
    local e={}
    local y=r:FindFirstChild("__DEBRIS")
    if y then
        for r,y in ipairs(y:GetChildren())do
            local u=y:FindFirstChild("Hitbox")
            if u and u:IsA("BasePart")then
                table.insert(e,u)
            elseif y:IsA("BasePart")and string.find(y.Name:lower(),"hitbox")then
                table.insert(e,y)
            end
        end
    end
    local u=r:FindFirstChild("BossArenaTeleport")
    if u then
        local r=u:FindFirstChild("Hitbox")or u:FindFirstChildWhichIsA("BasePart")or(u:IsA("BasePart")and u)
        if r and r:IsA("BasePart")then table.insert(e,r) end
    end
    return e
end
g4=function(e,r,u,...)
    local w=o.Character
    local j=w and w:FindFirstChild("HumanoidRootPart")
    local k=w and w:FindFirstChildOfClass("Humanoid")
    if not j then return false end
    if k then k.AutoRotate=false end
    local a=s4()
    e=math.max(100,e or h.glideSpeed or 600)
    local V=h.laneZ or L
    h.isReturning=true
    h.stateTime=os.clock()
    V4(a,20)
    j.AssemblyLinearVelocity=Vector3.zero
    j.AssemblyAngularVelocity=Vector3.zero
    local H=o4()
    local t=math.max(e,H)
    local s=os.clock()+25
    while h.alive and(h.isReturning and os.clock()<s)do
        if r and O4~=r then
            if k then k.AutoRotate=true end
            h.isReturning=false
            return false
        end
        if not u and(not h.pureTweenFarm and not h.autoFarmLoop)then
            if k then k.AutoRotate=true end
            h.isReturning=false
            return false
        end
        local e=j.Position
        local w=((a-e)).Magnitude
        if(e.X<=(a.X+3)and math.abs(e.Z-a.Z)<=8)or w<=6 then break end
        local o=y.Heartbeat:Wait()
        e=j.Position
        local H=t
        if e.X<=b and e.X>E then
            local r=math.clamp(((e.X-E))/((b-E)),0,1)
            H=A+(((t-A))*r)
        elseif e.X<=E then
            H=A
        end
        local s=a.Z
        if e.X>540 then s=V end
        local B=math.sign(a.X-e.X)
        local J=B*math.min(math.abs(a.X-e.X),H*o)
        local K=e.X+J
        local c=math.sign(a.Y-e.Y)
        local v=c*math.min(math.abs(a.Y-e.Y),(H*o)*0.5)
        local i=e.Y+v
        local R=s-e.Z
        local g=math.sign(R)*math.min(math.abs(R),H*o)
        local Q=e.Z+g
        local P=i4()
        local N=false
        if e.X>E then
            for e,r in ipairs(P)do
                local y=r.Position
                local u=((Vector3.new(K,i,Q)-y)).Magnitude
                local w=math.abs(K-y.X)
                local j=math.abs(Q-y.Z)
                if u<22 or(w<18 and j<14)then
                    N=true
                    local e=y.Y+16
                    if i<e then i=math.min(i+((H*o)*1.5),e) end
                    break
                end
            end
        end
        local U=Vector3.new(K,i,Q)
        local l=((U-e)).Magnitude>0.05 and((U-e)).Unit or j.CFrame.LookVector
        j.CFrame=CFrame.lookAt(U,U+l)
        j.AssemblyLinearVelocity=Vector3.zero
        j.AssemblyAngularVelocity=Vector3.zero
        if N then
            h.statusText=string.format("Tweening Home (Z: %.0f) [DODGING TRAP!]",Q)
        else
            h.statusText=string.format("Tweening Home (%.0f studs | Z: %.0f | Spd: %.0f)",w,Q,H)
        end
    end
    j.CFrame=CFrame.new(a)
    j.AssemblyLinearVelocity=Vector3.zero
    j.AssemblyAngularVelocity=Vector3.zero
    if k then k.AutoRotate=true end
    u4()
    h.isReturning=false
    h.delivering=false
    h.statusText="Arrived at Base PetArea!"
    return true
end
v4=function(e,r,y,...)
    local u=o.Character
    local w=u and u:FindFirstChild("HumanoidRootPart")
    local j=u and u:FindFirstChildOfClass("Humanoid")
    if not w or not j then return end
    local k=s4()
    local a=((w.Position-k)).Magnitude
    if a>8 then
        h.statusText="[Place] Tweening back to base plot..."
        g4(e or h.glideSpeed or 600,r,true)
    end
    V4(k,15)
    w.CFrame=CFrame.new(k)
    w.AssemblyLinearVelocity=Vector3.zero
    h.statusText="[Place] Placing All Eggs to Stand..."
    local V=os.clock()+3
    while y4()>0 and(os.clock()<V and h.alive)do
        B4()
        task.wait(0.06)
    end
    h.statusText="[Place] Hatching ready eggs..."
    J4(true)
    u4()
    h.isReturning=false
    h.delivering=false
    h.currentTargetModel=nil
    h.targetPosition=nil
    local H=y4()
    h.statusText=string.format("Placed & Hatched (Left: %d)! Hands Free.",H)
end
local uk=5
K4=function(e,...)
    if h.isBatchPlacing then return end
    h.isBatchPlacing=true
    H(string.format("[AutoPlace] %d steals done! Batch placing (%s mode)...",uk,tostring(e)))
    local r=O4
    h.pureTweenFarm=(e=="TWEEN")
    h.autoFarmLoop=(e=="WARP")
    local y=o.Character
    local u=y and y:FindFirstChild("HumanoidRootPart")
    local w=y and y:FindFirstChildOfClass("Humanoid")
    local j=s4()
    local k=u and((u.Position-j)).Magnitude or 999
    if k>8 then
        h.statusText="[AutoPlace] Tweening home to base plot..."
        g4(h.glideSpeed or 600,r,true)
    end
    if u then
        V4(j,20)
        u.CFrame=CFrame.new(j)
        u.AssemblyLinearVelocity=Vector3.zero
        u.AssemblyAngularVelocity=Vector3.zero
        if w then w.AutoRotate=true end
    end
    task.spawn(function(...)
        pcall(B4)
        pcall(J4,true)
    end)
    u4()
    h.isReturning=false
    h.delivering=false
    h.glidingToTarget=false
    h.securingEgg=false
    h.teleporting=false
    h.currentTargetModel=nil
    h.targetPosition=nil
    for e=5,1,-1 do
        if not h.alive then break end
        h.statusText=string.format("[AutoPlace] At Base: Resuming in %ds...",e)
        task.wait(1)
    end
    h.isBatchPlacing=false
    if h.alive and O4==r then
        H(string.format("[AutoPlace] Done! Continuing %s farm.",e))
        h.statusText=string.format("[AutoPlace] Resuming %s farm...",e)
        if e=="TWEEN"then
            h.pureTweenFarm=true
            h.autoFarmLoop=false
        elseif e=="WARP"then
            h.autoFarmLoop=true
            h.pureTweenFarm=false
        end
        Y4=e
    end
end
c4=function(e,...)
    if not h.autoPlaceEvery5 then return false end
    h.batchStealCount=((h.batchStealCount or 0))+1
    H(string.format("[AutoPlace] Steal trip %d / %d completed successfully.",h.batchStealCount,uk))
    if h.batchStealCount>=uk then
        h.batchStealCount=0
        task.spawn(function(...) K4(e) end)
        return true
    end
    return false
end
local function wk(e,r,u,w,...)
    local j=o.Character
    local k=j and j:FindFirstChild("HumanoidRootPart")
    local a=j and j:FindFirstChildOfClass("Humanoid")
    if not k then return false end
    if a then a.AutoRotate=false end
    r=math.max(60,r or h.glideSpeed or 350)
    local V=e.Position
    V4(V,14)
    pcall(function(...) o:RequestStreamAroundAsync(V) end)
    k.AssemblyLinearVelocity=Vector3.zero
    k.AssemblyAngularVelocity=Vector3.zero
    local H=h.laneZ or L
    h.glidingToTarget=true
    h.stateTime=os.clock()
    local t=0
    local s=os.clock()+15
    while h.alive and(h.glidingToTarget and os.clock()<s)do
        if w and O4~=w then
            if a then a.AutoRotate=true end
            h.glidingToTarget=false
            return false
        end
        if not h.pureTweenFarm and(not h.autoFarmLoop and not h.teleporting)then
            if a then a.AutoRotate=true end
            h.glidingToTarget=false
            return false
        end
        local e=k.Position
        local j=((V-e)).Magnitude
        local o=((Vector2.new(e.X,e.Z)-Vector2.new(V.X,V.Z))).Magnitude
        local s=math.abs(e.Y-V.Y)
        if j<=6 or(o<=3.5 and s<=6)then break end
        local B=y.Heartbeat:Wait()
        e=k.Position
        j=((V-e)).Magnitude
        o=((Vector2.new(e.X,e.Z)-Vector2.new(V.X,V.Z))).Magnitude
        local J=math.abs(e.X-V.X)
        if u and(os.clock()-t>0.5)then
            t=os.clock()
            local e,r=k4(u)
            if not e and r=="CarriedByOther"then
                if a then a.AutoRotate=true end
                h.glidingToTarget=false
                return false
            end
        end
        local K=V.Z
        if J>40 then K=H end
        local c=math.sign(V.X-e.X)
        local v=c*math.min(math.abs(V.X-e.X),r*B)
        local i=e.X+v
        local R=(o<=25)and 1.2 or 0.5
        local g=math.sign(V.Y-e.Y)
        local Q=g*math.min(math.abs(V.Y-e.Y),(r*B)*R)
        local P=e.Y+Q
        local N=K-e.Z
        local U=math.sign(N)*math.min(math.abs(N),r*B)
        local l=e.Z+U
        local D=false
        if o>25 then
            local e=i4()
            for e,y in ipairs(e)do
                local u=y.Position
                local w=((Vector3.new(i,P,l)-u)).Magnitude
                local j=math.abs(i-u.X)
                local k=math.abs(l-u.Z)
                if w<22 or(j<18 and k<14)then
                    D=true
                    local e=u.Y+16
                    if P<e then P=math.min(P+((r*B)*1.5),e) end
                    break
                end
            end
        end
        local C=Vector3.new(i,P,l)
        local q=((C-e)).Magnitude>0.05 and((C-e)).Unit or k.CFrame.LookVector
        k.CFrame=CFrame.lookAt(C,C+q)
        k.AssemblyLinearVelocity=Vector3.zero
        k.AssemblyAngularVelocity=Vector3.zero
        if D then
            h.statusText=string.format("Gliding Out (Z: %.0f) [DODGING TRAP!]",l)
        else
            h.statusText=string.format("Gliding -> Egg (%.0f studs | H: %.0f)",j,o)
        end
    end
    k.CFrame=e*CFrame.new(0,0.4,0)
    k.AssemblyLinearVelocity=Vector3.zero
    k.AssemblyAngularVelocity=Vector3.zero
    if a then a.AutoRotate=true end
    h.glidingToTarget=false
    return true
end
R4=function(e,r,y,u,...)
    local w=o.Character
    local j=w and w:FindFirstChild("HumanoidRootPart")
    if j then
        local w=j.Position.X
        local a=e.Position.X
        if w<=535 and a>510 then
            local e=CFrame.new(500,70,-364)
            local a=((j.Position-e.Position)).Magnitude
            if a>5 then
                h.statusText="[AutoSteal] Exiting Base -> Waypoint (500, 70, -364)..."
                H(string.format("[AutoSteal] Leaving base (X=%.1f): Gliding to waypoint (500, 70, -364) first (dist=%.1f studs)...",w,a))
                local j=wk(e,r,y,u)
                if not j then return false end
                task.wait(0.04)
            end
        end
    end
    return wk(e,r,y,u)
end
Q4=function(e,r,...)
    local u=o.Character
    local w=u and u:FindFirstChild("HumanoidRootPart")
    local j=u and u:FindFirstChildOfClass("Humanoid")
    if not w then return false end
    if j then j.AutoRotate=false end
    local k=h.laneZ or L
    local a=Vector3.new(E-10,70,k)
    e=math.max(100,e or h.glideSpeed or 350)
    h.isReturning=true
    h.stateTime=os.clock()
    V4(Vector3.new(E,70,k),20)
    pcall(u4)
    w.AssemblyLinearVelocity=Vector3.zero
    w.AssemblyAngularVelocity=Vector3.zero
    local V=o4()
    local H=math.max(e,V)
    local s=os.clock()+15
    while h.alive and(h.isReturning and os.clock()<s)do
        if r and O4~=r then
            t("[Return] Aborted by session switch!")
            if j then j.AutoRotate=true end
            h.isReturning=false
            return false
        end
        if not h.pureTweenFarm and not h.autoFarmLoop then
            t("[Return] Aborted (all farms disabled)")
            if j then j.AutoRotate=true end
            h.isReturning=false
            return false
        end
        local e=w.Position
        local o=((a-e)).Magnitude
        if e.X<=(E+10)or o<=6 then
            u4()
            break
        end
        if u then
            for e,r in ipairs(u:GetChildren())do
                if r:IsA("Tool")then
                    pcall(u4)
                    break
                end
            end
        end
        local V=y.Heartbeat:Wait()
        e=w.Position
        local s=H
        if e.X<=b and e.X>E then
            local r=math.clamp(((e.X-E))/((b-E)),0,1)
            s=A+(((H-A))*r)
        elseif e.X<=E then
            s=A
        end
        local B=math.sign(a.X-e.X)
        local J=B*math.min(math.abs(a.X-e.X),s*V)
        local K=e.X+J
        local c=math.sign(a.Y-e.Y)
        local v=c*math.min(math.abs(a.Y-e.Y),(s*V)*0.5)
        local i=e.Y+v
        local R=k-e.Z
        local g=math.sign(R)*math.min(math.abs(R),s*V)
        local Q=e.Z+g
        local P=i4()
        local N=false
        for e,r in ipairs(P)do
            local y=r.Position
            local u=((Vector3.new(K,i,Q)-y)).Magnitude
            local w=math.abs(K-y.X)
            local j=math.abs(Q-y.Z)
            if u<22 or(w<18 and j<14)then
                N=true
                local e=y.Y+16
                if i<e then i=math.min(i+((s*V)*1.5),e) end
                break
            end
        end
        local U=Vector3.new(K,i,Q)
        local l=((U-e)).Magnitude>0.05 and((U-e)).Unit or w.CFrame.LookVector
        w.CFrame=CFrame.lookAt(U,U+l)
        w.AssemblyLinearVelocity=Vector3.zero
        w.AssemblyAngularVelocity=Vector3.zero
    end
    w.CFrame=CFrame.new(a)
    w.AssemblyLinearVelocity=Vector3.zero
    w.AssemblyAngularVelocity=Vector3.zero
    if j then j.AutoRotate=true end
    h.isReturning=false
    u4()
    return true
end
P4=function(...)
    local e=h4(true)
    if not e or#e==0 then return nil end
    local r=o.Character
    local y=r and r:FindFirstChild("HumanoidRootPart")
    if not y then return nil end
    local u=nil
    local w=math.huge
    for r,j in ipairs(e)do
        local e=j.BoundsCFrame or j.CFrame or(j.PhysicalModel and j.PhysicalModel:GetPivot())
        if e then
            local a=(e.Position-y.Position).Magnitude
            if a<w then
                w=a
                u=j
            end
        end
    end
    return u
end
N4=function(...)
    local e=h4(true)
    if not e then return nil end
    for r,y in ipairs(e)do
        local e=tostring(y.AreaId or "")
        local u=tostring(y.AssetCategory or y.Uid or "")
        local w=tostring(y.Rarity or "")
        if h.selectedZones and h.selectedZones[e]then
            if h.selectedRarities and h.selectedRarities[w]then
                if y.State=="Slot"or y.State=="Dropped"then return y end
            end
        end
    end
    return nil
end
U4=function(...)
    local e=h4(true)
    if not e then return nil end
    local r=o.Character
    local y=r and r:FindFirstChild("HumanoidRootPart")
    if not y then return nil end
    local u=nil
    local w=math.huge
    for r,j in ipairs(e)do
        if j.State=="Slot"or j.State=="Dropped"then
            local e=j.BoundsCFrame or j.CFrame or(j.PhysicalModel and j.PhysicalModel:GetPivot())
            if e then
                local a=(e.Position-y.Position).Magnitude
                if a<w then
                    w=a
                    u=j
                end
            end
        end
    end
    return u
end
l4=function(...)
    local e=o.Character
    local r=e and e:FindFirstChild("HumanoidRootPart")
    if not r then return end
    local y=h4(true)
    if not y then return end
    local u=0
    for e,j in ipairs(y)do
        if j.State=="Slot"or j.State=="Dropped"then
            local e=j.BoundsCFrame or j.CFrame or(j.PhysicalModel and j.PhysicalModel:GetPivot())
            if e then
                local a=e.Position
                if((a-r.Position)).Magnitude<=18 then u=u+1 end
            end
        end
    end
    return u
end
local function checkAutoBuy()
    if not h.autoBuyTrails then return end
    if not C or not q then return end
    local e=o:FindFirstChild("leaderstats")
    if not e then return end
    local r=e:FindFirstChild("Coins")or e:FindFirstChild("Money")or e:FindFirstChild("Cash")
    if not r then return end
    local y=r.Value
    if y and y>=1000 then
        pcall(function(...) C:InvokeServer() end)
        task.wait(0.1)
        pcall(function(...) q:InvokeServer(math.random(1,10)) end)
    end
end
local function checkAutoTreadmill()
    if not h.autoTreadmill then return end
    if L4()then return end
    if not l then return end
    local e=o.Character
    local r=e and e:FindFirstChild("HumanoidRootPart")
    if not r then return end
    if r.Position.X>E+50 then return end
    pcall(function(...) l:InvokeServer() end)
end
local function checkAutoUpgradeTreadmill()
    if not h.autoUpgradeTreadmill then return end
    if not D then return end
    local e=o:FindFirstChild("leaderstats")
    if not e then return end
    local r=e:FindFirstChild("Coins")or e:FindFirstChild("Money")or e:FindFirstChild("Cash")
    if not r then return end
    if r.Value and r.Value>=5000 then
        pcall(function(...) D:InvokeServer() end)
    end
end
local function antiAFK()
    if not h.antiAFK then return end
    local e=game:GetService("VirtualUser")
    e:CaptureController()
    e:ClickButton2(Vector2.new())
end
o.Idled:Connect(function(...) antiAFK() end)
spawn(function(...)
    while true do
        task.wait(60)
        pcall(antiAFK)
    end
end)
local function mainLoop()
    while h.alive do
        task.wait(0.5)
        if not o.Character or not o.Character.Parent then
            task.wait(1)
        end
        pcall(checkAutoBuy)
        pcall(checkAutoTreadmill)
        pcall(checkAutoUpgradeTreadmill)
    end
end
task.spawn(mainLoop)
local function renderUI()
end
pcall(function(...)
    h.alive=true
    h.statusText="Axiom Hub Ready"
end)