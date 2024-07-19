require 'fileutils'

appdata_path = ENV['APPDATA']
six_months_ago = Time.now - (6 * 30 * 24 * 60 * 60)

def delete_old_files(directory, cutoff_time)
  Dir.glob("#{directory}/**/*.tmp").each do |file|
    if File.mtime(file) < cutoff_time
      File.delete(file)
      puts "Deleted: #{file}"
    end
  end
end

if appdata_path
  delete_old_files(appdata_path, six_months_ago)
else
  puts "AppData directory not found."
end
