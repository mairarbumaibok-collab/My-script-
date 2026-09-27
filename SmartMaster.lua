-- =================================================================
-- SCRIPT NAME: SMART MASTER (RAYFIELD EDITION)
-- DEVELOPER: mairarbumaibok
-- =================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "SMART MASTER - ADMIN HUB",
   LoadingTitle = "SMART MASTER HUB",
   LoadingSubtitle = "by mairarbumaibok",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = { Enabled = false },
   KeySystem = false
})

-- ==========================================
-- TAB 1: MY SELF (ฟังก์ชันตัวละคร)
-- ==========================================
local TabMySelf = Window:CreateTab("👤 My Self", 4483362458)

-- --- 1. WALKING ---
TabMySelf:CreateSection("1. การเดิน (Walking)")

local currentSpeed = 16
TabMySelf:CreateSlider({
   Name = "Ultra Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      currentSpeed = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local autoWalkEnabled = false
TabMySelf:CreateToggle({
   Name = "Auto Walk (เดินแมพเอง)",
   CurrentValue = false,
   Flag = "AutoWalkToggle",
   Callback = function(Value)
      autoWalkEnabled = Value
   end,
})

-- --- 2. JUMPING ---
TabMySelf:CreateSection("2. การกระโดด (Jumping)")

local currentJumpPower = 50
TabMySelf:CreateSlider({
   Name = "Ultra Jump",
   Range = {50, 500},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      currentJumpPower = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.UseJumpPower = true
         LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

local autoJumpEnabled = false
TabMySelf:CreateToggle({
   Name = "Auto Jump (กระโดดรัวๆ)",
   CurrentValue = false,
   Flag = "AutoJumpToggle",
   Callback = function(Value)
      autoJumpEnabled = Value
   end,
})

local geppoEnabled = false
TabMySelf:CreateToggle({
   Name = "Geppo (Air Jump / กระโดดกลางอากาศ)",
   CurrentValue = false,
   Flag = "GeppoToggle",
   Callback = function(Value)
      geppoEnabled = Value
   end,
})

-- --- 3. NOCLIP & INVISIBILITY ---
TabMySelf:CreateSection("3. ทะลุกำแพง & ล่องหน")

local kamuiEnabled = false
TabMySelf:CreateToggle({
   Name = "Kamui (Noclip ทะลุสิ่งกีดขวาง)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      kamuiEnabled = Value
   end,
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

-- --- 4. GOD MODE ---
TabMySelf:CreateSection("4. ระบบอมตะ (God Mode)")

local godModeEnabled = false
TabMySelf:CreateToggle({
   Name = "God Mode (Lock Health / อมตะ)",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
      godModeEnabled = Value
      if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
         LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
      end
   end,
})

-- --- 5. PHYSICS FLY ---
TabMySelf:CreateSection("5. ระบบบิน (Physics Fly Mobile)")

local flySpeed = 5
TabMySelf:CreateSlider({
   Name = "Fly Speed (ความเร็วบิน)",
   Range = {1, 100},
   Increment = 1,
   Suffix = "x",
   CurrentValue = 5,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
      flySpeed = Value
   end,
})

local flyEnabled = false
local bodyVelocity, bodyGyro = nil, nil

local function StopPhysicsFly()
   if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
   if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
   if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
      LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
   end
end

local function StartPhysicsFly()
   local char = LocalPlayer.Character
   if not char then return end
   local hrp = char:FindFirstChild("HumanoidRootPart")
   local hum = char:FindFirstChildOfClass("Humanoid")
   if not hrp or not hum then return end

   StopPhysicsFly()
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
   Name = "Fly (บินเหินฟ้า)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      flyEnabled = Value
      if flyEnabled then StartPhysicsFly() else StopPhysicsFly() end
   end,
})

-- --- 6. NIGHT VISION ---
TabMySelf:CreateSection("6. เติมแสง (Night Vision VIP)")

TabMySelf:CreateToggle({
   Name = "Night Vision (แมพสว่าง)",
   CurrentValue = false,
   Flag = "NightVisionToggle",
   Callback = function(Value)
      if Value then
         Lighting.Ambient = Color3.fromRGB(255, 255, 255)
         Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
         Lighting.Brightness = 2
      else
         Lighting.Ambient = Color3.fromRGB(128, 128, 128)
         Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
         Lighting.Brightness = 1
      end
   end,
})

-- ==========================================
-- TAB 2: ATTACK & UTILITY (ระบบโจมตี/จัดการ)
-- ==========================================
local TabAttack = Window:CreateTab("⚔️ Attack", 4483362458)

TabAttack:CreateSection("Server Utilities")

TabAttack:CreateButton({
   Name = "Rejoin Server (เข้าเซิร์ฟใหม่)",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
   end,
})

-- ==========================================
-- BACKGROUND LOGIC LOOPS (ระบบประมวลผลเบื้องหลัง)
-- ==========================================

-- Jump Request for Geppo
UserInputService.JumpRequest:Connect(function()
   if geppoEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
   end
end)

-- Stepped Loop (GodMode & Noclip)
RunService.Stepped:Connect(function()
   if kamuiEnabled and LocalPlayer.Character then
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

-- RenderStepped Loop (Speed, Jump, Auto Walk/Jump, Flying)
RunService.RenderStepped:Connect(function()
   local char = LocalPlayer.Character
   if not char then return end
   local hum = char:FindFirstChild("Humanoid")
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
   if autoWalkEnabled and hrp and hum then
      hum:Move(Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z), false)
   end

   -- Auto Jump
   if autoJumpEnabled and hum then
      hum.Jump = true
   end

   -- Flying Logic
   if flyEnabled and hrp then
      local cam = workspace.CurrentCamera
      if not bodyVelocity or not bodyGyro or bodyVelocity.Parent ~= hrp then StartPhysicsFly() end

      local moveVector = hum and hum.MoveDirection or Vector3.zero
      local realVelocity = flySpeed * 10

      if moveVector.Magnitude > 0 then
         local camCFrame = cam.CFrame
         local flyDirection = (camCFrame.LookVector * -moveVector.Z) + (camCFrame.RightVector * moveVector.X)
         if flyDirection.Magnitude > 0 then flyDirection = flyDirection.Unit end

         bodyVelocity.Velocity = flyDirection * realVelocity
         bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flyDirection) * CFrame.Angles(math.rad(-70), 0, 0)
      else
         bodyVelocity.Velocity = Vector3.zero
         bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + cam.CFrame.LookVector)
      end
   end
end)

-- Notify Completed
Rayfield:Notify({
   Title = "SMART MASTER Ready!",
   Content = "โหลดฟังก์ชันทั้งหมดด้วย Rayfield UI สำเร็จแล้วครับ!",
   Duration = 5,
})
