local args = { ... }
local url
local exit = false
if args[1] then
    -- Save args[1] to ".gitFromGit" and set the "url" variable
    local file = fs.open(".gitFromGit", "w")
    file.writeLine(args[1])
    file.close()
    url = args[1]
elseif fs.exists(".gitFromGit") then
    -- Set "url" to the first line of ".gitFromGit"
    local file = fs.open(".gitFromGit", "r")
    url = file.readLine()
    file.close()
else
    -- Display usage and exit with error code 1
    print("Usage: git <URL>")
    exit = true
end

if not exit then
    if not url or not url:match("^https?://") then
        print("Error: Invalid URL")
        exit = true
    end
end

if not exit then
    local response = http.get(url)
    if response then
        local responseBody = response.readAll()
        response.close()
    	local file = fs.open(url:match("/([^/]+)$") or "output.txt", "w")
    	file.write(responseBody)
        file.close()
    else
        print("Error: Unable to connect to URL")
    end
end
