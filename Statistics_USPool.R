#==========================================================================================================
#
# Libraries and connections
#
#==========================================================================================================


library(RODBC)
library(RODBCext)
library(stringr)
library(lubridate)

# Loading functions
source('C:/bin/r_stuff/Stats_queries_USPool.R')

# Set Connections
usdbsvr9 <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;trusted_connection=true')

#==========================================================================================================
#
# GET STATS PARAMETERS
# ======================== 
#
# NECESSARY:
# ModelId -> uniquely identifies model. Also used to define many other options if undefined
# 
# 
# OPTIONAL:
#  
# DbTZ -> Timezone of data in db. Default "UTC". Other options are "GMT","UTC", "UTC+1" or "UTC+2". 
# DbId  -> points to the correct database for load and fcst tables. Default 2 letter acronym from ModelId
# DbIdStats  -> points to the correct stats database. Default EuropoolStats
# 
# LoadActTable -> Load act table name.Default {ModelId}_load_act
# LoadRollTable -> Rollback table name.Default {ModelId}_{""/ISO}_load_fcst_r
# StatsTable -> Output stats table name.Default "{TESLA/ISO}_{ModelId}_<X>_DA" . 
# set it as <X> if looping accross multiple DaysAhead  to save the results in multiple tables 
# 
# DaysAhead -> Set historical data. Default is 1 DA. Can be also set as a vector, for example c(1,2,3,7,14)
# CompareTime -> Hour and in "HH:MM" of the historic forecast. Default is "06:30"
#
# Granularity -> Model Granularity. Default is 'H'. Other options are 'HH' or 'QH'
# InstantLoad -> logic TRUE or FALSE indication if load is instantaneous. Default is FALSE. 
# DbSvr ->  Db Server for load and fcst tables. Options are ukdbsvr2 or ukdbsvr3. Default ukdbsvr3
# DbSvrStats ->  Db Server stats tables. Options are ukdbsvr2 or ukdbsvr3. Default ukdbsvr3
# SolveDays -> Set how many days to update. Default 1:10
#
# TradingParts -> What Trading Parts to calulate. Options "UK" or "EU". Default "EU"
# CreateTable -> Creates stats table if it doesn't exsists. By default this is turned off. 
# BadDays -> Ignore day(s). Set in format 'YYYMMDD'. Default is NULL
# TSO -> logic TRUE or FALSE. 
#
# =========================================================================================================
#
# WX ERROR ADITIONAL PARAMETERS (GetWXStats):
#=============================================
# 
# Default to same value as in get stats if not specified differently !!!
# 
# NECCESARY:
#
# ErrorType -> Select between "S1", "BACKCAST" and WX
# 
# OPTIONAL:  
# 
# StatsTable -> Output stats table name. Default "{ErrorType}_{ModelId}_<X>_DA" 
# TSO        -> not a valid parameter
# LoadRollTable -> Rollback table name. Default "{ModelId}_s1_load_fcst_r" if ErrorType ="S1" else "{ModelId}_modeld<D>_load_fcst_r".
# LoadBackcastTable -> Only option if ErrorType = "WX". Defult set as {ModelId}_modeld<D>_load_fcst_r
#
#
#==========================================================================================================
#
# HOURLY US MODELS - HOUR ENDING 
#==========================================================================================================
###CONTINUE SCRIPT RUNNING THROUGH NON-ESSENTIAL ERRORS

continue_on_error <- function()
{
  print("NONESSENTIAL ERROR IN MODEL BUILD")
  }

options(error=continue_on_error)

#====================
# CAISO
#====================

#CAISO TOTAL
GetStats(ModelId = "caiso_total" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_total" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO TOTAL
GetStats(ModelId = "caiso_total" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_total" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_AZPS
GetStats(ModelId = "caiso_azps" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_azps" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_AZPS
GetStats(ModelId = "caiso_azps" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_azps" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_NEVP
GetStats(ModelId = "caiso_nevp" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_nevp" , DaysAhead = 1, DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_NEVP
GetStats(ModelId = "caiso_nevp" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_nevp" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_PGE
GetStats(ModelId = "caiso_pge" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_pge" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_PGE
GetStats(ModelId = "caiso_pge" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_pge" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_PSEI
GetStats(ModelId = "caiso_psei" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_psei" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_PSEI
GetStats(ModelId = "caiso_psei" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_psei" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_SCE
GetStats(ModelId = "caiso_sce" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_sce" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_SCE
GetStats(ModelId = "caiso_sce" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_sce" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_SDGE
GetStats(ModelId = "caiso_sdge" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_sdge" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_SDGE
GetStats(ModelId = "caiso_sdge" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_sdge" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")

# CAISO_VEA
GetStats(ModelId = "caiso_vea" , DaysAhead = 0, CompareTime = "00:00", DbId = "caiso", DbTZ="UTC-8") # Intraday
GetStats(ModelId = "caiso_vea" , DaysAhead = c(1,2,3,4), DbId = "caiso", DbTZ="UTC-8")

# RTO CAISO_VEA
GetStats(ModelId = "caiso_vea" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "caiso", DbTZ="UTC-8")
GetStats(ModelId = "caiso_vea" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "caiso", DbTZ="UTC-8")


#====================
# AESO
#====================

# CA_AESO
GetStats(ModelId = "ca_aeso" , LoadActTable = "ca_aeso_load_act", DaysAhead = 0, CompareTime = "00:00", DbId = "aeso", DbTZ="UTC-7") # Intraday
GetStats(ModelId = "ca_aeso" , LoadActTable = "ca_aeso_load_act", DaysAhead = c(1,2,3,4), DbId = "aeso", DbTZ="UTC-7")

# RTO CA_AESO
GetStats(ModelId = "ca_aeso" , LoadActTable = "ca_aeso_load_act", LoadRollTable = "ca_aeso_iso_load_fcst_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "aeso", DbTZ="UTC-7") # Intraday
GetStats(ModelId = "ca_aeso" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "aeso", DbTZ="UTC-7") #not working for DA=2,3,4

#====================
# IESO
#====================

# CA_ONT_IESO_MKT
GetStats(ModelId = "ca_ont_ieso_mkt", DaysAhead = 0, CompareTime = "00:00", DbId = "ieso", DbTZ="UTC-5") # Intraday
GetStats(ModelId = "ca_ont_ieso_mkt", DaysAhead = c(1,2,3,4), DbId = "ieso", DbTZ="UTC-5")

# RTO CA_ONT_IESO_MKT
GetStats(ModelId = "ca_ont_ieso_mkt" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ieso", DbTZ="UTC-5")
GetStats(ModelId = "ca_ont_ieso_mkt" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "ieso", DbTZ="UTC-5")

# CA_ONT_IESO_TOTAL
GetStats(ModelId = "ca_ont_ieso_total", DaysAhead = 0, CompareTime = "00:00", DbId = "ieso", DbTZ="UTC-5") # Intraday
GetStats(ModelId = "ca_ont_ieso_total", DaysAhead = c(1,2,3,4), DbId = "ieso", DbTZ="UTC-5")

# RTO CA_ONT_IESO_TOTAL
GetStats(ModelId = "ca_ont_ieso_total" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ieso", DbTZ="UTC-5")
GetStats(ModelId = "ca_ont_ieso_total" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "ieso", DbTZ="UTC-5")

#====================
# ERCOT
#====================

# TOTAL ERCOT_TOTAL_RT 4-regional split
GetStats(ModelId = "ercot_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_total_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")

# TOTAL ERCOT_TOTAL_RT 8-zones split
GetStats(ModelId = "ercot_zones_total_rt", LoadActTable = "ercot_total_rt_zones_load_act", LoadRollTable = "ercot_total_rt_zones_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_zones_total_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")

# RTO ERCOT_TOTAL_RT
GetStats(ModelId = "ercot_total_rt" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_total_rt" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")

#REGIONAL TOTALS
GetStats(ModelId = "ercot_east_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_north_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_south_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_west_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday

GetStats(ModelId = "ercot_east_total_rt", DaysAhead = 0, DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_north_total_rt", DaysAhead = 0, DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_south_total_rt", DaysAhead = 0, DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_west_total_rt", DaysAhead = 0, DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")

# REGIONAL MODELS
GetStats(ModelId = "ercot_coast_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_east_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_farwest_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_north_c_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_north_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_southern_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_south_c_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_west_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "ercot", DbTZ="UTC-6") # Intraday

GetStats(ModelId = "ercot_coast_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_east_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_farwest_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_north_c_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_north_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_southern_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_south_c_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_west_rt", DaysAhead = c(1,2,3,4), DbId = "ercot", DbTZ="UTC-6")


# RTO REGIONAL MODELS
GetStats(ModelId = "ercot_coast_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_east_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_farwest_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_north_c_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_north_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_southern_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_south_c_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday
GetStats(ModelId = "ercot_west_rt", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "ercot", DbTZ="UTC-6") # Intraday

GetStats(ModelId = "ercot_coast_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_east_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_farwest_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_north_c_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_north_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_southern_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_south_c_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")
GetStats(ModelId = "ercot_west_rt", DaysAhead = c(1,2,3,4), TSO = T, DbId = "ercot", DbTZ="UTC-6")

#====================
# MISO 
#====================

# TOTAL MISO_TOTAL_RT 
GetStats(ModelId = "miso_total_rt", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_total_rt", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 

# TOTAL MISO_TOTAL  
GetStats(ModelId = "miso_total", LoadActTable = "miso_total_load_act", LoadRollTable = "miso_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_total", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 

# TOTAL LRZ MISO_TOTAL  
GetStats(ModelId = "miso_lrz_total", LoadActTable = "miso_total_load_act", LoadRollTable = "miso_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_total", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 

# RTO MISO_TOTAL
GetStats(ModelId = "miso_total" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_total" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")

# TOTAL MISO_WIND  
GetStats(ModelId = "miso_wind", LoadActTable = "miso_wind_load_act", LoadRollTable = "miso_wind_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_wind", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 

# RTO MISO_WIND
GetStats(ModelId = "miso_wind" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_wind" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")

# REGIONAL TOTALS
GetStats(ModelId = "miso_central", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_north", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_south", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "miso_central",DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_north",DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")  
GetStats(ModelId = "miso_south", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")  

# RTO REGIONAL TOTALS
GetStats(ModelId = "miso_central", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_north", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_south", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "miso_central",  DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_north",  DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")  
GetStats(ModelId = "miso_south",  DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")

# ZONAL MODELS
GetStats(ModelId = "miso_lrz_1", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_2_7", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_3_5", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_4", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_6", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_8_9", DaysAhead = 0, CompareTime = "00:00", DbId = "miso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "miso_lrz_1", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_2_7", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_lrz_3_5", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_lrz_4", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_6", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_8_9", DaysAhead = c(1,2,3,4), DbId = "miso", DbTZ="UTC-5")

# RTO ZONAL MODELS
GetStats(ModelId = "miso_lrz_1", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_2_7", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_3_5", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_4", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_6", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "miso_lrz_8_9", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "miso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "miso_lrz_1", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_2_7", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_lrz_3_5", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5") 
GetStats(ModelId = "miso_lrz_4", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_6", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")
GetStats(ModelId = "miso_lrz_8_9", DaysAhead = c(1,2,3,4), TSO = T, DbId = "miso", DbTZ="UTC-5")

#====================
# NYISO 
#====================

# TOTAL NYISO_TOTAL  
GetStats(ModelId = "nyiso_total", LoadActTable = "nyiso_total_load_act", LoadRollTable = "nyiso_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_total", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 

# RTO NYISO_TOTAL
GetStats(ModelId = "nyiso_total" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5")
GetStats(ModelId = "nyiso_total" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5")

# ZONAL MODELS
GetStats(ModelId = "nyiso_capitl", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_centrl", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_dunwod", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_genese", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_hudvl", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_longil", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_mhkvl", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_millwd", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_north", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_nyc", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_south_total", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_west", DaysAhead = 0, CompareTime = "00:00", DbId = "nyiso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "nyiso_capitl", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5")  
GetStats(ModelId = "nyiso_centrl", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5")
GetStats(ModelId = "nyiso_dunwod", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_genese", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_hudvl", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_longil", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_mhkvl", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_millwd", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_north", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5")  
GetStats(ModelId = "nyiso_nyc", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_south_total", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_west", DaysAhead = c(1,2,3,4), DbId = "nyiso", DbTZ="UTC-5") 
 

# RTO ZONAL MODELS
GetStats(ModelId = "nyiso_capitl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_centrl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_dunwod", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_genese", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_hudvl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_longil", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_mhkvl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_millwd", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_north", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_nyc", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_south_total", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "nyiso_west", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "nyiso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "nyiso_capitl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5")  
GetStats(ModelId = "nyiso_centrl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5")
GetStats(ModelId = "nyiso_dunwod", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_genese", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_hudvl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_longil", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_mhkvl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_millwd", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_north", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5")  
GetStats(ModelId = "nyiso_nyc", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_south_total", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 
GetStats(ModelId = "nyiso_west", DaysAhead = c(1,2,3,4), TSO = T, DbId = "nyiso", DbTZ="UTC-5") 

#====================
# NEISO 
#====================

# TOTAL NEISO_RT  
GetStats(ModelId = "neiso_rt", LoadActTable = "neiso_rt_load_act", LoadRollTable = "neiso_rt_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_rt", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5")

# TOTAL NEISO_TOTAL  
GetStats(ModelId = "neiso_total", LoadActTable = "neiso_total_load_act", LoadRollTable = "neiso_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_total", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5") 

# RTO NEISO_TOTAL
GetStats(ModelId = "neiso_total" , DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "neiso", DbTZ="UTC-5")
GetStats(ModelId = "neiso_total" , DaysAhead = c(1,2,3,4), TSO = T, DbId = "neiso", DbTZ="UTC-5")

# ZONAL MODELS
GetStats(ModelId = "neiso_ct", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_me", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_nemass", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_nh", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_ri", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_semass", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_vt", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "neiso_wcmass", DaysAhead = 0, CompareTime = "00:00", DbId = "neiso", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "neiso_ct", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5")
GetStats(ModelId = "neiso_me", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5") 
GetStats(ModelId = "neiso_nemass", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5") 
GetStats(ModelId = "neiso_nh", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5")
GetStats(ModelId = "neiso_ri", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5") 
GetStats(ModelId = "neiso_semass", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5") 
GetStats(ModelId = "neiso_vt", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5")  
GetStats(ModelId = "neiso_wcmass", DaysAhead = c(1,2,3,4), DbId = "neiso", DbTZ="UTC-5")

#====================
# PJM
#====================

# TOTAL PJM_RTO  
GetStats(ModelId = "pjm_rto", LoadActTable = "pjm_rto_load_act", LoadRollTable = "pjm_rto_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_rto", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")

# TOTAL PJM_TOTAL  
GetStats(ModelId = "pjm_total", LoadActTable = "pjm_total_load_act", LoadRollTable = "pjm_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_total", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 

# TOTAL PJM_EAST_ZONAL_TOTAL  
GetStats(ModelId = "pjm_east_zonal_total", LoadActTable = "pjm_east_zonal_total_load_act", LoadRollTable = "pjm_east_zonal_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_east_zonal_total", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 

# TOTAL PJM_WEST_ZONAL_TOTAL  
GetStats(ModelId = "pjm_west_zonal_total", LoadActTable = "pjm_west_zonal_total_load_act", LoadRollTable = "pjm_west_zonal_total_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_west_zonal_total", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 

# RTO PJM_RTO  
GetStats(ModelId = "pjm_rto", LoadActTable = "pjm_rto_load_act", LoadRollTable = "pjm_rto_load_act_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_rto", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")

# RTO PJM_TOTAL  
GetStats(ModelId = "pjm_total", LoadActTable = "pjm_total_load_act", LoadRollTable = "pjm_total_load_act_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_total", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 

# RTO PJM_EAST_ZONAL_TOTAL  
GetStats(ModelId = "pjm_east_zonal_total", LoadActTable = "pjm_east_zonal_total_load_act", LoadRollTable = "pjm_east_zonal_total_load_act_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_east_zonal_total", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 

# RTO PJM_WEST_ZONAL_TOTAL  
GetStats(ModelId = "pjm_west_zonal_total", LoadActTable = "pjm_west_zonal_total_load_act", LoadRollTable = "pjm_west_zonal_total_load_act_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_west_zonal_total", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 


# EAST ZONAL MODELS
GetStats(ModelId = "pjm_ae", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_bc", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_dpl", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_jc", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_me", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pe", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pep", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pl", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pn", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_ps", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_reco", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_ae", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_bc", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_dpl", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_jc", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_me", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_pe", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_pep", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_pl", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_pn", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_ps", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_reco", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 

# RTO EAST ZONAL MODELS
GetStats(ModelId = "pjm_ae", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_bc", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_dpl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_jc", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_me", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pe", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pep", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pl", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_pn", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_ps", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_reco", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_ae", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_bc", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_dpl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_jc", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_me", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_pe", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_pep", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_pl", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_pn", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_ps", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_reco", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")

# WEST ZONAL MODELS
GetStats(ModelId = "pjm_aepower", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_aps", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_atsi", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_comed", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_dayton", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_deok", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_domin", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_duquesne", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_ekpc", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_aepower", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_aps", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_atsi", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_comed", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_dayton", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_deok", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_domin", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_duquesne", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_ekpc", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  

# RTO WEST ZONAL MODELS
GetStats(ModelId = "pjm_aepower", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_aps", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_atsi", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_comed", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_dayton", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_deok", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_domin", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_duquesne", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_ekpc", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_aepower", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_aps", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_atsi", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_comed", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_dayton", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_deok", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")
GetStats(ModelId = "pjm_domin", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_duquesne", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_ekpc", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")

# REGIONAL MODELS
GetStats(ModelId = "pjm_midatlantic", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_southern", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_western", DaysAhead = 0, CompareTime = "00:00", DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_midatlantic", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_southern", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_western", DaysAhead = c(1,2,3,4), DbId = "pjm", DbTZ="UTC-5") 

# RTO REGIONAL MODELS
GetStats(ModelId = "pjm_midatlantic", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_southern", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 
GetStats(ModelId = "pjm_western", DaysAhead = 0, CompareTime = "00:00", TSO = T, DbId = "pjm", DbTZ="UTC-5") # Intraday 

GetStats(ModelId = "pjm_midatlantic", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 
GetStats(ModelId = "pjm_southern", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5")  
GetStats(ModelId = "pjm_western", DaysAhead = c(1,2,3,4), TSO = T, DbId = "pjm", DbTZ="UTC-5") 

#====================
# SPP
#====================

# TOTAL SPP  
GetStats(ModelId = "spp", LoadActTable = "spp_load_act", LoadRollTable = "spp_load_act_r", DaysAhead = 0, CompareTime = "00:00", DbId = "spp", DbTZ="UTC-6") # Intraday 
GetStats(ModelId = "spp", DaysAhead = c(1,2,3,4), DbId = "spp", DbTZ="UTC-6")

# RTO SPP  
GetStats(ModelId = "spp", LoadActTable = "spp_load_act", LoadRollTable = "spp_load_act_r", TSO = T, DaysAhead = 0, CompareTime = "00:00", DbId = "spp", DbTZ="UTC-6") # Intraday 
GetStats(ModelId = "spp", DaysAhead = c(1,2,3,4), TSO = T, DbId = "spp", DbTZ="UTC-6")


#=========================================================================================================
# Disconnect 
#==========================================================================================================
odbcCloseAll()


