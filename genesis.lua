local minFuel = 100
print("Fuel: "..turtle.getFuelLevel().."/"..turtle.getFuelLimit())
while true do
    for i = 1, 16 do
        turtle.select(i)
        if not turtle.refuel(0) or turtle.getFuelLevel() >= turtle.getFuelLimit() then
            turtle.dropUp()
        else
            turtle.refuel()
            turtle.dropUp()
        end
    end
    if turtle.getFuelLevel() <= turtle.getFuelLimit() then
        turtle.select(1)
        repeat
            turtle.suckDown()
            turtle.refuel()
        until not turtle.suckUp() or turtle.getFuelLevel() >= turtle.getFuelLimit()
        turtle.dropDown()
    end
    if turtle.getFuelLevel() < minFuel then
        print("Out of fuel! Please place me on a chest with fuel inside!")
        break
    end
    turtle.up()
    for j = 1, 8 do
        for k = 1, j do
            turtle.forward()
        end
        turtle.turnRight()
        for l = 1, j do
            turtle.forward()
        end
        turtle.turnRight()
    end
    turtle.down()
end
