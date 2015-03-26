select A.st as state, 100*C.popvote2012 as popular_vote2012, Active, Total, 100*active/total as hamp_approval_rate 
from 
( SELECT st, count(*) as Active
from [eaftc-free:unofficialhamp.mods201501] as mods
JOIN [eaftc-free:unofficialhamp.msas] as msas
ON mods.prop_geoc_cnsus_msa_cd=msas.msa
WHERE ln_st_cd==2 and ln_mdfc_mode_cd==2
GROUP BY st
) as A 
JOIN EACH 
( SELECT st, count(*) as Total
from [eaftc-free:unofficialhamp.mods201501] as mods
JOIN [eaftc-free:unofficialhamp.msas] as msas
ON mods.prop_geoc_cnsus_msa_cd=msas.msa
GROUP BY st
) as B
ON A.st=B.st
LEFT JOIN ( SELECT st, (pop_Romney-pop_Obama)/pop_Total as popvote2012
from [eaftc-free:unofficialhamp.vote2012]) as C
ON A.st=C.st
order by C.popvote2012 asc

