# Library and connection
#==========================================================================================================

library(RODBC)
library(stringr)
library(lubridate)
#library(XLConnectJarsc)
library("XLConnect")

MyConnection <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;database=tesla;trusted_connection=true')

#==========================================================================================================

#Get Dates
#=============================
Get_date <- function(i) {as.character.Date(Sys.time()+i*86400, format = "%Y%m%d")}

Date <- data.frame(Date = as.numeric(Get_date(-1:-14)))

##IGNORE NON ESSENTIAL ERRORS
#continue_on_error <- function()
#{
#  print("NONESSENTIAL ERROR")
  
#}

#options(error=continue_on_error)

#------------------------------------------------------------------------------------------------------------------
#USA Models
#------------------------------------------------------------------------------------------------------------------
#Models on the Report


Models <- c(
#CAISO (77)
  "ISO_caiso_azps_1_DA",
  "ISO_caiso_azps_2_DA",
  "ISO_caiso_azps_3_DA",
  "ISO_caiso_azps_4_DA",
  "ISO_caiso_azps_Intraday",
  "TESLA_caiso_azps_1_DA",
  "TESLA_caiso_azps_2_DA",
  "TESLA_caiso_azps_3_DA",
  "TESLA_caiso_azps_4_DA",
  "TESLA_caiso_azps_Intraday",
  "ISO_caiso_nevp_1_DA",
  "ISO_caiso_nevp_2_DA",
  "ISO_caiso_nevp_3_DA",
  "ISO_caiso_nevp_4_DA",
  "ISO_caiso_nevp_Intraday",
  "TESLA_caiso_nevp_1_DA",
  "TESLA_caiso_nevp_Intraday",
  "ISO_caiso_pge_1_DA",
  "ISO_caiso_pge_2_DA",
  "ISO_caiso_pge_3_DA",
  "ISO_caiso_pge_4_DA",
  "ISO_caiso_pge_Intraday",
  "TESLA_caiso_pge_1_DA",
  "TESLA_caiso_pge_2_DA",
  "TESLA_caiso_pge_3_DA",
  "TESLA_caiso_pge_4_DA",
  "TESLA_caiso_pge_Intraday",
  "ISO_caiso_psei_1_DA",
  "ISO_caiso_psei_2_DA",
  "ISO_caiso_psei_3_DA",
  "ISO_caiso_psei_4_DA",
  "ISO_caiso_psei_Intraday",
  "TESLA_caiso_psei_1_DA",
  "TESLA_caiso_psei_2_DA",
  "TESLA_caiso_psei_3_DA",
  "TESLA_caiso_psei_4_DA",
  "TESLA_caiso_psei_Intraday",
  "ISO_caiso_sce_1_DA",
  "ISO_caiso_sce_2_DA",
  "ISO_caiso_sce_3_DA",
  "ISO_caiso_sce_4_DA",
  "ISO_caiso_sce_Intraday",
  "TESLA_caiso_sce_1_DA",
  "TESLA_caiso_sce_2_DA",
  "TESLA_caiso_sce_3_DA",
  "TESLA_caiso_sce_4_DA",
  "TESLA_caiso_sce_Intraday",
  "ISO_caiso_sdge_1_DA",
  "ISO_caiso_sdge_2_DA",
  "ISO_caiso_sdge_3_DA",
  "ISO_caiso_sdge_4_DA",
  "ISO_caiso_sdge_Intraday",
  "TESLA_caiso_sdge_1_DA",
  "TESLA_caiso_sdge_2_DA",
  "TESLA_caiso_sdge_3_DA",
  "TESLA_caiso_sdge_4_DA",
  "TESLA_caiso_sdge_Intraday",
  "ISO_caiso_total_1_DA",
  "ISO_caiso_total_2_DA",
  "ISO_caiso_total_3_DA",
  "ISO_caiso_total_4_DA",
  "ISO_caiso_total_Intraday",
  "TESLA_caiso_total_1_DA",
  "TESLA_caiso_total_2_DA",
  "TESLA_caiso_total_3_DA",
  "TESLA_caiso_total_4_DA",
  "TESLA_caiso_total_Intraday",
  "ISO_caiso_vea_1_DA",
  "ISO_caiso_vea_2_DA",
  "ISO_caiso_vea_3_DA",
  "ISO_caiso_vea_4_DA",
  "ISO_caiso_vea_Intraday",
  "TESLA_caiso_vea_1_DA",
  "TESLA_caiso_vea_2_DA",
  "TESLA_caiso_vea_3_DA",
  "TESLA_caiso_vea_4_DA",
  "TESLA_caiso_vea_Intraday",
#ERCOT(96)
  "ISO_ercot_coast_rt_1_DA",
  "ISO_ercot_coast_rt_2_DA",
  "ISO_ercot_coast_rt_3_DA",
  "ISO_ercot_coast_rt_4_DA",
  "ISO_ercot_coast_rt_Intraday",
  "TESLA_ercot_coast_rt_1_DA",
  "TESLA_ercot_coast_rt_2_DA",
  "TESLA_ercot_coast_rt_3_DA",
  "TESLA_ercot_coast_rt_4_DA",
  "TESLA_ercot_coast_rt_Intraday",
  "ISO_ercot_east_rt_1_DA",
  "ISO_ercot_east_rt_2_DA",
  "ISO_ercot_east_rt_3_DA",
  "ISO_ercot_east_rt_4_DA",
  "ISO_ercot_east_rt_Intraday",
  "TESLA_ercot_east_rt_1_DA",
  "TESLA_ercot_east_rt_2_DA",
  "TESLA_ercot_east_rt_3_DA",
  "TESLA_ercot_east_rt_4_DA",
  "TESLA_ercot_east_rt_Intraday",
  "TESLA_ercot_east_total_rt_Intraday",
  "ISO_ercot_farwest_rt_1_DA",
  "ISO_ercot_farwest_rt_2_DA",
  "ISO_ercot_farwest_rt_3_DA",
  "ISO_ercot_farwest_rt_4_DA",
  "ISO_ercot_farwest_rt_Intraday",
  "TESLA_ercot_farwest_rt_1_DA",
  "TESLA_ercot_farwest_rt_2_DA",
  "TESLA_ercot_farwest_rt_3_DA",
  "TESLA_ercot_farwest_rt_4_DA",
  "TESLA_ercot_farwest_rt_Intraday",
  "ISO_ercot_north_c_rt_1_DA",
  "ISO_ercot_north_c_rt_2_DA",
  "ISO_ercot_north_c_rt_3_DA",
  "ISO_ercot_north_c_rt_4_DA",
  "ISO_ercot_north_c_rt_Intraday",
  "TESLA_ercot_north_c_rt_1_DA",
  "TESLA_ercot_north_c_rt_2_DA",
  "TESLA_ercot_north_c_rt_3_DA",
  "TESLA_ercot_north_c_rt_4_DA",
  "TESLA_ercot_north_c_rt_Intraday",
  "ISO_ercot_north_rt_1_DA",
  "ISO_ercot_north_rt_2_DA",
  "ISO_ercot_north_rt_3_DA",
  "ISO_ercot_north_rt_4_DA",
  "ISO_ercot_north_rt_Intraday",
  "TESLA_ercot_north_rt_1_DA",
  "TESLA_ercot_north_rt_2_DA",
  "TESLA_ercot_north_rt_3_DA",
  "TESLA_ercot_north_rt_4_DA",
  "TESLA_ercot_north_rt_Intraday",
  "TESLA_ercot_north_total_rt_Intraday",
  "ISO_ercot_south_c_rt_1_DA",
  "ISO_ercot_south_c_rt_2_DA",
  "ISO_ercot_south_c_rt_3_DA",
  "ISO_ercot_south_c_rt_4_DA",
  "ISO_ercot_south_c_rt_Intraday",
  "TESLA_ercot_south_c_rt_1_DA",
  "TESLA_ercot_south_c_rt_2_DA",
  "TESLA_ercot_south_c_rt_3_DA",
  "TESLA_ercot_south_c_rt_4_DA",
  "TESLA_ercot_south_c_rt_Intraday",
  "TESLA_ercot_south_total_rt_Intraday",
  "ISO_ercot_southern_rt_1_DA",
  "ISO_ercot_southern_rt_2_DA",
  "ISO_ercot_southern_rt_3_DA",
  "ISO_ercot_southern_rt_4_DA",
  "ISO_ercot_southern_rt_Intraday",
  "TESLA_ercot_southern_rt_1_DA",
  "TESLA_ercot_southern_rt_2_DA",
  "TESLA_ercot_southern_rt_3_DA",
  "TESLA_ercot_southern_rt_4_DA",
  "TESLA_ercot_southern_rt_Intraday",
  "ISO_ercot_total_rt_1_DA",
  "ISO_ercot_total_rt_2_DA",
  "ISO_ercot_total_rt_3_DA",
  "ISO_ercot_total_rt_4_DA",
  "ISO_ercot_total_rt_Intraday",
  "TESLA_ercot_total_rt_1_DA",
  "TESLA_ercot_total_rt_2_DA",
  "TESLA_ercot_total_rt_3_DA",
  "TESLA_ercot_total_rt_4_DA",
  "TESLA_ercot_total_rt_Intraday",
  "ISO_ercot_west_rt_1_DA",
  "ISO_ercot_west_rt_2_DA",
  "ISO_ercot_west_rt_3_DA",
  "ISO_ercot_west_rt_4_DA",
  "ISO_ercot_west_rt_Intraday",
  "TESLA_ercot_west_rt_1_DA",
  "TESLA_ercot_west_rt_2_DA",
  "TESLA_ercot_west_rt_3_DA",
  "TESLA_ercot_west_rt_4_DA",
  "TESLA_ercot_west_rt_Intraday",
  "TESLA_ercot_west_total_rt_Intraday",
  "TESLA_ercot_zones_total_rt_1_DA",
  "TESLA_ercot_zones_total_rt_Intraday", 
#MISO 
"ISO_miso_central_Intraday",
"ISO_miso_lrz_1_1_DA",
"ISO_miso_lrz_1_2_DA",
"ISO_miso_lrz_1_3_DA",
"ISO_miso_lrz_1_4_DA",
"ISO_miso_lrz_1_Intraday",
"TESLA_miso_central_Intraday",
"TESLA_miso_lrz_1_1_DA",
"TESLA_miso_lrz_1_2_DA",
"TESLA_miso_lrz_1_3_DA",
"TESLA_miso_lrz_1_4_DA",
"TESLA_miso_lrz_1_Intraday",
"ISO_miso_lrz_2_7_1_DA",
"ISO_miso_lrz_2_7_2_DA",
"ISO_miso_lrz_2_7_3_DA",
"ISO_miso_lrz_2_7_4_DA",
"ISO_miso_lrz_2_7_Intraday",
"TESLA_miso_lrz_2_7_1_DA",
"TESLA_miso_lrz_2_7_2_DA",
"TESLA_miso_lrz_2_7_3_DA",
"TESLA_miso_lrz_2_7_4_DA",
"TESLA_miso_lrz_2_7_Intraday",
"ISO_miso_lrz_3_5_1_DA",
"ISO_miso_lrz_3_5_2_DA",
"ISO_miso_lrz_3_5_3_DA",
"ISO_miso_lrz_3_5_4_DA",
"ISO_miso_lrz_3_5_Intraday",
"TESLA_miso_lrz_3_5_1_DA",
"TESLA_miso_lrz_3_5_2_DA",
"TESLA_miso_lrz_3_5_3_DA",
"TESLA_miso_lrz_3_5_4_DA",
"TESLA_miso_lrz_3_5_Intraday",
"ISO_miso_lrz_4_1_DA",
"ISO_miso_lrz_4_2_DA",
"ISO_miso_lrz_4_3_DA",
"ISO_miso_lrz_4_4_DA",
"ISO_miso_lrz_4_Intraday",
"TESLA_miso_lrz_4_1_DA",
"TESLA_miso_lrz_4_2_DA",
"TESLA_miso_lrz_4_3_DA",
"TESLA_miso_lrz_4_4_DA",
"TESLA_miso_lrz_4_Intraday",
"ISO_miso_lrz_6_1_DA",
"ISO_miso_lrz_6_2_DA",
"ISO_miso_lrz_6_3_DA",
"ISO_miso_lrz_6_4_DA",
"ISO_miso_lrz_6_Intraday",
"TESLA_miso_lrz_6_1_DA",
"TESLA_miso_lrz_6_2_DA",
"TESLA_miso_lrz_6_3_DA",
"TESLA_miso_lrz_6_4_DA",
"TESLA_miso_lrz_6_Intraday",
"ISO_miso_lrz_8_9_1_DA",
"ISO_miso_lrz_8_9_2_DA",
"ISO_miso_lrz_8_9_3_DA",
"ISO_miso_lrz_8_9_4_DA",
"ISO_miso_lrz_8_9_Intraday",
"TESLA_miso_lrz_8_9_1_DA",
"TESLA_miso_lrz_8_9_2_DA",
"TESLA_miso_lrz_8_9_3_DA",
"TESLA_miso_lrz_8_9_4_DA",
"TESLA_miso_lrz_8_9_Intraday",
"TESLA_miso_lrz_total_1_DA",
"TESLA_miso_lrz_total_Intraday",
"ISO_miso_north_Intraday",
"ISO_miso_south_Intraday",
"TESLA_miso_north_Intraday",
"TESLA_miso_south_Intraday",
"ISO_miso_total_1_DA",
"ISO_miso_total_2_DA",
"ISO_miso_total_3_DA",
"ISO_miso_total_4_DA",
"ISO_miso_total_Intraday",
"TESLA_miso_total_1_DA",
"TESLA_miso_total_Intraday",
"TESLA_miso_total_rt_1_DA",
"TESLA_miso_total_rt_Intraday",
"ISO_miso_wind_1_DA",
"ISO_miso_wind_2_DA",
"ISO_miso_wind_3_DA",
"ISO_miso_wind_4_DA",
"ISO_miso_wind_Intraday",
"TESLA_miso_wind_1_DA",
"TESLA_miso_wind_Intraday",
#PJM (270)
"ISO_pjm_ae_1_DA",
"TESLA_pjm_ae_1_DA",
"ISO_pjm_ae_2_DA",
"TESLA_pjm_ae_2_DA",
"ISO_pjm_ae_3_DA",
"TESLA_pjm_ae_3_DA",
"ISO_pjm_ae_4_DA",
"TESLA_pjm_ae_4_DA",
"ISO_pjm_ae_Intraday",
"TESLA_pjm_ae_Intraday",
"ISO_pjm_aepower_1_DA",
"TESLA_pjm_aepower_1_DA",
"ISO_pjm_aepower_2_DA",
"TESLA_pjm_aepower_2_DA",
"ISO_pjm_aepower_3_DA",
"TESLA_pjm_aepower_3_DA",
"ISO_pjm_aepower_4_DA",
"TESLA_pjm_aepower_4_DA",
"ISO_pjm_aepower_Intraday",
"TESLA_pjm_aepower_Intraday",
"ISO_pjm_aps_1_DA",
"TESLA_pjm_aps_1_DA",
"ISO_pjm_aps_2_DA",
"TESLA_pjm_aps_2_DA",
"ISO_pjm_aps_3_DA",
"TESLA_pjm_aps_3_DA",
"ISO_pjm_aps_4_DA",
"TESLA_pjm_aps_4_DA",
"ISO_pjm_aps_Intraday",
"TESLA_pjm_aps_Intraday",
"ISO_pjm_atsi_1_DA",
"TESLA_pjm_atsi_1_DA",
"ISO_pjm_atsi_2_DA",
"TESLA_pjm_atsi_2_DA",
"ISO_pjm_atsi_3_DA",
"TESLA_pjm_atsi_3_DA",
"ISO_pjm_atsi_4_DA",
"TESLA_pjm_atsi_4_DA",
"ISO_pjm_atsi_Intraday",
"TESLA_pjm_atsi_Intraday",
"ISO_pjm_bc_1_DA",
"TESLA_pjm_bc_1_DA",
"ISO_pjm_bc_2_DA",
"TESLA_pjm_bc_2_DA",
"ISO_pjm_bc_3_DA",
"TESLA_pjm_bc_3_DA",
"ISO_pjm_bc_4_DA",
"TESLA_pjm_bc_4_DA",
"ISO_pjm_bc_Intraday",
"TESLA_pjm_bc_Intraday",
"ISO_pjm_comed_1_DA",
"TESLA_pjm_comed_1_DA",
"ISO_pjm_comed_2_DA",
"TESLA_pjm_comed_2_DA",
"ISO_pjm_comed_3_DA",
"TESLA_pjm_comed_3_DA",
"ISO_pjm_comed_4_DA",
"TESLA_pjm_comed_4_DA",
"ISO_pjm_comed_Intraday",
"TESLA_pjm_comed_Intraday",
"ISO_pjm_dayton_1_DA",
"TESLA_pjm_dayton_1_DA",
"ISO_pjm_dayton_2_DA",
"TESLA_pjm_dayton_2_DA",
"ISO_pjm_dayton_3_DA",
"TESLA_pjm_dayton_3_DA",
"ISO_pjm_dayton_4_DA",
"TESLA_pjm_dayton_4_DA",
"ISO_pjm_dayton_Intraday",
"TESLA_pjm_dayton_Intraday",
"ISO_pjm_deok_1_DA",
"TESLA_pjm_deok_1_DA",
"ISO_pjm_deok_2_DA",
"TESLA_pjm_deok_2_DA",
"ISO_pjm_deok_3_DA",
"TESLA_pjm_deok_3_DA",
"ISO_pjm_deok_4_DA",
"TESLA_pjm_deok_4_DA",
"ISO_pjm_deok_Intraday",
"TESLA_pjm_deok_Intraday",
"ISO_pjm_domin_1_DA",
"TESLA_pjm_domin_1_DA",
"ISO_pjm_domin_2_DA",
"TESLA_pjm_domin_2_DA",
"ISO_pjm_domin_3_DA",
"TESLA_pjm_domin_3_DA",
"ISO_pjm_domin_4_DA",
"TESLA_pjm_domin_4_DA",
"ISO_pjm_domin_Intraday",
"TESLA_pjm_domin_Intraday",
"ISO_pjm_dpl_1_DA",
"TESLA_pjm_dpl_1_DA",
"ISO_pjm_dpl_2_DA",
"TESLA_pjm_dpl_2_DA",
"ISO_pjm_dpl_3_DA",
"TESLA_pjm_dpl_3_DA",
"ISO_pjm_dpl_4_DA",
"TESLA_pjm_dpl_4_DA",
"ISO_pjm_dpl_Intraday",
"TESLA_pjm_dpl_Intraday",
"ISO_pjm_duquesne_1_DA",
"TESLA_pjm_duquesne_1_DA",
"ISO_pjm_duquesne_2_DA",
"TESLA_pjm_duquesne_2_DA",
"ISO_pjm_duquesne_3_DA",
"TESLA_pjm_duquesne_3_DA",
"ISO_pjm_duquesne_4_DA",
"TESLA_pjm_duquesne_4_DA",
"ISO_pjm_duquesne_Intraday",
"TESLA_pjm_duquesne_Intraday",
"ISO_pjm_east_zonal_total_1_DA",
"TESLA_pjm_east_zonal_total_1_DA",
"ISO_pjm_east_zonal_total_2_DA",
"TESLA_pjm_east_zonal_total_2_DA",
"ISO_pjm_east_zonal_total_3_DA",
"TESLA_pjm_east_zonal_total_3_DA",
"ISO_pjm_east_zonal_total_4_DA",
"TESLA_pjm_east_zonal_total_4_DA",
"ISO_pjm_east_zonal_total_Intraday",
"TESLA_pjm_east_zonal_total_Intraday",
"ISO_pjm_ekpc_1_DA",
"TESLA_pjm_ekpc_1_DA",
"ISO_pjm_ekpc_2_DA",
"TESLA_pjm_ekpc_2_DA",
"ISO_pjm_ekpc_3_DA",
"TESLA_pjm_ekpc_3_DA",
"ISO_pjm_ekpc_4_DA",
"TESLA_pjm_ekpc_4_DA",
"ISO_pjm_ekpc_Intraday",
"TESLA_pjm_ekpc_Intraday",
"ISO_pjm_jc_1_DA",
"TESLA_pjm_jc_1_DA",
"ISO_pjm_jc_2_DA",
"TESLA_pjm_jc_2_DA",
"ISO_pjm_jc_3_DA",
"TESLA_pjm_jc_3_DA",
"ISO_pjm_jc_4_DA",
"TESLA_pjm_jc_4_DA",
"ISO_pjm_jc_Intraday",
"TESLA_pjm_jc_Intraday",
"ISO_pjm_me_1_DA",
"TESLA_pjm_me_1_DA",
"ISO_pjm_me_2_DA",
"TESLA_pjm_me_2_DA",
"ISO_pjm_me_3_DA",
"TESLA_pjm_me_3_DA",
"ISO_pjm_me_4_DA",
"TESLA_pjm_me_4_DA",
"ISO_pjm_me_Intraday",
"TESLA_pjm_me_Intraday",
"ISO_pjm_midatlantic_1_DA",
"TESLA_pjm_midatlantic_1_DA",
"ISO_pjm_midatlantic_2_DA",
"TESLA_pjm_midatlantic_2_DA",
"ISO_pjm_midatlantic_3_DA",
"TESLA_pjm_midatlantic_3_DA",
"ISO_pjm_midatlantic_4_DA",
"TESLA_pjm_midatlantic_4_DA",
"ISO_pjm_midatlantic_Intraday",
"TESLA_pjm_midatlantic_Intraday",
"ISO_pjm_pe_1_DA",
"TESLA_pjm_pe_1_DA",
"ISO_pjm_pe_2_DA",
"TESLA_pjm_pe_2_DA",
"ISO_pjm_pe_3_DA",
"TESLA_pjm_pe_3_DA",
"ISO_pjm_pe_4_DA",
"TESLA_pjm_pe_4_DA",
"ISO_pjm_pe_Intraday",
"TESLA_pjm_pe_Intraday",
"ISO_pjm_pep_1_DA",
"TESLA_pjm_pep_1_DA",
"ISO_pjm_pep_2_DA",
"TESLA_pjm_pep_2_DA",
"ISO_pjm_pep_3_DA",
"TESLA_pjm_pep_3_DA",
"ISO_pjm_pep_4_DA",
"TESLA_pjm_pep_4_DA",
"ISO_pjm_pep_Intraday",
"TESLA_pjm_pep_Intraday",
"ISO_pjm_pl_1_DA",
"TESLA_pjm_pl_1_DA",
"ISO_pjm_pl_2_DA",
"TESLA_pjm_pl_2_DA",
"ISO_pjm_pl_3_DA",
"TESLA_pjm_pl_3_DA",
"ISO_pjm_pl_4_DA",
"TESLA_pjm_pl_4_DA",
"ISO_pjm_pl_Intraday",
"TESLA_pjm_pl_Intraday",
"ISO_pjm_pn_1_DA",
"TESLA_pjm_pn_1_DA",
"ISO_pjm_pn_2_DA",
"TESLA_pjm_pn_2_DA",
"ISO_pjm_pn_3_DA",
"TESLA_pjm_pn_3_DA",
"ISO_pjm_pn_4_DA",
"TESLA_pjm_pn_4_DA",
"ISO_pjm_pn_Intraday",
"TESLA_pjm_pn_Intraday",
"ISO_pjm_ps_1_DA",
"TESLA_pjm_ps_1_DA",
"ISO_pjm_ps_2_DA",
"TESLA_pjm_ps_2_DA",
"ISO_pjm_ps_3_DA",
"TESLA_pjm_ps_3_DA",
"ISO_pjm_ps_4_DA",
"TESLA_pjm_ps_4_DA",
"ISO_pjm_ps_Intraday",
"TESLA_pjm_ps_Intraday",
"ISO_pjm_reco_1_DA",
"TESLA_pjm_reco_1_DA",
"ISO_pjm_reco_2_DA",
"TESLA_pjm_reco_2_DA",
"ISO_pjm_reco_3_DA",
"TESLA_pjm_reco_3_DA",
"ISO_pjm_reco_4_DA",
"TESLA_pjm_reco_4_DA",
"ISO_pjm_reco_Intraday",
"TESLA_pjm_reco_Intraday",
"ISO_pjm_rto_1_DA",
"TESLA_pjm_rto_1_DA",
"ISO_pjm_rto_2_DA",
"TESLA_pjm_rto_2_DA",
"ISO_pjm_rto_3_DA",
"TESLA_pjm_rto_3_DA",
"ISO_pjm_rto_4_DA",
"TESLA_pjm_rto_4_DA",
"ISO_pjm_rto_Intraday",
"TESLA_pjm_rto_Intraday",
"ISO_pjm_southern_1_DA",
"TESLA_pjm_southern_1_DA",
"ISO_pjm_southern_2_DA",
"TESLA_pjm_southern_2_DA",
"ISO_pjm_southern_3_DA",
"TESLA_pjm_southern_3_DA",
"ISO_pjm_southern_4_DA",
"TESLA_pjm_southern_4_DA",
"ISO_pjm_southern_Intraday",
"TESLA_pjm_southern_Intraday",
"ISO_pjm_total_1_DA",
"TESLA_pjm_total_1_DA",
"ISO_pjm_total_2_DA",
"TESLA_pjm_total_2_DA",
"ISO_pjm_total_3_DA",
"TESLA_pjm_total_3_DA",
"ISO_pjm_total_4_DA",
"TESLA_pjm_total_4_DA",
"ISO_pjm_total_Intraday",
"TESLA_pjm_total_Intraday",
"ISO_pjm_west_zonal_total_1_DA",
"TESLA_pjm_west_zonal_total_1_DA",
"ISO_pjm_west_zonal_total_2_DA",
"TESLA_pjm_west_zonal_total_2_DA",
"ISO_pjm_west_zonal_total_3_DA",
"TESLA_pjm_west_zonal_total_3_DA",
"ISO_pjm_west_zonal_total_4_DA",
"TESLA_pjm_west_zonal_total_4_DA",
"ISO_pjm_west_zonal_total_Intraday",
"TESLA_pjm_west_zonal_total_Intraday",
"ISO_pjm_western_1_DA",
"TESLA_pjm_western_1_DA",
"ISO_pjm_western_2_DA",
"TESLA_pjm_western_2_DA",
"ISO_pjm_western_3_DA",
"TESLA_pjm_western_3_DA",
"ISO_pjm_western_4_DA",
"TESLA_pjm_western_4_DA",
"ISO_pjm_western_Intraday",
"TESLA_pjm_western_Intraday",
#neiso (55)
"TESLA_neiso_ct_1_DA",
"TESLA_neiso_ct_2_DA",
"TESLA_neiso_ct_3_DA",
"TESLA_neiso_ct_4_DA",
"TESLA_neiso_ct_Intraday",
"TESLA_neiso_me_1_DA",
"TESLA_neiso_me_2_DA",
"TESLA_neiso_me_3_DA",
"TESLA_neiso_me_4_DA",
"TESLA_neiso_me_Intraday",
"TESLA_neiso_nemass_1_DA",
"TESLA_neiso_nemass_2_DA",
"TESLA_neiso_nemass_3_DA",
"TESLA_neiso_nemass_4_DA",
"TESLA_neiso_nemass_Intraday",
"TESLA_neiso_nh_1_DA",
"TESLA_neiso_nh_2_DA",
"TESLA_neiso_nh_3_DA",
"TESLA_neiso_nh_4_DA",
"TESLA_neiso_nh_Intraday",
"TESLA_neiso_ri_1_DA",
"TESLA_neiso_ri_2_DA",
"TESLA_neiso_ri_3_DA",
"TESLA_neiso_ri_4_DA",
"TESLA_neiso_ri_Intraday",
"TESLA_neiso_rt_1_DA",
"TESLA_neiso_rt_2_DA",
"TESLA_neiso_rt_3_DA",
"TESLA_neiso_rt_4_DA",
"TESLA_neiso_rt_Intraday",
"TESLA_neiso_semass_1_DA",
"TESLA_neiso_semass_2_DA",
"TESLA_neiso_semass_3_DA",
"TESLA_neiso_semass_4_DA",
"TESLA_neiso_semass_Intraday",
"ISO_neiso_total_1_DA",
"TESLA_neiso_total_1_DA",
"ISO_neiso_total_2_DA",
"TESLA_neiso_total_2_DA",
"ISO_neiso_total_3_DA",
"TESLA_neiso_total_3_DA",
"ISO_neiso_total_4_DA",
"TESLA_neiso_total_4_DA",
"ISO_neiso_total_Intraday",
"TESLA_neiso_total_Intraday",
"TESLA_neiso_vt_1_DA",
"TESLA_neiso_vt_2_DA",
"TESLA_neiso_vt_3_DA",
"TESLA_neiso_vt_4_DA",
"TESLA_neiso_vt_Intraday",
"TESLA_neiso_wcmass_1_DA",
"TESLA_neiso_wcmass_2_DA",
"TESLA_neiso_wcmass_3_DA",
"TESLA_neiso_wcmass_4_DA",
"TESLA_neiso_wcmass_Intraday",
#NYISO (127)
"ISO_nyiso_capitl_1_DA",
"TESLA_nyiso_capitl_1_DA",
"ISO_nyiso_capitl_2_DA",
"TESLA_nyiso_capitl_2_DA",
"ISO_nyiso_capitl_3_DA",
"TESLA_nyiso_capitl_3_DA",
"ISO_nyiso_capitl_4_DA",
"TESLA_nyiso_capitl_4_DA",
"ISO_nyiso_capitl_Intraday",
"TESLA_nyiso_capitl_Intraday",
"ISO_nyiso_centrl_1_DA",
"TESLA_nyiso_centrl_1_DA",
"ISO_nyiso_centrl_2_DA",
"TESLA_nyiso_centrl_2_DA",
"ISO_nyiso_centrl_3_DA",
"TESLA_nyiso_centrl_3_DA",
"ISO_nyiso_centrl_4_DA",
"TESLA_nyiso_centrl_4_DA",
"ISO_nyiso_centrl_Intraday",
"TESLA_nyiso_centrl_Intraday",
"ISO_nyiso_dunwod_1_DA",
"TESLA_nyiso_dunwod_1_DA",
"ISO_nyiso_dunwod_2_DA",
"TESLA_nyiso_dunwod_2_DA",
"ISO_nyiso_dunwod_3_DA",
"TESLA_nyiso_dunwod_3_DA",
"ISO_nyiso_dunwod_4_DA",
"TESLA_nyiso_dunwod_4_DA",
"ISO_nyiso_dunwod_Intraday",
"TESLA_nyiso_dunwod_Intraday",
"ISO_nyiso_genese_1_DA",
"TESLA_nyiso_genese_1_DA",
"ISO_nyiso_genese_2_DA",
"TESLA_nyiso_genese_2_DA",
"ISO_nyiso_genese_3_DA",
"TESLA_nyiso_genese_3_DA",
"ISO_nyiso_genese_4_DA",
"TESLA_nyiso_genese_4_DA",
"ISO_nyiso_genese_Intraday",
"TESLA_nyiso_genese_Intraday",
"ISO_nyiso_hudvl_1_DA",
"TESLA_nyiso_hudvl_1_DA",
"ISO_nyiso_hudvl_2_DA",
"TESLA_nyiso_hudvl_2_DA",
"ISO_nyiso_hudvl_3_DA",
"TESLA_nyiso_hudvl_3_DA",
"ISO_nyiso_hudvl_4_DA",
"TESLA_nyiso_hudvl_4_DA",
"ISO_nyiso_hudvl_Intraday",
"TESLA_nyiso_hudvl_Intraday",
"ISO_nyiso_longil_1_DA",
"TESLA_nyiso_longil_1_DA",
"ISO_nyiso_longil_2_DA",
"TESLA_nyiso_longil_2_DA",
"ISO_nyiso_longil_3_DA",
"TESLA_nyiso_longil_3_DA",
"ISO_nyiso_longil_4_DA",
"TESLA_nyiso_longil_4_DA",
"ISO_nyiso_longil_Intraday",
"TESLA_nyiso_longil_Intraday",
"ISO_nyiso_mhkvl_1_DA",
"TESLA_nyiso_mhkvl_1_DA",
"ISO_nyiso_mhkvl_2_DA",
"TESLA_nyiso_mhkvl_2_DA",
"ISO_nyiso_mhkvl_3_DA",
"TESLA_nyiso_mhkvl_3_DA",
"ISO_nyiso_mhkvl_4_DA",
"TESLA_nyiso_mhkvl_4_DA",
"ISO_nyiso_mhkvl_Intraday",
"TESLA_nyiso_mhkvl_Intraday",
"ISO_nyiso_millwd_1_DA",
"TESLA_nyiso_millwd_1_DA",
"ISO_nyiso_millwd_2_DA",
"TESLA_nyiso_millwd_2_DA",
"ISO_nyiso_millwd_3_DA",
"TESLA_nyiso_millwd_3_DA",
"ISO_nyiso_millwd_4_DA",
"TESLA_nyiso_millwd_4_DA",
"ISO_nyiso_millwd_Intraday",
"TESLA_nyiso_millwd_Intraday",
"ISO_nyiso_north_1_DA",
"TESLA_nyiso_north_1_DA",
"ISO_nyiso_north_2_DA",
"TESLA_nyiso_north_2_DA",
"ISO_nyiso_north_3_DA",
"TESLA_nyiso_north_3_DA",
"ISO_nyiso_north_4_DA",
"TESLA_nyiso_north_4_DA",
"ISO_nyiso_north_Intraday",
"TESLA_nyiso_north_Intraday",
"ISO_nyiso_nyc_1_DA",
"TESLA_nyiso_nyc_1_DA",
"ISO_nyiso_nyc_2_DA",
"TESLA_nyiso_nyc_2_DA",
"ISO_nyiso_nyc_3_DA",
"TESLA_nyiso_nyc_3_DA",
"ISO_nyiso_nyc_4_DA",
"TESLA_nyiso_nyc_4_DA",
"ISO_nyiso_nyc_Intraday",
"TESLA_nyiso_nyc_Intraday",
"TESLA_nyiso_south_total_1_DA",
"TESLA_nyiso_south_total_2_DA",
"TESLA_nyiso_south_total_3_DA",
"TESLA_nyiso_south_total_4_DA",
"TESLA_nyiso_south_total_Intraday",
"ISO_nyiso_total_1_DA",
"TESLA_nyiso_total_1_DA",
"ISO_nyiso_total_2_DA",
"TESLA_nyiso_total_2_DA",
"ISO_nyiso_total_3_DA",
"TESLA_nyiso_total_3_DA",
"ISO_nyiso_total_4_DA",
"TESLA_nyiso_total_4_DA",
"ISO_nyiso_total_Intraday",
"TESLA_nyiso_total_Intraday",
"ISO_nyiso_west_1_DA",
"TESLA_nyiso_west_1_DA",
"ISO_nyiso_west_2_DA",
"TESLA_nyiso_west_2_DA",
"ISO_nyiso_west_3_DA",
"TESLA_nyiso_west_3_DA",
"ISO_nyiso_west_4_DA",
"TESLA_nyiso_west_4_DA",
"ISO_nyiso_west_Intraday",
"TESLA_nyiso_west_Intraday",
#ieso
"ISO_ca_ont_ieso_mkt_1_DA",
"TESLA_ca_ont_ieso_mkt_1_DA",
"ISO_ca_ont_ieso_mkt_2_DA",
"TESLA_ca_ont_ieso_mkt_2_DA",
"ISO_ca_ont_ieso_mkt_3_DA",
"TESLA_ca_ont_ieso_mkt_3_DA",
"ISO_ca_ont_ieso_mkt_4_DA",
"TESLA_ca_ont_ieso_mkt_4_DA",
"ISO_ca_ont_ieso_mkt_Intraday",
"TESLA_ca_ont_ieso_mkt_Intraday",
"TESLA_ca_ont_ieso_total_1_DA",
"TESLA_ca_ont_ieso_total_2_DA",
"TESLA_ca_ont_ieso_total_3_DA",
"TESLA_ca_ont_ieso_total_4_DA",
"TESLA_ca_ont_ieso_total_Intraday",
#AESO (10)
"ISO_ca_aeso_1_DA",
"TESLA_ca_aeso_1_DA",
"ISO_ca_aeso_2_DA",
"TESLA_ca_aeso_2_DA",
"ISO_ca_aeso_3_DA",
"TESLA_ca_aeso_3_DA",
"ISO_ca_aeso_4_DA",
"TESLA_ca_aeso_4_DA",
"ISO_ca_aeso_Intraday",
"TESLA_ca_aeso_Intraday",
#SPP (10)
"ISO_spp_1_DA",
"TESLA_spp_1_DA",
"ISO_spp_2_DA",
"TESLA_spp_2_DA",
"ISO_spp_3_DA",
"TESLA_spp_3_DA",
"ISO_spp_4_DA",
"TESLA_spp_4_DA",
"ISO_spp_Intraday",
"TESLA_spp_Intraday")

for (i in 1:length(Models)) {
# Get Stats and join
Query <- paste("SELECT TOP 14 Date, Mape_Baseload FROM", Models[i], "ORDER by Date desc")
ModelStats <- NA
ModelStats <- sqlQuery(MyConnection,Query)
ModelStats[2] <- round(as.numeric(as.character(ModelStats$Mape_Baseload)), digits = 2) 
names(ModelStats)[2] <- Models[i]

  if(i==1) {Stats <- merge(Date, ModelStats, by = "Date", all.x= TRUE)}
  else { Stats <- merge(Stats, ModelStats, by = "Date", all.x= TRUE)}
}


# Shaping before sending 
Stats <- Stats[order(Stats$Date, decreasing = T),]
Stats$Date <- paste(str_sub(Stats$Date,-2,-1),str_sub(Stats$Date,5,6),str_sub(Stats$Date,1,4), sep= "/")

# Get weekdays for final table
Stats <-  cbind(weekdays(strptime(Stats$Date, format = "%d/%m/%Y"), abbreviate = TRUE), Stats)
names(Stats)[1] <- "Weekdays"
avg <- colMeans(Stats[3:length(Stats)], na.rm = TRUE)
Stats <- rbind(Stats, c(NA,NA,round(avg, digits = 2)))
Stats <- t(Stats)


#----------------------------------------------------------------------------------------------------------------------
#Writing xls
#----------------------------------------------------------------------------------------------------------------------

wb <- loadWorkbook("//steven2-pc/c$/bin/r_stuff/Stats_Report_Template1.xlsx")

setStyleAction(wb,XLC$"STYLE_ACTION.NONE")

#CAISO
#--------------------------------------
# DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="CAISO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 3:79) {
writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="CAISO", startRow = i+2, startCol = 2, header = FALSE, rownames= FALSE)
}

#ERCOT
#--------------------------------------
# DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="ERCOT", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 80:175) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="ERCOT", startRow = i-75, startCol = 2, header = FALSE, rownames= FALSE)
}

#MISO
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="MISO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 176:259) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="MISO", startRow = i-171, startCol = 2, header = FALSE, rownames= FALSE)
}

#PJM
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="PJM", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 260:529) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="PJM", startRow = i-255, startCol = 2, header = FALSE, rownames= FALSE)
}


#NEISO
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="NEISO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 530:584) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="NEISO", startRow = i-525, startCol = 2, header = FALSE, rownames= FALSE)
}

#NYISO
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="NYISO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 585:709) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="NYISO", startRow = i-575, startCol = 2, header = FALSE, rownames= FALSE)
}

#IESO
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="IESO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 710:724) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="IESO", startRow = i-703, startCol = 2, header = FALSE, rownames= FALSE)
}

#AESO
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="AESO", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 726:732) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="AESO", startRow = i-720, startCol = 2, header = FALSE, rownames= FALSE)
}

#SPP
#--------------------------------------
#DAY and Date 
writeWorksheet(wb, Stats[1:2,1:14], sheet ="SPP", startRow = 2, startCol = 2, header = FALSE)
#TESLA & RTOS
for (i in 733:740) {
  writeWorksheet(wb, t(as.numeric(Stats[i,])), sheet ="AESO", startRow = i-728, startCol = 2, header = FALSE, rownames= FALSE)
}

# Saving workbook
#=========================================================================================================
saveWorkbook(wb, "C:/bin/Stats_Report.xlsx")


# Closing connections
#==========================================================================================================
odbcCloseAll()