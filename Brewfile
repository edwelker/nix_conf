dot_dir = File.expand_path(File.dirname(__FILE__))

# Load base tools
instance_eval(File.read("#{dot_dir}/brewfile.base"))

# Environment-specific loading
if File.exist?(File.expand_path("~/.ncbi_hints"))
  instance_eval(File.read("#{dot_dir}/brewfile.ncbi"))
elsif `hostname -s`.strip == "PLACEHOLDER_RS_HOST"
  instance_eval(File.read("#{dot_dir}/brewfile.rs"))
end
