# README
----------husky init ------------------------------\
npx husky --init && npm install\
mkdir .husky\
npx husky install ./husky\
touch pre-commit (copied content from ci/cd)\
touch commit-msg (copied content form ci/cd)\
sudo chmod +X pre-commit (for making files executable)\
sudo chmod +X commit-msg (for making file executable)\
-----------commtizen init---------------------------\
npx commmitizen init .\
commitizen init cz-conventional-changelog --save --save-exact\
instead of git commit use git cz\
-----------------test init------------------------------\
delete already present test folder\
rpsec --init (not worked properly so used the below command) | missed rails helpers files\
rails g rspec:install\
rails g rspec:model (Name of model)\
