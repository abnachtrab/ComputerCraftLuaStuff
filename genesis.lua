local minFuel = 100
local rowLength = 6
local numRows = 1  --- Note: One row == two crops on each side
---   T = Turtle (with a fuel chest under it, optionally waterlogged)
---   C = Chest
---   P = Plant (with air above it)
---   O = Air (Optionally, with water below)
---   Example with rowLength=6 and numRows=2
---   PPPPPP
---   OOOOOTC
---   PPPPPP
---   PPPPPP
---   OOOOOO
---   PPPPPP
---
local hand = peripheral.find("weakAutomata")
if not hand then
    print("Please attach a Weak Automata Core from Advanced Peripherals!")
else
    hand.setFuelConsumptionRate(2)
    while true do
        print("Fuel: "..turtle.getFuelLevel().."/"..turtle.getFuelLimit())
        if turtle.getFuelLevel() <= turtle.getFuelLimit() then
            turtle.select(15)
            local canSuck = true
            repeat
                canSuck = turtle.suckDown()
                turtle.refuel()
            until not canSuck or turtle.getFuelLevel() >= turtle.getFuelLimit()
            turtle.dropDown()
        end
        if turtle.getFuelLevel() < minFuel then
            print("Out of fuel!")
            break
        end
        turtle.turnLeft()
        turtle.select(16)
        for i = 1, numRows do
            for j = 1, rowLength-1 do
                local worked = false
                repeat
                    worked = hand.useOnBlock()
                until worked
                turtle.suck()
                turtle.turnLeft()
                turtle.forward()
                turtle.turnRight()
            end
            turtle.turnLeft()
            turtle.turnLeft()
            for j = 1, rowLength-1 do
                local worked = false
                repeat
                    worked = hand.useOnBlock()
                until worked
                turtle.suck()
                turtle.turnLeft()
                turtle.forward()
                turtle.turnRight()
            end
            if i < numRows then
                turtle.up()
                turtle.forward()
                turtle.forward()
                turtle.forward()
                turtle.down()
                turtle.turnLeft()
                turtle.turnLeft()
            elseif numRows > 1 then
                turtle.turnLeft()
                turtle.turnLeft()
                turtle.up()
                for j = 1, i*3-1 do
                    turtle.forward()
                end
                turtle.down()
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
        end
        for i = 1, 15 do
            turtle.select(i)
            if not turtle.refuel(0) or turtle.getFuelLevel() >= turtle.getFuelLimit() then
                turtle.drop()
            else
                turtle.refuel()
                turtle.drop()
            end
        end
    end
end
