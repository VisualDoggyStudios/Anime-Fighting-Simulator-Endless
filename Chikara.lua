-- Chikara.lua | AFSE Modular Script

return function(Tabs, Fluent)

    Tabs.Chikara:AddParagraph({
        Title = "Important Note",
        Content = "Works perfectly with GUI open — no minimizing needed!"
    })

    local AutoFarmChikaraEnabled = false

    Tabs.Chikara:AddToggle("AutoFarmChikara", {
        Title = "Auto Farm Chikara Box",
        Default = false,
        Callback = function(state)
            AutoFarmChikaraEnabled = state
            if state then
                spawn(function()
                    while AutoFarmChikaraEnabled do
                        local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                        local hrp = character:WaitForChild("HumanoidRootPart")
                        local folder = workspace.Scriptable.ChikaraBoxes
                        
                        local closestBox = nil
                        local closestDist = math.huge
                        
                        for _, box in ipairs(folder:GetChildren()) do
                            local clickBox = box:FindFirstChild("ClickBox")
                            if clickBox then
                                local clickDetector = clickBox:FindFirstChild("ClickDetector")
                                if clickDetector then
                                    local dist = (hrp.Position - clickBox.Position).Magnitude
                                    if dist < closestDist then
                                        closestDist = dist
                                        closestBox = box
                                    end
                                end
                            end
                        end
                        
                        if closestBox then
                            local clickBox = closestBox.ClickBox
                            local clickDetector = clickBox.ClickDetector
                            
                            hrp.CFrame = clickBox.CFrame
                            
                            fireclickdetector(clickDetector)
                            wait(0.5)
                            fireclickdetector(clickDetector)
                        else
                            wait(0.5)
                        end
                    end
                end)
                
                Fluent:Notify({
                    Title = "Chikara Farm",
                    Content = "Auto farming Chikara boxes enabled!",
                    Duration = 4
                })
            else
                Fluent:Notify({
                    Title = "Chikara Farm",
                    Content = "Disabled",
                    Duration = 3
                })
            end
        end
    })

end