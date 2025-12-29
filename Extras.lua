-- Extras.lua | AFSE Modular Script (Personal Features)

return function(Tabs, Fluent)

    -- Wind Grimore Loop Toggle
    local WindGrimoreLoopEnabled = false
    
    Tabs.Extras:AddToggle("WindGrimoreLoop", {
        Title = "Wind Grimore Loop",
        Default = false,
        Callback = function(state)
            WindGrimoreLoopEnabled = state
            if state then
                spawn(function()
                    while WindGrimoreLoopEnabled do
                        local args = {
                            "UseSpecialPower",
                            Enum.KeyCode.Z
                        }
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                        end)
                        wait(1.55)
                    end
                end)
                
                Fluent:Notify({
                    Title = "Wind Grimore Loop",
                    Content = "Enabled - Spamming Z power!",
                    Duration = 4
                })
            else
                Fluent:Notify({
                    Title = "Wind Grimore Loop",
                    Content = "Disabled",
                    Duration = 3
                })
            end
        end
    })

    -- Farm Position Gen Button
    Tabs.Extras:AddButton({
        Title = "Farm Position Gen",
        Description = "Teleports you to the optimal Gen farming spot",
        Callback = function()
            local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                Fluent:Notify({Title = "Error", Content = "Character not loaded!", Duration = 5})
                return
            end
            
            local hrp = character.HumanoidRootPart
            local targetPos = Vector3.new(-424.06512451171875, 60.99999237060547, 723.4719848632812)
            
            hrp.CFrame = CFrame.new(targetPos)
            
            Fluent:Notify({
                Title = "Teleported",
                Content = "Successfully teleported to Gen farm position!",
                Duration = 4
            })
        end
    })

end