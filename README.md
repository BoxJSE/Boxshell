# Boxshell
Command line interface for BOX

Requirement --------

bash

Homebrew

curl

jq

Environment ----------

MAC 

Installation ----------

1) create folder in local MAC donwload all files into it. 

	mkdir NEW_FOLDER (for example: mkdir /Users/test/ )

2) Set path to created folder.

	sudo YOUR_LOCAL_EDITOR .bash_profile
	add following line, 
		export PATH=$PATH:NEW_FOLDER (for example: export PATH=$PATH:/Users/test/ )

3) Install Homebrew

	a) Install Java
	
		$ java -version (If, java does not exist, system asks java installation)

	b) Install Command Line Tools

		$xcode-select --install

c) Install Homebrew

	See following link and install with instruction, 
	URL link: http://brew.sh/index_ja.html

	Install link (As of June 1, 2016) : 
	
	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	$ brew doctor

	$ brew update (update to later version)

	$ brew -v (version check)	

	* Use latest install link from Homebrew page.
	* Run above command from Command console.


4) Install jq

	$ brew install jq

	* if you don't have homebrew, alternative method is to build from source in GitHub

		$ git clone https://github.com/stedolan/jq.git
	
		$ cd jq
	
		$ make && sudo make install



		




