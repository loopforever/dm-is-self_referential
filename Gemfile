source 'http://rubygems.org'

gem 'rake',          '~> 0.8.7'
gem 'jeweler',       '~> 1.4'
gem 'rspec',         '~> 1.3'
gem 'yard',          '~> 0.5'
gem 'rcov',          '~> 0.9.8'

# We need to add these here because we want to pin these gems to their git sources

if ENV['EXTLIB']
  gem 'extlib',          '~> 0.9.15',      :git => 'git://github.com/datamapper/extlib.git'
else
  gem 'activesupport',   '~> 3.0.0.beta3', :git => 'git://github.com/rails/rails.git', :require => nil
end

gem 'dm-do-adapter',     '~> 0.10.3', :git => 'git://github.com/datamapper/dm-do-adapter.git'
gem 'dm-validations',    '~> 0.10.3', :git => 'git://github.com/datamapper/dm-validations.git'


# We need these for specs

gem 'dm-migrations',     '~> 0.10.3', :git => 'git://github.com/datamapper/dm-migrations.git'
gem 'dm-sqlite-adapter', '~> 0.10.3', :git => 'git://github.com/datamapper/dm-sqlite-adapter.git'

# This are the only real toplevel dependencies

gem 'dm-core',           '~> 0.10.3', :git => 'git://github.com/datamapper/dm-core.git'
