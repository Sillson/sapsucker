class CredFinder
  attr_accessor :cred_hsh
  def initialize(urn)
    puts "***** \nSapSucking Creds For -- \n#{urn} \n*****"
    @cms_urn = urn
    @cred_hsh = {'dbname'=>'','host'=>'','port'=>'','user'=>'', 'password'=>''}
    build_creds
  end

  def build_creds
    # get credentials string from heroku
    str = `heroku pg:credentials -a "#{@cms_urn}"`
    # split string by spaces
    str = str.split(' ')
    # select only values that contain an equals symbol
    creds = str.select {|substr| substr.include?('=')}

    # for each key in the credentials hash, return the value from the creds array
    @cred_hsh.keys.each do |key|
      item_array = creds.select { |val| val.include?(key) }
      item = item_array[0].split('=')
      value = item.last
      @cred_hsh[key] = value
    end
    return @cred_hsh
  end
end