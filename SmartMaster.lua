-- =================================================================
-- SCRIPT NAME: SMART MASTER (RAYFIELD FULL HUB)
-- THEME: Minimalist Dark Rayfield
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
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- =================================================================
-- TAB 1: MY SELF
-- =================================================================
local Tab1 = Window:CreateTab("👤 My Self", 4483362458)

-- --- 1. Walking Controls ---
Tab1:CreateSection("1. การเดิน (Walking)")

local currentSpeed = 16
Tab1:CreateSlider({
   Name = "Ultra Speed (ความเร็วเดิน)",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      currentSpeed = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local autoWalkEnabled = false
Tab1:CreateToggle({
   Name = "Auto Walk (เดินอัตโนมัติ)",
   CurrentValue = false,
   Flag = "AutoWalkToggle",
   Callback = function(Value)
      autoWalkEnabled = Value
   end,
})

RunService.RenderStepped:Connect(function()
   if autoWalkEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
      local hrp = LocalPlayer.Character.HumanoidRootPart
      LocalPlayer.Character.Humanoid:Move(Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z), false)
   end
   if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      if LocalPlayer.Character.Humanoid.WalkSpeed ~= currentSpeed and currentSpeed ~= 16 then
         LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
      end
   end
end)

-- --- 2. Jumping Controls ---
Tab1:CreateSection("2. การกระโดด (Jumping)")

local currentJumpPower = 50
Tab1:CreateSlider({
   Name = "Ultra Jump (พลังกระโดด)",
   Range = {50, 500},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      currentJumpPower = Value
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.UseJumpPower = true
         LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

local autoJumpEnabled = false
Tab1:CreateToggle({
   Name = "Auto Jump (กระโดดรัวๆ)",
   CurrentValue = false,
   Flag = "AutoJumpToggle",
   Callback = function(Value)
      autoJumpEnabled = Value
   end,
})

local geppoEnabled = false
Tab1:CreateToggle({
   Name = "Geppo (Air Jump - กระโดดกลางอากาศ)",
   CurrentValue = false,
   Flag = "GeppoToggle",
   Callback = function(Value)
      geppoEnabled = Value
   end,
})

UserInputService.JumpRequest:Connect(function()
   if geppoEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
   end
end)

RunService.RenderStepped:Connect(function()
   if autoJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid.Jump = true
   end
   if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      if currentJumpPower ~= 50 then
         LocalPlayer.Character.Humanoid.UseJumpPower = true
         LocalPlayer.Character.Humanoid.JumpPower = currentJumpPower
      end
   end
end)

-- --- 3. Noclip & Invisibility ---
Tab1:CreateSection("3. ทะลุกำแพง & ล่องหน")

local kamuiEnabled = false
Tab1:CreateToggle({
   Name = "Kamui (Noclip ทะลุสิ่งกีดขวาง)",
   CurrentValue = false,
   Flag = "KamuiToggle",
   Callback = function(Value)
      kamuiEnabled = Value
   end,
})

Tab1:CreateToggle({
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

-- --- 4. God Mode ---
Tab1:CreateSection("4. ระบบอมตะ (God Mode)")

local godModeEnabled = false
Tab1:CreateToggle({
   Name = "God Mode (Lock Health เลือดไม่ลด)",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
      godModeEnabled = Value
      if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
         LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
      end
   end,
})

RunService.Stepped:Connect(function()
   if (kamuiEnabled or flyKamuiEnabled) and LocalPlayer.Character then
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

-- --- 5. Physics Fly ---
Tab1:CreateSection("5. ระบบบิน (Physics Fly Mobile)")

local flySpeed = 5
Tab1:CreateSlider({
   Name = "Fly Speed (ความเร็วบิน)",
   Range = {1, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 5,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
      flySpeed = Value
   end,
})

local flyEnabled, flyKamuiEnabled = false, false
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

Tab1:CreateToggle({
   Name = "Fly (Superman Flight บินธรรมดา)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      flyEnabled = Value
      if flyEnabled then StartPhysicsFly() else StopPhysicsFly() end
   end,
})

Tab1:CreateToggle({
   Name = "Fly Kamui (Noclip Fly บินทะลุตึก)",
   CurrentValue = false,
   Flag = "FlyKamuiToggle",
   Callback = function(Value)
      flyKamuiEnabled = Value
      if flyKamuiEnabled then StartPhysicsFly() else StopPhysicsFly() end
   end,
})

RunService.RenderStepped:Connect(function()
   local isFlying = flyEnabled or flyKamuiEnabled
   if isFlying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
      local char = LocalPlayer.Character
      local hrp = char.HumanoidRootPart
      local hum = char:FindFirstChildOfClass("Humanoid")
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

-- --- 6. Night Vision ---
Tab1:CreateSection("6. เติมแสง (Night Vision VIP)")

Tab1:CreateToggle({
   Name = "FullBright (มองในที่มืด)",
   CurrentValue = false,
   Flag = "FullBrightToggle",
   Callback = function(Value)
      if Value then
         Lighting.Ambient = Color3.fromRGB(255, 255, 255)
         Lighting.Brightness = 2
         Lighting.ClockTime = 14
      else
         Lighting.Ambient = Color3.fromRGB(127, 127, 127)
         Lighting.Brightness = 1
      end
   end,
})

-- =================================================================
-- TAB 2: UTILITIES & ATTACK
-- =================================================================
local Tab2 = Window:CreateTab("⚔️ Attack / Util", 4483362458)

Tab2:CreateSection("Server Utilities")

Tab2:CreateButton({
   Name = "Rejoin Server (เข้าเซิร์ฟเดิมใหม่)",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
   end,
})

-- Notification
Rayfield:Notify({
   Title = "SMART MASTER Ready!",
   Content = "โหลดฟังก์ชันทั้งหมดเรียบร้อยแล้วครับ!",
   Duration = 5,
})
