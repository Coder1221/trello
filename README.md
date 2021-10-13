# README
Setting up husky
npx husky --init && npm install
mkdir .husky
npx husky install ./husky
touch pre-commit (copied content from ci/cd)
touch commit-msg (copied content form ci/cd)
sudo chmod +X pre-commit (for making files executable) 
sudo chmod +X commit-msg (for making file executable)
-----------commtizen init-----------------
npx commmitizen init .
commitizen init cz-conventional-changelog --save --save-exact
instead of git commit use git cz
-----------------------------------------------------

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions