-- โหลด Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- สร้างหน้าต่างหลัก SMART MASTER
local Window = Rayfield:CreateWindow({
   Name = "SMART MASTER - Admin Hub",
   LoadingTitle = "SMART MASTER",
   LoadingSubtitle = "by mairarbumaibok",
   ConfigurationSaving = { Enabled = false }
})

-- TAB 1: MY SELF
local Tab1 = Window:CreateTab("My Self", 4483362458)

Tab1:CreateSection("Movement Controls")

Tab1:CreateSlider({
   Name = "WalkSpeed (ความเร็วเดิน)",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

Tab1:CreateSlider({
   Name = "JumpPower (พลังกระโดด)",
   Range = {50, 500},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- TAB 2: UTILITIES
local Tab2 = Window:CreateTab("Utilities", 4483362458)

Tab2:CreateButton({
   Name = "Rejoin Server (เข้าเซิร์ฟใหม่)",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

Rayfield:Notify({
   Title = "SMART MASTER Ready!",
   Content = "โหลดสคริปต์สำเร็จ!",
   Duration = 5,
})
