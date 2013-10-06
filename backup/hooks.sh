# The "post-receive" script is run after receive-pack has accepted a pack
# and the repository has been updated.  It is passed arguments in through
# stdin in the form
#  <oldrev> <newrev> <refname>
# For example:
#  aa453216d1b3e49e7f6f98441fa56946ddcd6a20 68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
#!/bin/sh
#current repository
if [ $(git rev-parse --is-bare-repository) = true ]
then
        REPOSITORY="$PWD";
        REPOSITORY_BASENAME=$(basename "$PWD"); 
else
        REPOSITORY=$(readlink -nf "$PWD"/..);
        REPOSITORY_BASENAME=$(basename $(readlink -nf "$PWD"/..));
fi
echo "REPOSITORY is $REPOSITORY"
echo "REPOSITORY_BASENAME is $REPOSITORY_BASENAME"

read oldrev newrev refname
echo "Old revision: $oldrev"
echo "New revision: $newrev"
echo "Reference name: $refname"

BRANCH=${refname#refs/heads/}
echo "Update : pushed to branch : $BRANCH"

# if a json for this branch exists
#example read file from current branch

has_json=0
git rev-parse --verify $BRANCH:conf/$BRANCH.json 2>&1 && has_json=1
if [[ $has_json -eq 0 ]];
then
        echo -e "\nno configuration json file found. exit without deploying\n"
        exit 0 # no json founded : exit script normally
else
        echo "json found : applying deployement"
fi

json=$(git show $BRANCH:conf/$BRANCH.json)
#echo "deploy was try for : $newrev ($BRANCH)" >> deploy-post-receive.txt

source ~/.nvm/nvm.sh nvm
nvm use 0.10.2
node /home/nodes/deployer/deploy.js --conf "$json"  --branch $BRANCH --repository $REPOSITORY

# deploy should minify sources if necessary, and write timestamp of deployement to be inserted in index.html template to manage cache problemes
exit 0
