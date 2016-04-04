##############################
# Standard_demo.sh 
#
# Standard demo environment preparation script
# 2016.04.01 M.Ishikawa @ Box Japan
##############################

cd /Users/mishikawa/boxsh

####################
# Set token
####################

echo "Login with Source Account."

tokengen -n weng81h01f1kysybgi1ahrjqmxy1oqzr jwgf22wt0RGqynOIb6cvtkGHn1CotgFy

cp Token Token_source
cp refresh_token refresh_token_source

echo "Login with Target Account."

tokengen -r

cp Token Token_target
cp refresh_token refresh_token_target

####################
# User Creation
####################

#echo "user ID list file name?:"
#read userlist

#bulkuser.sh $userlist | bfilter id > userlist.tmp

# echo "Did you complete User password settings? (Yes / ANY (abort): "
#echo "Do you continue Demo account setup? (Yes / ANY (abort): "
#read Answer

#if [ $Answer = "Yes" ]; then

#	echo "Start Preparation!!"

#else
#		echo "Quit" 
#		exit
#fi

####################
# Folder Copy
####################

# Select Master folder

cp Token_source Token
cp refresh_token_source refresh_token 

bcd -i 0
bcd -n Master >dummy
bls -s 
echo "Please choose Master Folder ID:"
read Master_ID

# Start each user preparation
cat userlist.tmp |while read AuserID
do 

echo $AuserID > Standard_demo.log
 
cp Token_source Token
cp refresh_token_source refresh_token 

	bcd -i 0  >> Standard_demo.log
	bcd -i $Master_ID >> Standard_demo.log

	# Create temporary Copy folder
	bmkdir Copy_folder |bfilter ID > folder_ID.tmp

	echo "1. Create temporary Copy folder"

	# Copy Master contents to Copy directly 

	bconvni -fo "01. 個人用フォルダ" > copyfolderlist.tmp
	bconvni -fo "02. プレビュー素材" >> copyfolderlist.tmp
	bconvni -fo "04. ファイルを直接編集（Box Edit）" >> copyfolderlist.tmp
	bconvni -fo "05. デモ時説明用パーツ" >> copyfolderlist.tmp

	read folder_ID_tmp < folder_ID.tmp

	while read line
	do
		bcp -o $line $folder_ID_tmp >> Standard_demo.log

	done < copyfolderlist.tmp

	echo "2. Copy Master contents to Copy directly "

	# Collaborate Folders with Target user
	bconvni -fo "03. 新機能" > collabfolderlist.tmp
	bconvni -fo "06. boxPLATFORM" >> collabfolderlist.tmp
	bconvni -fo "07. お客様事例＆インテグレーション事例" > collabfolderlist5.tmp

	bcd -i $folder_ID_tmp >> Standard_demo.log

	bconvni -fo "01. 個人用フォルダ" >> collabfolderlist.tmp
	bconvni -fo "02. プレビュー素材" >> collabfolderlist.tmp
	bconvni -fo "04. ファイルを直接編集（Box Edit）" >> collabfolderlist.tmp
	bconvni -fo "05. デモ時説明用パーツ" >> collabfolderlist.tmp

	while read line
	do
	
		setfocl-id -i $line $AuserID editor >> Standard_demo.log

	done < collabfolderlist.tmp

	while read line
	do
	
		setfocl-id -i $line $AuserID previewer >> Standard_demo.log

	done < collabfolderlist5.tmp

	echo "3. Collaborate Folders with Target user"

	# Collaboration Owner change

	bconvni -fo "01. 個人用フォルダ" > collabfolderlist2.tmp
	bconvni -fo "02. プレビュー素材" >> collabfolderlist2.tmp
	bconvni -fo "04. ファイルを直接編集（Box Edit）" >> collabfolderlist2.tmp
	bconvni -fo "05. デモ時説明用パーツ" >> collabfolderlist2.tmp

	while read line
	do
		shfocl -i $line | bfilter ID > collabid.tmp
		read collabid < collabid.tmp
		setfocl -c $collabid owner >> Standard_demo.log

	done < collabfolderlist2.tmp

	echo "4. Collaboration Owner change"

	# remove Copy folder 
	
	brmdir -f $folder_ID_tmp

	echo "5. remove Copy folder"

####################
# Target user setup
####################

	# Change account

	cp Token_target Token 
	cp refresh_token_target refresh_token 

	# read AuserID < userlist.tmp
	
	bcd -i 0

	echo "6. Change account for Target user setup"

	# Delete collaborator

	bls-asuser -l $AuserID|bgrep Name "01. 個人用フォルダ"|bfilter ID > collabfolderlist3.tmp
	bls-asuser -l $AuserID|bgrep Name "04. ファイルを直接編集（Box Edit）"|bfilter ID >> collabfolderlist3.tmp

	while read line
	do
		shfocl -i $line | bfilter ID > collabid.tmp
		read collabid < collabid.tmp
		setfocl-asuser -d $collabid $AuserID >> Standard_demo.log

	done < collabfolderlist3.tmp

	echo "7. Delete collaborator"

	# Set additional collaborator

	bls-asuser -l $AuserID|bgrep Name "02. プレビュー素材"|bfilter ID > collabfolderlist4.tmp
	bls-asuser -l $AuserID|bgrep Name "05. デモ時説明用パーツ"|bfilter ID >> collabfolderlist4.tmp

	while read line
	do

		setfocl-asuser -i $line demo+source_member1@box.com editor $AuserID >> Standard_demo.log
		setfocl-asuser -i $line demo+source_member2@box.com editor $AuserID >> Standard_demo.log
		setfocl-asuser -i $line demo+source_member3@box.com editor $AuserID >> Standard_demo.log
		setfocl-asuser -i $line demo+source_member4@box.com editor $AuserID >> Standard_demo.log

	done < collabfolderlist4.tmp

	echo "8. Set additional collaborator"

	# Create Shardlink for "02.Preview" Folder

	bcd-asuser -n "02. プレビュー素材" $AuserID >> Standard_demo.log
	setfisl-asuser -n "01. 画像ファイルサンプル.jpg" Collaborators $AuserID|bfilter url >sharedlink.tmp

	echo "9. Create Shardlink for 02.Preview Folder"

	# Change Bookmark for "02.Preview"

	bcd -i 0
	bcd-asuser -n "05. デモ時説明用パーツ" $AuserID >> Standard_demo.log
	bls-asuser -l $AuserID |bgrep Name "2.0 プレビュー" |bfilter ID > bmpreviewid.tmp

	read bmpreview_ID < bmpreviewid.tmp
	read sl_URL < sharedlink.tmp

	setweblink-asuser -churl $bmpreview_ID $sl_URL $AuserID  >> Standard_demo.log

	echo "10. Change Bookmark for 02.Preview"

	# Set Favorite

	setcollection-asuser -getid $AuserID|bfilter id > favorite_ID.tmp
	bls-asuser -l $AuserID|bgrep Type file|bfilter ID > favoritefilelist.tmp
	bls-asuser -l $AuserID|bgrep Type web_link|bfilter ID > favoritebookmarklist.tmp

	setfavorite-fi.sh favorite_ID.tmp favoritefilelist.tmp $AuserID  >> Standard_demo.log
	setfavorite-bm.sh favorite_ID.tmp favoritebookmarklist.tmp $AuserID  >> Standard_demo.log

	echo "11. Set Favorite"

	# Set Sync on

	bcd -i 0

	bls-asuser -l $AuserID|bgrep Name "04. ファイルを直接編集（Box Edit）"|bfilter ID > syncfollist.tmp
	bls-asuser -l $AuserID|bgrep Name "05. デモ時説明用パーツ"|bfilter ID >> syncfollist.tmp

	bulkfosync.sh syncfollist.tmp $AuserID  >> Standard_demo.log

	echo "12. Set Sync on"
	
	# Set comment
	
	bcd-asuser -n "02. プレビュー素材" $AuserID >> Standard_demo.log
	setcomment-asuser -n "99. 3D file Truck.3ds" "https://app.box.com/files/0/f/0" $AuserID  >> Standard_demo.log
	
	echo "13. Set comment"
	
	
done

####################
# Close
####################

echo "Preparation is completed."

# EOF
