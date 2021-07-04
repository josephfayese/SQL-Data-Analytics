--- Device Bundle Analysis
select tbl_dt, 
case
  when  serviceclassid in ( '184','185','186','191','1000','1009','1010','1011','1012','1013')  then 'Prepaid'
  else 'Postpaid'
end svc_category,
case
  when serviceclassid in ('300','301','311','312','334','308','315','317','318','302','313','336','150') then 'Corporate EvaluPlus'
  when serviceclassid in ('319','320','321','325','326','331','332','333','327','328','329','330','322','323','324') then 'SME EvaluPlus'
  when serviceclassid in ('1000','1009','1010','1011','1012','1013') then 'Visafone Prepaid'
  when serviceclassid in ('1050','1051','1052','1053','1055') then 'Visafone Postpaid'
  when serviceclassid = '186' then 'Biz Plus'
  when serviceclassid = '185' then 'Biz Class'
  when serviceclassid = '184' then 'Mifi'
  when serviceclassid = '191' then 'HyNetflex'
  else 'Others'
end service_category,
case 
  when partner_name = 'IDB' then 'IDB Bundle'
  when partner_name = 'SME Data Share'then 'SME DataShare Bundle'
  when partner_name = 'SME Deskphone Voice bundle' then 'SME Deskphone Bundle'
  when partner_name = 'Sponsored data pass' then 'Sponsored Data Pass'
  when partner_name = 'MTN BizPlus' then 'MTN BizPlus Bundle'
  when partner_name = 'Roaming Bundle' then 'Roaming Bundle'
  when partner_name = 'HelloWorld Roaming' then 'HelloWorld Bundle'
  when partner_name = 'HyNetflex' then 'HyNetflex Bundle'
  when vascode in ('450','23401220000012828') then 'SME VPack Bundle'
  when partner_name = 'SuperValue Bundle' then 'SuperValue Bundle'
  when partner_name = 'M2M' then 'M2M Bundle'
  when partner_name = 'Data Bundle' and upper(product_name) like 'POSTPAID DATA%' then 'Postpaid Data Bundle'
  else 'Prepaid Data Bundle'
end product_category,
vascode,
product_name product_type,
round(sum(sub_fee)/case when tbl_dt < 20200205 then 1.05 else 1.075 end, 2) rev,
count(msisdn_key) subscription_count,
count(distinct msisdn_key) Customer_count
from nigeria.hsdp_sumd
where tbl_dt >= 20200101
and serviceclassid in ('300','301','311','312','334','308','315','317','318','302','313','336','319','320','321','325','326','331','332','333','327','328','329','330','322','323','324','150','186','185','184','191','1000','1009','1010','1011','1012','1013','1050','1051','1052','1053','1055')
and sub_fee > 0
and (
    partner_name in ('IDB Bundle','Data Bundle','MTN BizPlus','Roaming Bundle','HelloWorld Roaming','SuperValue Bundle','HyNetflex','SME Data Share','SME Deskphone Voice bundle','M2M','MTN BizPlus','Sponsored data pass')
    or vascode in ('450','23401220000012828')
    )
group by tbl_dt, 
case
    when  serviceclassid in ( '184','185','186','191','1000','1009','1010','1011','1012','1013')  then 'Prepaid'
    else 'Postpaid'
end,
case
  when serviceclassid in ('300','301','311','312','334','308','315','317','318','302','313','336','150') then 'Corporate EvaluPlus'
  when serviceclassid in ('319','320','321','325','326','331','332','333','327','328','329','330','322','323','324') then 'SME EvaluPlus'
  when serviceclassid in ('1000','1009','1010','1011','1012','1013') then 'Visafone Prepaid'
  when serviceclassid in ('1050','1051','1052','1053','1055') then 'Visafone Postpaid'
  when serviceclassid = '186' then 'Biz Plus'
  when serviceclassid = '185' then 'Biz Class'
  when serviceclassid = '184' then 'Mifi'
  when serviceclassid = '191' then 'HyNetflex'
  else 'Others'
end,
case 
  when partner_name = 'IDB' then 'IDB Bundle'
  when partner_name = 'SME Data Share'then 'SME DataShare Bundle'
  when partner_name = 'SME Deskphone Voice bundle' then 'SME Deskphone Bundle'
  when partner_name = 'Sponsored data pass' then 'Sponsored Data Pass'
  when partner_name = 'MTN BizPlus' then 'MTN BizPlus Bundle'
  when partner_name = 'Roaming Bundle' then 'Roaming Bundle'
  when partner_name = 'HelloWorld Roaming' then 'HelloWorld Bundle'
  when partner_name = 'HyNetflex' then 'HyNetflex Bundle'
  when vascode in ('450','23401220000012828') then 'SME VPack Bundle'
  when partner_name = 'SuperValue Bundle' then 'SuperValue Bundle'
  when partner_name = 'M2M' then 'M2M Bundle'
  when partner_name = 'Data Bundle' and upper(product_name) like 'POSTPAID DATA%' then 'Postpaid Data Bundle'
  else 'Prepaid Data Bundle'
end,
vascode,
product_name
