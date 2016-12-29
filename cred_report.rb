class CredReport
  require 'csv'
  require_relative 'cred_finder'

  def initialize(file)
    csv_headers = ["CMS_URN","CMS_DBNAME","CMS_HOST","CMS_PORT","CMS_USER","CMS_PASS"]
    applist = File.readlines("#{file}").each {|line| line.gsub!("\n",'')}

    CSV.open('sap_sucker_report.csv', 'wb', write_headers: true, headers: csv_headers) do |csv|
      applist.each do |urn|
        creds = CredFinder.new(urn).cred_hsh
        sleep 3
        row = ["#{urn}"]+creds.values
        csv << row
      end
    end
  end
end