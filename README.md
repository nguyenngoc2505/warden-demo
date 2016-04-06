# README

- git clone https://github.com/nguyenngoc2505/warden-demo.git
- bundle install
- rake db:migrate
- rails s

### Run in wweb
- http://localhost:3000

### Cal API
```ruby
curl -X POST -H "Content-Type: application/json" http://localhost:3000/v1/welcome -d '{"authentication_token":"447e50302f0cbf5b1a7951c603123c2ce354fd12"}'
```
