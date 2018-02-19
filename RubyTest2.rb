puts "Getting there"
require 'active_record'
require 'tiny_tds'
require 'activerecord-sqlserver-adapter'
require 'pp'

ActiveRecord::Base.establish_connection(
  :adapter=> "sqlserverN",
  :host => "localhost",
  :username => "Enzox230\sqlexp2",
  :password => ""
)

#Create new database SampleDB
puts "Drop and create new database 'SampleDB'"
ActiveRecord::Base.connection.drop_database('SampleDB') rescue nil
ActiveRecord::Base.connection.create_database('SampleDB')
ActiveRecord::Base.connection.use_database('SampleDB')



#require 'tiny_tds'  
#   client = TinyTds::Client.new username: 'Enzox230\sqlexp2', password: '',  
##   host: 'ENZOX230\SQLEXP2', port: 1433,  
#    database: 'TestDBNew', azure:true  

#results = client.execute("SELECT Name, PlayerTeam, R, HR, RBI, SB from TblBatters WHERE PlayerTeam = 'STL'")  
#    results.each do |row|  
#    puts row  
#    end  

 puts "DONE?"