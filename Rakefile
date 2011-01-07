require 'bundler'
Bundler::GemHelper.install_tasks

namespace :spoke do

  desc 'Start Spoke using "spec/fixtures/classes.js"'
  task :start do 
    FileUtils.cd 'vendor/spoke' do
      sh 'java -jar start.jar'
    end
  end

  namespace :db do

    desc 'Create Spoke database' 
    task :create do
      sh 'mysql -uroot -e "CREATE DATABASE spoke_development CHARACTER SET utf8"'
    end
    
    desc 'Drop Spoke database' 
    task :drop do
      sh 'mysql -uroot -e "DROP DATABASE spoke_development"'
    end
    
    desc 'Migrate Spoke database' 
    task :migrate do
      Dir['vendor/spoke/db/*'].sort.each do |file|
        sh "mysql -uroot spoke_development < #{file}"
      end
    end

    desc 'Drop, create and migrate the Spoke database' 
    task :setup => [:drop, :create, :migrate]

  end

end
