
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
source('C:/TeslaPerformance/R/Performance/Helpfiles/Stats_queries.R')

# Set Connections
ukdbsvr2 <- odbcDriverConnect('driver={SQL Server};server=ukdbsvr2;trusted_connection=true')
ukdbsvr3 <- odbcDriverConnect('driver={SQL Server};server=ukdbsvr3;trusted_connection=true')

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
# LoadRollTable -> Rollback table name.Default {ModelId}_{""/TSO}_load_fcst_r
# StatsTable -> Output stats table name.Default "{TESLA/TSO}_{ModelId}_<X>_DA" . 
# set it as <X> if looping accross multiple DaysAhead  to save the results in multiple tables 
# 
# DaysAhead -> Set historical data. Default is 1 DA. Can be also set as a vector, for example c(1,2,3,7,14)
# CompareTime -> Hour and in "HH:MM" of the historic forecast. Default is "06:30"
#
# Granularity -> Model Granularity. Default is 'H'. Other options are 'HH' or 'QH'
# InstantLoad -> logic TRUE or FALSE indication if load is instantaneous. Defult is FALSE. 
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
# HOURLY EUROPEAN MODELS - HOUR ENDING 
#==========================================================================================================

#====================
# SPAIN
#====================

# REE
GetStats(ModelId = "es_ree" , DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "es_ree" , DaysAhead = c(1,2,7,14))

# TSO REE
GetStats(ModelId = "es_ree" , DaysAhead = 0, CompareTime = "00:00", TSO = T)
GetStats(ModelId = "es_ree" , DaysAhead = 1, CompareTime = "07:00", TSO = T)

# PBF 
GetStats(ModelId = "es_pbf" , LoadActTable = "es_pbf_peninsular_demand_load_act", DaysAhead = c(1,2,7,14)) 

# PBF WIND & SOLAR - running on the old system 
#GetStats(ModelId = "es_pbf_wind" , DbId = 'europool', DbSvr = ukdbsvr2,  DaysAhead = 1) 
#GetStats(ModelId = "es_pbf_solar", DbId = 'europool', LoadActTable = "es_pbf_solar_pv_load_act", DbSvr = ukdbsvr2,  DaysAhead = 1) 

# ENAGAS - NOT ACTIVE 
#GetStats(ModelId = "es_gas_enagas", DbId = 'europool', DbSvr = ukdbsvr2,  DaysAhead = 1) 

#====================
# GERMANY
#====================

# DE ENTSOE NEW
GetStats(ModelId = "de_entsoe_new" , LoadActTable = "de_tp_entsoe_15to0_load_act", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "de_entsoe_new" , LoadActTable = "de_tp_entsoe_15to0_load_act", DaysAhead = c(1,2,7,14)) 

# TSO DE ENTSOE NEW
GetStats(ModelId = "de_entsoe_new" , LoadActTable = "de_tp_entsoe_15to0_load_act", LoadRollTable = "de_tp_entsoe_15to0_tso_load_fcst_r", TSO = T, DaysAhead = 0, CompareTime = "01:30") # Intraday 


#====================
# GRECEE
#====================

# GR DESMIE 
GetStats(ModelId = "gr_desmie", DaysAhead = 0, CompareTime = "00:00", DbTZ="UTC+2") # Intraday 
GetStats(ModelId = "gr_desmie", DaysAhead = c(1,2,7,14), DbTZ="UTC+2")  

#====================
# ITALY 
#====================

# TOTAL (COMPOUND) ITALY 
GetStats(ModelId = "it_terna_total", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_terna_total", DaysAhead = c(1,2,7)) 

# TSO TOTAL (COMPOUND) ITALY 
GetStats(ModelId = "it_terna_total", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 

# REGIONAL MODELS
GetStats(ModelId = "it_cnor", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_csud", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_nord", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_sard", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_sici", DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "it_sud", DaysAhead = 0, CompareTime = "00:00") # Intraday 

GetStats(ModelId = "it_cnor", DaysAhead = c(1,2,7)) 
GetStats(ModelId = "it_csud", DaysAhead = c(1,2,7)) 
GetStats(ModelId = "it_nord", DaysAhead = c(1,2,7))  
GetStats(ModelId = "it_sard", DaysAhead = c(1,2,7))  
GetStats(ModelId = "it_sici", DaysAhead = c(1,2,7))  
GetStats(ModelId = "it_sud", DaysAhead = c(1,2,7))  

# TSO REGIONAL MODELS
GetStats(ModelId = "it_cnor", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 
GetStats(ModelId = "it_csud", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 
GetStats(ModelId = "it_nord", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 
GetStats(ModelId = "it_sard", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 
GetStats(ModelId = "it_sici", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 
GetStats(ModelId = "it_sud", DaysAhead = 0, CompareTime = "00:30", TSO = T) # Intraday 

#====================
# CZECH REPUBLIC
#====================

# CZ CEPS
GetStats(ModelId = "cz_ceps" , DaysAhead = c(1,2,7)) 

#====================
# SWITZERLAND
#====================

# CH ENTSOE NEW
GetStats(ModelId = "ch_entsoe_new" , LoadActTable = "ch_tpentsoe_country_load_act", DaysAhead = c(1,2,7)) 
GetStats(ModelId = "ch_entsoe_new" , LoadActTable = "ch_tpentsoe_country_load_act", DaysAhead = 0, CompareTime = "00:00") # Intraday

# TSO CH ENTSOE NEW
GetStats(ModelId = "ch_entsoe_new" , LoadActTable = "ch_tpentsoe_country_load_act", LoadRollTable = "ch_tpentsoe_country_tso_load_fcst_r", TSO = T, DaysAhead = 0, CompareTime = "01:30", CreateTable = T) # Intraday 

#====================
# TURKEY
#====================
GetStats(ModelId = "tr_teias" , DaysAhead = 0, CompareTime = "00:00", DbTZ = "UTC+3",LoadActTable = "tr_teias_utc3_load_act") # Intraday
GetStats(ModelId = "tr_teias" , DaysAhead = c(1), DbTZ = "UTC+3", LoadActTable = "tr_teias_utc3_load_act") 


#====================
# HUNGARY
#====================
GetStats(ModelId = "hu_mavir" , DaysAhead = 0, CompareTime = "00:00") # Intraday
GetStats(ModelId = "hu_mavir" , DaysAhead = c(1,2,7)) 


#====================
# NORDPOOL MODELS
#====================

# NORWAY
#==========
GetStats(ModelId = "no_statnett" , DbId ='Nordpool', DaysAhead = 0, CompareTime = "00:00") # Intraday
GetStats(ModelId = "no_statnett" , DbId ='Nordpool', DaysAhead = c(1,2,7)) 


# NORWAY REGIONAL & COMPOUND
GetStats(ModelId = "no_statnett_compound" , DbId ='Nordpool', StatsTable = "TESLA_no_statnett_comp_<X>_DA", DaysAhead = c(1,2,7))
GetStats(ModelId = "no_statnett1" , DbId ='Nordpool', DaysAhead = 1) 
GetStats(ModelId = "no_statnett2" , DbId ='Nordpool', DaysAhead = 1) 
GetStats(ModelId = "no_statnett3" , DbId ='Nordpool', DaysAhead = 1) 
GetStats(ModelId = "no_statnett4" , DbId ='Nordpool', DaysAhead = 1) 
GetStats(ModelId = "no_statnett5" , DbId ='Nordpool', DaysAhead = 1) 

# NORWAY TSO
GetStats(ModelId = "no_statnett" , DbId ='Nordpool', DaysAhead = 1, CompareTime = "09:00", TSO = T, BadDays = 20151122) 


# DENMARK
#===========
GetStats(ModelId = "dk_total", DbId ='Nordpool', DaysAhead = c(1,2,7))
GetStats(ModelId = "dk_east" , DbId ='Nordpool', DaysAhead = c(1,2,7))
GetStats(ModelId = "dk_west" , DbId ='Nordpool', DaysAhead = c(1,2,7))

# DENMARK TSO
GetStats(ModelId = "dk_total", DbId ='Nordpool', DaysAhead = 1, TSO=T, CompareTime = "10:00")
GetStats(ModelId = "dk_east" , DbId ='Nordpool', DaysAhead = 1, TSO=T, CompareTime = "09:00")
GetStats(ModelId = "dk_west" , DbId ='Nordpool', DaysAhead = 1, TSO=T, CompareTime = "09:00")


# SWEDEN
#===========
GetStats(ModelId = "se_svk" , DbId ='Nordpool', DaysAhead = c(1,2,7)) 

# SWEDEN REGIONAL & COMPOUND
GetStats(ModelId = "se_svk_compound" , DbId ='Nordpool', LoadActTable ="se_svk_load_act",  StatsTable = "TESLA_se_svk_comp_<X>_DA", DaysAhead = c(1,2,7))
GetStats(ModelId = "se_svk1" , DbId ='Nordpool', DaysAhead = 1)
GetStats(ModelId = "se_svk2" , DbId ='Nordpool', DaysAhead = 1)
GetStats(ModelId = "se_svk3" , DbId ='Nordpool', DaysAhead = 1)
GetStats(ModelId = "se_svk4" , DbId ='Nordpool', DaysAhead = 1)

# SWEDEN REGIONAL & COMPOUND TSO
GetStats(ModelId = "se_svk" , DbId ='Nordpool', DaysAhead = 1, TSO = T, CompareTime = "09:00") # Total/Compound
GetStats(ModelId = "se_svk1" , DbId ='Nordpool', DaysAhead = 1, TSO = T, CompareTime = "09:00")
GetStats(ModelId = "se_svk2" , DbId ='Nordpool', DaysAhead = 1, TSO = T, CompareTime = "09:00")
GetStats(ModelId = "se_svk3" , DbId ='Nordpool', DaysAhead = 1, TSO = T, CompareTime = "09:00")
GetStats(ModelId = "se_svk4" , DbId ='Nordpool', DaysAhead = 1, TSO = T, CompareTime = "09:00")


# FINLAND
#===========
GetStats(ModelId = "fi_fingrid" , LoadActTable = "fi_fingrid_fixed_load_act", DbId ='Nordpool', DaysAhead = c(1,2,7), DbTZ = "UTC+2") 
GetStats(ModelId = "fi_fingrid" , LoadActTable = "fi_fingrid_load_act", DbId ='Nordpool', DaysAhead = 1, DbTZ = "UTC+2", CompareTime = "13:00", TSO = T) 


# NORDIC MODELS
#==================
# TOTAL
GetStats(ModelId = "nordic_total", StatsTable = "TESLA_Nordic_NSFD_<X>_DA", DbId ='Nordpool', DaysAhead = 0, CompareTime = "00:00") # Intraday
GetStats(ModelId = "nordic_total", StatsTable = "TESLA_Nordic_NSFD_<X>_DA", DbId ='Nordpool', DaysAhead = c(1,2,7,14))

# COMPOUND 1 (WITH NOR & SWE COMPOUND MODELS)
GetStats(ModelId = "nordic_compound", LoadActTable = "nordic_total_load_act", StatsTable = "TESLA_Nordic_NSFD_comp_<X>_DA", DbId ='Nordpool', DaysAhead = 0, CompareTime = "00:00") # Intraday
GetStats(ModelId = "nordic_compound", LoadActTable = "nordic_total_load_act", StatsTable = "TESLA_Nordic_NSFD_comp_<X>_DA", DbId ='Nordpool', DaysAhead = c(1,2,7,14))

# COMPOUND 2 (WITH NOR & SWE COMPOUND MODELS) ---- stopped
#GetStats(ModelId = "nordic_compound2", LoadActTable = "nordic_total_load_act", StatsTable = "TESLA_Nordic_NSFD_comp2_<X>_DA", DbId ='Nordpool', DaysAhead = 0, CompareTime = "00:00") # Intraday
#GetStats(ModelId = "nordic_compound2", LoadActTable = "nordic_total_load_act", StatsTable = "TESLA_Nordic_NSFD_comp2_<X>_DA", DbId ='Nordpool', DaysAhead = c(1,2,7,14))

# NORDIC TOTAL TSO
GetStats(ModelId = "nordic_total", StatsTable = "TSO_Nordic_NSFD_<X>_DA", TSO = T, CompareTime = "13:00", DbId ='Nordpool', DaysAhead = 1, BadDays = 20151122)


#===============
# BALKAN MODELS
#===============

# CROATIA 
GetStats(ModelId = "hr_entsoe" , DbId ='HR', DaysAhead = 1)
GetStats(ModelId = "hr_entsoe" , DbId ='HR', DaysAhead = 1, CompareTime = '18:00', TSO = T) # TSO

# SLOVENIA
GetStats(ModelId = "si_eles" , DbId ='SI', DaysAhead = 1)
GetStats(ModelId = "si_eles" , DbId ='SI', DaysAhead = 1, CompareTime = '12:00', TSO = T) #TSO

# SERBIA 
GetStats(ModelId = "rs_entsoe" , DbId ='RS', DaysAhead = 1)
GetStats(ModelId = "rs_entsoe" , DbId ='RS', DaysAhead = 1, CompareTime = '12:00', TSO = T) #TSO


#=========================================================================================================
# HALF HOURLY EUROPEAN MODELS - HOUR ENDING 
#=========================================================================================================

#====================
# FRANCE
#====================

# FR RTE 
GetStats(ModelId = "fr_rte" , InstantLoad = T, Granularity = 'HH', DaysAhead = 0, CompareTime = '00:00') # Intraday
GetStats(ModelId = "fr_rte" , InstantLoad = T, Granularity = 'HH', DaysAhead = c(1,2,7,14)) 

# TSO FR RTE 
GetStats(ModelId = "fr_rte" , InstantLoad = T, Granularity = 'HH', DaysAhead = 0, TSO = T, CompareTime = '01:00') # Intraday
GetStats(ModelId = "fr_rte" , InstantLoad = T, Granularity = 'HH', DaysAhead = c(1,2), TSO = T, CompareTime = '07:30') 

# Their long term fcst gets published around 11am
GetStats(ModelId = "fr_rte" , InstantLoad = T, Granularity = 'HH', DaysAhead = 7, TSO = T, CompareTime = '12:00') 

# FRANCE WIND 
#GetStats(ModelId = "fr_rte_wind" , DbId = 'europool', LoadRollTable = "fr_wind_rte_load_fcst_r", DbSvr = ukdbsvr2, Granularity = 'H', DaysAhead = 1) # Hourly model


#==============
# IRELAND EA, EP2
#===============

GetStats(ModelId = "ie_semo_ea", Granularity = 'HH', DbTZ = "GMT", DaysAhead = c(1,2,7))
GetStats(ModelId = "ie_semo_ep2", Granularity = 'HH', DbTZ = "GMT", DaysAhead = c(1,2,7))



#=========================================================================================================
# QH EUROPEAN MODELS - HOUR ENDING 
#=========================================================================================================

#====================
# BELGIUM
#====================

# BE ELIA
GetStats(ModelId = "be_elia" , Granularity = 'QH', DaysAhead = 0, CompareTime = '00:00') # Intraday
GetStats(ModelId = "be_elia" , Granularity = 'QH', DaysAhead = c(1,2,7,14), BadDays= 20161123 )

# TSO BE ELIA
#GetStats(ModelId = "be_elia" , DbSvr = ukdbsvr2, DbId = 'europool', Granularity = 'QH', DaysAhead = 1, TSO = T, CompareTime = '09:00') Not needed

# BE ELIA TOTAL 
GetStats(ModelId = "be_total" , LoadActTable = "be_elia_total_load_act", Granularity = 'QH', DaysAhead = 0, CompareTime = '00:00') # Intraday
GetStats(ModelId = "be_total" , LoadActTable = "be_elia_total_load_act", Granularity = 'QH', DaysAhead = c(1,2,7,14)) 

#====================
# AUSTRIA
#====================

# AT APG
GetStats(ModelId = "at_apg" , Granularity = 'QH', DaysAhead = c(1,2,7)) 
GetStats(ModelId = "at_apg" , Granularity = 'QH', DaysAhead = c(1,2,7)) 

# AT APG TSO
GetStats(ModelId = "at_apg" , Granularity = 'QH', DaysAhead = 1, TSO = T, CompareTime = '09:00') 

#====================
# NETHERLANDS
#====================

# NL TENNET
GetStats(ModelId = "nl_tennet" , Granularity = 'QH', DaysAhead = c(1,2,7)) 

# NL ENTSOE
GetStats(ModelId = "nl_entsoe" , Granularity = 'QH', DaysAhead = c(1,2,7)) 
GetStats(ModelId = "nl_entsoe" , Granularity = 'QH', DaysAhead = 1 , TSO = T, CompareTime = "12:00", BadDays = "20170116") # TSO

#====================
# POLAND 
#====================

#PL PSE
GetStats(ModelId = "pl_pse" , Granularity = 'QH', DaysAhead = c(1,2,7)) 

#====================
# SLOVAKIA
#====================

#SK SEPSAS
GetStats(ModelId = "sk_sepsas", Granularity = 'QH', DaysAhead = c(1,2,7))

#====================
# PORTUGAL
#====================

# PT REN
GetStats(ModelId = "pt_ren", Granularity = 'QH', DaysAhead = c(1,2,7))

#====================
# IRELAND
#====================

# IE EIRGRID
GetStats(ModelId = "ie_eirgrid", Granularity = 'QH', DbTZ = "GMT", DaysAhead = c(1,2,7))


# NORTHERN IRELAND
GetStats(ModelId = "ie_ni_eirgrid", Granularity = 'QH', DbTZ = "GMT", DaysAhead = c(1,2,7))

# TOTAL MODEL 
GetStats(ModelId = "ie_total", Granularity = 'QH', DbTZ = "GMT", DaysAhead = c(1,2,7))

#====================
# GERMANY
#====================

# DE ENTSOE QH

GetStats(ModelId = "de_entsoe_15min" , DbId = "DE",  LoadActTable = "de_tpentsoe_country_load_act", DaysAhead = c(1,2,7) , Granularity = 'QH') 

#TSO
GetStats(ModelId = "de_entsoe_15min", DbId = "DE",  LoadActTable = "de_tpentsoe_country_load_act", LoadRollTable ="de_tpentsoe_country_tso_load_fcst_r", DaysAhead = 1 , Granularity = 'QH', TSO = T, CompareTime = "12:00") 


#=====================
# 10 MINUTE MODELS
#=====================

#ROMANIA
GetStats(ModelId = "ro_ope_10min", DbId = 'RO', Granularity = 'TM', DaysAhead = 1, InstantLoad = T)




#=========================================================================================================
# UK TEMPLATE MODELS 
#=========================================================================================================

# INDO
GetStats(ModelId = "uk_indo", LoadRollTable = "uk_gb_indo_load_fcst_r", Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = 0, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "uk_indo", LoadRollTable = "uk_gb_indo_load_fcst_r", Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = c(1,2,7,14))

# TSO INDO
GetStats(ModelId = "uk_indo", Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = 0, TSO = T, CompareTime = "00:00") # Intraday 
GetStats(ModelId = "uk_indo", Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', 
         DaysAhead = 1, TSO = T, CompareTime = "09:00", 
         BadDays = c("20160222","20160613","20160614","20160615","20160616","20160721","20160826","20160914",as.character(20161020:20161025), "20161110","20161124", "20161210")) 

# TGSD
GetStats(ModelId = "uk_tgsd", LoadRollTable = "uk_gb_tgsd_load_fcst_r", LoadActTable = "uk_itsdo_load_act", Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = c(1,2,7))

# SOLAR NG 
#GetStats(ModelId = "uk_solar_ng", LoadRollTable = "uk_solar_ng_load_fcst_r", LoadActTable = "ng_embedded_solar", DbSvr = ukdbsvr2, DbId = 'europool', Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = 1)

# WIND NG 
#GetStats(ModelId = "uk_wind_ng", LoadActTable = "ng_embedded_wind", DbSvr = ukdbsvr2, DbId = 'europool', Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = 1)

# TD NG 
#GetStats(ModelId = "uk_td_ng", DbSvr = ukdbsvr2, DbId = 'europool', Granularity = 'HH', DbTZ = "GMT", TradingParts = 'UK', DaysAhead = 1)


#=========================================================================================================
# Disconnect 
#==========================================================================================================
odbcCloseAll()


