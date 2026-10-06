"""Finite fixed-support-size cohorts; execute in the validated Colab session."""
density_orbits,density_basis,density_indices=research.make_tables(16,5)
density_engine=research.Evaluator(density_basis,density_indices,'cuda')
density_rng=np.random.default_rng(90261006)
density_records=[]
for density_k in [4,5,6,8,12,16,24,32,48,64,96,128,192,256]:
    density_count=density_weight_ok=density_strict=density_all=0
    density_max_weight=0;density_best=255
    for density_chunk in range(8):
        density_c=np.zeros((1024,273),np.uint8)
        density_positions=np.argsort(density_rng.random((1024,273)),axis=1)[:,:density_k]
        density_c[np.arange(1024)[:,None],density_positions]=1
        density_w,density_d=original_eval(density_engine,density_c)
        density_weight=density_w.sum(axis=1)
        density_pass=np.isin(density_weight,[32640,32896])
        density_s=density_pass&(density_d==32768)&(density_w[:,-1]==128)
        density_bad=(density_w[:,1:]!=128).sum(axis=1)
        density_count+=len(density_c);density_weight_ok+=int(density_pass.sum())
        density_strict+=int(density_s.sum());density_all+=int((density_bad==0).sum())
        density_max_weight=max(density_max_weight,int(density_weight.max()))
        density_best=min(density_best,int(density_bad.min()))
    density_row={'active_orbits':density_k,'draws':density_count,'passing_weight':density_weight_ok,
                 'passing_all_three':density_strict,'all_fiber_survivors':density_all,
                 'maximum_sample_weight':density_max_weight,'minimum_sample_bad_fibers':density_best}
    density_records.append(density_row);print('DENSIDADE',json.dumps(density_row),flush=True)
(COND_ROOT/'densities.json').write_text(json.dumps({'gpu':density_engine.gpu,'seed':90261006,
   'records':density_records,'limitations':'Fixed-size random draws may repeat; no universal support bound.'},indent=2))
del density_engine,density_basis,density_indices
