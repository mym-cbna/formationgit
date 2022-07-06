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
