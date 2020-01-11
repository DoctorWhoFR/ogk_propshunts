Logger = {}

function Logger.info(file, message, id)
    print("-----------LOGGER v1.0 -------------")
    print("-------------INFOS------------------")
    print("[OGK LOGGER] FILE --> " .. file)
    print("[OGK LOGGER] MSG --> " .. message)
    print("[OGK LOGGER] id --> " .. id)
    print("------------------------------------")
end

function Logger.warning(file, message)
    print("-----------WARNING-----------------")
    print("[OGK LOGGER] FILE --> " .. file)
    print("[OGK LOGGER] MSG --> " .. message)
    print("[OGK LOGGER] id --> " .. id)
    print("------------------------------------")
end

function Logger.setter(file, message, old, newvalue)
    print("-----------LOGGER v1.0 -------------")
    print("---------SETTER FUNCTIONS-----------")
    print("[OGK LOGGER] FILE --> " .. file)
    print("[OGK LOGGER] MSG --> " .. message)
    print("[OGK LOGGER] old --> " .. old)
    print("[OGK LOGGER] new --> " .. newvalue)
    print("------------------------------------")
end