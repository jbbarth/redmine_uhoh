export REDMINE_PATH=$HOME/redmine
export PLUGIN_NAME=redmine_uhoh

mysql -e 'CREATE DATABASE redmine;'
svn co http://svn.redmine.org/redmine/tags/$REDMINE_VER $REDMINE_PATH
ln -s $TRAVIS_BUILD_DIR $REDMINE_PATH/plugins/$PLUGIN_NAME
cp .travis/database-mysql.yml $REDMINE_PATH/config/database.yml

cd $REDMINE_PATH/plugins
git clone https://github.com/tools-aoeur/redmine_base_rspec.git
