require("io")

File = {
  exists = function (path)
    local fd = io.open(path, "r")
    if fd ~= nil then
      io.close(fd)
      return true
    end

    return false
  end
}
