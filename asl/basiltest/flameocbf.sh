for i in 81725
81760
82492
82790
83454
83835
83999
84688
84761
85173
85853
86444
86924
87135
87563
87601
88209
88402
88773
89377
90060
90077
90262
90281
91962
92193
92211
92554
92927
93051
93169
93278
93406
93787
94848
95015
95057
96659
97092
97994
98314
98394
98871
99604
99949
104235
104785
105168
105176
105860
105979
106039
106331
106880
109521
110828
112061
112126
112332
112694
114713
114990
116019
117397
118864
118990
119791
120562
121001
121085
121670
122522
122528
122916
125511
125535
125554
126176
126554
126903
127305
127417
127611
128154
129405
129886
129926
130121
130211
130687
132179
132657
133220; do  
   img1= 
   img2=  
    echo '' >> /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/flameo/grcbflist.csv
    echo '' >> /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/flameo/pncbflist.csv
done   
cbgr=
cbpn=
fslmerge -t    /data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/flameo/grcbf.nii.gz    ''
fslmerge -t    /data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/flameo/pncbf.nii.gz    ''
   flameo --copefile=/data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/flameo/grcbf.nii.gz  --mask=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz  --dm=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/grmcov.mat --tc=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/contrast.con --cs=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/group.grp --runmode=flame1 --ld=/data/jux/BBL/studies/grmpy/processedData/basil_asl/grmpy/flameo/cbfstats
   flameo --copefile=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/flameo/pncbf.nii.gz  --mask=/data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz  --dm=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/pnccov.mat --tc=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/contrast.con --cs=/data/jux/BBL/projects/grmpyProcessing/grmpyProcessing2017Scripts/asl/basiltest/flameo/group.grp --runmode=flame1 --ld=/data/jux/BBL/studies/grmpy/processedData/basil_asl/pnc/flameo/cbfstats

