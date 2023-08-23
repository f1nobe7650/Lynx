settings = {
    enabled = true; -- / true / false
    minCameraDistance = 1; -- / any number
    hatTransparency = .35; -- / 0 - 1 (0 being invisible)
    circleTransparency = 1; -- / 0 - 1 (0 being invisible)
    height = .75; -- / any number
    radius = 1; -- /-- any number
    sides = 25; -- / any number
    rainbow = true; -- / true / false
    color = Color3.fromRGB(128,18,255); -- / 0-255,0-255,0-255
    offset = Vector3.new(0,.75,0); -- / number,number,number (studs offset from head center)
 }
 
 local runservice = game:GetService('RunService');
 local lplr = game:GetService('Players').LocalPlayer
 local camera = workspace.CurrentCamera;
 local tau = math.pi*2
 local drawings = {};
 
 for i = 1,settings.sides do
    drawings[i] = {Drawing.new('Line'),Drawing.new('Triangle')}
    drawings[i][1].ZIndex = 2;
    drawings[i][1].Thickness = 2;
    drawings[i][2].ZIndex = 1;
    drawings[i][2].Filled = true;
 end
 
 runservice.RenderStepped:Connect(function()
    local pass = settings.enabled and lplr.Character and lplr.Character:FindFirstChild('Head') ~= nil and (camera.CFrame.p - camera.Focus.p).magnitude > settings.minCameraDistance and lplr.Character.Humanoid.Health > 0
    for i = 1,#drawings do
        local line,triangle = drawings[i][1], drawings[i][2];
        if pass then
            local color = settings.rainbow and Color3.fromHSV((tick() % 5 / 5 - (i / #drawings)) % 1,.5,1) or settings.color;
            local pos = lplr.Character.Head.Position + settings.offset;
            local topWorld = pos + Vector3.new(0,settings.height,0);
 
            local last, next = (i/settings.sides)*tau, ((i+1)/settings.sides)*tau;
            local lastWorld = pos + (Vector3.new(math.cos(last),0,math.sin(last))*settings.radius);
            local nextWorld = pos + (Vector3.new(math.cos(next),0,math.sin(next))*settings.radius);
            local lastScreen = camera:WorldToViewportPoint(lastWorld);
            local nextScreen = camera:WorldToViewportPoint(nextWorld);
            local topScreen = camera:WorldToViewportPoint(topWorld);
 
            line.From = Vector2.new(lastScreen.X,lastScreen.Y);
            line.To = Vector2.new(nextScreen.X,nextScreen.Y);
            line.Color = color;
            line.Transparency = settings.circleTransparency;
            line.Visible = true;
 
            triangle.PointA = Vector2.new(topScreen.X,topScreen.Y);
            triangle.PointB = line.From;
            triangle.PointC = line.To;
            triangle.Color = color;
            triangle.Transparency = settings.hatTransparency;
            triangle.Visible = true;
        else
            line.Visible = false;
            triangle.Visible = false;
        end
    end
 end)
