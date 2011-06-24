require 'rbconfig'

class SystemHelper

  def self.clear
    cmd = if is_windows? then 'cls' else 'clear' end

    system(cmd)
  end

  private
  def self.is_windows?
    !((Config::CONFIG['host_os'] =~ /mswin|mingw/).nil?)
  end

end
