--[[
	mysql - 1.0.3
	A simple MySQL wrapper for Garry's Mod.

	Alexander Grist-Hucker
	http://www.alexgrist.com


	The MIT License (MIT)

	Copyright (c) 2014 Alex Grist-Hucker

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
--]]
--- ## Serverside
-- Handles SQL module selection, SQL queries.
-- @module serverguard.mysql
serverguard.mysql = serverguard.mysql or {
    module = "sqlite"
}

local QueueTable = {}
local type = type
local tostring = tostring
local table = table

--[[
	Replacement tables
--]]
local Replacements = {
    sqlite = {
        Create = {
            {"UNSIGNED ", ""},
            {"NOT NULL AUTO_INCREMENT", ""}, -- assuming primary key
            {"AUTO_INCREMENT", ""},
            {"INT%(%d*%)", "INTEGER"},
            {"INT ", "INTEGER"}
        }
    }
}

--[[
	Phrases
--]]
local MODULE_NOT_EXIST = "[mysql] The %s module does not exist!\n"
--- Query class object that holds information about the current query being built.
-- @type QUERY_CLASS
local QUERY_CLASS = {}
QUERY_CLASS.__index = QUERY_CLASS

--- **This is called internally, use the corresponding methods.**
-- Creates a new query object.
-- @string tableName The name of the table to manipulate.
-- @string queryType The type of query to start building. (i.e CREATE, UPDATE, INSERT, etc.)
function QUERY_CLASS:New(tableName, queryType)
    local newObject = setmetatable({}, QUERY_CLASS)
    newObject.queryType = queryType
    newObject.tableName = tableName
    newObject.selectList = {}
    newObject.insertList = {}
    newObject.updateList = {}
    newObject.createList = {}
    newObject.whereList = {}
    newObject.orderByList = {}

    return newObject
end

--- Escapes the given string.
-- @string text The string to escape.
-- @treturn string The escaped string.
function QUERY_CLASS:Escape(text)
    return serverguard.mysql:Escape(tostring(text))
end

function QUERY_CLASS:ForTable(tableName)
    self.tableName = tableName
end

--- Adds a WHERE clause to the SQL query. Analagous to WhereEqual.
-- @string key The key to compare.
-- @string value The value to compare to.
function QUERY_CLASS:Where(key, value)
    self:WhereEqual(key, value)
end

--- Adds a "WHERE `column` = value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereEqual(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` = '" .. self:Escape(value) .. "'"
end

--- Adds a "WHERE `column` ~= value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereNotEqual(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` != '" .. self:Escape(value) .. "'"
end

--- Adds a "WHERE `column` LIKE value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereLike(key, value, format)
    format = format or "%%%s%%"
    self.whereList[#self.whereList + 1] = "`" .. key .. "` LIKE '" .. string.format(format, self:Escape(value)) .. "'"
end

--- Adds a "WHERE `column` NOT LIKE value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereNotLike(key, value, format)
    format = format or "%%%s%%"
    self.whereList[#self.whereList + 1] = "`" .. key .. "` NOT LIKE '" .. string.format(format, self:Escape(value)) .. "'"
end

--- Adds a "WHERE `column` > value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereGT(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` > '" .. self:Escape(value) .. "'"
end

--- Adds a "WHERE `column` < value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereLT(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` < '" .. self:Escape(value) .. "'"
end

--- Adds a "WHERE `column` >= value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereGTE(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` >= '" .. self:Escape(value) .. "'"
end

--- Adds a "WHERE `column` <= value" clause to the query.
-- You can use multiple of these statements to compare more than one column.
-- @string key The column to compare.
-- @string value The value to compare with.
function QUERY_CLASS:WhereLTE(key, value)
    self.whereList[#self.whereList + 1] = "`" .. key .. "` <= '" .. self:Escape(value) .. "'"
end

function QUERY_CLASS:WhereIn(key, value)
    value = istable(value) and value or {value}

    local values = ""
    local bFirst = true

    for k, v in pairs(value) do
        values = values .. (bFirst and "" or ", ") .. "'" .. self:Escape(v) .. "'"
        bFirst = false
    end

    self.whereList[#self.whereList + 1] = "`" .. key .. "` IN (" .. values .. ")"
end

--- Adds a "ORDER BY `column` DESC" clause to the query.
-- You can use multiple of these statements to sort by more than one column.
-- @string key The column to sort.
function QUERY_CLASS:OrderByDesc(key)
    self.orderByList[#self.orderByList + 1] = "`" .. key .. "` DESC"
end

--- Adds a "ORDER BY `column` ASC" clause to the query.
-- You can use multiple of these statements to sort by more than one column.
-- @string key The column to sort.
function QUERY_CLASS:OrderByAsc(key)
    self.orderByList[#self.orderByList + 1] = "`" .. key .. "` ASC"
end

--- Sets the function to be called when the query finishes.
-- @func queryCallback The callback function to execute.
function QUERY_CLASS:Callback(queryCallback)
    self.callback = queryCallback
end

--- Adds a "SELECT `column` FROM" clause to the query.
-- You can use multiple of these statements to select more than one column.
-- @string fieldName The column to select.
function QUERY_CLASS:Select(fieldName)
    self.selectList[#self.selectList + 1] = "`" .. fieldName .. "`"
end

--- Adds a "INSERT INTO `column` VALUES(value)" clause to the query.
-- @string key The column to insert into.
-- @string value The value to insert.
function QUERY_CLASS:Insert(key, value)
    self.insertList[#self.insertList + 1] = {"`" .. key .. "`", "'" .. self:Escape(value) .. "'"}
end

--- Adds a "UPDATE `column` SET key=value" clause to the query.
-- @string key The column to update.
-- @string value The value to update to.
function QUERY_CLASS:Update(key, value)
    self.updateList[#self.updateList + 1] = {"`" .. key .. "`", "'" .. self:Escape(value) .. "'"}
end

--- Populates the table create list with the given keys and values if the query is a CREATE query.
-- @string key The column to create.
-- @string value The value to set it to.
function QUERY_CLASS:Create(key, value)
    self.createList[#self.createList + 1] = {"`" .. key .. "`", value}
end

function QUERY_CLASS:Add(key, value)
    self.add = {"`" .. key .. "`", value}
end

function QUERY_CLASS:Drop(key)
    self.drop = "`" .. key .. "`"
end

--- Sets the primary key for the table.
-- @string key The primary key.
function QUERY_CLASS:PrimaryKey(key)
    self.primaryKey = "`" .. key .. "`"
end

--- Adds a "LIMIT value" clause to the query.
-- @number value The value to limit the query to.
function QUERY_CLASS:Limit(value)
    self.limit = value
end

--- Adds a "OFFSET value" clause to the query.
-- @number value The amount to offset by.
function QUERY_CLASS:Offset(value)
    self.offset = value
end

local function ApplyQueryReplacements(mode, query)
    if (not Replacements[serverguard.mysql.module]) then return query end
    local result = query
    local entries = Replacements[serverguard.mysql.module][mode]

    for i = 1, #entries do
        result = string.gsub(result, entries[i][1], entries[i][2])
    end

    return result
end

local function BuildSelectQuery(queryObj)
    local queryString = {"SELECT"}

    if (not istable(queryObj.selectList) or #queryObj.selectList == 0) then
        queryString[#queryString + 1] = " *"
    else
        queryString[#queryString + 1] = " " .. table.concat(queryObj.selectList, ", ")
    end

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " FROM `" .. queryObj.tableName .. "` "
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    if (istable(queryObj.whereList) and #queryObj.whereList > 0) then
        queryString[#queryString + 1] = " WHERE "
        queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ")
    end

    if (istable(queryObj.orderByList) and #queryObj.orderByList > 0) then
        queryString[#queryString + 1] = " ORDER BY "
        queryString[#queryString + 1] = table.concat(queryObj.orderByList, ", ")
    end

    if (isnumber(queryObj.limit)) then
        queryString[#queryString + 1] = " LIMIT "
        queryString[#queryString + 1] = queryObj.limit
    end

    return table.concat(queryString)
end

local function BuildInsertQuery(queryObj, bIgnore)
    local suffix = (bIgnore and (serverguard.mysql.module == "sqlite" and "INSERT OR IGNORE INTO" or "INSERT IGNORE INTO") or "INSERT INTO")

    local queryString = {suffix}

    local keyList = {}
    local valueList = {}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    for i = 1, #queryObj.insertList do
        keyList[#keyList + 1] = queryObj.insertList[i][1]
        valueList[#valueList + 1] = queryObj.insertList[i][2]
    end

    if (#keyList == 0) then return end
    queryString[#queryString + 1] = " (" .. table.concat(keyList, ", ") .. ")"
    queryString[#queryString + 1] = " VALUES (" .. table.concat(valueList, ", ") .. ")"

    return table.concat(queryString)
end

local function BuildUpdateQuery(queryObj)
    local queryString = {"UPDATE"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    if (istable(queryObj.updateList) and #queryObj.updateList > 0) then
        local updateList = {}
        queryString[#queryString + 1] = " SET"

        for i = 1, #queryObj.updateList do
            updateList[#updateList + 1] = queryObj.updateList[i][1] .. " = " .. queryObj.updateList[i][2]
        end

        queryString[#queryString + 1] = " " .. table.concat(updateList, ", ")
    end

    if (istable(queryObj.whereList) and #queryObj.whereList > 0) then
        queryString[#queryString + 1] = " WHERE "
        queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ")
    end

    if (isnumber(queryObj.offset)) then
        queryString[#queryString + 1] = " OFFSET "
        queryString[#queryString + 1] = queryObj.offset
    end

    return table.concat(queryString)
end

local function BuildDeleteQuery(queryObj)
    local queryString = {"DELETE FROM"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    if (istable(queryObj.whereList) and #queryObj.whereList > 0) then
        queryString[#queryString + 1] = " WHERE "
        queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ")
    end

    if (isnumber(queryObj.limit)) then
        queryString[#queryString + 1] = " LIMIT "
        queryString[#queryString + 1] = queryObj.limit
    end

    return table.concat(queryString)
end

local function BuildDropQuery(queryObj)
    local queryString = {"DROP TABLE"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    return table.concat(queryString)
end

local function BuildTruncateQuery(queryObj)
    local queryString = {"TRUNCATE TABLE"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    return table.concat(queryString)
end

local function BuildCreateQuery(queryObj)
    local queryString = {"CREATE TABLE IF NOT EXISTS"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    queryString[#queryString + 1] = " ("

    if (istable(queryObj.createList) and #queryObj.createList > 0) then
        local createList = {}

        for i = 1, #queryObj.createList do
            if (serverguard.mysql.module == "sqlite") then
                createList[#createList + 1] = queryObj.createList[i][1] .. " " .. ApplyQueryReplacements("Create", queryObj.createList[i][2])
            else
                createList[#createList + 1] = queryObj.createList[i][1] .. " " .. queryObj.createList[i][2]
            end
        end

        queryString[#queryString + 1] = " " .. table.concat(createList, ", ")
    end

    if (isstring(queryObj.primaryKey)) then
        queryString[#queryString + 1] = ", PRIMARY KEY"
        queryString[#queryString + 1] = " (" .. queryObj.primaryKey .. ")"
    end

    queryString[#queryString + 1] = " )"

    return table.concat(queryString)
end

local function BuildAlterQuery(queryObj)
    local queryString = {"ALTER TABLE"}

    if (isstring(queryObj.tableName)) then
        queryString[#queryString + 1] = " `" .. queryObj.tableName .. "`"
    else
        ErrorNoHalt("[mysql] No table name specified!\n")

        return
    end

    if (istable(queryObj.add)) then
        queryString[#queryString + 1] = " ADD " .. queryObj.add[1] .. " " .. ApplyQueryReplacements("Create", queryObj.add[2])
    elseif (isstring(queryObj.drop)) then
        if (serverguard.mysql.module == "sqlite") then
            ErrorNoHalt("[mysql] Cannot drop columns in sqlite!\n")

            return
        end

        queryString[#queryString + 1] = " DROP COLUMN " .. queryObj.drop
    end

    return table.concat(queryString)
end

--- Executes the query on the database.
-- @bool[opt] bQueueQuery Whether or not to queue the query. Defaults to false.
function QUERY_CLASS:Execute(bQueueQuery)
    local queryString = nil
    local queryType = string.lower(self.queryType)

    if (queryType == "select") then
        queryString = BuildSelectQuery(self)
    elseif (queryType == "insert") then
        queryString = BuildInsertQuery(self)
    elseif (queryType == "insert ignore") then
        queryString = BuildInsertQuery(self, true)
    elseif (queryType == "update") then
        queryString = BuildUpdateQuery(self)
    elseif (queryType == "delete") then
        queryString = BuildDeleteQuery(self)
    elseif (queryType == "drop") then
        queryString = BuildDropQuery(self)
    elseif (queryType == "truncate") then
        queryString = BuildTruncateQuery(self)
    elseif (queryType == "create") then
        queryString = BuildCreateQuery(self)
    elseif (queryType == "alter") then
        queryString = BuildAlterQuery(self)
    end

    if (isstring(queryString)) then
        if (not bQueueQuery) then
            return serverguard.mysql:RawQuery(queryString, self.callback)
        else
            return serverguard.mysql:Queue(queryString, self.callback)
        end
    end
end

--- Creates a new SELECT query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Select(tableName)
    return QUERY_CLASS:New(tableName, "SELECT")
end

--- Creates a new INSERT INTO query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Insert(tableName)
    return QUERY_CLASS:New(tableName, "INSERT")
end

function serverguard.mysql:InsertIgnore(tableName)
    return QUERY_CLASS:New(tableName, "INSERT IGNORE")
end

--- Creates a new UPDATE query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Update(tableName)
    return QUERY_CLASS:New(tableName, "UPDATE")
end

--- Creates a new DELETE query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Delete(tableName)
    return QUERY_CLASS:New(tableName, "DELETE")
end

--- Creates a new DROP query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Drop(tableName)
    return QUERY_CLASS:New(tableName, "DROP")
end

function serverguard.mysql:Truncate(tableName)
    return QUERY_CLASS:New(tableName, "TRUNCATE")
end

--- Creates a new CREATE TABLE query.
-- @string tableName The name of the table.
-- @treturn QUERY_CLASS The query object.
function serverguard.mysql:Create(tableName)
    return QUERY_CLASS:New(tableName, "CREATE")
end

function serverguard.mysql:Alter(tableName)
    return QUERY_CLASS:New(tableName, "ALTER")
end

--- Connects to the SQL database with the given information.
-- @string host The host name.
-- @string username The username.
-- @string password The password.
-- @string database The name of the database.
-- @number[opt] port The port to use. Defaults to 3306.
-- @string[opt] socket The unix socket to use. Defaults to none.
-- @number flags The query flags to use. Usually these aren't needed.
local UTF8MB4 = "ALTER DATABASE %s CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci"

function serverguard.mysql:Connect(host, username, password, database, port, socket, flags)
    port = port or 3306

    if (self.module == "mysqloo") then
        if (not istable(mysqloo)) then
            require("mysqloo")
        end

        if (mysqloo) then
            if (self.connection and self.connection:ping()) then return end
            self.connection = mysqloo.connect(host, username, password, database, port, socket or "", (flags or 0))

            self.connection.onConnected = function(database)
                local success, error_message = database:setCharacterSet("utf8mb4")

                if (not success) then
                    ErrorNoHalt("Failed to set MySQL encoding!\n")
                    ErrorNoHalt(error_message .. "\n")
                else
                    self:RawQuery(string.format(UTF8MB4, database))
                end

                serverguard.mysql:OnConnected()
            end

            self.connection.onConnectionFailed = function(database, errorText)
                serverguard.mysql:OnConnectionFailed(errorText)
            end

            self.connection:connect()

            timer.Create("serverguard.mysql.KeepAlive", 300, 0, function()
                self.connection:ping()
            end)
        else
            ErrorNoHalt(string.format(MODULE_NOT_EXIST, self.module))
        end
    elseif (self.module == "sqlite") then
        timer.Simple(0, function()
            serverguard.mysql:OnConnected()
        end)
    end
end

--- Sends a query to the database without any preprocessing. You should not use this unless
-- you know what you're doing.
-- @string query The query to run.
-- @func callback The function to call when the query finishes.
-- @number flags The flags to set on the query. Usually this isn't needed.
function serverguard.mysql:RawQuery(query, callback, flags, ...)
    if (self.module == "mysqloo") then
        local queryObj = self.connection:query(query)
        queryObj:setOption(mysqloo.OPTION_NAMED_FIELDS)

        queryObj.onSuccess = function(queryObj, result)
            if (callback) then
                local bStatus, value = pcall(callback, result, true, tonumber(queryObj:lastInsert()))

                if (not bStatus) then
                    error(string.format("[mysql] MySQL Callback Error!\n%s\n", value))
                end
            end
        end

        queryObj.onError = function(queryObj, errorText)
            ErrorNoHalt(string.format("[mysql] MySQL Query Error!\nQuery: %s\n%s\n", query, errorText))
        end

        queryObj:start()
    elseif (self.module == "sqlite") then
        local result = sql.Query(query)

        if (result == false) then
            error(string.format("[mysql] SQL Query Error!\nQuery: %s\n%s\n", query, sql.LastError()))
        else
            if (callback) then
                local bStatus, value = pcall(callback, result, true, tonumber(sql.QueryValue("SELECT last_insert_rowid()")))

                if (not bStatus) then
                    error(string.format("[mysql] SQL Callback Error!\n%s\n", value))
                end
            end
        end
    else
        ErrorNoHalt(string.format("[mysql] Unsupported module \"%s\"!\n", self.module))
    end
end

--- Adds a query to the queue to be executed once previously pending ones have finished.
-- @string queryString The query to run.
-- @func callback The function to run when the query executes.
function serverguard.mysql:Queue(queryString, callback)
    if (isstring(queryString)) then
        QueueTable[#QueueTable + 1] = {queryString, callback}
    end
end

--- Escapes the string to be used in a query.
-- @string text The string to escape.
-- @bool[opt] bNoQuotes Whether or not to NOT wrap with quotes. Defaults to false.
function serverguard.mysql:Escape(text)
    if (self.connection) then
        if (self.module == "mysqloo") then return self.connection:escape(text) end
    else
        return sql.SQLStr(text, true)
    end
end

-- A function to disconnect from the MySQL database.
function serverguard.mysql:Disconnect()
    if (self.connection) then
        if (self.module == "mysqloo") then
            self.connection:disconnect(true)
        end
    end
end

-- Function that's ran for checking the query queue.
function serverguard.mysql:Think()
    if (#QueueTable > 0) then
        if (istable(QueueTable[1])) then
            local queueObj = QueueTable[1]
            local queryString = queueObj[1]
            local callback = queueObj[2]

            if (isstring(queryString)) then
                self:RawQuery(queryString, callback)
            end

            table.remove(QueueTable, 1)
        end
    end
end

--- A function to set the SQL module to be used. This should not be set unless
-- you know what you're doing!
function serverguard.mysql:SetModule(moduleName)
    self.module = moduleName
end

-- Called when the database connects sucessfully.
function serverguard.mysql:OnConnected()
    serverguard.PrintConsole("[mysql] Connected to the database!\n")
	serverguard.PrintConsole("[mysql] Database Type: " .. self.module .. ".\n")

    timer.Create("serverguard.mysql.Think", 0.5, 0, function()
        serverguard.mysql:Think()
    end)

	hook.Call("serverguard.mysql.CreateTables", nil)

	timer.Simple(1, function()
		hook.Call("serverguard.mysql.OnConnected", nil)
	end)
end

-- Called when the database connection fails.
function serverguard.mysql:OnConnectionFailed(errorText)
    ErrorNoHalt(string.format("[mysql] Unable to connect to the database!\n%s\n", errorText))
    hook.Call("serverguard.mysql.DatabaseConnectionFailed", nil, errorText)
end

-- A function to check whether or not the module is connected to a database.
function serverguard.mysql:IsConnected()
    return self.module == "mysqloo" and (self.connection and self.connection:ping()) or self.module == "sqlite"
end

hook.Add("serverguard.Initialize", "serverguard.mysql.Initialize", function()
    local config = {
        host = "example.com",
        username = "example",
        password = "example",
        database = "serverguard",
        port = 3306
    }

    if (file.Exists("addons/serverguard_mysql.cfg", "MOD")) then
        config = util.KeyValuesToTable(file.Read("addons/serverguard_mysql.cfg", "MOD"))
    end

    SERVERGUARD.STEAM_APIKEY = SERVERGUARD.STEAM_APIKEY or config.steam_apikey
    serverguard.mysql:SetModule(config.module or "sqlite")
    serverguard.mysql:Connect(config.host, config.username, config.password, config.database, config.port, config.unixsocket)
end)

hook.Add("serverguard.mysql.CreateTables", "serverguard.mysql.CreateTables", function()
    local query = serverguard.mysql:Create("serverguard_users")
		query:Create("id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("steam_id", "VARCHAR(25) NOT NULL")
		query:Create("rank", "VARCHAR(255) DEFAULT \"\" NOT NULL")
		query:Create("name", "VARCHAR(255) NOT NULL")
		query:Create("last_played", "INT(11) UNSIGNED DEFAULT NULL")
		query:Create("data", "TEXT")
		query:PrimaryKey("id")
    query:Execute()

    query = serverguard.mysql:Create("serverguard_bans")
		query:Create("id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("steam_id", "VARCHAR(25) NOT NULL")
		query:Create("community_id", "TEXT NOT NULL")
		query:Create("player", "VARCHAR(255) NOT NULL")
		query:Create("reason", "TEXT NOT NULL")
		query:Create("start_time", "INT(11) NOT NULL")
		query:Create("end_time", "INT(11) NOT NULL")
		query:Create("admin", "VARCHAR(255) NOT NULL")
		query:Create("ip_address", "VARCHAR(15) NOT NULL")
		query:PrimaryKey("id")
    query:Execute()
end)