##Implement of Random Forest
In this project, we have two implements of random forest on MATLAB, with preprocessing and without preprocessing. The source code is shown on the folders. 

##How to ran the code
RandomForest.m is the main file to conduct random forest process, by which user can just write some commands in the command window to run the program. In order to simplify the process to run the code, we provide a file named Main.m to list frequently used commands, and users can choose to select the command they want to run, and then paste the command to the command window of MATLAB or just choose the “run this command” option. (See Main.m for more details)
Main Step to run: 
1)	“initial” command to initial parameters
2)	“load_traning_dataset” command to load training dataset
3)	In preprocessing version, use “preprocessing” command to preprocess dataset
4)	“validation” command to set the way to conduct training and testing process

##Different components between to implements
Compared with implementing random forest without preprocessing, the version with preprocessing include files like Preprocessing.m, FeatureExtraction.m, and other method files to conduct preprocessing works. Besides, the formatted of loaded dataset is different between this two different versions. The version without preprocessing use table to access data, and another version use matrix-formatted data from preprocessing.

##Others
1.	In order to quickly review the code, we just provide 5,000 training dataset on the folder, and users can found the full dataset at http://yann.lecun.com/exdb/mnist/index.html
2.	Preprocessing is the way tried to improve performance, but the result is not good enough. We need to add more preprocessing and feature extraction works to improve the performance.
3.	These two version of random forest has including some measures we found from papers to increase accuracy and have a slight improvement. However, it makes the running time of our random forest longer and we currently don’t optimize for that yet.

##Results
See <a href="https://github.com/chc2212/Classification-of-handwritten-digits/blob/master/Final%20Report.pdf">Result_Report</a> for information.<br>
Accuracy rate and training time of algorithms are as follows.<br><br>
<img src="https://github.com/chc2212/Classification-of-handwritten-digits/blob/master/pic1.png" align="left" height="209" width="400" ><img src="https://github.com/chc2212/Classification-of-handwritten-digits/blob/master/pic2.png" align="right" height="209" width="400" >


