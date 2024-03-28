CREATE VIEW DataForRegression as
SELECT Word,AvgEng as GeneralFreq,AvgEng *0  as RealFreq  
from freq_of_words;




#Store info for regression formula in a view 
# GeneralFreq is the actual engagemnet based on the platform
# RealFreq is the mathimatical engagement based on the statistics
