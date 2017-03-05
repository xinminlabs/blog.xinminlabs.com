role :web,  'blog.xinminlabs.com'
role :app,  'blog.xinminlabs.com'
role :db,   'blog.xinminlabs.com', :primary => true

server 'blog.xinminlabs.com', user: 'deploy', roles: %w{web app}, port: 12222
