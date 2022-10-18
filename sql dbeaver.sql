modif cd_ref

update flore.observation
set cd_ref = erreur_taxons_txt.cd_ref_revu
from z_temp_cbna.erreur_taxons_txt 
where observation.id_observation = erreur_taxons_txt.id_observation

ajout geom

update flore.releve
set geom_zone_2154 = geom_acer_txt.geom
from z_temp_cbna.geom_acer_txt
where releve.id_releve = geom_acer_txt.id_releve

Comparaison uuid

select *
from z_temp_cbna.pnv20 p
join flore.releve r
on p.id_releve_sinp = r.id_releve_sinp


nb_obs_maille 5km paca

with observations_p as (
select r.geom_2154 ,r.id_releve ,count(*) as nbobs
from flore.observation o
join flore.releve r 
on o.id_releve = r.id_releve 
join referentiels.taxref t
on o.cd_ref = t.cd_nom
where o.valid_reg in (1,2) and t.tax_type ='P' and r.insee_dept in ('06','04','05','13','83','84')
--and (date_part('year',r.date_releve_deb)>= 2000 or date_part('year',r.date_releve_fin) >= 2000)
and (date_part('year',r.date_releve_deb)< 2000 or date_part('year',r.date_releve_fin) < 2000)
-- and (date_part('year',r.date_releve_deb)< 1989 or date_part('year',r.date_releve_fin) < 1989)
-- and (date_part('year',r.date_releve_deb)>= 1989 or date_part('year',r.date_releve_fin) >= 1989 )and (date_part('year',r.date_releve_deb)< 2000 and date_part('year',r.date_releve_fin) < 2000 )
-- and (date_part('year',r.date_releve_deb)>= 2000 or date_part('year',r.date_releve_fin) >= 2000 )and (date_part('year',r.date_releve_deb)< 2011 and date_part('year',r.date_releve_fin) < 2011 )
-- and (date_part('year',r.date_releve_deb)>= 2011 or date_part('year',r.date_releve_fin) >= 2011 )and (date_part('year',r.date_releve_deb)< 2022 and date_part('year',r.date_releve_fin) < 2022 )
group by r.geom_2154 ,r.id_releve)

select m1.code5km , sum(o1.nbobs) as nb_obs
from z_temp_cbna.mailles_5km_paca m1 , observations_p o1
where st_contains(m1.geom,o1.geom_2154)
group by m1.code5km 
