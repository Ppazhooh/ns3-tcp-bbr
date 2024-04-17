rm traces/bbr/*
rm JF_results.txt
rm JFSetting.txt
echo copa_flow_nums,cubic_flow_numes,delay_par,link_owd,link_bw,q_delay >> JFSetting.txt
echo JF_Index >> JF_results.txt
for copa_flow_nums in {2..6}
do
    for cubic_flow_numes in {2..6}
    do
        for delay_par in 0.01 0.05 0.1 0.2 0.4 0.8
        # for delay_par in 0.01 0.05 0.1 0.2 0.3
        do
            for link_owd in 5 10 20
            # for link_owd in 5
            do
                for link_bw in 5000000 10000000 20000000 40000000
                # for link_bw in 5000000
                do
                    for q_delay in 50 100 200 400 800 
                    # for q_delay in 100
                    do
                        echo $copa_flow_nums,$cubic_flow_numes,$delay_par,$link_owd,$link_bw,$q_delay >> JFSetting.txt

                        rm traces/bbr/*
                        ./waf --run "scratch/tcp-test
                                    --cc=copa 
                                    --folder=bbr 
                                    --copa_flow_nums=$copa_flow_nums
                                    --cubic_flow_nums=$cubic_flow_numes 
                                    --link_bw=$link_bw
                                    --link_owd=$link_owd
                                    --q_delay=$q_delay
                                    --delay_par=$delay_par"
                        ~/anaconda3/envs/py3/bin/python JF.py
                    done
                done
            done
        done
    done
done