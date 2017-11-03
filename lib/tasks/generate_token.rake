task :generate_token => [:environment] do
  require 'securerandom'
  puts Token.create(token: SecureRandom.hex(16)).token
end
