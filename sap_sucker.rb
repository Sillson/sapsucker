class SapSucker
  require_relative 'cred_report'

  def initialize(file)
    CredReport.new(file)
  end
end