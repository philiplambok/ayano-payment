module JSONSupport 
  def json_parse(string) 
    JSON.parse(string)
  end
end

RSpec.configure do |config| 
  config.include JSONSupport
end