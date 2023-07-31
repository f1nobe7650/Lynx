local Lynx = {}
--
local repo = "https://raw.githubusercontent.com/f1nobe7650/Lynx/main/"
local Color = loadstring(game:HttpGet(repo .."Color.lua"))();
local Math = loadstring(game:HttpGet(repo .."Math.lua"))();
-- Services
local InputService, TeleportService, RunService, Workspace, Lighting, Players, HttpService, StarterGui, ReplicatedStorage, TweenService  = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players"), game:GetService("HttpService"), game:GetService("StarterGui"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
-- Decendants 
local LocalPlayer = Players.LocalPlayer
local Mouse, Camera = LocalPlayer:GetMouse(), Workspace.Camera
-- Optimizers
local Find, Clear, Sub, Upper, Lower, Insert = table.find, table.clear, string.sub, string.upper, string.lower, table.insert
local Huge, Pi, Clamp, Round, Abs, Floor, Random, Sin, Cos, Rad, Halfpi = math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random, math.sin, math.cos, math.rad, math.pi/2
local SpinAngle, SpinSize, SpinSpeed = 0, 25, 0
local Create, Resume = coroutine.create, coroutine.resume
local Spawn, Wait = task.spawn, task.wait
local NewVector2, NewVector3, NewCFrame = Vector2.new, Vector3.new, CFrame.new
local NewRGB, NewHex = Color3.fromRGB, Color3.fromHex
local NewInstance = Instance.new

-- Funcs
do 
    function Lynx:ThreadFunction(Func, Name, ...)
        local Func = Name and function()
            local Passed, Statement = pcall(Func)
            --
            if not Passed and not Lynx.Safe then
                warn("Lynx:\n", "              " .. Name .. ":", Statement)
            end
        end or Func
        local Thread = Create(Func)
        --
        Resume(Thread, ...)
        return Thread
    end
    -- 
    function Lynx:RayCast(Part, Origin, Ignore, Distance)
        local Ignore = Ignore or {}
        local Distance = Distance or 5000
        --
        local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
        --
        return (Hit and Hit:IsDescendantOf(Part.Parent)) == true, Hit
    end
    -- 
    function Lynx:newDrawing(type, prop)
        local obj = Drawing.new(type)
        --
        if prop then
            for i,v in next, prop do
                obj[i] = v
            end
        end
        return obj  
    end
    --

    -- 
    function Lynx:GetPlayerStatus(Player: Instance)
        if not Player then Player = LocalPlayer end
        return Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and true or false
    end 
    --
    function Lynx:CreateBeam(Origin, End, Color1, Color2, Texture)
        local BeamPart = Instance("Part", workspace)
        BeamPart.Name = "BeamPart"
        BeamPart.Transparency = 1
        --
        local Part = Instance("Part", BeamPart)
        Part.Size = Vector3.new(1, 1, 1)
        Part.Transparency = 1
        Part.CanCollide = false
        Part.CFrame = CFrame.new(Origin)
        Part.Anchored = true
        local Attachment = Instance("Attachment", Part)
        local Part2 = Instance("Part", BeamPart)
        Part2.Size = Vector3.new(1, 1, 1)
        Part2.Transparency = 1
        Part2.CanCollide = false
        Part2.CFrame = CFrame.new(End)
        Part2.Anchored = true
        Part2.Color = Color3.fromRGB(255, 255, 255)
        local Attachment2 = Instance("Attachment", Part2)
        local Beam = Instance("Beam", Part)
        Beam.FaceCamera = true
        Beam.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color1),
            ColorSequenceKeypoint.new(1, Color2),
        }
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment2
        Beam.LightEmission = 6
        Beam.LightInfluence = 1
        Beam.Width0 = 1
        Beam.Width1 = 0.6
        Beam.Texture = "rbxassetid://".. Texture ..""
        Beam.LightEmission = 1
        Beam.LightInfluence = 1
        Beam.TextureMode = Enum.TextureMode.Wrap 
        Beam.TextureLength = 3 
        Beam.TextureSpeed = 3
        delay(1, function()
        for i = 0.5, 1, 0.02 do
            wait()
            Beam.Transparency = NumberSequence.new(i)
        end
        Part:Destroy()
        Part2:Destroy()
        BeamPart:Destroy()
        end)
    end
    -- 
    function Lynx:GetTool() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and Lynx:GetPlayerStatus() then 
            return LocalPlayer.Character:FindFirstChildWhichIsA("Tool") 
        end 
    end 
    -- 
    function Lynx:Rainbow(Speed: Int)
        return Color3.fromHSV(Abs(Sin(tick()) / (5 - Speed)),1,1)
    end 
    --
    function Lynx:CheckIfEven(Number: Int)
        if (Number % 2 == 0) then
            return true
        else
            return false 
        end
    end
    --
    function Lynx:Connection(Type, Callback)
        local Connection = Type:Connect(Callback)
        Lynx.Connections[#Lynx.Connections + 1] = Connection
        --
        return Connection
    end
    --
    function Lynx:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
        local Parts = {}
        local Hitboxes = Hitboxes or {"Head", "Torso", "Arms", "Legs"}
        --
        for Index, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                if Find(Hitboxes, "Head") and Part.Name:lower():find("head") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif (Find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) or (Find(Hitboxes, "Legs ") and Part.Name:lower():find("foot")) then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                end
            end
        end
        --
        return Parts
    end
    -- 
    function Lynx:GetClosestPlayer()
        local shortestDistance = Huge
        --  
        local closestPlayer
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Lynx:GetPlayerStatus(Player) then
                local pos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                --
                if magnitude < shortestDistance and OnScreen then
                        closestPlayer = Player
                        shortestDistance = magnitude
                    end
                end
            end 
        return closestPlayer
    end
    -- 
    function Lynx:UpdateVisuals()
        if pointers["lighting_masterswitch"]:Get() then 
            if pointers["lighting_ambient"]:Get() then 
                if Lighting.Ambient ~= pointers["lighting_ambient1"]:Get() then 
                    Lighting.Ambient = pointers["lighting_ambient1"]:Get()
                end 
                if Lighting.OutdoorAmbient ~= pointers["lighting_ambient2"]:Get() then 
                    Lighting.OutdoorAmbient = pointers["lighting_ambient2"]:Get()
                end 
            end 
            --
            if pointers["lighting_ambientcolorshift"]:Get() then 
                if Lighting.ColorShift_Bottom ~= pointers["lighting_ambientcolorshift1"]:Get() then 
                    Lighting.ColorShift_Bottom = pointers["lighting_ambientcolorshift1"]:Get()
                end 
                if Lighting.ColorShift_Top ~= pointers["lighting_ambientcolorshift2"]:Get() then 
                    Lighting.ColorShift_Top = pointers["lighting_ambientcolorshift2"]:Get()
                end 
            end 
            --
            if pointers["lighting_fog"]:Get() then 
                if Lighting.FogColor ~= pointers["lighting_fog1"]:Get() then 
                    Lighting.FogColor = pointers["lighting_fog1"]:Get()
                end 
                if Lighting.FogEnd ~= pointers["lighting_fog_end"]:Get() then 
                    Lighting.FogEnd = pointers["lighting_fog_end"]:Get()
                end 
                if Lighting.FogStart ~= pointers["lighting_fog_start"]:Get() then 
                    Lighting.FogStart = pointers["lighting_fog_start"]:Get()
                end 
            end 
            --
            if pointers["lighting_clocktime"]:Get() then
                if Lighting.ClockTime ~= pointers["lighting_clocktime_slider"]:Get() then 
                    Lighting.ClockTime = pointers["lighting_clocktime_slider"]:Get()
                end 
            end
            --
            if pointers["lighting_brightness"]:Get() then 
                if Lighting.Brightness ~= pointers["lighting_brightness_slider"]:Get() then
                    Lighting.Brightness = pointers["lighting_brightness_slider"]:Get()
                end
            end 
        end 
    end 
    --
    function Lynx:GetPlayerParent(Player)
        return Player.Parent
    end
    --
    function Lynx:GetCharacter(Player)
        return Player.Character
    end
    --
    function Lynx:GetHumanoid(Player, Character)
        return Character:FindFirstChildOfClass("Humanoid")
    end
    --
    function Lynx:GetRootPart(Player, Character, Humanoid)
        return Humanoid.RootPart
    end
    --
    function Lynx:GetHealth(Player, Character, Humanoid)
        if Humanoid then
            return Clamp(Humanoid.Health, 0, Humanoid.MaxHealth), Humanoid.MaxHealth
        end
    end
    --
    function Lynx:ValidateClient(Player)
        local Object = Lynx:GetCharacter(Player)
        local Humanoid = (Object and Lynx:GetHumanoid(Player, Object))
        local RootPart = (Humanoid and Lynx:GetRootPart(Player, Object, Humanoid))
        --
        return Object, Humanoid, RootPart
    end
    --
    function Lynx:ClientAlive(Player, Character, Humanoid)
        local Health, MaxHealth = Lynx:GetHealth(Player, Character, Humanoid)
        --
        return (Health > 0)
    end
    --
    function Lynx:Unload()
        for Index, Connection in next, Lynx.Connections do
            Connection:Disconnect()
        end
        --
        if Visuals ~= nil then
            Visuals:Unload()
        end
    end
    --
    function Lynx:ClampString(String, Length, Font)
        local Font = (Font or 2)
        local Split = String:split("\n")
        --
        local Clamped = ""
        --
        for Index, Value2 in pairs(Split) do
            if (Index * 13) <= Length then
                Clamped = Clamped .. Value2 .. (Index == #Split and "" or "\n")
            end
        end
        --
        return (Clamped ~= String and (Clamped == "" and "" or Clamped:sub(0, #Clamped - 1) .. " ...") or Clamped)
    end
    -- 
    function Lynx:GetIgnore(Unpacked)
        if Unpacked then
            return
        else
            return {}
        end
    end
    -- 
    function Lynx:GetTeam(Player)
        return Player.Team
    end
    -- 
    function Lynx:CheckTeam(Player1, Player2)
        return (Lynx:GetTeam(Player1) ~= Lynx:GetTeam(Player2))
    end
    -- 
    function Lynx:GetClosestPart(Player: Instance, List: Table)
        local shortestDistance = Huge
        local closestPart = nil
        if Lynx:GetPlayerStatus(Player) then
            for Index, Value in pairs(Player.Character:GetChildren()) do
                if Value:IsA("BasePart") then 
                    local pos = Camera:WorldToViewportPoint(Value.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y + 36)).magnitude
                    if magnitude < shortestDistance and Find(List, Value) then
                        closestPart = Value
                        shortestDistance = magnitude
                    end
                end
            end 
            return closestPart
        end
    end 
    -- 
    function Lynx:RandomChance(Percentage: Int)
        local Chance = Percentage
        --
        if Random(1,100) <= Chance then
            return true 
        else
            return false
        end
    end
    -- 
    local Folder = NewInstance("Folder")
    Folder.Parent = Workspace.Terrain
    Folder.Name = "Backtrack"
    -- 
    function Lynx:CloneCharacter(Player: Instance, Color: Color3, Material: Enum, Transparency: Int)
        for i,v in pairs(Player.Character:GetChildren()) do 
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                local ClonedPart = Instance.new("Part")
                ClonedPart.Anchored = true 
                ClonedPart.CanCollide = false 
                ClonedPart.Position = v.Position
                ClonedPart.Parent = Workspace.Terrain["Backtrack"]
                ClonedPart.Material = Enum.Material[Material]
                ClonedPart.Shape = Enum.PartType.Block 
                ClonedPart.Transparency = Transparency 
                ClonedPart.Color = Color
                ClonedPart.Size = v.Size + Vector3.new(0.01,0.01,0.01)
                ClonedPart.Name = v.Name
                ClonedPart.Rotation = v.Rotation
            end 
        end
    end 
    -- 
    function Lynx:CalculateAbsolutePosition(Player: Instance)
        if Lynx:GetPlayerStatus(Player) then
            local root = Player.Character.HumanoidRootPart
            local character = Player.Character 
            --
            local currentPosition = root.Position
            local currentTime = tick() 
            --
            task.wait()
            --
            local newPosition = root.Position
            local newTime = tick()
            --
            local distanceTraveled = (newPosition - currentPosition) 
            --
            local timeInterval = newTime - currentTime
            local velocity = distanceTraveled / timeInterval
            currentPosition = newPosition
            currentTime = newTime
            --
            return velocity
        end
    end 
    --
    function Lynx:Speed()
        local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
        if (Object and Humanoid and RootPart) then
            --
            if (Flags["Misc_Speed"]:Get() == true and Flags["Misc_Speed_Key"]:Is_Active() == true) then
                local Travel = NewVector3()
                local LookVector = Camera.CFrame.lookVector
                --
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    Travel += NewVector3(LookVector.x, 0, LookVector.Z)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    Travel -= NewVector3(LookVector.x, 0, LookVector.Z)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    Travel += NewVector3(-LookVector.Z, 0, LookVector.x)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    Travel += NewVector3(LookVector.Z, 0, -LookVector.x)
                end
                --
                Travel = Travel.Unit
                local NewDirection = NewVector3(Travel.X * Flags["Misc_Speed_Speed"]:Get(), RootPart.Velocity.Y, Travel.Z * Flags["Misc_Speed_Speed"]:Get())
                --
                if Travel.Unit.X == Travel.Unit.X then
                    RootPart.Velocity = NewDirection
                end
            end
        end
	end
    --
    function Lynx:StaffCheck(Player)
        if (Player:GetRankInGroup(4165692) > 1) or (Player:GetRankInGroup(32406137) > 1) then
            if (Flags["Misc_StaffCheck"]:Get() == true) then
                if (Flags["Misc_StaffCheck_Type"]:Get() == "Kick") then
                    LocalPlayer:Kick(("Lynx | Risk-classed user detected: %s"):format(Player.Name))
                else
                    local Str = ("Lynx | Risk-classed user detected: %s"):format(Player.Name)
                    Lynx.Locals.Window.notificationlist:AddNotification({Text = Str})
                end
            end
        end
    end
    -- 
    function Lynx:GetOrigin(Origin)
        if Origin == "Head" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            local Head = Object:FindFirstChild("Head")
            --
            if Head and Head:IsA("RootPart") then
                return Head.CFrame.Position
            end
        elseif Origin == "Torso" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            --
            if RootPart then
                return RootPart.CFrame.Position
            end
        end
        --
        return Workspace.CurrentCamera.CFrame.Position
    end
    -- 

    --
    function Lynx:ValidateArguments(Args, RayMethod)
        local Matches = 0
            --
        if #Args < RayMethod.ArgCountRequired then
            return false
        end
        --
        for Pos, Argument in next, Args do
            if typeof(Argument) == RayMethod.Args[Pos] then
                Matches = Matches + 1
            end
        end
            --
        return Matches >= RayMethod.ArgCountRequired
    end
    --
    function Lynx:GetDirection(Origin, Position)
        return (Position - Origin).Unit * 1000
    end
    --
    function Lynx:GetTarget()
        local Target = {
            Player = nil,
            Object = nil,
            Part = nil,
            Magnitude = Huge
        }
        --
        local PossibleTarget = {
            Player = nil,
            Object = nil,
            Magnitude = Huge
        }
        --
        local MouseLocation = UserInputService:GetMouseLocation()
        --
        local FieldOfView = Flags["RageSaim_FOV"]:Get()
        local Hitboxes = Flags["RageSaim_Hitbox"]:Get()
        --
        for Index, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer then
                if (Library and Library.Relations[Player.UserId] and Library.Relations[Player.UserId] == "Friend") then continue end
                --
                local Object, Humanoid, RootPart = Lynx:ValidateClient(Player)
                --
                if (Object and Humanoid and RootPart) then
                    if (Object:FindFirstChildOfClass("ForceField")) then continue end
                    if (not Lynx:ClientAlive(Player, Object, Humanoid)) then continue end
                    --
                    local Position, Visible = Camera:WorldToViewportPoint(RootPart.CFrame.Position)
                    local Position2 = NewVector2(Position.X, Position.Y)
                    local Magnitude = (MouseLocation - Position2).Magnitude
                    local Distance = (Camera.CFrame.Position - RootPart.CFrame.Position).Magnitude
                    --
                    if Visible and Magnitude <= PossibleTarget.Magnitude then
                        PossibleTarget = {
                            Player = Player,
                            Object = Object,
                            Distance = Distance,
                            Magnitude = Magnitude
                        }
                    end
                    --
                    --
                    if Visible and Magnitude <= Target.Magnitude then
                        local ClosestPart, ClosestMagnitude = nil, Huge
                        --
                        for Index2, Part in pairs(Lynx:GetBodyParts(Object, RootPart, false, Hitboxes)) do
                            if (true and not (Part.Transparency ~= 1)) then continue end
                            --
                            local Position3, Visible2 = Camera:WorldToViewportPoint(Part.CFrame.Position)
                            local Position4 = NewVector2(Position3.X, Position3.Y)
                            local Magnitude2 = (MouseLocation - Position4).Magnitude
                            --
                            if Position4 and Visible2 then
                                --if (WallCheck and not Lynx:RayCast(Part, Lynx:GetOrigin(Origin), {Lynx:GetCharacter(LocalPlayer), Lynx:GetIgnore(true)})) then continue end
                                --
                                if Magnitude2 <= ClosestMagnitude then
                                    ClosestPart = Part
                                    ClosestMagnitude = Magnitude2
                                end
                            end
                        end
                        --
                        if ClosestPart and ClosestMagnitude then
                            Target = {
                                Player = Player,
                                Object = Object,
                                Part = ClosestPart,
                                Distance = Distance,
                                Magnitude = ClosestMagnitude
                            }
                        end
                    end
                end
            end
        end
        --
        if Target.Player and Target.Object and Target.Part and Target.Magnitude then
            PossibleTarget = {
                Player = Target.Player,
                Object = Target.Object,
                Distance = Target.Distance,
                Magnitude = Target.Magnitude
            }
            --
            Lynx.Locals.Target = Target
        else
            Lynx.Locals.Target = nil
        end
        --
        if PossibleTarget and PossibleTarget.Distance then
            Lynx.Locals.PossibleTarget = PossibleTarget
        else
            Lynx.Locals.PossibleTarget = nil
        end
    end  
end

return Lynx
