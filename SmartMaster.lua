-- =================================================================
-- SCRIPT NAME: SMART MASTER (FULL HUB)
-- DEVELOPER: mairarbumaibok
-- =================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "SMART MASTER - ADMIN HUB",
   LoadingTitle = "SMART MASTER HUB",
   LoadingSubtitle = "by mairarbumaibok",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- Floating Buttons Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SmartMaster_FloatingUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local FloatingContainer = Instance.new("Frame")
FloatingContainer.Name = "FloatingContainer"
FloatingContainer.Size = UDim2.new(0, 300, 0, 50)
FloatingContainer.Position = UDim2.new(0.02, 0, 0.65, 0)
FloatingContainer.BackgroundTransparency = 1
FloatingContainer.Parent = ScreenGui

local FloatingList = Instance.new("UIListLayout")
FloatingList.Parent = FloatingContainer
FloatingList.FillDirection = Enum.FillDirection.Horizontal
FloatingList.Padding = UDim.new(0, 8)

local function CreateFloatingButton(textIcon)
   local Btn = Instance.new("TextButton")
   Btn.Size = UDim2.new(0, 45, 0, 45)
   Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
   Btn.Text = textIcon
   Btn.TextSize = 18
   Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
   Btn.Visible = false
   Btn.Parent = FloatingContainer

   local Corner = Instance.new("UICorner")
   Corner.CornerRadius = UDim.new(0, 10)
   Corner.Parent = Btn

   local Stroke = Instance.new("UIStroke")
   Stroke.Color = Color3.fromRGB(80, 80, 80)
   Stroke.Thickness = 1.5
   Stroke.Parent = Btn

   return Btn
end

-- ==========================================
-- TAB 1: MY SELF
-- ==========================================
local TabMySelf = Window:CreateTab("👤 My Self", 4483362458)

-- 1. การเดิน
TabMySelf:CreateSection("1. การเดิน")

local currentSpeed = 16
TabMySelf:CreateSlider({
   Name = "ultra speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "UltraSpeed",
   Callback = function(Value)
      currentSpeed = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local autoWalkEnabled = false
local autoWalkActive = false
local btnAutoWalk = CreateFloatingButton("👟")

TabMySelf:CreateToggle({
   Name = "auto walk",
   CurrentValue = false,
   Flag = "AutoWalkToggle",
   Callback = function(Value)
      autoWalkEnabled = Value
      btnAutoWalk.Visible = Value
      if not Value then autoWalkActive = false btnAutoWalk.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
   end,
})

btnAutoWalk.MouseButton1Click:Connect(function()
   autoWalkActive = not autoWalkActive
   btnAutoWalk.BackgroundColor3 = autoWalkActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 30)
end)

-- 2. การกระโดด
TabMySelf:CreateSection("2. การกระโดด")

local currentJumpPower = 50
TabMySelf:CreateSlider({
   Name = "ultra jump",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Jump",
   CurrentValue = 50,
   Flag = "UltraJump",
   Callback = function(Value)
      currentJumpPower = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.UseJumpPower = true
         LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

local autoJumpEnabled = false
local autoJumpActive = false
local btnAutoJump = CreateFloatingButton("🦘")

TabMySelf:CreateToggle({
   Name = "auto jump",
   CurrentValue = false,
   Flag = "AutoJumpToggle",
   Callback = function(Value)
      autoJumpEnabled = Value
      btnAutoJump.Visible = Value
      if not Value then autoJumpActive = false btnAutoJump.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
   end,
})

btnAutoJump.MouseButton1Click:Connect(function()
   autoJumpActive = not autoJumpActive
   btnAutoJump.BackgroundColor3 = autoJumpActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 30)
end)

local geppoEnabled = false
TabMySelf:CreateToggle({
   Name = "geppo",
   CurrentValue = false,
   Flag = "GeppoToggle",
   Callback = function(Value) geppoEnabled = Value end,
})

-- 3. ทะลุกำแพง & ล่องหน
TabMySelf:CreateSection("3. ทะลุกำแพง & ล่องหน")

local kamuiEnabled = false
TabMySelf:CreateToggle({
   Name = "kamui",
   CurrentValue = false,
   Flag = "KamuiToggle",
   Callback = function(Value) kamuiEnabled = Value end,
})

TabMySelf:CreateToggle({
   Name = "Invisibility (ล่องหน)",
   CurrentValue = false,
   Flag = "InvisToggle",
   Callback = function(Value)
      local char = LocalPlayer.Character
      if char then
         for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
               p.Transparency = Value and 1 or 0
            end
         end
      end
   end,
})

-- 4. บิน & อมตะ
TabMySelf:CreateSection("4. ระบบบิน & อมตะ")

local godModeEnabled = false
TabMySelf:CreateToggle({
   Name = "God Mode (อมตะ)",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
      godModeEnabled = Value
      if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
         LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
      end
   end,
})

local flySpeed = 5
TabMySelf:CreateSlider({
   Name = "Fly Speed",
   Range = {1, 100},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 5,
   Flag = "FlySpeed",
   Callback = function(Value) flySpeed = Value end,
})

local flyEnabled, flyKamuiEnabled = false, false
local bodyVelocity, bodyGyro = nil, nil

local function StopFly()
   if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
   if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
   if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
      LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
   end
end

local function StartFly()
   local char = LocalPlayer.Character
   if not char then return end
   local hrp = char:FindFirstChild("HumanoidRootPart")
   local hum = char:FindFirstChildOfClass("Humanoid")
   if not hrp or not hum then return end

   StopFly()
   hum.PlatformStand = true

   bodyVelocity = Instance.new("BodyVelocity")
   bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
   bodyVelocity.Velocity = Vector3.zero
   bodyVelocity.Parent = hrp

   bodyGyro = Instance.new("BodyGyro")
   bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
   bodyGyro.P = 10000
   bodyGyro.CFrame = hrp.CFrame
   bodyGyro.Parent = hrp
end

TabMySelf:CreateToggle({
   Name = "fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      flyEnabled = Value
      if flyEnabled then StartFly() else StopFly() end
   end,
})

TabMySelf:CreateToggle({
   Name = "fly kamui",
   CurrentValue = false,
   Flag = "FlyKamuiToggle",
   Callback = function(Value)
      flyKamuiEnabled = Value
      if flyKamuiEnabled then StartFly() else StopFly() end
   end,
})

-- 5. เติมแสง
TabMySelf:CreateSection("5. เติมแสง")

_G.FullBrightEnabled = false
if not _G.FullBrightExecuted then
   _G.NormalLightingSettings = {
      Brightness = Lighting.Brightness,
      ClockTime = Lighting.ClockTime,
      FogEnd = Lighting.FogEnd,
      GlobalShadows = Lighting.GlobalShadows,
      Ambient = Lighting.Ambient
   }
   _G.FullBrightExecuted = true
end

TabMySelf:CreateToggle({
   Name = "Night Vision VIP",
   CurrentValue = false,
   Flag = "NightVisionToggle",
   Callback = function(Value)
      _G.FullBrightEnabled = Value
      if Value then
         Lighting.Brightness = 1
         Lighting.ClockTime = 12
         Lighting.FogEnd = 786543
         Lighting.GlobalShadows = false
         Lighting.Ambient = Color3.fromRGB(178, 178, 178)
      else
         Lighting.Brightness = _G.NormalLightingSettings.Brightness
         Lighting.ClockTime = _G.NormalLightingSettings.ClockTime
         Lighting.FogEnd = _G.NormalLightingSettings.FogEnd
         Lighting.GlobalShadows = _G.NormalLightingSettings.GlobalShadows
         Lighting.Ambient = _G.NormalLightingSettings.Ambient
      end
   end,
})

-- ==========================================
-- TAB 2: ATTACK
-- ==========================================
local TabAttack = Window:CreateTab("⚔️ Attack", 4483362458)

-- Player Target Systems
TabAttack:CreateSection("Player Target Options")

local aimbotPlayerNearest = false
local btnAimbotNearest = CreateFloatingButton("🎯")

TabAttack:CreateToggle({
   Name = "Aimbot player (nearest)",
   CurrentValue = false,
   Flag = "AimbotNearestToggle",
   Callback = function(Value)
      aimbotPlayerNearest = Value
      btnAimbotNearest.Visible = Value
   end,
})

local consistentTarget = nil
local aimbotConsistent = false
TabAttack:CreateToggle({
   Name = "Aimbot player consistent",
   CurrentValue = false,
   Flag = "AimbotConsistentToggle",
   Callback = function(Value)
      aimbotConsistent = Value
      if Value then
         -- Find closest player and lock
         local closest = nil
         local maxDist = math.huge
         for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
               local dist = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
               if dist < maxDist then
                  maxDist = dist
                  closest = p
               end
            end
         end
         consistentTarget = closest
      else
         consistentTarget = nil
      end
   end,
})

-- ESP Player
local espPlayerEnabled = false
local espFolder = Instance.new("Folder", workspace)
espFolder.Name = "SmartMaster_ESP"

TabAttack:CreateToggle({
   Name = "Observation Haki (ESP Player)",
   CurrentValue = false,
   Flag = "ESPObservation",
   Callback = function(Value)
      espPlayerEnabled = Value
      if not Value then
         espFolder:ClearAllChildren()
      end
   end,
})

-- Chess Pieces & Player Actions
TabAttack:CreateSection("Chess Pieces (Select Player)")

local selectedPlayerName = nil
local playerDropdown = nil

local function GetPlayerNames()
   local names = {}
   for _, p in ipairs(Players:GetPlayers()) do
      if p ~= LocalPlayer then table.insert(names, p.Name) end
   end
   return #names > 0 and names or {"ไม่มีผู้เล่นอื่น"}
end

playerDropdown = TabAttack:CreateDropdown({
   Name = "chess pieces (เลือกผู้เล่น)",
   Options = GetPlayerNames(),
   CurrentOption = "เลือกผู้เล่น",
   Flag = "ChessPiecesDropdown",
   Callback = function(Option)
      if type(Option) == "table" then Option = Option[1] end
      selectedPlayerName = Option
   end,
})

TabAttack:CreateButton({
   Name = "refresh รายชื่อผู้เล่น",
   Callback = function()
      if playerDropdown then
         playerDropdown:Refresh(GetPlayerNames())
      end
   end,
})

local currentTween = nil
local tweenToPlayer = false
TabAttack:CreateToggle({
   Name = "Tween ไปหาผู้เล่นที่เลือก",
   CurrentValue = false,
   Flag = "TweenPlayerToggle",
   Callback = function(Value)
      tweenToPlayer = Value
      if not Value and currentTween then
         currentTween:Cancel()
         currentTween = nil
      end
   end,
})

local specPlayerEnabled = false
TabAttack:CreateToggle({
   Name = "แอบมองผู้เล่นที่เลือก (Spectate)",
   CurrentValue = false,
   Flag = "SpectatePlayerToggle",
   Callback = function(Value)
      specPlayerEnabled = Value
      if not Value then
         Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
      end
   end,
})

-- Mob Target Systems
TabAttack:CreateSection("Mob Target Options")

local aimbotMobNearest = false
TabAttack:CreateToggle({
   Name = "Aimbot mob (nearest)",
   CurrentValue = false,
   Flag = "AimbotMobNearest",
   Callback = function(Value) aimbotMobNearest = Value end,
})

local aimbotMobConsistent = false
local consistentMobTarget = nil
TabAttack:CreateToggle({
   Name = "Aimbot mob consistent (เล็งตัวเดิม)",
   CurrentValue = false,
   Flag = "AimbotMobConsistent",
   Callback = function(Value)
      aimbotMobConsistent = Value
      if not Value then consistentMobTarget = nil end
   end,
})

local espMobEnabled = false
TabAttack:CreateToggle({
   Name = "Observation Haki v2 (ESP Mob)",
   CurrentValue = false,
   Flag = "ESPMobToggle",
   Callback = function(Value)
      espMobEnabled = Value
      if not Value then
         for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "MobHighlight" then v:Destroy() end
         end
      end
   end,
})

-- ==========================================
-- BACKGROUND LOGICS & LOOPS
-- ==========================================

-- Geppo Air Jump
UserInputService.JumpRequest:Connect(function()
   if geppoEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
   end
end)

-- Stepped Loop (Kamui & GodMode)
RunService.Stepped:Connect(function()
   if (kamuiEnabled or flyKamuiEnabled or tweenToPlayer) and LocalPlayer.Character then
      for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
         if part:IsA("BasePart") then part.CanCollide = false end
      end
   end

   if godModeEnabled and LocalPlayer.Character then
      local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then
         hum.Health = hum.MaxHealth
         hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
      end
   end
end)

-- RenderStepped Main Loop
RunService.RenderStepped:Connect(function()
   local char = LocalPlayer.Character
   if not char then return end
   local hum = char:FindFirstChildOfClass("Humanoid")
   local hrp = char:FindFirstChild("HumanoidRootPart")

   -- Lock Speed & Jump
   if hum then
      if currentSpeed ~= 16 then hum.WalkSpeed = currentSpeed end
      if currentJumpPower ~= 50 then 
         hum.UseJumpPower = true
         hum.JumpPower = currentJumpPower 
      end
   end

   -- Auto Walk
   if autoWalkEnabled and autoWalkActive and hrp and hum then
      hum:Move(Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z), false)
   end

   -- Auto Jump
   if autoJumpEnabled and autoJumpActive and hum then
      hum.Jump = true
   end

   -- Flying Logic
   if (flyEnabled or flyKamuiEnabled) and hrp then
      if not bodyVelocity or not bodyGyro or bodyVelocity.Parent ~= hrp then StartFly() end
      local moveVector = hum and hum.MoveDirection or Vector3.zero
      local realVelocity = flySpeed * 10

      if moveVector.Magnitude > 0 then
         local camCFrame = Camera.CFrame
         local flyDirection = (camCFrame.LookVector * -moveVector.Z) + (camCFrame.RightVector * moveVector.X)
         if flyDirection.Magnitude > 0 then flyDirection = flyDirection.Unit end

         bodyVelocity.Velocity = flyDirection * realVelocity
         bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flyDirection) * CFrame.Angles(math.rad(-70), 0, 0)
      else
         bodyVelocity.Velocity = Vector3.zero
         bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
      end
   end

   -- Player Aimbot Nearest
   if aimbotPlayerNearest and hrp then
      local closest = nil
      local maxDist = math.huge
      for _, p in ipairs(Players:GetPlayers()) do
         if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if dist < maxDist then
               maxDist = dist
               closest = p
            end
         end
      end
      if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
         Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closest.Character.HumanoidRootPart.Position)
      end
   end

   -- Player Aimbot Consistent
   if aimbotConsistent and consistentTarget and consistentTarget.Character and consistentTarget.Character:FindFirstChild("HumanoidRootPart") then
      Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, consistentTarget.Character.HumanoidRootPart.Position)
   end

   -- Mob Aimbot (Nearest & Visible Only)
   if aimbotMobNearest and hrp then
      local closestMob = nil
      local maxDist = math.huge
      for _, obj in ipairs(workspace:GetDescendants()) do
         if obj:IsA("Humanoid") and obj.Parent ~= char and not Players:GetPlayerFromCharacter(obj.Parent) then
            local mobHrp = obj.Parent:FindFirstChild("HumanoidRootPart") or obj.Parent:FindFirstChild("Head")
            if mobHrp then
               local _, isVisible = Camera:WorldToScreenPoint(mobHrp.Position)
               if isVisible then
                  local ray = Ray.new(Camera.CFrame.Position, (mobHrp.Position - Camera.CFrame.Position).Unit * 500)
                  local hit = workspace:FindPartOnWithIgnoreList(ray, {char})
                  if hit and hit:IsDescendantOf(obj.Parent) then
                     local dist = (hrp.Position - mobHrp.Position).Magnitude
                     if dist < maxDist then
                        maxDist = dist
                        closestMob = mobHrp
                     end
                  end
               end
            end
         end
      end
      if closestMob then
         Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestMob.Position)
      end
   end

   -- Tween To Selected Player
   if tweenToPlayer and selectedPlayerName and hrp then
      local targetP = Players:FindFirstChild(selectedPlayerName)
      if targetP and targetP.Character and targetP.Character:FindFirstChild("HumanoidRootPart") then
         local targetHrp = targetP.Character.HumanoidRootPart
         local dist = (hrp.Position - targetHrp.Position).Magnitude
         if dist > 10 then
            local targetPos = targetHrp.Position - (targetHrp.Position - hrp.Position).Unit * 10
            local tweenInfo = TweenInfo.new(dist / 30, Enum.EasingStyle.Linear)
            if currentTween then currentTween:Cancel() end
            currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
            currentTween:Play()
         end
      end
   end

   -- Spectate Player
   if specPlayerEnabled and selectedPlayerName then
      local targetP = Players:FindFirstChild(selectedPlayerName)
      if targetP and targetP.Character and targetP.Character:FindFirstChild("Humanoid") then
         Camera.CameraSubject = targetP.Character.Humanoid
      end
   end
end)

-- ESP Players Loop
task.spawn(function()
   while task.wait(1) do
      if espPlayerEnabled then
         espFolder:ClearAllChildren()
         for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
               local box = Instance.new("Highlight")
               box.Name = "ESP_" .. p.Name
               box.Adornee = p.Character
               box.FillColor = Color3.fromRGB(255, 0, 0)
               box.OutlineColor = Color3.fromRGB(255, 255, 255)
               box.Parent = espFolder
            end
         end
      end

      if espMobEnabled then
         for _, obj in ipairs(workspace
