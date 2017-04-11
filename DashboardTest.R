## app.R ##
library(shiny)
library(shinydashboard)
library(RODBCext)
library(RODBC)
library(DT)
library(lubridate)
library(ggplot2)
library(rsconnect)


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
  #PJM (98)
  "TESLA_pjm_ae_1_DA",
  "TESLA_pjm_ae_2_DA",
  "TESLA_pjm_ae_3_DA",
  "TESLA_pjm_ae_4_DA",
  "ISO_pjm_ae_Intraday",
  "TESLA_pjm_ae_Intraday",
  "TESLA_pjm_bc_1_DA",
  "TESLA_pjm_bc_2_DA",
  "TESLA_pjm_bc_3_DA",
  "TESLA_pjm_bc_4_DA",
  "ISO_pjm_bc_Intraday",
  "TESLA_pjm_bc_Intraday",
  "TESLA_pjm_dpl_1_DA",
  "TESLA_pjm_dpl_2_DA",
  "TESLA_pjm_dpl_3_DA",
  "TESLA_pjm_dpl_4_DA",
  "ISO_pjm_dpl_Intraday",
  "TESLA_pjm_dpl_Intraday",
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
  "TESLA_pjm_jc_1_DA",
  "TESLA_pjm_jc_2_DA",
  "TESLA_pjm_jc_3_DA",
  "TESLA_pjm_jc_4_DA",
  "TESLA_pjm_jc_Intraday",
  "TESLA_pjm_me_1_DA",
  "TESLA_pjm_me_2_DA",
  "TESLA_pjm_me_3_DA",
  "TESLA_pjm_me_4_DA",
  "TESLA_pjm_me_Intraday",
  "TESLA_pjm_pe_1_DA",
  "TESLA_pjm_pe_2_DA",
  "TESLA_pjm_pe_3_DA",
  "TESLA_pjm_pe_4_DA",
  "TESLA_pjm_pe_Intraday",
  "TESLA_pjm_pep_1_DA",
  "TESLA_pjm_pep_2_DA",
  "TESLA_pjm_pep_3_DA",
  "TESLA_pjm_pep_4_DA",
  "TESLA_pjm_pep_Intraday",
  "TESLA_pjm_pl_1_DA",
  "TESLA_pjm_pl_2_DA",
  "TESLA_pjm_pl_3_DA",
  "TESLA_pjm_pl_4_DA",
  "TESLA_pjm_pl_Intraday",
  "TESLA_pjm_pn_1_DA",
  "TESLA_pjm_pn_2_DA",
  "TESLA_pjm_pn_3_DA",
  "TESLA_pjm_pn_4_DA",
  "TESLA_pjm_pn_Intraday",
  "TESLA_pjm_ps_1_DA",
  "TESLA_pjm_ps_2_DA",
  "TESLA_pjm_ps_3_DA",
  "TESLA_pjm_ps_4_DA",
  "TESLA_pjm_ps_Intraday",
  "TESLA_pjm_reco_1_DA",
  "TESLA_pjm_reco_2_DA",
  "TESLA_pjm_reco_3_DA",
  "TESLA_pjm_reco_4_DA",
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
  "ISO_nyiso_south_total_1_DA",
  "TESLA_nyiso_south_total_1_DA",
  "TESLA_nyiso_south_total_2_DA",
  "TESLA_nyiso_south_total_3_DA",
  "TESLA_nyiso_south_total_4_DA",
  "ISO_nyiso_south_total_Intraday",
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
  "TESLA_ca_ont_ieso_mkt_14_DA",
  "ISO_ca_ont_ieso_mkt_2_DA",
  "TESLA_ca_ont_ieso_mkt_2_DA",
  "ISO_ca_ont_ieso_mkt_3_DA",
  "TESLA_ca_ont_ieso_mkt_3_DA",
  "ISO_ca_ont_ieso_mkt_4_DA",
  "TESLA_ca_ont_ieso_mkt_4_DA",
  "TESLA_ca_ont_ieso_mkt_7_DA",
  "ISO_ca_ont_ieso_mkt_Intraday",
  "TESLA_ca_ont_ieso_mkt_Intraday",
  "ISO_ca_ont_ieso_total_1_DA",
  "TESLA_ca_ont_ieso_total_1_DA",
  "TESLA_ca_ont_ieso_total_14_DA",
  "TESLA_ca_ont_ieso_total_2_DA",
  "TESLA_ca_ont_ieso_total_3_DA",
  "TESLA_ca_ont_ieso_total_4_DA",
  "TESLA_ca_ont_ieso_total_7_DA",
  "ISO_ca_ont_ieso_total_Intraday",
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
  "TESLA_alliant_east_lr_Intraday",
  "TESLA_alliant_east_lr_1_DA",
  "TESLA_alliant_east_lr_2_DA",
  "TESLA_alliant_east_lr_7_DA",
  "TESLA_alliant_west_lr_Intraday",
  "TESLA_alliant_west_lr_1_DA",
  "TESLA_alliant_west_lr_2_DA",
  "TESLA_alliant_west_lr_7_DA")


Models<-sort(Models, decreasing = F)


ui <- dashboardPage( skin="blue", 
  dashboardHeader(title="Mape Dashboard"),
  dashboardSidebar(selectInput("gId", "Select Stat for Plot 1", c(
    "Week_Number",
    "Week_Day", 
    "Mape_Baseload",
    "Mape_Peak",
    "Mape_OffPeak",
    "Mape_Block_1_2",
    "Mape_Block_3_4",
    "Mape_Block_5",
    "Mape_Block_6",
    "Mape_Block_1A",
    "Mape_Block_1B",
    "Mape_Block_2A",
    "Mape_Block_2B",
    "Mape_Block_3A",
    "Mape_Block_3B",
    "Mape_Block_4A",
    "Mape_Block_4B",
    "Mape_Block_5A",
    "Mape_Block_5B",
    "Mape_Block_6A",
    "Mape_Block_6B",
    "Bias_Baseload",
    "Bias_Peak",
    "Bias_OffPeak",
    "Bias_Block_1_2",
    "Bias_Block_3_4",
    "Bias_Block_5",
    "Bias_Block_6",
    "Max_Act",
    "Max_Fcst",
    "Max_Hour_Act", 
    "Max_Hour_Fcst",
    "Min_Act",
    "Min_Fcst",
    "Min_Hour_Act",
    "Min_Hour_Fcst",
    "RMSE",
    "NOBS",
    "Fcst_Prod_Time" ), selected="Mape_Baseload"),
    selectizeInput("Id", "Select Model Name", Models, multiple=FALSE),
                   dateInput("date1",
                                  label = "Select Start Date", value="2017-03-01",
                                  min = "2017-01-01", max = "2017-12-31"),
                   dateInput("date2",
                             label = "Select End Date",
                             min = "2017-01-01", max = "2017-12-31"),
    selectInput("gId3", "Select Stat for Plot 2", c(
      "Week_Number",
      "Week_Day", 
      "Mape_Baseload",
      "Mape_Peak",
      "Mape_OffPeak",
      "Mape_Block_1_2",
      "Mape_Block_3_4",
      "Mape_Block_5",
      "Mape_Block_6",
      "Mape_Block_1A",
      "Mape_Block_1B",
      "Mape_Block_2A",
      "Mape_Block_2B",
      "Mape_Block_3A",
      "Mape_Block_3B",
      "Mape_Block_4A",
      "Mape_Block_4B",
      "Mape_Block_5A",
      "Mape_Block_5B",
      "Mape_Block_6A",
      "Mape_Block_6B",
      "Bias_Baseload",
      "Bias_Peak",
      "Bias_OffPeak",
      "Bias_Block_1_2",
      "Bias_Block_3_4",
      "Bias_Block_5",
      "Bias_Block_6",
      "Max_Act",
      "Max_Fcst",
      "Max_Hour_Act", 
      "Max_Hour_Fcst",
      "Min_Act",
      "Min_Fcst",
      "Min_Hour_Act",
      "Min_Hour_Fcst",
      "RMSE",
      "NOBS",
      "Fcst_Prod_Time" ), selected="Mape_Baseload"),
    selectizeInput("Id2", "Select 2nd Model Name", Models, multiple=FALSE),
    dateInput("date3",
              label = "Select Start Date", value="2017-03-01",
              min = "2017-01-01", max = "2017-12-31"),
    dateInput("date4",
              label = "Select End Date",
              min = "2017-01-01", max = "2017-12-31"),
    submitButton(text="Submit")
    ),
  dashboardBody(tabsetPanel(tabPanel ("Model 1 Plot", (plotOutput("MapeGraph"))), tabPanel("Table",(DT::dataTableOutput("qTable")))),
                tabsetPanel(tabPanel ("Model 2 Plot", (plotOutput("MapeGraph2"))), tabPanel("Table",(DT::dataTableOutput("qTable2"))))
))
server <- function(input, output) {  

  output$MapeGraph <- renderPlot({ 
    
    #connect to database 
    
    usdbsvr9 <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;trusted_connection=true')
    
    #create file name
    
    filename <-  paste0(input$Id)
    filename2 <- paste0(input$Id2)
    
    #prepare query
    
    query1 <-  paste0("select * from tesla.dbo.",filename,"")
    
    # perform query 
    res <- sqlQuery(usdbsvr9, query1)
    
    #Change Date formats for compatability with input criteria
    
    res$Date<- as.character(res$Date)
    res$Date<- as.Date(res$Date,"%Y%m%d")
    
    #Truncate table according to inputs
    res_subset <- reactive({
      a <- subset(res, Date >= input$date1 & Date <= input$date2)
      return(a)
    })
  b <- res_subset()

  
  
    #prepare second query
  query2 <-  paste0("select * from tesla.dbo.",filename2,"")
  
  res2 <- sqlQuery(usdbsvr9, query2)
  
  res2$Date<- as.character(res2$Date)
  res2$Date<- as.Date(res2$Date,"%Y%m%d")
  res2_subset <- reactive({
    c <- subset(res2, Date >= input$date1 & Date <= input$date2)
    return(c)
  })
  c <- res2_subset()
  
 ##Plot both
  
  
  ggplot()+geom_line(data=b, aes_string(x=b$Date, y=input$gId))
  #+geom_line(data=c, aes_string(x=c$Date, y=input$gId))
 

  
  })
  
  output$qTable <- DT::renderDataTable({
    #connect to database 
    
    usdbsvr9 <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;trusted_connection=true')
    #create file name
    
    filename <-  paste0(input$Id)
    
    #prepare query
    
    query1 <-  paste0("select * from tesla.dbo.",filename,"")
    
    
    
    res <- sqlQuery(usdbsvr9, query1)
    
    res$Date<- as.character(res$Date)
    res$Date<- as.Date(res$Date,"%Y%m%d")
    res12 <- rapply(object = res, f = round, classes = "numeric", how = "replace", digits = 2) 
    
    
    res_subset <- reactive({
      a <- subset(res12, Date >= input$date1 & Date <= input$date2)
    return(a)
    })
    res_subset()
    #tabler[,-2] <- round(tabler[,-2],2)
    #tabler
    
  }  , extensions = 'Buttons', filter= 'top', options = list(pageLength=5, autoWidth=TRUE, scrollX=TRUE,
                                                             dom = 'Bfrtip',
                                                             buttons = c('copy'), keys=TRUE)
  )
  output$MapeGraph2 <- renderPlot({ 
    
    #connect to database 
    
    usdbsvr9 <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;trusted_connection=true')
    
    #create file name
    
    filename <-  paste0(input$Id)
    filename2 <- paste0(input$Id2)
    
    #prepare query
    
    query1 <-  paste0("select * from tesla.dbo.",filename2,"")
    
    # perform query 
    res <- sqlQuery(usdbsvr9, query1)
    
    #Change Date formats for compatability with input criteria
    
    res$Date<- as.character(res$Date)
    res$Date<- as.Date(res$Date,"%Y%m%d")
    
    #Truncate table according to inputs
    res_subset <- reactive({
      a <- subset(res, Date >= input$date1 & Date <= input$date2)
      return(a)
    })
    b <- res_subset()
    
    
    
    #prepare second query
    query2 <-  paste0("select * from tesla.dbo.",filename2,"")
    
    res2 <- sqlQuery(usdbsvr9, query2)
    
    res2$Date<- as.character(res2$Date)
    res2$Date<- as.Date(res2$Date,"%Y%m%d")
    res2_subset <- reactive({
      c <- subset(res2, Date >= input$date3 & Date <= input$date4)
      return(c)
    })
    c <- res2_subset()
    
    ##Plot both
    
    
    ggplot()+geom_line(data=c, aes_string(x=c$Date, y=input$gId3)) 
    #+geom_line(data=c, aes_string(x=c$Date, y=input$gId3))
    
    
    
  })
  
  output$qTable2 <- DT::renderDataTable({
    #connect to database 
    
    usdbsvr9 <- odbcDriverConnect('driver={SQL Server};server=usdbsvr9;trusted_connection=true')
    #create file name
    
    filename12 <-  paste0(input$Id2)
    
    #prepare query
    
    query12 <-  paste0("select * from tesla.dbo.",filename12,"")
    
    
    
    res3 <- sqlQuery(usdbsvr9, query12)
    
    res3$Date<- as.character(res3$Date)
    res3$Date<- as.Date(res3$Date,"%Y%m%d")
     res32 <- rapply(object = res3, f = round, classes = "numeric", how = "replace", digits = 2) 
    res3_subset <- reactive({
      a <- subset(res32, Date >= input$date1 & Date <= input$date2)
      return(a)
    })
    res3_subset()
    
  }, extensions = 'Buttons', filter= 'top', options = list(pageLength=5, autoWidth=TRUE, scrollX=TRUE,
                                               dom = 'Bfrtip',
                                               buttons = 'copy', keys=TRUE)
  )
  
  
  }

app <- shinyApp(ui, server)
runApp(app, host="0.0.0.0",port=5050)

