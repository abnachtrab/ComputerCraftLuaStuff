while true do
    for i = 1, 16 do
        turtle.select(i)
        if not turtle.refuel(0) or turtle.getFuelLevel() >= turtle.getFuelLimit() then
            turtle.dropDown()
        else
            turtle.refuel()
            turtle.dropDown()
        end
    end
    if turtle.getFuelLevel() <= turtle.getFuelLimit() then
        turtle.select(1)
        repeat
            turtle.suckUp()
            turtle.refuel()
        until not turtle.suckUp() or turtle.getFuelLevel() >= turtle.getFuelLimit()
        turtle.dropUp()
    end
    turtle.up()
    for i = 1, 8 do
        for j = 1, i do
            turtle.forward()
        end
        turtle.turnRight()
        for j = 1, i do
            turtle.forward()
        end
        turtle.turnRight()
    end
    turtle.down()
end