--Nuclearcraft Fusion Reactor Controller
-- Version 0.0.2 by Zenthae

--  If reactor ON 
--      if heat or energy to hight => stop
--  if reactor OFF
--      if heat and energy low enough => start

local component = require("component")
local os = require("os")
local reactor = component.nc_fission_reactor

-- The Critical level of heat (value: 0 ~ 1. default: 0.90)
local CRITICAL_HEAT = 0.90
-- The Critical level of energy (value: 0 ~ 1. default: 0.90)
local CRITICAL_RF = 0.90
-- Refresh rate (in second. default: 0.5)
local refresh = 0.5

local MAX_HEAT = reactor.getMaxHeatLevel()
local MAX_RF = reactor.getMaxEnergyStored()

local current_heat = reactor.getHeatLevel()
local current_rf = reactor.getEnergyStored()

local activated = reactor.isProcessing()

function UpdateValues()
    current_heat = reactor.getHeatLevel()
    current_rf = reactor.getEnergyStored()
    activated = reactor.isProcessing()
end

while true do
    if activated then
        if (current_heat > (MAX_HEAT * CRITICAL_HEAT)) or (current_rf > (MAX_RF * CRITICAL_RF)) then
            reactor.deactivate()
        end
    else
        if (current_heat < (MAX_HEAT * CRITICAL_HEAT)) and (current_rf < (MAX_RF * CRITICAL_RF)) then
            reactor.activate()
        end
    end
    UpdateValues()
    os.sleep(refresh)
end

