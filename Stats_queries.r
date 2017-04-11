
#==========================================
#
# FUNCTIONS
#
#==========================================

#===========================================
#
# Initilialize Data
#
#==========================================

IniData <- function(Granularity = 'H', TradingParts ='EU', DDay, DDayMinus, DDayPlus) {
        

        # Hourly EU model
        if (Granularity == 'H' & TradingParts =='EU') {
                Data <- data.frame('date' = c(DDayMinus, rep(DDay,24), DDayPlus), 'time' = c(2300, seq(0, 2300, by = 100), 0), load_act = NaN, load_fcst = NaN) 
        } 
        
        # HH EU Model
        else if (Granularity == 'HH' & TradingParts =='EU') {

                Data <- data.frame('date' = c(rep(DDayMinus,2), rep(DDay,48), DDayPlus), 
                                   'time' = c(2300, 2330, sort.default(c(seq(0, 2300, by = 100), seq(30,2330, by =100)), decreasing = F), 0), 
                                   load_act = NaN, load_fcst = NaN)     
        } 
        
        # QH EU Model
        else if (Granularity == 'QH' & TradingParts =='EU') {
                
                Data <- data.frame('date' = c(rep(DDayMinus,4), rep(DDay,96), DDayPlus), 
                                   'time' = c(2300, 2315, 2330,2345, sort.default(c(seq(0, 2300, by = 100), seq(15, 2315, by =100), seq(30,2330, by =100), seq(45, 2345, by = 100)), decreasing = F), 0), 
                                   load_act = NaN, load_fcst = NaN)  
        }      
        
        # HH Model model -> set up other granularity later if needed
        else if (Granularity == 'HH' & TradingParts =='UK') {
                
                Data <- data.frame('date' = c(rep(DDayMinus,3), rep(DDay,47)), 
                                   'time' = c(2230, 2300, 2330, sort.default(c(seq(0, 2300, by = 100), seq(30,2230, by =100)), decreasing = F)), 
                                   load_act = NaN, load_fcst = NaN)            
        
        }
        # 10 min Model model -> set up other granularity later if needed
        else if (Granularity == 'TM' & TradingParts =='EU') {
        
        Data <- data.frame('date' = c(DDayMinus,rep(DDay,144),DDayPlus), 
                           'time' = c(2350,sort.default(c(seq(10,2310, by =100), seq(20,2320, by =100), seq(30,2330, by =100), seq(40,2340, by =100), seq(50,2350, by =100),seq(0, 2300, by = 100)), decreasing = F),0), 
                           load_act = NaN, load_fcst = NaN)            
        
        }
    
   
        return(Data)
        
}

#=============================================================
#
# Create new Table
#
#
#============================================================

CreateTableQuery <- function(TradingParts, DbIdStats, StatsTable) {
        
        ifelse(TradingParts == 'UK',
        
           # UK TEMPLATE 
           query <- paste0("CREATE TABLE [", DbIdStats,"].[dbo].[", StatsTable, "]
                   (
                   Date varchar(50) NOT NULL PRIMARY KEY,
                   Week_Number float(53) NULL,
                   Week_Day varchar(50) NULL,
                   Mape_Baseload float(53) NULL,
                   Mape_Peak float(53) NULL,
                   Mape_OffPeak float(53) NULL,
                   Mape_Block_1_2 float(53) NULL,
                   Mape_Block_3_4 float(53) NULL,
                   Mape_Block_5 float(53) NULL,
                   Mape_Block_6 float(53) NULL,
                   Mape_Block_1A float(53) NULL,
                   Mape_Block_1B float(53) NULL,
                   Mape_Block_2A float(53) NULL,
                   Mape_Block_2B float(53) NULL,
                   Mape_Block_3A float(53) NULL,
                   Mape_Block_3B float(53) NULL,
                   Mape_Block_4A float(53) NULL,
                   Mape_Block_4B float(53) NULL,
                   Mape_Block_5A float(53) NULL,
                   Mape_Block_5B float(53) NULL,
                   Mape_Block_6A float(53) NULL,
                   Mape_Block_6B float(53) NULL,
                   Bias_Baseload float(53) NULL,
                   Bias_Peak float(53) NULL,
                   Bias_OffPeak float(53) NULL,
                   Bias_Block_1_2 float(53) NULL,
                   Bias_Block_3_4 float(53) NULL,
                   Bias_Block_5 float(53) NULL,
                   Bias_Block_6 float(53) NULL,
                   Max_Act float(53) NULL,
                   Max_Fcst float(53) NULL,
                   Max_Hour_Act varchar(50) NULL,
                   Max_Hour_Fcst varchar(50) NULL,
                   Min_Act float(53) NULL,
                   Min_Fcst float(53) NULL,
                   Min_Hour_Act varchar(50) NULL,
                   Min_Hour_Fcst varchar(50) NULL,
                   RMSE float(53) NULL,
                   NOBS int NULL,
                   Fcst_Prod_Time varchar(50) NULL
                   )"),
           
                # EU TEMPLATE 
                paste0("CREATE TABLE [", DbIdStats,"].[dbo].[", StatsTable, "]
                (
                Date varchar(50) NOT NULL PRIMARY KEY,
                Week_Number float(53) NULL,
                Week_Day varchar(10) NULL,
                Mape_Baseload float(53) NULL,
                Mape_Peak float(53) NULL,
                Mape_OffPeak float(53) NULL,
                Mape_Part_0_6 float(53) NULL,
                Mape_Part_6_16 float(53) NULL,
                Mape_Part_16_20 float(53) NULL,
                Mape_Part_20_24 float(53) NULL,
                Bias_Baseload float(53) NULL,
                Bias_Peak float(53) NULL,
                Bias_OffPeak float(53) NULL,
                Bias_Part_0_6 float(53) NULL,
                Bias_Part_6_16 float(53) NULL,
                Bias_Part_16_20 float(53) NULL,
                Bias_Part_20_24 float(53) NULL,
                Max_Act float(53) NULL,
                Max_Fcst float(53) NULL,
                Max_Hour_Act varchar(50) NULL,
                Max_Hour_Fcst varchar(50) NULL,
                Min_Act float(53) NULL,
                Min_Fcst float(53) NULL,
                Min_Hour_Act varchar(50) NULL,
                Min_Hour_Fcst varchar(50) NULL,
                RMSE float(53) NULL,
                NOBS int NULL,
                Fcst_Prod_Time varchar(50) NULL
                )")
        )
           
           
}


#===============================================================
#
# Calculate Stats - EU Template
#
#==============================================================
CalculateStats <- function(DbTZ, Data, InstantLoad, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable, DbIdStats, ErrorType = "NOTWX") {
        
        if(DbTZ == "UTC+1") {
                TimeZoneDb ="Etc/GMT-1"
                TimezoneStats = "Europe/Paris"
                
                #FOR UK TIME ZONE 

                
        } else if (DbTZ == "GMT" | DbTZ == "UTC")  {
                TimeZoneDb = "GMT"
                TimezoneStats = "Europe/London"
                
        } else if (DbTZ == "UTC+2")  {
                TimeZoneDb ="Etc/GMT-2"
                TimezoneStats = "Europe/Istanbul" 
                
        } else if (DbTZ == "UTC+3")  {
            TimeZoneDb ="Etc/GMT-3"
            TimezoneStats = "Europe/Istanbul" 
            
            }
        
        # Getting prevailing time
        Data$DateTime <- as.POSIXlt(as.POSIXct(paste(Data$date, str_sub(paste0("000",Data$time),-4,-1)),
                                               format = "%Y%m%d %H%M", tz=TimeZoneDb), tz= TimezoneStats)
        
        if (InstantLoad == TRUE)  {
                # Setting bounds for instantenous load
                Bound1 <- as.POSIXlt(paste(DDay,"0000"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound2 <- as.POSIXlt(paste(DDay,"0545"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound3 <- as.POSIXlt(paste(DDay,"0745"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound4 <- as.POSIXlt(paste(DDay,"1545"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound5 <- as.POSIXlt(paste(DDay,"1945"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound6 <- as.POSIXlt(paste(DDay,"2345"),format = "%Y%m%d %H%M", TimezoneStats)
        } else {
                # Setting bounds 
                Bound1 <- as.POSIXlt(paste(DDay,"0015"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound2 <- as.POSIXlt(paste(DDay,"0600"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound3 <- as.POSIXlt(paste(DDay,"0800"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound4 <- as.POSIXlt(paste(DDay,"1600"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound5 <- as.POSIXlt(paste(DDay,"2000"),format = "%Y%m%d %H%M", TimezoneStats)
                Bound6 <- as.POSIXlt(paste(DDay,"2400"),format = "%Y%m%d %H%M", TimezoneStats)
        }
        
        
        # Trading Day Data 
        StatsDay <- Data[which(Data$DateTime >= Bound1 & Data$DateTime <= Bound6),]
        
        
        # Shaping 
        if(ErrorType == "WX") {
           
                StatsDay <- StatsDay[which(StatsDay$load_act > 0 & StatsDay$backcast > 0),] # Remove all -99 load
                StatsDay$mape <- abs((StatsDay$load_fcst - StatsDay$backcast)/StatsDay$load_act)*100
                StatsDay$bias <- StatsDay$load_fcst - StatsDay$backcast
                
        } else {
        
                StatsDay <- StatsDay[which(StatsDay$load_act > 0),] # Remove all -99 load
                StatsDay$mape <- abs((StatsDay$load_fcst - StatsDay$load_act)/StatsDay$load_act)*100
                StatsDay$bias <- StatsDay$load_fcst - StatsDay$load_act
                
        }
        #MAPE
        Baseload <- mean(StatsDay$mape)
        Peak <- mean(StatsDay$mape[which(StatsDay$DateTime > Bound3 & StatsDay$DateTime <= Bound5)])
        OffPeak <- mean(StatsDay$mape[which((StatsDay$DateTime >= Bound1 & StatsDay$DateTime <= Bound3) | 
                                                    (StatsDay$DateTime > Bound5 & StatsDay$DateTime <= Bound6) )])
        Part0_6 <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound1 & StatsDay$DateTime <= Bound2)])
        Part6_16 <- mean(StatsDay$mape[which(StatsDay$DateTime > Bound2 & StatsDay$DateTime <= Bound4)])
        Part16_20 <- mean(StatsDay$mape[which(StatsDay$DateTime > Bound4 & StatsDay$DateTime <= Bound5)])
        Part20_24 <- mean(StatsDay$mape[which(StatsDay$DateTime > Bound5 & StatsDay$DateTime <= Bound6)])
        
        #BIAS
        Baseloadb <- mean(StatsDay$bias)
        Peakb <- mean(StatsDay$bias[which(StatsDay$DateTime > Bound3 & StatsDay$DateTime <= Bound5)])
        OffPeakb <- mean(StatsDay$bias[which((StatsDay$DateTime >= Bound1 & StatsDay$DateTime <= Bound3) | 
                                                     (StatsDay$DateTime > Bound5 & StatsDay$DateTime <= Bound6) )])
        Part0_6b <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound1 & StatsDay$DateTime <= Bound2)])
        Part6_16b <- mean(StatsDay$bias[which(StatsDay$DateTime > Bound2 & StatsDay$DateTime <= Bound4)])
        Part16_20b <- mean(StatsDay$bias[which(StatsDay$DateTime > Bound4 & StatsDay$DateTime <= Bound5)])
        Part20_24b <- mean(StatsDay$bias[which(StatsDay$DateTime > Bound5 & StatsDay$DateTime <= Bound6)])
        
        
        #Max
        MaxAct <- ifelse(nrow(StatsDay) > 0, max(StatsDay$load_act), NaN)
        MaxFcst <- ifelse(nrow(StatsDay) > 0, max(StatsDay$load_fcst), NaN)
        MaxHourAct <- ifelse(nrow(StatsDay) > 0, format(StatsDay$DateTime[which.max(StatsDay$load_act)],"%H:%M"), NaN)
        MaxHourFcst <- ifelse(nrow(StatsDay) > 0, format(StatsDay$DateTime[which.max(StatsDay$load_fcst)],"%H:%M"), NaN)
        
        #Min
        MinAct <- ifelse(nrow(StatsDay) > 0, min(StatsDay$load_act), NaN)
        MinFcst <- ifelse(nrow(StatsDay) > 0, min(StatsDay$load_fcst), NaN)
        MinHourAct <- ifelse(nrow(StatsDay) > 0,format(StatsDay$DateTime[which.min(StatsDay$load_act)],"%H:%M"), NaN)
        MinHourFcst <- ifelse(nrow(StatsDay) > 0,format(StatsDay$DateTime[which.min(StatsDay$load_fcst)],"%H:%M"), NaN)
        
        # OTHER 
        NOBS <- nrow(StatsDay)
        RMSE <- sqrt(mean(StatsDay$bias^2))
        Weekday <- strftime(Bound3,'%a')
        WeekNumber <- isoweek(Bound3)
        Fcst_Time <- CompareTime
        
        # Output Query
        #===============
        query <- paste0("DECLARE @ValueExists  int
                   SELECT @ValueExists= Date from [",DbIdStats,"].[dbo].[", StatsTable, "] WHERE Date =", DDay,
                       "IF @ValueExists is NULL 
                   BEGIN
                   insert into [",DbIdStats,"].[dbo].[", StatsTable, "] (Date, Week_Number, Week_Day, Mape_Baseload, Mape_Peak, Mape_OffPeak,   
                   Mape_Part_0_6, Mape_Part_6_16, Mape_Part_16_20, Mape_Part_20_24, Bias_Baseload, Bias_Peak,      
                   Bias_OffPeak, Bias_Part_0_6, Bias_Part_6_16, Bias_Part_16_20, Bias_Part_20_24, Max_Act,        
                   Max_Fcst, Max_Hour_Act, Max_Hour_Fcst, Min_Act, Min_Fcst, Min_Hour_Act,   
                   Min_Hour_Fcst, RMSE, NOBS, Fcst_Prod_Time)
                   Values(", DDay,",",WeekNumber,",", paste0("'",Weekday,"'"),",", Baseload, ",", Peak, "," , OffPeak,",", Part0_6,",", Part6_16,",", Part16_20, ",", Part20_24,",",Baseloadb, ",", Peakb, ",",
                       OffPeakb,",", Part0_6b, ",", Part6_16b, ",", Part16_20b, ",", Part20_24b, ",", MaxAct, ",", MaxFcst,",", paste0("'", MaxHourAct,"'"), ",", paste0("'",MaxHourFcst,"'"),",",
                       MinAct, ",", MinFcst,  ",", paste0("'",MinHourAct,"'"), ",", paste0("'",MinHourFcst,"'"),",", RMSE, ",", NOBS, ",", paste0("'",Fcst_Time,"'"),") 
                   END 
                   ELSE 
                   BEGIN 
                   UPDATE [",DbIdStats,"].[dbo].[", StatsTable, "] SET Week_Number=", WeekNumber, ", Week_Day=", paste0("'",Weekday,"'"), ", Mape_Baseload=", Baseload, ", Mape_Peak=", Peak, ", Mape_OffPeak=", OffPeak, ", Mape_Part_0_6=", Part0_6, 
                       ", Mape_Part_6_16=", Part6_16, ", Mape_Part_16_20=", Part16_20, ", Mape_Part_20_24=", Part20_24, ", Bias_Baseload=", Baseloadb, ", Bias_Peak=", Peakb, ", Bias_OffPeak=",OffPeakb, 
                       ", Bias_Part_0_6=", Part0_6b, ", Bias_Part_6_16=", Part6_16b, ", Bias_Part_16_20=", Part16_20b, ", Bias_Part_20_24=", Part20_24b, ", Max_Act=", MaxAct, ", Max_Fcst=" , MaxFcst, ", Max_Hour_Act=", paste0("'",MaxHourAct,"'"), 
                       ", Max_Hour_Fcst=", paste0("'",MaxHourFcst,"'"),  ", Min_Act=", MinAct, ", Min_Fcst=", MinFcst , ", Min_Hour_Act=", paste0("'",MinHourAct,"'"), ", Min_Hour_Fcst=", paste0("'",MinHourFcst,"'"), ", RMSE=", RMSE, ", NOBS=", NOBS, ", Fcst_Prod_Time=",paste0("'",Fcst_Time,"'"), "WHERE Date=" , DDay,
                       " END", sep = " ")
        
        # Return
        return(gsub("NaN", "NULL", query))

}      
 
#===============================================================
#
# Calculate Stats - UK Template
#
#==============================================================

CalculateStatsUK <- function(Data, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable, DbIdStats, ErrorType = "NOTWX") {
        
                
        # Timezone settings
        TimeZoneDb = "GMT"
        TimezoneStats = "Europe/London"
        
        # Getting prevailing time
        Data$DateTime <- as.POSIXlt(as.POSIXct(paste(Data$date, str_sub(paste0("000",Data$time),-4,-1)),
                                               format = "%Y%m%d %H%M", tz=TimeZoneDb), tz= TimezoneStats)
        
        # Setting bounds 
        Bound1A <- as.POSIXlt(paste(DDayMinus,"2330"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound1B <- as.POSIXlt(paste(DDay,"0130"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound2A <- as.POSIXlt(paste(DDay,"0330"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound2B <- as.POSIXlt(paste(DDay,"0530"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound3A <- as.POSIXlt(paste(DDay,"0730"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound3B <- as.POSIXlt(paste(DDay,"0930"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound4A <- as.POSIXlt(paste(DDay,"1130"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound4B <- as.POSIXlt(paste(DDay,"1330"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound5A <- as.POSIXlt(paste(DDay,"1530"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound5B <- as.POSIXlt(paste(DDay,"1730"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound6A <- as.POSIXlt(paste(DDay,"1930"),format = "%Y%m%d %H%M", TimezoneStats)
        Bound6B <- as.POSIXlt(paste(DDay,"2130"),format = "%Y%m%d %H%M", TimezoneStats)
        BoundLast <- as.POSIXlt(paste(DDay,"2300"),format = "%Y%m%d %H%M", TimezoneStats)
        
        
        # Trading Day Data 
        StatsDay <- Data[which(Data$DateTime >= Bound1A & Data$DateTime <= BoundLast),]
        
        # Shaping 
        if(ErrorType == "WX") {
                
                StatsDay <- StatsDay[which(StatsDay$load_act > 0 & StatsDay$backcast > 0),] # Remove all -99 load
                StatsDay$mape <- abs((StatsDay$load_fcst - StatsDay$backcast)/StatsDay$load_act)*100
                StatsDay$bias <- StatsDay$load_fcst - StatsDay$backcast
                
        } else {
                
                StatsDay <- StatsDay[which(StatsDay$load_act > 0),] # Remove all -99 load
                StatsDay$mape <- abs((StatsDay$load_fcst - StatsDay$load_act)/StatsDay$load_act)*100
                StatsDay$bias <- StatsDay$load_fcst - StatsDay$load_act
                
        }
        #MAPE
        Baseload <- mean(StatsDay$mape)
        Peak <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound3A & StatsDay$DateTime < Bound6A)])
        OffPeak <- mean(StatsDay$mape[which((StatsDay$DateTime >= Bound1A & StatsDay$DateTime < Bound3A) | 
                                                    (StatsDay$DateTime >= Bound6A & StatsDay$DateTime <= BoundLast) )])
        
        Block_1_2 <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound1A & StatsDay$DateTime < Bound3A)])
        Block_3_4 <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound3A & StatsDay$DateTime < Bound5A)])
        Block_5 <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound5A & StatsDay$DateTime < Bound6A)])
        Block_6 <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound6A & StatsDay$DateTime <= BoundLast)])
        
        Block_1A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound1A & StatsDay$DateTime < Bound1B)])
        Block_1B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound1B & StatsDay$DateTime < Bound2A)])
        Block_2A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound2A & StatsDay$DateTime < Bound2B)])
        Block_2B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound2B & StatsDay$DateTime < Bound3A)])
        Block_3A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound3A & StatsDay$DateTime < Bound3B)])
        Block_3B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound3B & StatsDay$DateTime < Bound4A)])
        Block_4A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound4A & StatsDay$DateTime < Bound4B)])
        Block_4B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound4B & StatsDay$DateTime < Bound5A)])
        Block_5A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound5A & StatsDay$DateTime < Bound5B)])
        Block_5B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound5B & StatsDay$DateTime < Bound6A)])
        Block_6A <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound6A & StatsDay$DateTime < Bound6B)])
        Block_6B <- mean(StatsDay$mape[which(StatsDay$DateTime >= Bound6B & StatsDay$DateTime <= BoundLast)])
        
        #BIAS
        Baseloadbias <- mean(StatsDay$bias)
        Peakbias <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound3A & StatsDay$DateTime < Bound6A)])
        OffPeakbias <- mean(StatsDay$bias[which((StatsDay$DateTime >= Bound1A & StatsDay$DateTime < Bound3A) | 
                                                        (StatsDay$DateTime >= Bound6A & StatsDay$DateTime <= BoundLast) )])
        
        Block_1_2bias <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound1A & StatsDay$DateTime < Bound3A)])
        Block_3_4bias <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound3A & StatsDay$DateTime < Bound5A)])
        Block_5bias <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound5A & StatsDay$DateTime < Bound6A)])
        Block_6bias <- mean(StatsDay$bias[which(StatsDay$DateTime >= Bound6A & StatsDay$DateTime <= BoundLast)])
        
        #Max
        MaxAct <- ifelse(nrow(StatsDay) > 0, max(StatsDay$load_act), NaN)
        MaxFcst <- ifelse(nrow(StatsDay) > 0, max(StatsDay$load_fcst), NaN)
        MaxHourAct <- ifelse(nrow(StatsDay) > 0, format(StatsDay$DateTime[which.max(StatsDay$load_act)],"%H:%M"), NaN)
        MaxHourFcst <- ifelse(nrow(StatsDay) > 0, format(StatsDay$DateTime[which.max(StatsDay$load_fcst)],"%H:%M"), NaN)
        
        #Min
        MinAct <- ifelse(nrow(StatsDay) > 0, min(StatsDay$load_act), NaN)
        MinFcst <- ifelse(nrow(StatsDay) > 0, min(StatsDay$load_fcst), NaN)
        MinHourAct <- ifelse(nrow(StatsDay) > 0,format(StatsDay$DateTime[which.min(StatsDay$load_act)],"%H:%M"), NaN)
        MinHourFcst <- ifelse(nrow(StatsDay) > 0,format(StatsDay$DateTime[which.min(StatsDay$load_fcst)],"%H:%M"), NaN)
        
        # OTHER 
        NOBS <- nrow(StatsDay)
        RMSE <- sqrt(mean(StatsDay$bias^2))
        Weekday <- strftime(Bound3A,'%a')
        WeekNumber <- isoweek(Bound3A)
        Fcst_Time <- CompareTime
        
        
        # Output Query
        #===============
        query <- paste0("DECLARE @ValueExists  int
                        SELECT @ValueExists= Date from [",DbIdStats,"].[dbo].[", StatsTable, "] WHERE Date = ", DDay,
                        " IF @ValueExists is NULL 
                        BEGIN
                        insert into [",DbIdStats,"].[dbo].[", StatsTable, "] (Date, Week_Number, Week_Day, 
                        Mape_Baseload, Mape_Peak, Mape_OffPeak,   
                        Mape_Block_1_2, Mape_Block_3_4, Mape_Block_5, Mape_Block_6, 
                        Mape_Block_1A, Mape_Block_1B, Mape_Block_2A, Mape_Block_2B, Mape_Block_3A, Mape_Block_3B,
                        Mape_Block_4A, Mape_Block_4B, Mape_Block_5A, Mape_Block_5B, Mape_Block_6A, Mape_Block_6B,
                        Bias_Baseload, Bias_Peak, Bias_OffPeak,    
                        Bias_Block_1_2, Bias_Block_3_4, Bias_Block_5, Bias_Block_6,
                        Max_Act, Max_Fcst, Max_Hour_Act, Max_Hour_Fcst, Min_Act, Min_Fcst, Min_Hour_Act,   
                        Min_Hour_Fcst, RMSE, NOBS, Fcst_Prod_Time)
                        Values(", DDay,",",WeekNumber,",", paste0("'",Weekday,"'"),",", 
                        Baseload, ",", Peak, "," , OffPeak,",", 
                        Block_1_2,",", Block_3_4,",", Block_5, ",", Block_6,",",
                        Block_1A,",", Block_1B,",", Block_2A,",", Block_2B,",", Block_3A,",", Block_3B,",", 
                        Block_4A,",", Block_4B,",", Block_5A,",", Block_5B,",", Block_6A,",", Block_6B,",",
                        Baseloadbias, ",", Peakbias, "," , OffPeakbias,",", 
                        Block_1_2bias,",", Block_3_4bias,",", Block_5bias, ",", Block_6bias,",",               
                        MaxAct, ",", MaxFcst,",", paste0("'", MaxHourAct,"'"), ",", paste0("'",MaxHourFcst,"'"),",",
                        MinAct, ",", MinFcst,  ",", paste0("'",MinHourAct,"'"), ",", paste0("'",MinHourFcst,"'"),",", RMSE, ",", NOBS, ",", paste0("'",Fcst_Time,"'"),") 
                        END 
                        ELSE 
                        BEGIN 
                        UPDATE [",DbIdStats,"].[dbo].[", StatsTable, "] SET Week_Number=", WeekNumber, ", Week_Day=", paste0("'",Weekday,"'"), ", Mape_Baseload=", Baseload, ", Mape_Peak=", Peak, ", Mape_OffPeak=", OffPeak, 
                        ", Mape_Block_1_2=", Block_1_2, ", Mape_Block_3_4=", Block_3_4,", Mape_Block_5=", Block_5,", Mape_Block_6=", Block_6,
                        ", Mape_Block_1A=", Block_1A,", Mape_Block_1B=", Block_1B,", Mape_Block_2A=", Block_2A, ", Mape_Block_2B=", Block_2B,
                        ", Mape_Block_3A=", Block_3A,", Mape_Block_3B=", Block_3B,", Mape_Block_4A=", Block_4A, ", Mape_Block_4B=", Block_4B,
                        ", Mape_Block_5A=", Block_5A,", Mape_Block_5B=", Block_5B,", Mape_Block_6A=", Block_6A,", Mape_Block_6B=", Block_6B,
                        ", Bias_Baseload=", Baseloadbias, ", Bias_Peak=", Peakbias, ", Bias_OffPeak=", OffPeakbias,
                        ", Bias_Block_1_2=", Block_1_2bias, ", Bias_Block_3_4=", Block_3_4bias,", Bias_Block_5=", Block_5bias,", Bias_Block_6=", Block_6bias,          
                        ", Max_Act=", MaxAct, ", Max_Fcst=" , MaxFcst, ", Max_Hour_Act=", paste0("'",MaxHourAct,"'"), 
                        ", Max_Hour_Fcst=", paste0("'",MaxHourFcst,"'"),  ", Min_Act=", MinAct, ", Min_Fcst=", MinFcst , ", Min_Hour_Act=", paste0("'",MinHourAct,"'"), ", Min_Hour_Fcst=", paste0("'",MinHourFcst,"'"), ", RMSE=", RMSE, ", NOBS=", NOBS, ", Fcst_Prod_Time=",paste0("'",Fcst_Time,"'"), " WHERE Date=" , DDay,
                        " END")
        
        # Return
        return(gsub("NaN", "NULL", query))
        
} 

#===============================================================
#
# Get Stats 
#
#===============================================================

GetStats <- function(ModelId , DbId = NULL, LoadActTable = NULL, LoadRollTable = NULL , StatsTable = NULL,
                     DaysAhead = 1, CompareTime = "06:30", SolveDays = 1:10, 
                     Granularity = 'H', DbSvr = ukdbsvr3, DbSvrStats = ukdbsvr3,  DbIdStats = "EuropoolStats",
                     DbTZ = 'UTC+1', TradingParts = 'EU', CreateTable = F, InstantLoad = F, BadDays = NULL, TSO = F) {
        
        
        # Set Optional Parameters if undefined
        #======================================
        # Table Options
        if(is.null(DbId)) { DbId <- toupper(str_sub(ModelId,1,2))}
        if(is.null(StatsTable)) { StatsTable <- paste0(ifelse(TSO == T, "TSO_", "TESLA_"), ModelId,"_<X>_DA")}
        if(is.null(LoadActTable)) { LoadActTable <- paste0(ModelId, "_load_act")}
        if(is.null(LoadRollTable)) { LoadRollTable <- paste0(ModelId, ifelse(TSO == T,"_tso",""), "_load_fcst_r")}
        
        ## Loop through different DA 
        #==========================================
        for (DA in DaysAhead ) {
                
                # Set Stats Table DA number if loop through multiple days / Intarday Tag if DA = 0
                UseStatsTable <- gsub("<X>_DA", gsub("0_DA", "Intraday", paste0(DA,"_DA")), StatsTable)
                
                # Create Table if it doesn't exist & CreateTable is TRUE 
                #==========================================================
                if(CreateTable) {
                        
                        # Check if Table already exists
                        query <- paste0("select table_name from [",DbIdStats,"].INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE' and  table_name = '", UseStatsTable,"'")
                        TableExists <- sqlQuery(DbSvrStats, query)  
                        
                        # Create Table -> design is based on TradedParts
                        if(nrow(TableExists)==0) {
                                CreateQuery <- CreateTableQuery(TradingParts, DbIdStats, StatsTable = UseStatsTable)
                                sqlExecute(DbSvrStats, CreateQuery)
                                
                        }
                }
                
                ### Loop through days 
                #=====================
                for (d in SolveDays) {
                        
                        # Get Days
                        DDay <- as.character.Date(Sys.time()-d*86400, format = "%Y%m%d")
                        DDayMinus  <- as.character.Date(Sys.time()-(d+1)*86400, format = "%Y%m%d")
                        DDayPlus <- as.character.Date(Sys.time()-(d-1)*86400, format = "%Y%m%d")
                        
                        # Ignore Bad Days
                        #======================
                        if (any(BadDays == DDay)) {next} 
                        
                        # Initilize Data 
                        Data <- IniData(Granularity = Granularity, TradingParts = TradingParts, DDay = DDay, DDayMinus = DDayMinus, DDayPlus = DDayPlus)
                        RevDate <- paste0(as.Date(Sys.time()-(d + DA)*86400)," ", CompareTime,":00.000" )
                        
                        # Prepare a query 
                        #=====================
                        query <- paste0("SELECT load_act, load_fcst  from 
                                (SELECT top 1 * FROM [",DbId ,"].[dbo].[", LoadRollTable, "]   
                                where date = ? and 
                                time = ? and load_fcst > 0 and
                                revision <= '", RevDate,"'
                                order by revision desc) as fcst
                                JOIN
                                (select * from [",DbId ,"].[dbo].[", LoadActTable ,"] where date = ? and time = ?) as act
                                on act.date = fcst.date and act.time = fcst.time")
                        
                        sqlPrepare(DbSvr, query)
                        
                        
                        for(t in 1:nrow(Data)) {
                                
                                tmp <- sqlExecute(DbSvr, NULL, Data[t,c('date', 'time','date', 'time')], fetch=T)
                                
                                # Skip if no data
                                if (nrow(tmp)==0) {next}
                                Data[t, c('load_act', 'load_fcst')] <- tmp
                        }
                        
                        
                        # Calculate stats 
                        ################################
                        UpdateQuery <- ifelse(TradingParts == "EU", 
                                        CalculateStats(DbTZ, Data, InstantLoad, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable = UseStatsTable, DbIdStats),
                                        CalculateStatsUK(Data, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable = UseStatsTable, DbIdStats))
                        
                        # Update DB
                        sqlQuery(DbSvrStats, UpdateQuery)
                        
                ### loop SolvedDays 
                #===================
                }
        ## loop DA
        #=================
        }
        
        
        
        # Close Connectrions
        #====================
        #odbcClose(DbSvr)
        
}



#===============================================================
#
# Get WX Stats 
#
#===============================================================

GetWXStats <- function(ModelId , ErrorType, DbId = NULL, LoadActTable = NULL, LoadRollTable = NULL , LoadBackcastTable = NULL, StatsTable = NULL,
                     DaysAhead = 1, CompareTime = "06:30", SolveDays = 1:10, 
                     Granularity = 'H', DbSvr = ukdbsvr3, DbSvrStats = ukdbsvr3,  DbIdStats = "EuropoolStats",
                     DbTZ = 'UTC+1', TradingParts = 'EU', CreateTable = F, InstantLoad = F, BadDays = NULL) {
        
        
        # Set Optional Parameters if undefined
        #======================================
        # Table Options
        ErrorType <- toupper(ErrorType)
        if(is.null(DbId)) { DbId <- toupper(str_sub(ModelId,1,2))}
        if(is.null(StatsTable)) { StatsTable <- paste0(ErrorType,"_", ModelId,"_<X>_DA")}
        if(is.null(LoadActTable)) { LoadActTable <- paste0(ModelId, "_load_act")}
        if(is.null(LoadRollTable)) { LoadRollTable <-  ifelse(ErrorType !="BACKCAST" , paste0(ModelId, "_s1_load_fcst_r"),
                                                                paste0(ModelId, "_" ,"modeld<D>_load_fcst_r")) }
        
        # Set Backcast table for WX stats if not passed in the function
        if(is.null(LoadBackcastTable) & ErrorType=="WX") { LoadBackcastTable <- paste0(ModelId, "_" ,"modeld<D>_load_fcst_r") }
        
        ## Loop through different DA 
        #==========================================
        for (DA in DaysAhead ) {
                
                # Set Stats Table DA number if loop through multiple days / Intarday Tag if DA = 0
                UseStatsTable <- gsub("<X>_DA", gsub("0_DA", "Intraday", paste0(DA,"_DA")), StatsTable)

                
                # Redefine LoadRollback table LoadBackcastTable if needed
                UseLoadRollTable <- gsub("<D>",DA, LoadRollTable) 
                if(ErrorType=="WX") { UseLoadBackcastTable <- gsub("<D>",DA, LoadBackcastTable)} 
                
                # Create Table if it doesn't exist & CreateTable is TRUE 
                #==========================================================
                if(CreateTable) {
                        
                        # Check if Table already exists
                        query <- paste0("select table_name from [",DbIdStats,"].INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE' and  table_name = '", UseStatsTable,"'")
                        TableExists <- sqlQuery(DbSvrStats, query)  
                        
                        # Create Table -> design is based on TradedParts
                        if(nrow(TableExists)==0) {
                                CreateQuery <- CreateTableQuery(TradingParts, DbIdStats, StatsTable = UseStatsTable)
                                sqlExecute(DbSvrStats, CreateQuery)
                                
                        }
                }
                
                ### Loop through days 
                #=====================
                for (d in SolveDays) {
                        
                        # Get Days
                        DDay <- as.character.Date(Sys.time()-d*86400, format = "%Y%m%d")
                        DDayMinus  <- as.character.Date(Sys.time()-(d+1)*86400, format = "%Y%m%d")
                        DDayPlus <- as.character.Date(Sys.time()-(d-1)*86400, format = "%Y%m%d")
                        
                        # Ignore Bad Days
                        #======================
                        if (any(BadDays == DDay)) {next} 
                        
                        # Initilize Data 
                        Data <- IniData(Granularity = Granularity, TradingParts = TradingParts, DDay = DDay, DDayMinus = DDayMinus, DDayPlus = DDayPlus)
                        
                        # Define Rev Data based on ErrorType
                        if (ErrorType == "BACKCAST") {
                                
                                # Fcst has to produced between midnight next day (after having wx actuals) and before def files are copied to new modeld folder
                                RevDate <- paste0(as.Date(Sys.time()-(d - 1)*86400)," ", CompareTime,":00.000" )
                                RevDateStart <- paste0(as.Date(Sys.time()-(d- 1)*86400)," 00:00:00.000" ) 
                           
                        } else if(ErrorType == "S1")  {
                              
                                # Fcst has to produced between midnight and CompareTime DA ahead
                                RevDate <- paste0(as.Date(Sys.time()-(d + DA)*86400)," ", CompareTime,":00.000" )
                                RevDateStart <- paste0(as.Date(Sys.time()-(d + DA)*86400)," 00:00:00.000" )   
                                
                        } else {
                                
                                # S1 ----> Fcst has to produced between midnight and CompareTime DA ahead
                                RevDate <- paste0(as.Date(Sys.time()-(d + DA)*86400)," ", CompareTime,":00.000" )
                                RevDateStart <- paste0(as.Date(Sys.time()-(d + DA)*86400)," 00:00:00.000" )  
                                
                                # BACKCAST ----> # Fcst has to produced between midnight next day (after having wx actuals) and before def files are copied to new modeld folder
                                RevDateBC <- paste0(as.Date(Sys.time()-(d - 1)*86400)," ", CompareTime,":00.000" )
                                RevDateStartBC <- paste0(as.Date(Sys.time()-(d- 1)*86400)," 00:00:00.000" ) 
                        }
                        
                        # Prepare a query 
                        #=====================
                        
                        if (ErrorType == "WX") {
                        
                        query <- paste0("SELECT load_act, fcst.load_fcst, backcast.load_fcst as backcast  from 
                                
                                        (SELECT top 1 * FROM [",DbId ,"].[dbo].[", UseLoadRollTable, "]   
                                        where date = ? and 
                                        time = ? and 
                                        revision <= '", RevDate,"' and revision >= '", RevDateStart,"'
                                        order by revision desc) as fcst
                                        JOIN
                                        (SELECT top 1 * FROM [",DbId ,"].[dbo].[", UseLoadBackcastTable, "]   
                                        where date = ? and 
                                        time = ? and 
                                        revision <= '", RevDateBC,"' and revision >= '", RevDateStartBC,"'
                                        order by revision desc) as backcast
                                        on backcast.date = fcst.date and backcast.time = fcst.time
                                        JOIN
                                        (select * from [",DbId ,"].[dbo].[", LoadActTable ,"] where date = ? and time = ?) as act
                                        on act.date = fcst.date and act.time = fcst.time")        
                                
                                
                                
                        } else {
                        query <- paste0("SELECT load_act, load_fcst  from 
                                        (SELECT top 1 * FROM [",DbId ,"].[dbo].[", UseLoadRollTable, "]   
                                        where date = ? and 
                                        time = ? and 
                                        revision <= '", RevDate,"' and revision >= '", RevDateStart,"'
                                        order by revision desc) as fcst
                                        JOIN
                                        (select * from [",DbId ,"].[dbo].[", LoadActTable ,"] where date = ? and time = ?) as act
                                        on act.date = fcst.date and act.time = fcst.time")
                        
                        }
                        
                        # Prepare Query
                        sqlPrepare(DbSvr, query)
                        
                        if (ErrorType != "WX") {
                                
                                for(t in 1:nrow(Data)) {
                                        
                                        tmp <- sqlExecute(DbSvr, NULL, Data[t,c('date', 'time','date', 'time')], fetch=T)
                                        
                                        # Skip if no data
                                        if (nrow(tmp)==0) {next}
                                        Data[t, c('load_act', 'load_fcst')] <- tmp
                                }
                        } else {
                                
                                # Initialize column for backcast
                                Data$backcast <- NaN
                                for(t in 1:nrow(Data)) {
                                        
                                        tmp <- sqlExecute(DbSvr, NULL, Data[t,c('date', 'time','date', 'time', 'date', 'time')], fetch=T)
                                        
                                        # Skip if no data
                                        if (nrow(tmp)==0) {next}
                                        Data[t, c('load_act', 'load_fcst', 'backcast')] <- tmp
                                }  
                        }
                        
                        
                        # Calculate stats 
                        ################################
                        UpdateQuery <- ifelse(TradingParts == "EU", 
                                              CalculateStats(DbTZ, Data, InstantLoad, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable = UseStatsTable, DbIdStats, ErrorType = ErrorType),
                                              CalculateStatsUK(Data, DDay, DDayMinus, DDayPlus, CompareTime, StatsTable = UseStatsTable, DbIdStats, ErrorType = ErrorType))
                        
                        
                        # Update DB
                        sqlQuery(DbSvrStats, UpdateQuery)
                        
                        ### loop SolvedDays 
                        #===================
                }
                ## loop DA
                #=================
        }
        
        
        
        # Close Connectrions
        #====================
        #odbcClose(DbSvr)
        
}













